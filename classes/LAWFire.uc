class LAWFire extends KFShotgunFire;

function bool AllowFire()
{
    if( Instigator != none && Instigator.IsHumanControlled() )
    {
        if( !KFWeapon(Weapon).bAimingRifle || KFWeapon(Weapon).bZoomingIn )
        {
            return false;
        }
    }
    return ( Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire);
}
function ServerPlayFiring()
{
    super.ServerPlayFiring();
    KFWeapon(Weapon).ZoomOut(false);
}
function PlayFiring()
{
    super.PlayFiring();
    KFWeapon(Weapon).ZoomOut(false);
}

defaultproperties
{
     CrouchedAccuracyBonus=0.100000
     KickMomentum=(X=-45.000000,Z=25.000000)
     maxVerticalRecoilAngle=1000
     maxHorizontalRecoilAngle=250
     StereoFireSound=Sound'KFOldModSnd.Weapon.LAWFire'
     bRandomPitchFireSound=false
     ProjPerFire=1
     ProjSpawnOffset=(X=100.000000,Z=0.000000)
     bSplashDamage=true
     bRecommendSplashDamage=true
     bWaitForRelease=true
     TransientSoundVolume=100.000000
     FireAnim="AimFire"
     FireSound=Sound'KFOldModSnd.Weapon.LAWFire'
     NoAmmoSound=Sound'KF_LAWSnd.LAW_DryFire'
     FireForce="redeemer_shoot"
     FireRate=3.250000
     AmmoClass=class'LAWAmmo'
     ShakeRotMag=(X=50.000000,Y=50.000000,Z=400.000000)
     ShakeRotRate=(X=12500.000000,Y=12500.000000,Z=12500.000000)
     ShakeRotTime=5.000000
     ShakeOffsetMag=(X=6.000000,Y=2.000000,Z=10.000000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=3.000000
     ProjectileClass=class'LAWProj'
     BotRefireRate=3.250000
     Spread=1.000000
}
