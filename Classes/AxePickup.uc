//=============================================================================
// Axe Pickup.
//=============================================================================
class AxePickup extends KFWeaponPickup;

defaultproperties
{
     Weight=5.000000
     cost=225
     PowerValue=56
     SpeedValue=32
     RangeValue=-20
     Description="A sturdy fireman's axe."
     ItemName="KFMOD Axe"
     ItemShortName="Axe"
     CorrespondingPerkIndex=4
     InventoryType=class'Axe'
     PickupMessage="You got the Fire Axe."
     PickupSound=Sound'KFOldModSnd.Weapon.pickupm2-3'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KillingFloorStatics.3PFireAxe_Ground'
     DrawScale=0.400000
     CollisionRadius=27.000000
     CollisionHeight=5.000000
}
