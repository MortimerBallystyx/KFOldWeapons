// Spawn Random items / weapons in to keep the envirments searchable and dynamic :)
// Modded from WildcardBase to allow for all pickup classtypes, not just tournament ones.
class OldRandomAmmoSpawn extends KFRandomSpawn;

defaultproperties
{
     PickupClasses(0)=class'SingleAmmoPickup'
     PickupClasses(1)=class'ShotgunAmmoPickup'
     PickupClasses(2)=class'BullpupAmmoPickup'
     PickupClasses(3)=class'DeagleAmmoPickup'
     PickupClasses(4)=class'WinchesterAmmoPickup'
     PickupClasses(5)=class'CrossbowAmmoPickup'
     PickupClasses(6)=class'LAWAmmoPickup'
     PickupClasses(7)=class'DBShotgunAmmoPickup'
     PickupClasses(8)=class'FragAmmoPickup'
     PickupClasses(9)=class'FTAmmoPickup'
     PickupClasses(10)=class'KFMod.CashPickup'
     PickupWeight(0)=3
     PickupWeight(1)=3
     PickupWeight(2)=3
     PickupWeight(3)=3
     PickupWeight(4)=3
     PickupWeight(8)=3
     PickupWeight(9)=3
     Texture=none
}
