class DamTypeAxe extends DamTypeMelee;

static function AwardKill(KFSteamStatsAndAchievements KFStatsAndAchievements, KFPlayerController Killer, KFMonster Killed )
{
    if( KFStatsAndAchievements!=none )
        KFStatsAndAchievements.AddFireAxeKill();
}

defaultproperties
{
     WeaponClass=class'Axe'
     PawnDamageSounds(0)=Sound'KFOldModSnd.Zeds.axehitflesh'
     KDamageImpulse=15000.000000
     VehicleDamageScaling=0.700000
}
