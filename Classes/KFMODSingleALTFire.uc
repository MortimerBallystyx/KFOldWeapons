//=============================================================================
// Flashlight
//=============================================================================
class KFMODSingleALTFire extends KFFire;

var float ClickTime;
var name FireAnim2;

simulated function ModeDoFire()
{
    if (Weapon != none && KFPlayerController(pawn(Weapon.Owner).Controller) != none )
    {
        KFPlayerController(pawn(Weapon.Owner).Controller).ToggleTorch();
        KFWeapon(Weapon).AdjustLightGraphic();
    }
    super.ModeDoFire();
}

function DoTrace(Vector Start, Rotator Dir)
{

}

// Sends a value to the 9mm attachment telling whether the light is being used.
function bool LightFiring()
{
    return bIsFiring;
}

simulated function bool AllowFire()
{
    if(KFWeapon(Weapon).bIsReloading || KFPawn(Instigator).SecondaryItem!=none || KFPawn(Instigator).bThrowingNade )
        return false;
    if(Level.TimeSeconds - LastClickTime > FireRate)
        return true;
}

defaultproperties
{
     bFiringDoesntAffectMovement=true
     RecoilRate=0.150000
     bDoClientRagdollShotFX=false
     DamageType=class'KFMODDamTypeDualies'
     Momentum=0.000000
     bPawnRapidFireAnim=true
     bAttachSmokeEmitter=true
     TransientSoundVolume=1.800000
     FireAnim="LightOn"
     FireSound=Sound'KF_9MMSnd.Ninemm_AltFire1'
     FireForce="AssaultRifleFire"
     AmmoClass=class'KFMODSingleAmmo'
     BotRefireRate=0.500000
     aimerror=0.000000
}
