class KFMODDamTypeBullpup extends KFProjectileWeaponDamageType
    abstract;

static function AwardKill(KFSteamStatsAndAchievements KFStatsAndAchievements, KFPlayerController Killer, KFMonster Killed )
{
    if( Killed.IsA('ZombieStalker') )
        KFStatsAndAchievements.AddStalkerKill();
}

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount)
{
    KFStatsAndAchievements.AddBullpupDamage(Amount);
}

defaultproperties
{
     WeaponClass=class'KFMODBullpup'
     DeathString="%k killed %o (Bullpup)."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bRagdollBullet=true
     KDamageImpulse=2400.000000
     KDeathVel=110.000000
     KDeathUpKick=3.000000
}
