class LAWPickup extends KFWeaponPickup;

#exec OBJ LOAD FILE=KillingFloorWeapons.utx
#exec OBJ LOAD FILE=WeaponStaticMesh.usx

defaultproperties
{
     Weight=14.000000
     cost=600
     AmmoCost=30
     BuyClipSize=1
     PowerValue=100
     SpeedValue=20
     RangeValue=64
     Description="Light Anti Tank weapon. Designed to punch through armored vehicles."
     ItemName="L.A.W"
     ItemShortName="L.A.W"
     AmmoItemName="L.A.W Rockets"
     AmmoMesh=StaticMesh'KillingFloorStatics.LAWAmmo'
     CorrespondingPerkIndex=1
     EquipmentCategoryID=3
     MaxDesireability=0.790000
     InventoryType=Class'KFOldModC.LAW'
     RespawnTime=60.000000
     PickupMessage="You got the L.A.W."
     PickupSound=Sound'KFOldModSnd.Weapon.GunPickupKF'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'KillingFloorStatics.LAWGround'
     DrawScale=0.400000
     CollisionRadius=35.000000
     CollisionHeight=10.000000
}
