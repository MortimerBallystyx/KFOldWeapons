// Spawn Random items / weapons in to keep the envirments searchable and dynamic :)
// Modded from WildcardBase to allow for all pickup classtypes, not just tournament ones.
class OldRandomItemSpawn extends KFRandomSpawn;

var() class<Pickup> PickupClasses[19];
var() int PickupWeight[19];

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
     PickupClasses(8)=class'SingleAmmoPickup'
     PickupClasses(9)=class'ShotgunAmmoPickup'
     PickupClasses(10)=class'BullpupAmmoPickup'
     PickupClasses(11)=class'DeagleAmmoPickup'
     PickupClasses(12)=class'WinchesterAmmoPickup'
     PickupClasses(13)=class'CrossbowAmmoPickup'
     PickupClasses(14)=class'LAWAmmoPickup'
     PickupClasses(15)=class'DBShotgunAmmoPickup'
     PickupClasses(16)=class'FragAmmoPickup'
     PickupClasses(17)=class'FTAmmoPickup'
     PickupClasses(18)=class'KFMod.CashPickup'
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
