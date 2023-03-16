class DamTypeKnife extends DamTypeMelee
	abstract;

static function AwardKill(KFSteamStatsAndAchievements KFStatsAndAchievements, KFPlayerController Killer, KFMonster Killed )
{
	if( KFStatsAndAchievements!=None && Killer.SelectedVeterancy==class'KFVetFieldMedic' )
		KFStatsAndAchievements.AddMedicKnifeKill();
}

defaultproperties
{
     WeaponClass=Class'KFOldModC.knife'
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.500000
}
