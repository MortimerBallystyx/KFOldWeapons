//
//=============================================================================
class KFMODFlameBurstFire extends CrossbowFire ;

var byte FlockIndex;
var int MaxLoad;

// Animation
//var     float                    LoopFireAnimRate;            // The rate to play the looped fire animation when hipped
//var     float                    IronLoopFireAnimRate;       // The rate to play the looped fire animation when deployed or in iron sights

// sound
var     sound                   FireEndSound;                // The sound to play at the end of the ambient fire sound
var     float                   AmbientFireSoundRadius;        // The sound radius for the ambient fire sound
var        sound                    AmbientFireSound;           // How loud to play the looping ambient fire sound
var        byte                    AmbientFireVolume;          // The ambient fire sound

// Sends the fire class to the looping state
function StartFiring()
{
   GotoState('FireLoop');
}

// Handles toggling the weapon attachment's ambient sound on and off
function PlayAmbientSound(Sound aSound)
{
    local WeaponAttachment WA;

    WA = WeaponAttachment(Weapon.ThirdPersonActor);

    if ( Weapon == none || (WA == none))
        return;

    if(aSound == none)
    {
        WA.SoundVolume = WA.default.SoundVolume;
        WA.SoundRadius = WA.default.SoundRadius;
    }
    else
    {
        WA.SoundVolume = AmbientFireVolume;
        WA.SoundRadius = AmbientFireSoundRadius;
    }

    WA.AmbientSound = aSound;
}

// Make sure we are in the fire looping state when we fire
event ModeDoFire()
{
    if( AllowFire() && IsInState('FireLoop'))
    {
        super.ModeDoFire();
    }
}

simulated function bool AllowFire()
{
    if(KFWeapon(Weapon).bIsReloading)
        return false;
    if(KFWeapon(Weapon).MagAmmoRemaining < 1)
    {
        if(Level.TimeSeconds - LastClickTime > FireRate)
        {
            Weapon.PlayOwnedSound(NoAmmoSound, SLOT_Interact, TransientSoundVolume,,,, false);
            LastClickTime = Level.TimeSeconds;
            if(Weapon.HasAnim(EmptyAnim))
                weapon.PlayAnim(EmptyAnim, EmptyAnimRate, 0.0);
        }
        return false;
    }
    LastClickTime = Level.TimeSeconds;
    return super.AllowFire();
}

/* =================================================================================== *
* FireLoop
*     This state handles looping the firing animations and ambient fire sounds as well
*    as firing rounds.
*
* modified by: Ramm 1/17/05
* =================================================================================== */
state FireLoop
{
    function BeginState()
    {
        NextFireTime = Level.TimeSeconds - 0.1; //fire now!

        Weapon.LoopAnim(FireLoopAnim, FireLoopAnimRate, TweenTime);

        PlayAmbientSound(AmbientFireSound);
    }

    // Overriden because we play an anbient fire sound
    function PlayFiring() {}
    function ServerPlayFiring() {}

    function EndState()
    {
        Weapon.AnimStopLooping();
        PlayAmbientSound(none);
        Weapon.PlayOwnedSound(FireEndSound,SLOT_None,AmbientFireVolume/127,,AmbientFireSoundRadius);
        Weapon.StopFire(ThisModeNum);
    }

    function StopFiring()
    {
        GotoState('');
    }

    function ModeTick(float dt)
    {
        super.ModeTick(dt);

        if ( !bIsFiring ||  !AllowFire()  )  // stopped firing, magazine empty
        {
            GotoState('');
            return;
        }
    }
}

function DoFireEffect()
{
    local Vector StartProj, StartTrace, X,Y,Z;
    local Rotator Aim;
    local Vector HitLocation, HitNormal,FireLocation;
    local Actor Other;
    local int p, SpawnCount;
    local FlameTendril FiredRockets[4];

    if ( (SpreadStyle == SS_Line) || (Load < 2) )
    {
        super.DoFireEffect();
        return;
    }

    Instigator.MakeNoise(1.0);
    Weapon.GetViewAxes(X,Y,Z);

    StartTrace = Instigator.Location + Instigator.EyePosition();
    StartProj = StartTrace + X*ProjSpawnOffset.X + Z*ProjSpawnOffset.Z;
    if ( !Weapon.WeaponCentered() )
        StartProj = StartProj + Weapon.Hand * Y*ProjSpawnOffset.Y;

    // check if projectile would spawn through a wall and adjust start location accordingly
    Other = Weapon.Trace(HitLocation, HitNormal, StartProj, StartTrace, false);
    if (Other != none)
    {
        StartProj = HitLocation;
    }

    Aim = AdjustAim(StartProj, AimError);

    SpawnCount = Max(1, int(Load));

    for ( p=0; p<SpawnCount; p++ )
    {
        Firelocation = StartProj - 2*((Sin(p*2*PI/MaxLoad)*8 - 7)*Y - (Cos(p*2*PI/MaxLoad)*8 - 7)*Z) - X * 8 * FRand();
        FiredRockets[p] = FlameTendril(SpawnProjectile(FireLocation, Aim));
    }
}

function float MaxRange()
{
    return 1500;
}

defaultproperties
{
     MaxLoad=3
     FireEndSound=SoundGroup'KF_FlamethrowerSnd.FT_Fire1Shot'
     AmbientFireSoundRadius=500.000000
     AmbientFireSound=Sound'KFOldModSnd.Weapon.FlameThrowerFire'
     AmbientFireVolume=255
     EffectiveRange=1500.000000
     maxVerticalRecoilAngle=300
     maxHorizontalRecoilAngle=150
     ProjSpawnOffset=(X=65.000000,Y=10.000000,Z=-15.000000)
     bSplashDamage=true
     bRecommendSplashDamage=true
     bWaitForRelease=false
     bAttachSmokeEmitter=true
     TransientSoundVolume=1.000000
     TransientSoundRadius=500.000000
     FireAnim="'"
     FireLoopAnim="Fire"
     FireEndAnim="Idle"
     FireSound=none
     NoAmmoSound=SoundGroup'KF_FlamethrowerSnd.FT_DryFire'
     FireRate=0.070000
     AmmoClass=class'KFMODFlameAmmo'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ProjectileClass=class'KFMODFlameTendril'
     BotRefireRate=0.070000
     aimerror=0.000000
     Spread=0.000000
     SpreadStyle=SS_Random
}
