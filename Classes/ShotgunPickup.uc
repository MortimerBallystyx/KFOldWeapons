//=============================================================================
// Shotgun Pickup.
//=============================================================================
class ShotgunPickup extends KFWeaponPickup;

/*
function ShowShotgunInfo(Canvas C)
{
  C.SetPos((C.SizeX - C.SizeY) / 2,0);
  C.DrawTile( Texture'KillingfloorHUD.ClassMenu.Shotgun', C.SizeY, C.SizeY, 0.0, 0.0, 256, 256);
}
*/

defaultproperties
{
     Weight=8.000000
     cost=500
     BuyClipSize=8
     PowerValue=70
     SpeedValue=40
     RangeValue=15
     Description="A rugged 12-gauge pump action shotgun. "
     ItemName="Shotgun"
     ItemShortName="Shotgun"
     AmmoItemName="12-gauge shells"
     CorrespondingPerkIndex=1
     EquipmentCategoryID=2
     InventoryType=class'Shotgun'
     PickupMessage="You got the Shotgun."
     PickupSound=Sound'KFOldModSnd.Weapon.GunPickupKF'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KillingFloorStatics.3PShotgun_Ground'
     DrawScale=0.400000
     CollisionRadius=35.000000
     CollisionHeight=5.000000
}
