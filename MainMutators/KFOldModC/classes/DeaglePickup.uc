//=============================================================================
// Deagle Pickup.
//=============================================================================
class DeaglePickup extends KFWeaponPickup;

/*
function ShowDeagleInfo(Canvas C)
{
  C.SetPos((C.SizeX - C.SizeY) / 2,0);
  C.DrawTile( Texture'KillingfloorHUD.ClassMenu.Deagle', C.SizeY, C.SizeY, 0.0, 0.0, 256, 256);
}
*/

function inventory SpawnCopy( pawn Other )
{
	local Inventory I;

	For( I=Other.Inventory; I!=None; I=I.Inventory )
	{
		if( Deagle(I)!=None )
		{
			if( Inventory!=None )
				Inventory.Destroy();
			InventoryType = Class'DualDeagle';
			I.Destroyed();
			I.Destroy();
			Return Super.SpawnCopy(Other);
		}
	}
	InventoryType = Default.InventoryType;
	Return Super.SpawnCopy(Other);
}

defaultproperties
{
     Weight=5.000000
     cost=200
     AmmoCost=15
     BuyClipSize=7
     PowerValue=65
     SpeedValue=35
     RangeValue=60
     Description="50 Cal AE handgun. A powerful personal choice for personal defense."
     ItemName="Handcannon"
     ItemShortName="Handcannon"
     AmmoItemName=".300 JHP Ammo"
     CorrespondingPerkIndex=2
     EquipmentCategoryID=1
     InventoryType=Class'KFOldModC.Deagle'
     PickupMessage="You got the Handcannon"
     PickupSound=Sound'KFOldModSnd.Weapon.GunPickupKF'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KillingFloorStatics.3PDeagle_Ground'
     DrawScale=0.400000
     CollisionHeight=5.000000
}
