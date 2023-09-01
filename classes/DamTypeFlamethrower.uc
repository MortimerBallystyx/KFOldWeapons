class DamTypeFlamethrower extends KFWeaponDamageType
    abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount)
{
    KFStatsAndAchievements.AddFlameThrowerDamage(Amount);
}

defaultproperties
{
     bCheckForHeadShots=false
     WeaponClass=class'FlameThrower'
     DeathString="%k incinerated %o (Flamethrower)."
     FemaleSuicide="%o roasted herself alive."
     MaleSuicide="%o roasted himself alive."
}
