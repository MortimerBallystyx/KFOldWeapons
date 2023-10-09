//=============================================================================
// Bat Pickup.
//=============================================================================
class KFMODBatPickup extends KFWeaponPickup;

defaultproperties
{
     Weight=1.000000
     cost=233
     PowerValue=45
     SpeedValue=70
     RangeValue=-20
     Description="This bit of broken pipe looks like it was pried from a gas-line."
     ItemName="Broken Pipe"
     ItemShortName="Broken Pipe"
     CorrespondingPerkIndex=4
     InventoryType=class'KFMODBat'
     PickupMessage="You got a broken pipe."
     PickupSound=Sound'KFOldModSnd.Weapon.pickupm2-2'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KillingFloorStatics.BatGround'
     DrawScale=0.400000
     CollisionRadius=28.000000
     CollisionHeight=5.000000
}
