//=============================================================================
// Dualies Pickup.
//=============================================================================
class KFMODDualiesPickup extends KFWeaponPickup;

function ShowDualiesInfo(Canvas C)
{
    C.SetPos((C.SizeX - C.SizeY) / 2,0);
    C.DrawTile( Texture'KillingfloorHUD.ClassMenu.Dualies', C.SizeY, C.SizeY, 0.0, 0.0, 256, 256);
}

defaultproperties
{
     Weight=2.000000
     cost=300
     AmmoCost=10
     BuyClipSize=30
     PowerValue=40
     SpeedValue=85
     RangeValue=35
     Description="A pair of custom 9mm handguns."
     ItemName="Dual 9mms"
     ItemShortName="Dual 9mms"
     AmmoItemName="9mm Rounds"
     AmmoMesh=StaticMesh'KillingFloorStatics.DualiesAmmo'
     CorrespondingPerkIndex=2
     EquipmentCategoryID=1
     InventoryType=class'KFMODDualies'
     PickupMessage="You found another 9mm handgun"
     PickupSound=Sound'KFOldModSnd.Weapon.GunPickupKF'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KillingFloorStatics.SingleGround'
     DrawScale=0.400000
     CollisionHeight=5.000000
}
