class KFMODDamTypeCrossbow extends KFProjectileWeaponDamageType;

static function AwardKill(KFSteamStatsAndAchievements KFStatsAndAchievements, KFPlayerController Killer, KFMonster Killed )
{
    if( KFStatsAndAchievements!=none && Killed.BurnDown>0 )
        KFStatsAndAchievements.AddBurningCrossbowKill();
}

defaultproperties
{
     HeadShotDamageMult=1.25000
     bSniperWeapon=true
     bThrowRagdoll=true
     bRagdollBullet=true
     DamageThreshold=1
     KDamageImpulse=2000.000000
     KDeathVel=110.000000
     KDeathUpKick=10.000000
}
