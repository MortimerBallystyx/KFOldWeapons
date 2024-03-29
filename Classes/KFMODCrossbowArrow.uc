class KFMODCrossbowArrow extends Projectile;

#exec OBJ LOAD FILE=KF_InventorySnd.uax

var xEmitter Trail;
var() class<DamageType> DamageTypeHeadShot;
var sound Arrow_hitwall[3];
var sound Arrow_rico[2];
var sound Arrow_hitarmor;
var sound Arrow_hitflesh;

var() float HeadShotDamageMult;

var Actor ImpactActor;
var Pawn IgnoreImpactPawn;

replication
{
    reliable if ( Role==ROLE_Authority && bNetInitial )
        ImpactActor;
}

simulated function PostNetBeginPlay()
{
    if( Level.NetMode!=NM_DedicatedServer && (Level.NetMode!=NM_Client || Physics==PHYS_Projectile) )
    {
        if ( !PhysicsVolume.bWaterVolume )
        {
            Trail = Spawn(class'KFArrowTracer',self);
            Trail.Lifespan = Lifespan;
        }
    }
    else if( Level.NetMode==NM_Client )
    {
        if( ImpactActor!=none )
            SetBase(ImpactActor);
        GoToState('OnWall');
    }
}
simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    Velocity = Speed * Vector(Rotation);
    if( PhysicsVolume.bWaterVolume )
        Velocity*=0.65;
}

simulated state OnWall
{
Ignores HitWall;

    function ProcessTouch (Actor Other, vector HitLocation)
    {
        local Inventory inv;

        if( Pawn(Other)!=none && Pawn(Other).Inventory!=none )
        {
            for( inv=Pawn(Other).Inventory; inv!=none; inv=inv.Inventory )
            {
                if( KFMODCrossbow(Inv)!=none && Weapon(inv).AmmoAmount(0)<Weapon(inv).MaxAmmo(0) )
                {
                    KFweapon(Inv).AddAmmo(1,0) ;
                    PlaySound(Sound'KF_InventorySnd.Ammo_GenericPickup', SLOT_Pain,2*TransientSoundVolume,,400);
                    if(PlayerController(Instigator.Controller)!=none)
                        PlayerController(Instigator.Controller).ClientMessage( "You picked up a bolt" );
                    Destroy();
                }
            }
        }
    }
    simulated function Tick( float Delta )
    {
        if( Base==none )
        {
            if( Level.NetMode==NM_Client )
                bHidden = true;
            else Destroy();
        }
    }
    simulated function BeginState()
    {
        bCollideWorld = false;
        if( Level.NetMode!=NM_DedicatedServer )
            AmbientSound = none;
        if( Trail!=none )
            Trail.mRegen = false;
        SetCollisionSize(25,25);
    }
}

simulated function Explode(vector HitLocation, vector HitNormal);

simulated function ProcessTouch (Actor Other, vector HitLocation)
{
    local vector X,End,HL,HN;
    local Vector TempHitLocation, HitNormal;
    local array<int>    HitPoints;
    local KFPawn HitPawn;
    local bool    bHitWhipAttachment;

    if ( Other == none || Other == Instigator || Other.Base == Instigator || !Other.bBlockHitPointTraces || Other==IgnoreImpactPawn ||
        (IgnoreImpactPawn != none && Other.Base == IgnoreImpactPawn) )
        return;

    X =  Vector(Rotation);

     if( ROBulletWhipAttachment(Other) != none )
    {

        bHitWhipAttachment=true;

        if(!Other.Base.bDeleteMe)
        {
            Other = Instigator.HitPointTrace(TempHitLocation, HitNormal, HitLocation + (65535 * X), HitPoints, HitLocation,, 1);

            if( Other == none || HitPoints.Length == 0 )
                return;

            HitPawn = KFPawn(Other);

            if (Role == ROLE_Authority)
            {
                if ( HitPawn != none )
                {
                     // Hit detection debugging
                    /*log("Bullet hit "$HitPawn.PlayerReplicationInfo.PlayerName);
                    HitPawn.HitStart = HitLocation;
                    HitPawn.HitEnd = HitLocation + (65535 * X);*/

                    if( !HitPawn.bDeleteMe )
                        HitPawn.ProcessLocationalDamage(Damage, Instigator, TempHitLocation, MomentumTransfer * X, MyDamageType,HitPoints);

                    Damage/=1.25;
                    Velocity*=0.85;

                    IgnoreImpactPawn = HitPawn;

                    if( Level.NetMode!=NM_Client )
                        PlayhitNoise(Pawn(Other)!=none && Pawn(Other).ShieldStrength>0);

                    // Hit detection debugging
                    /*if( Level.NetMode == NM_Standalone)
                        HitPawn.DrawBoneLocation();*/

                     return;
                }
            }
        }
        else
        {
            return;
        }
    }

    if( Level.NetMode!=NM_Client )
        PlayhitNoise(Pawn(Other)!=none && Pawn(Other).ShieldStrength>0);

    if( Physics==PHYS_Projectile && Pawn(Other)!=none && Vehicle(Other)==none )
    {
        IgnoreImpactPawn = Pawn(Other);
        if( IgnoreImpactPawn.IsHeadShot(HitLocation, X, 1.0) )
            Other.TakeDamage(Damage * HeadShotDamageMult, Instigator, HitLocation, MomentumTransfer * X, DamageTypeHeadShot);
        else Other.TakeDamage(Damage, Instigator, HitLocation, MomentumTransfer * X, MyDamageType);
        Damage/=1.25;
        Velocity*=0.85;
        return;
    }
    else if( ExtendedZCollision(Other)!=none && Pawn(Other.Owner)!=none )
    {
        if( Other.Owner==IgnoreImpactPawn )
            return;
        IgnoreImpactPawn = Pawn(Other.Owner);
        if ( IgnoreImpactPawn.IsHeadShot(HitLocation, X, 1.0))
            Other.TakeDamage(Damage * HeadShotDamageMult, Instigator, HitLocation, MomentumTransfer * X, DamageTypeHeadShot);
        else Other.TakeDamage(Damage, Instigator, HitLocation, MomentumTransfer * X, MyDamageType);
        Damage/=1.25;
        Velocity*=0.85;
        return;
    }
    if( Level.NetMode!=NM_DedicatedServer && SkeletalMesh(Other.Mesh)!=none && Other.DrawType==DT_Mesh && Pawn(Other)!=none )
    { // Attach victim to the wall behind if it dies.
        End = Other.Location+X*600;
        if( Other.Trace(HL,HN,End,Other.Location,false)!=none )
            Spawn(class'BodyAttacher',Other,,HitLocation).AttachEndPoint = HL-HN;
    }
    Stick(Other,HitLocation);
    if( Level.NetMode!=NM_Client )
    {
        if (Pawn(Other) != none && Pawn(Other).IsHeadShot(HitLocation, X, 1.0))
            Pawn(Other).TakeDamage(Damage * HeadShotDamageMult, Instigator, HitLocation, MomentumTransfer * X, DamageTypeHeadShot);
        else Other.TakeDamage(Damage, Instigator, HitLocation, MomentumTransfer * X, MyDamageType);
        }
}
function PlayhitNoise( bool bArmored )
{
    if( bArmored )
        PlaySound(Arrow_hitarmor);   // implies hit a target with shield/armor
    else PlaySound(Arrow_hitflesh);
}
simulated function HitWall( vector HitNormal, actor Wall )
{
    speed = VSize(Velocity);

    if ( Role==ROLE_Authority && Wall!=none )
    {
        if ( !Wall.bStatic && !Wall.bWorldGeometry )
        {
            if ( Instigator == none || Instigator.Controller == none )
                Wall.SetDelayedDamageInstigatorController(InstigatorController);
            Wall.TakeDamage( Damage, instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);
            HurtWall = Wall;
        }
        MakeNoise(1.0);
    }
    PlaySound(Arrow_hitwall[Rand(3)],,2.5*TransientSoundVolume);
    if(Level.NetMode != NM_DedicatedServer)
    {
            Spawn(class'ROBulletHitEffect',,, Location, rotator(-HitNormal));
    }
    if( Instigator!=none && Level.NetMode!=NM_Client )
        MakeNoise(0.3);
    Stick(Wall, Location+HitNormal);
}
simulated function Landed(vector HitNormal)
{
    HitWall(HitNormal, none);
}
simulated function Stick(actor HitActor, vector HitLocation)
{
    local name NearestBone;
    local float dist;

    SetPhysics(PHYS_None);

    if (pawn(HitActor) != none)
    {
        NearestBone = GetClosestBone(HitLocation, HitLocation, dist , 'CHR_Spine2' , 15 );
        HitActor.AttachToBone(self,NearestBone);
    }
    else SetBase(HitActor);

    ImpactActor = HitActor;

    if (Base==none)
        Destroy();
    else GoToState('OnWall');
}
simulated function PhysicsVolumeChange( PhysicsVolume Volume )
{
    if( Volume.bWaterVolume && !PhysicsVolume.bWaterVolume )
    {
        if ( Trail != none )
            Trail.mRegen=false;
        Velocity*=0.65;
    }
}
simulated function Destroyed()
{
    if (Trail !=none)
        Trail.mRegen = false;
    super.Destroyed();
}

defaultproperties
{
     DamageTypeHeadShot=class'KFMODDamTypeCrossbowHeadShot'
     Arrow_hitwall(0)=Sound'KFWeaponSound.bullethitflesh2'
     Arrow_hitwall(1)=Sound'KFWeaponSound.bullethitflesh3'
     Arrow_hitwall(2)=Sound'KFWeaponSound.bullethitflesh4'
     Arrow_rico(0)=Sound'KFWeaponSound.bullethitmetal'
     Arrow_rico(1)=Sound'KFWeaponSound.bullethitmetal3'
     Arrow_hitarmor=Sound'KFWeaponSound.bullethitflesh4'
     Arrow_hitflesh=Sound'KFWeaponSound.bullethitflesh4'
     HeadShotDamageMult=6.000000
     Speed=7500.000000
     MaxSpeed=10000.000000
     Damage=150.000000
     MomentumTransfer=150000.000000
     MyDamageType=class'KFMODDamTypeCrossbow'
     ExplosionDecal=class'KFMod.ShotgunDecal'
     CullDistance=3000.000000
     bNetTemporary=false
     AmbientSound=Sound'PatchSounds.ArrowZip'
     LifeSpan=0.000000
     Mesh=SkeletalMesh'KFWeaponModels.XbowBolt'
     DrawScale=15.000000
     AmbientGlow=30
     Style=STY_Alpha
     bUnlit=false
     bFullVolume=true
}
