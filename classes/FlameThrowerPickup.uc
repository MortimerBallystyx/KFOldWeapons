//=============================================================================
// L85 Pickup.
//=============================================================================
class FlameThrowerPickup extends KFWeaponPickup;

defaultproperties
{
     cost=850
     AmmoCost=30
     BuyClipSize=50
     PowerValue=35
     SpeedValue=100
     RangeValue=40
     Description="A deadly experimental weapon designed by Horzine industries. It can fire streams of burning liquid which ignite on contact."
     ItemName="FlameThrower"
     ItemShortName="FlameThrower"
     AmmoItemName="Napalm"
     AmmoMesh=StaticMesh'KillingFloorStatics.FT_AmmoMesh'
     CorrespondingPerkIndex=5
     EquipmentCategoryID=3
     InventoryType=class'FlameThrower'
     PickupMessage="You got the FlameThrower"
     PickupSound=Sound'KF_FlamethrowerSnd.FT_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KillingFloorStatics.FTGround'
     DrawScale=0.400000
     CollisionRadius=30.000000
     CollisionHeight=5.000000
}
