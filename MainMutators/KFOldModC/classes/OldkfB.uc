//-----------------------------------------------------------
// Written by Marco
//-----------------------------------------------------------
class OldkfB extends Mutator;

var bool bHasInit;
var int LastScannedWave;

function PostBeginPlay()
{
	SetTimer(0.1,False);
}
function Timer()
{
	if( !bHasInit )
	{
		bHasInit = true;
		InitMut();
	}
	else if( LastScannedWave!=KFGameType(Level.Game).WaveNum )
	{
		if( !KFGameType(Level.Game).bWaveInProgress )
			return;
		LastScannedWave = KFGameType(Level.Game).WaveNum;

	}
}
final function InitMut()
{
	local KFGameType KF;
	local int i,j;
	local class<KFMonstersCollection> MC;
	
	KF = KFGameType(Level.Game);
	if ( KF!=None )
	{
		for( i=0; i<KF.InitSquads.Length; i++ )
		{
			for( j=0; j<KF.InitSquads[i].MSquad.Length; j++ )
				KF.InitSquads[i].MSquad[j] = GetReplaceClass(KF.InitSquads[i].MSquad[j]);
		}
		for( i=0; i<KF.SpecialSquads.Length; i++ )
		{
			for( j=0; j<KF.SpecialSquads[i].ZedClass.Length; j++ )
				ReplaceMonsterStr(KF.SpecialSquads[i].ZedClass[j]);
		}
		for( i=0; i<KF.FinalSquads.Length; i++ )
		{
			for( j=0; j<KF.FinalSquads[i].ZedClass.Length; j++ )
				ReplaceMonsterStr(KF.FinalSquads[i].ZedClass[j]);
		}
		KF.FallbackMonster = GetReplaceClass( Class<KFMonster>(KF.FallbackMonster) );

		KF.EndGameBossClass = string(Class'ZombieBossold');
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

final function Class<KFMonster> GetReplaceClass( Class<KFMonster> MC )
{
	switch( MC )
	{
	case Class'ZombieClot':
			return Class'Zombieclotold';
	case Class'ZombieBloat':
			return Class'Zombiebloatold';
	case Class'ZombieCrawler':
		return Class'Zombiecrawlerold';
	case Class'ZombieHusk':
            return Class'ZombieShadeold';
	case Class'ZombieStalker':
			return Class'Zombiestalkerold';
	case Class'ZombieSiren':
			return Class'Zombiesirenold';
	case Class'ZombieScrake':
			return Class'Zombiescrakeold';
	case Class'ZombieFleshPound':
		return Class'Zombiefleshpoundold';
	case Class'ZombieGorefast':
			return Class'Zombiegorefastold';
	case Class'ZombieBoss':
			return Class'ZombieBossold';
	default:
		return MC;
	}
}
final function ReplaceMonsterStr( out string MC )
{
	MC = string(GetReplaceClass(Class<KFMonster>(DynamicLoadObject(MC,Class'Class'))));
	
}

defaultproperties
{
     bAddToServerPackages=True
     GroupName="KF-MonsterMut"
     FriendlyName="2.51 Monsters"
     Description="Replaces specimens with their 2.5 mod counterparts."
}
