class DamTypeKnife extends DamTypeMelee
    abstract;

static function AwardKill(KFSteamStatsAndAchievements KFStatsAndAchievements, KFPlayerController Killer, KFMonster Killed )
{
    if( KFStatsAndAchievements!=none && Killer.SelectedVeterancy==class'KFVetFieldMedic' )
        KFStatsAndAchievements.AddMedicKnifeKill();
}

defaultproperties
{
     WeaponClass=class'knife'
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.500000
}
