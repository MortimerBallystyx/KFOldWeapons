// Spawn Random items / weapons in to keep the envirments searchable and dynamic :)
// Modded from WildcardBase to allow for all pickup classtypes, not just tournament ones.
class KFMODOldRandomAmmoSpawn extends KFRandomSpawn;

defaultproperties
{
     PickupClasses(0)=class'KFMODSingleAmmoPickup'
     PickupClasses(1)=class'KFMODShotgunAmmoPickup'
     PickupClasses(2)=class'KFMODBullpupAmmoPickup'
     PickupClasses(3)=class'KFMODDeagleAmmoPickup'
     PickupClasses(4)=class'KFMODWinchesterAmmoPickup'
     PickupClasses(5)=class'KFMODCrossbowAmmoPickup'
     PickupClasses(6)=class'KFMODLAWAmmoPickup'
     PickupClasses(7)=class'KFMODDBShotgunAmmoPickup'
     PickupClasses(8)=class'KFMODFragAmmoPickup'
     PickupClasses(9)=class'KFMODFTAmmoPickup'
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
