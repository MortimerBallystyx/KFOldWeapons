//=============================================================================
// Deagle Ammo.
//=============================================================================
class KFMODDeagleAmmo extends KFAmmunition;

#EXEC OBJ LOAD FILE=InterfaceContent.utx

defaultproperties
{
     AmmoPickupAmount=16
     MaxAmmo=90
     InitialAmount=35
     PickupClass=class'KFMODDeagleAmmoPickup'
     IconMaterial=Texture'KillingFloorHUD.Generic.HUD'
     IconCoords=(X1=338,Y1=40,X2=393,Y2=79)
     ItemName="Deagle bullets"
}
