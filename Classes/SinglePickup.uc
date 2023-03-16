//=============================================================================
// Single Pickup.
//=============================================================================
class SinglePickup extends KFWeaponPickup;

function inventory SpawnCopy( pawn Other )
{
    local Inventory I;

    for( I=Other.Inventory; I!=none; I=I.Inventory )
    {
        if( Single(I)!=none )
        {
            if( Inventory!=none )
                Inventory.Destroy();
            InventoryType = class'Dualies';
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
     Weight=0.000000
     cost=0
     AmmoCost=10
     BuyClipSize=30
     PowerValue=20
     SpeedValue=50
     RangeValue=35
     Description="A 9mm handgun."
     ItemName="9mm Pistol"
     ItemShortName="9mm Pistol"
     AmmoItemName="9mm Rounds"
     AmmoMesh=StaticMesh'KillingFloorStatics.DualiesAmmo'
     CorrespondingPerkIndex=2
     EquipmentCategoryID=1
     InventoryType=class'Single'
     PickupMessage="You got the 9mm handgun"
     PickupSound=Sound'KFOldModSnd.Weapon.GunPickupKF'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KillingFloorStatics.SingleGround'
     DrawScale=0.400000
     CollisionHeight=5.000000
}
