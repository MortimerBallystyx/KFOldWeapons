class KFMODCrossbowAmmo extends KFAmmunition;

#EXEC OBJ LOAD FILE=KillingFloorHUD.utx

defaultproperties
{
     AmmoPickupAmount=8
     MaxAmmo=36
     InitialAmount=10
     PickupClass=class'KFMODCrossbowAmmoPickup'
     IconMaterial=Texture'KillingFloorHUD.Generic.HUD'
     IconCoords=(X1=4,Y1=350,X2=110,Y2=395)
     ItemName="An arrow"
}
