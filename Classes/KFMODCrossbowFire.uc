class KFMODCrossbowFire extends KFShotgunFire;

simulated function bool AllowFire()
{
    return (Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire);
}

function float MaxRange()
{
    return 2500;
}

function DoFireEffect()
{
   super(KFShotgunFire).DoFireEffect();
}

defaultproperties
{
     EffectiveRange=2500.000000
     maxVerticalRecoilAngle=200
     maxHorizontalRecoilAngle=50
     FireAimedAnim="Fire_Iron"
     bRandomPitchFireSound=false
     ProjPerFire=1
     ProjSpawnOffset=(Y=0.000000,Z=0.000000)
     bWaitForRelease=true
     TransientSoundVolume=1.800000
     FireSound=Sound'KFOldModSnd.Weapon.XbowFire'
     NoAmmoSound=Sound'KF_XbowSnd.Xbow_DryFire'
     FireForce="AssaultRifleFire"
     FireRate=1.800000
     AmmoClass=class'KFMODCrossbowAmmo'
     ShakeRotMag=(X=3.000000,Y=4.000000,Z=2.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeOffsetMag=(X=3.000000,Y=3.000000,Z=3.000000)
     ProjectileClass=class'KFMODCrossbowArrow'
     BotRefireRate=1.800000
     aimerror=1.000000
     Spread=1.000000
     SpreadStyle=SS_None
}
