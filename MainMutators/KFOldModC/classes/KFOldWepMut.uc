//-----------------------------------------------------------
class KFOldWepMut extends Mutator;

function PostNetBeginPlay()
{
	//Timer event happens in x seconds, and (true) event keeps happening every x seconds
	SetTimer(1.0, false);

	//makes this mutator appear as if it has a ServerPackages entry in KillingFloor.ini
	////under [Engine.GameEngine]
	self.AddToPackageMap();
}

//This function should not be simulated
function Timer()
{
    local KFGameType KF;

    KF = KFGameType(Level.Game);
    if ( KF!=None )
    {
        if( KF.KFLRules!=None )
            KF.KFLRules.Destroy();
        KF.KFLRules = Spawn(Class'KFOldlevelRules');
    }
}

function bool CheckReplacement( Actor Other, out byte bSuperRelevant )
{
	bSuperRelevant = 0;

	if ( Other == None )
		return true;

	if (Other.IsA('KFRandomItemSpawn') && !Other.IsA('OldRandomItemSpawn'))
	{
		ReplaceWith( Other, "KFOldModC.OldRandomItemSpawn" );
		return false;

	}





    if ( Other.IsA('KFHumanPawn') )
	{
		KFHumanPawn(Other).RequiredEquipment[0] = "KFOldModC.Single";
		KFHumanPawn(Other).RequiredEquipment[1] = "KFOldModC.Fragold";
		KFHumanPawn(Other).RequiredEquipment[2] = "KFOldModC.Knife";
		KFHumanPawn(Other).RequiredEquipment[3] = "KFOldModC.Welderb";
		KFHumanPawn(Other).RequiredEquipment[4] = "KFOldModC.Syringeb";

		
		// delete inventory leftover from previous perks? or set perk to nothing in the perk mutator when a player dies?
		
		return true;
	}

	return true;
}

defaultproperties
{
     GroupName="KF-WeaponMut"
     FriendlyName="2.51 Weapons Mode!"
     Description="Use KF2.51 Weapons."
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}
