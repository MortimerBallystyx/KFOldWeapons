// Spawn Random items / weapons in to keep the envirments searchable and dynamic :)
// Modded from WildcardBase to allow for all pickup classtypes, not just tournament ones.
class OldRandomItemSpawn extends KFRandomSpawn;

var() class<Pickup> PickupClasses[9];
var() int PickupWeight[9];

defaultproperties
{
     PickupClasses(0)=class'DualiesPickup'
     PickupClasses(1)=class'ShotgunPickup'
     PickupClasses(2)=class'BullpupPickup'
     PickupClasses(3)=class'DeaglePickup'
     PickupClasses(4)=class'WinchesterPickup'
     PickupClasses(5)=class'AxePickup'
     PickupClasses(6)=class'BatPickup'
     PickupClasses(7)=class'KFMod.Vest'
     PickupWeight(0)=3
     PickupWeight(1)=1
     PickupWeight(2)=3
     PickupWeight(3)=3
     PickupWeight(4)=2
     PickupWeight(5)=1
     PickupWeight(6)=1
     PickupWeight(7)=2
     Texture=none
}
