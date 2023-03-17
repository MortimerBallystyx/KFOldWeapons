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

    for( I=Other.Inventory; I!=none; I=I.Inventory )
    {
        if( Deagle(I)!=none )
        {
            if( Inventory!=none )
                Inventory.Destroy();
            InventoryType = class'DualDeagle';
            I.Destroyed();
            I.Destroy();
            return super.SpawnCopy(Other);
        }
    }
    InventoryType = default.InventoryType;
    return super.SpawnCopy(Other);
}

defaultproperties
{
     Weight=3.000000
     cost=500
     AmmoCost=15
     BuyClipSize=7
     PowerValue=75
     SpeedValue=35
     RangeValue=60
     Description="50 Cal AE handgun. A powerful personal choice for personal defense."
     ItemName="Handcannon"
     ItemShortName="Handcannon"
     AmmoItemName=".300 JHP Ammo"
     CorrespondingPerkIndex=2
     EquipmentCategoryID=1
     InventoryType=class'Deagle'
     PickupMessage="You got the Handcannon"
     PickupSound=Sound'KFOldModSnd.Weapon.GunPickupKF'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KillingFloorStatics.3PDeagle_Ground'
     DrawScale=0.400000
     CollisionHeight=5.000000
}
