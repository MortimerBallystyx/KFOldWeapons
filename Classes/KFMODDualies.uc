//=============================================================================
// Dualies Inventory class
//=============================================================================
class KFMODDualies extends KFMod.Dualies;

/**
 * Handles all the functionality for zooming out including
 * setting the parameters for the weapon, pawn, and playercontroller
 *
 * @param bAnimateTransition whether or not to animate this zoom transition
 */
simulated function ZoomOut(bool bAnimateTransition)
{
    super.ZoomOut(false);

    if( bAnimateTransition )
    {
        TweenAnim('GOTO_Hip',ZoomTime);
    }
}


function AttachToPawn(Pawn P)
{
    local name BoneName;

    super.AttachToPawn(P);

    if(altThirdPersonActor == none)
    {
        altThirdPersonActor = Spawn(AttachmentClass,Owner);
        InventoryAttachment(altThirdPersonActor).InitFor(self);
    }
    else altThirdPersonActor.NetUpdateTime = Level.TimeSeconds - 1;
    BoneName = P.GetOffhandBoneFor(self);
    if(BoneName == '')
    {
        altThirdPersonActor.SetLocation(P.Location);
        altThirdPersonActor.SetBase(P);
    }
    else P.AttachToBone(altThirdPersonActor,BoneName);

    if(altThirdPersonActor != none)
        DualiesAttachment(altThirdPersonActor).bIsOffHand = true;
    if(altThirdPersonActor != none && ThirdPersonActor != none)
    {
        DualiesAttachment(altThirdPersonActor).brother = DualiesAttachment(ThirdPersonActor);
        DualiesAttachment(ThirdPersonActor).brother = DualiesAttachment(altThirdPersonActor);
        altThirdPersonActor.LinkMesh(DualiesAttachment(ThirdPersonActor).BrotherMesh);
    }
}

simulated function DetachFromPawn(Pawn P)
{
    super.DetachFromPawn(P);
    if ( altThirdPersonActor != none )
    {
        altThirdPersonActor.Destroy();
        altThirdPersonActor = none;
    }
}

simulated function Destroyed()
{
    super.Destroyed();

    if( ThirdPersonActor!=none )
        ThirdPersonActor.Destroy();
    if( altThirdPersonActor!=none )
        altThirdPersonActor.Destroy();
}

//simulated function Vector GetTipLocation()
//{
//    local Coords C;
//    C = GetBoneCoords('tip');
//    return C.Origin;
//}

simulated function vector GetEffectStart()
{
    local Vector RightFlashLoc,LeftFlashLoc;

    RightFlashLoc = GetBoneCoords(default.FlashBoneName).Origin;
    LeftFlashLoc = GetBoneCoords(default.altFlashBoneName).Origin;

    // jjs - this function should actually never be called in third person views
    // any effect that needs a 3rdp weapon offset should figure it out itself

    // 1st person
    if (Instigator.IsFirstPerson())
    {
        if ( WeaponCentered() )
            return CenteredEffectStart();

        if( bAimingRifle )
        {
            if( KFFire(GetFireMode(0)).FireAimedAnim != 'FireLeft_Iron' )
            {
                return RightFlashLoc;
            }
            else // Off hand firing.  Moves tracer to the left.
            {
                return LeftFlashLoc;
            }
        }
        else
        {
            if (GetFireMode(0).FireAnim != 'FireLeft')
            {
                return RightFlashLoc;
            }
            else // Off hand firing.  Moves tracer to the left.
            {
                return LeftFlashLoc;
            }
        }
    }
    // 3rd person
    else
    {
        return (Instigator.Location +
            Instigator.EyeHeight*Vect(0,0,0.5) +
            Vector(Instigator.Rotation) * 40.0);
    }
}
function GiveTo( pawn Other, optional Pickup Pickup )
{
    local Inventory I;
    local int OldAmmo;
    local bool bNoPickup;

    MagAmmoRemaining = 0;
    for( I=Other.Inventory; I!=none; I=I.Inventory )
    {
        if( Single(I)!=none )
        {
            if( WeaponPickup(Pickup)!= none )
            {
                WeaponPickup(Pickup).AmmoAmount[0]+=Weapon(I).AmmoAmount(0);
            }
            else
            {
                OldAmmo = Weapon(I).AmmoAmount(0);
                bNoPickup = true;
            }

            MagAmmoRemaining = Single(I).MagAmmoRemaining;

            I.Destroyed();
            I.Destroy();

            Break;
        }
    }
    if( KFWeaponPickup(Pickup)!=none && Pickup.bDropped )
        MagAmmoRemaining = Clamp(MagAmmoRemaining+KFWeaponPickup(Pickup).MagAmmoRemaining,0,MagCapacity);
    else MagAmmoRemaining = Clamp(MagAmmoRemaining+class'KFMODSingle'.default.MagCapacity,0,MagCapacity);
    super(Weapon).GiveTo(Other,Pickup);

    if ( bNoPickup )
    {
        AddAmmo(OldAmmo, 0);
        Clamp(Ammo[0].AmmoAmount, 0, MaxAmmo(0));
    }
}
function DropFrom(vector StartLocation)
{
    local int m;
    local Pickup Pickup;
    local Inventory I;
    local int AmmoThrown,OtherAmmo;

    if( !bCanThrow )
        return;

    AmmoThrown = AmmoAmount(0);
    ClientWeaponThrown();

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if (FireMode[m].bIsFiring)
            StopFire(m);
    }

    if ( Instigator != none )
        DetachFromPawn(Instigator);

    if( Instigator.Health>0 )
    {
        OtherAmmo = AmmoThrown/2;
        AmmoThrown-=OtherAmmo;
        I = Spawn(class'KFMODSingle');
        I.GiveTo(Instigator);
        Weapon(I).Ammo[0].AmmoAmount = OtherAmmo;
        Single(I).MagAmmoRemaining = MagAmmoRemaining/2;
        MagAmmoRemaining = Max(MagAmmoRemaining-Single(I).MagAmmoRemaining,0);
    }
    Pickup = Spawn(PickupClass,,, StartLocation);
    if ( Pickup != none )
    {
        Pickup.InitDroppedPickupFor(self);
        Pickup.Velocity = Velocity;
        WeaponPickup(Pickup).AmmoAmount[0] = AmmoThrown;
        if( KFWeaponPickup(Pickup)!=none )
            KFWeaponPickup(Pickup).MagAmmoRemaining = MagAmmoRemaining;
        if (Instigator.Health > 0)
            WeaponPickup(Pickup).bThrown = true;
    }

    Destroyed();
    Destroy();
}

simulated function bool PutDown()
{
    if ( Instigator.PendingWeapon.class == class'KFMODSingle' )
    {
        bIsReloading = false;
    }

    return super.PutDown();
}

defaultproperties
{
     altFlashBoneName="tip"
     altTPAnim="DualiesAttackLeft"
     altWeaponAttach="Bone_weapon2"
     FlashBoneName="LightBone"
     SleeveNum=7
	 Weight=2.000000
     FireModeClass(0)=class'KFMODDualiesFire'
     FireModeClass(1)=class'KFMODSingleALTFire'
     Priority=4
     PickupClass=class'KFMODDualiesPickup'
     PlayerViewOffset=(Y=25.000000,Z=-10.000000)
     AttachmentClass=class'KFMODDualiesAttachment'
     Mesh=SkeletalMesh'KFWeaponModelsOldMod.Dualies'
     Skins(0)=Shader'KillingFloorWeapons.Dualies.DualiesShineShader'
     Skins(1)=Texture'KillingFloorWeapons.Deagle.HandSkinNew'
     Skins(2)=Texture'KillingFloorWeapons.Deagle.ArmSkinNew'
     Skins(3)=Shader'KillingFloorWeapons.Dualies.DualiesShineShader'
     Skins(4)=Shader'KillingFloorWeapons.Dualies.DualiesShineShader'
     Skins(5)=Shader'KillingFloorWeapons.Dualies.TacLightShader'
}
