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
    if ( KF!=none )
    {
        if( KF.KFLRules!=none )
            KF.KFLRules.Destroy();
        KF.KFLRules = Spawn(class'KFOldlevelRules');
    }
}

function bool CheckReplacement( Actor Other, out byte bSuperRelevant )
{
    bSuperRelevant = 0;

    if ( Other == none )
        return true;

    if (Other.IsA('KFRandomItemSpawn') && !Other.IsA('OldRandomItemSpawn'))
    {
        ReplaceWith( Other, string(class'OldRandomItemSpawn'));
        return false;

    }





    if ( Other.IsA('KFHumanPawn') )
    {
        KFHumanPawn(Other).RequiredEquipment[0] = string(class'Single');
        KFHumanPawn(Other).RequiredEquipment[1] = string(class'Fragold');
        KFHumanPawn(Other).RequiredEquipment[2] = string(class'Knife');
        KFHumanPawn(Other).RequiredEquipment[3] = string(class'Welderb');
        KFHumanPawn(Other).RequiredEquipment[4] = string(class'Syringeb');


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
     bAlwaysRelevant=true
     RemoteRole=ROLE_SimulatedProxy
}
