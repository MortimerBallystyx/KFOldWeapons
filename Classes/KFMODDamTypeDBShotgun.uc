class KFMODDamTypeDBShotgun extends KFMODDamTypeShotgunb
    abstract;

static function AwardKill(KFSteamStatsAndAchievements KFStatsAndAchievements, KFPlayerController Killer, KFMonster Killed )
{
    if( KFStatsAndAchievements!=none )
        KFStatsAndAchievements.AddHuntingShotgunKill();
}

defaultproperties
{
     KDamageImpulse=13500.000000
     KDeathVel=600.000000
}
