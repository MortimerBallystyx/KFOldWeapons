//=============================================================================
// Frag Pickup.
//=============================================================================
class KFMODFragPickup extends BullpupPickup;

defaultproperties
{
     Weight=0.000000
     AmmoCost=40
     BuyClipSize=3
     Description="Fragmentation Grenades."
     ItemName="Grenades"
     ItemShortName="Grenades"
     AmmoItemName="Grenades"
     AmmoMesh=StaticMesh'KillingFloorStatics.FragPickup'
     EquipmentCategoryID=4
     InventoryType=class'KFMODFragOld'
     PickupMessage="You got some Frag Grenades"
     PickupSound=Sound'KF_GrenadeSnd.Nade_Pickup'
     StaticMesh=StaticMesh'KF_pickups_Trip.explosive.Frag_pickup'
     CollisionRadius=10.000000
     CollisionHeight=10.000000
}
