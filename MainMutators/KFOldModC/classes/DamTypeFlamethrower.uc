class DamTypeFlamethrower extends KFWeaponDamageType
	abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount)
{
	KFStatsAndAchievements.AddFlameThrowerDamage(Amount);
}

defaultproperties
{
     bCheckForHeadShots=False
     WeaponClass=Class'KFOldModC.FlameThrower'
     DeathString="%k incinerated %o (Flamethrower)."
     FemaleSuicide="%o roasted herself alive."
     MaleSuicide="%o roasted himself alive."
}
