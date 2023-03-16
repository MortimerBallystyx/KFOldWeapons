class DamTypeDBShotgun extends DamTypeShotgunb
	abstract;

static function AwardKill(KFSteamStatsAndAchievements KFStatsAndAchievements, KFPlayerController Killer, KFMonster Killed )
{
	if( KFStatsAndAchievements!=None )
		KFStatsAndAchievements.AddHuntingShotgunKill();
}

defaultproperties
{
     KDamageImpulse=13500.000000
     KDeathVel=600.000000
}
