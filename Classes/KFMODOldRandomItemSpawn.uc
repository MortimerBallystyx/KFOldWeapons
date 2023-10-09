// Spawn Random items / weapons in to keep the envirments searchable and dynamic :)
// Modded from WildcardBase to allow for all pickup classtypes, not just tournament ones.
class KFMODOldRandomItemSpawn extends KFRandomSpawn;

//var() class<Pickup> PickupClasses[9];
//var() int PickupWeight[9];

defaultproperties
{
     PickupClasses(0)=class'KFMODDualiesPickup'
     PickupClasses(1)=class'KFMODShotgunPickup'
     PickupClasses(2)=class'KFMODBullpupPickup'
     PickupClasses(3)=class'KFMODDeaglePickup'
     PickupClasses(4)=class'KFMODWinchesterPickup'
     PickupClasses(5)=class'KFMODAxePickup'
     PickupClasses(6)=class'KFMODBatPickup'
     PickupClasses(7)=class'KFMod.Vest'
     PickupClasses(8)=class'KFMod.CashPickup'
     PickupWeight(0)=3
     PickupWeight(1)=1
     PickupWeight(2)=3
     PickupWeight(3)=3
     PickupWeight(4)=2
     PickupWeight(5)=1
     PickupWeight(6)=1
     PickupWeight(7)=2
     PickupWeight(8)=1
     Texture=none
}
