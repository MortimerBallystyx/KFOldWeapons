class DamTypeShotgunb extends KFProjectileWeaponDamageType
    abstract;

defaultproperties
{
     bIsPowerWeapon=true
     WeaponClass=class'Shotgun'
     DeathString="%k killed %o (Shotgun)."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bRagdollBullet=true
     bBulletHit=true
     FlashFog=(X=600.000000)
     KDamageImpulse=10000.000000
     KDeathVel=500.000000
     KDeathUpKick=300.000000
     VehicleDamageScaling=0.700000
}
