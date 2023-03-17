//=============================================================================
// Winchester Pickup.
//=============================================================================
class WinchesterPickup extends KFWeaponPickup;

/*
function ShowDeagleInfo(Canvas C)
{
  C.SetPos((C.SizeX - C.SizeY) / 2,0);
  C.DrawTile( Texture'KillingfloorHUD.ClassMenu.Deagle', C.SizeY, C.SizeY, 0.0, 0.0, 256, 256);
}
*/

defaultproperties
{
     Weight=6.000000
     cost=300
     BuyClipSize=10
     PowerValue=60
     SpeedValue=35
     RangeValue=90
     Description="A rugged and reliable single-shot rifle."
     ItemName="Lever Action Rifle"
     ItemShortName="Lever Action"
     AmmoItemName="Rifle bullets"
     CorrespondingPerkIndex=2
     EquipmentCategoryID=2
     InventoryType=class'Winchester'
     PickupMessage="You got the Lever Action Rifle"
     PickupSound=Sound'KFOldModSnd.Weapon.GunPickupKF'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KillingFloorStatics.WinchesterGround'
     DrawScale=0.400000
     CollisionRadius=30.000000
     CollisionHeight=5.000000
}
