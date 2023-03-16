class OldKF extends Mutator;

#exec obj load file=KFCharacters.utx
#exec obj load file=KFCharactermodels.ukx
#exec obj load file=KillingFloorWeapons.utx
#exec obj load file=KF_Specimens_Trip_T.utx
#exec obj load file=kfboss.ukx
#exec obj load file=kfpatch2.utx
#exec obj load file=kfweaponmodels.ukx
#exec obj load file=KillingFloorWeapons.utx

function PostBeginPlay()
{
	SetTimer(0.1,false);
}

function Timer()
{
	local KFGameType KF;
	local int i,j;
	local class<KFMonstersCollection> MC;

	KF = KFGameType(Level.Game);
	if(KF!=None)
	{
		for(i=0;i<KF.InitSquads.Length;i++)
		{
			for( j=0; j<KF.InitSquads[i].MSquad.Length; j++ )
				KF.InitSquads[i].MSquad[j] = GetReplaceClass(KF.InitSquads[i].MSquad[j]);
		}
		for(i=0;i<KF.SpecialSquads.Length;i++)
		{
			for( j=0; j<KF.SpecialSquads[i].ZedClass.Length; j++ )
				ReplaceMonsterStr(KF.SpecialSquads[i].ZedClass[j]);
		}
		for(i=0;i<KF.FinalSquads.Length;i++)
		{
			for( j=0; j<KF.FinalSquads[i].ZedClass.Length; j++ )
				ReplaceMonsterStr(KF.FinalSquads[i].ZedClass[j]);
		}
		KF.FallbackMonster = GetReplaceClass(Class<KFMonster>(KF.FallbackMonster));
		ReplaceMonsterStr(KF.EndGameBossClass);
		//KF.EndGameBossClass = string(Class'ZombieBossOld');
		MC = KF.MonsterCollection;
		if( MC!=None )
		{
			ReplaceMonsterStr(MC.Default.EndGameBossClass);
			for( i=0; i<MC.Default.SpecialSquads.Length; i++ )
			{
				for( j=0; j<MC.Default.SpecialSquads[i].ZedClass.Length; j++ )
					ReplaceMonsterStr(MC.Default.SpecialSquads[i].ZedClass[j]);
			}
			for( i=0; i<MC.Default.FinalSquads.Length; i++ )
			{
				for( j=0; j<MC.Default.FinalSquads[i].ZedClass.Length; j++ )
					ReplaceMonsterStr(MC.Default.FinalSquads[i].ZedClass[j]);
			}
		}
	}
	Destroy();
}
final function ReplaceMonsterStr( out string MC )
{
	MC = string(GetReplaceClass(Class<KFMonster>(DynamicLoadObject(MC,Class'Class'))));
}

function Class<KFMonster> GetReplaceClass( Class<KFMonster> MC )
{
	switch( MC )
	{
	case Class'ZombieClot_STANDARD':
		return Class'ZombieClotold';
	case Class'ZombieBloat_STANDARD':
		return Class'ZombieBloatold';
	//case Class'ZombieCrawler_STANDARD':
	//	return Class'ZombieCrawlerold';
	case Class'ZombieStalker_STANDARD':
		return Class'ZombieStalkerold';
	case Class'ZombieSiren_STANDARD':
		return Class'ZombieSirenold';
	case Class'ZombieScrake_STANDARD':
		return Class'ZombieScrakeold';
	case Class'ZombieFleshPound_STANDARD':
		return Class'ZombieFleshPoundold';
	case Class'ZombieGorefast_STANDARD':
		return Class'ZombieGorefastold';
	//case Class'ZombieHusk_STANDARD':
	//	return Class'ZombieShadeold';
	case Class'ZombieBoss_STANDARD':
		return Class'ZombieBossold';
	default:
		return MC;
	}
}

defaultproperties
{
     bAddToServerPackages=True
     GroupName="KF-OLD"
     FriendlyName="Old KF 2.51!"
     Description="Play the old KF 2.51 mod!"
}
