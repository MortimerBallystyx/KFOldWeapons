class KFMODDamTypeDeagle extends KFProjectileWeaponDamageType
    abstract;

defaultproperties
{
     bSniperWeapon=true
     WeaponClass=class'KFMODDeagle'
     DeathString="%k killed %o (Deagle)."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bRagdollBullet=true
     bBulletHit=true
     FlashFog=(X=600.000000)
     KDamageImpulse=9500.000000
     KDeathVel=200.000000
     KDeathUpKick=20.000000
     VehicleDamageScaling=0.800000
}
