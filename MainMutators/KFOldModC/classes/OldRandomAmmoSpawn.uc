// Spawn Random items / weapons in to keep the envirments searchable and dynamic :)
// Modded from WildcardBase to allow for all pickup classtypes, not just tournament ones.
class OldRandomAmmoSpawn extends KFRandomSpawn;

defaultproperties
{
     PickupClasses(0)=Class'KFOldModC.SingleAmmoPickup'
     PickupClasses(1)=Class'KFOldModC.ShotgunAmmoPickup'
     PickupClasses(2)=Class'KFOldModC.BullpupAmmoPickup'
     PickupClasses(3)=Class'KFOldModC.DeagleAmmoPickup'
     PickupClasses(4)=Class'KFOldModC.WinchesterAmmoPickup'
     PickupClasses(5)=Class'KFOldModC.CrossbowAmmoPickup'
     PickupClasses(6)=Class'KFOldModC.LAWAmmoPickup'
     PickupClasses(7)=Class'KFOldModC.DBShotgunAmmoPickup'
     PickupClasses(8)=Class'KFOldModC.FragAmmoPickup'
     PickupClasses(9)=Class'KFOldModC.FTAmmoPickup'
     PickupClasses(10)=Class'KFMod.CashPickup'
     PickupWeight(0)=3
     PickupWeight(1)=3
     PickupWeight(2)=3
     PickupWeight(3)=3
     PickupWeight(4)=3
     PickupWeight(8)=3
     PickupWeight(9)=3
     Texture=None
}
