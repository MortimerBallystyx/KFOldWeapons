// Spawn Random items / weapons in to keep the envirments searchable and dynamic :)
// Modded from WildcardBase to allow for all pickup classtypes, not just tournament ones.
class OldRandomItemSpawn extends KFRandomSpawn;

var() class<Pickup> PickupClasses[19];
var() int PickupWeight[19];

defaultproperties
{
     PickupClasses(0)=Class'KFOldModC.DualiesPickup'
     PickupClasses(1)=Class'KFOldModC.ShotgunPickup'
     PickupClasses(2)=Class'KFOldModC.BullpupPickup'
     PickupClasses(3)=Class'KFOldModC.DeaglePickup'
     PickupClasses(4)=Class'KFOldModC.WinchesterPickup'
     PickupClasses(5)=Class'KFOldModC.AxePickup'
     PickupClasses(6)=Class'KFOldModC.BatPickup'
     PickupClasses(7)=Class'KFMod.Vest'
     PickupClasses(8)=Class'KFOldModC.SingleAmmoPickup'
     PickupClasses(9)=Class'KFOldModC.ShotgunAmmoPickup'
     PickupClasses(10)=Class'KFOldModC.BullpupAmmoPickup'
     PickupClasses(11)=Class'KFOldModC.DeagleAmmoPickup'
     PickupClasses(12)=Class'KFOldModC.WinchesterAmmoPickup'
     PickupClasses(13)=Class'KFOldModC.CrossbowAmmoPickup'
     PickupClasses(14)=Class'KFOldModC.LAWAmmoPickup'
     PickupClasses(15)=Class'KFOldModC.DBShotgunAmmoPickup'
     PickupClasses(16)=Class'KFOldModC.FragAmmoPickup'
     PickupClasses(17)=Class'KFOldModC.FTAmmoPickup'
     PickupClasses(18)=Class'KFMod.CashPickup'
     PickupWeight(0)=3
     PickupWeight(1)=1
     PickupWeight(2)=3
     PickupWeight(3)=3
     PickupWeight(4)=2
     PickupWeight(5)=1
     PickupWeight(6)=1
     PickupWeight(7)=2
     Texture=None
}
