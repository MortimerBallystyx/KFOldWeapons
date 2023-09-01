class CrossbowPickup extends KFWeaponPickup;

#exec OBJ LOAD FILE=KillingFloorWeapons.utx
#exec OBJ LOAD FILE=WeaponStaticMesh.usx

defaultproperties
{
     cost=933
     Weight=9.000000
     AmmoCost=75
     BuyClipSize=1
     PowerValue=90
     SpeedValue=50
     RangeValue=100
     Description="Recreational hunting weapon, equipped with powerful scope and firing trigger. Exceptional headshot damage."
     ItemName="Crossbow"
     ItemShortName="Crossbow"
     AmmoItemName="Crossbow Bolts"
     AmmoMesh=StaticMesh'KillingFloorStatics.XbowAmmo'
     CorrespondingPerkIndex=2
     EquipmentCategoryID=3
     MaxDesireability=0.790000
     InventoryType=class'Crossbow'
     PickupMessage="You got the Crossbow."
     PickupSound=Sound'KFOldModSnd.Weapon.GunPickupKF'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KillingFloorStatics.XbowGround'
     DrawScale=0.400000
     CollisionRadius=25.000000
     CollisionHeight=10.000000
}
