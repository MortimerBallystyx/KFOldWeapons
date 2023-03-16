//=============================================================================
// Axe Inventory class
//=============================================================================
class Axe extends KFMeleeGun;

defaultproperties
{
     weaponRange=80.000000
     ChopSlowRate=0.200000
     bSpeedMeUp=True
     HudImage=Texture'KillingFloorHUD.WeaponSelect.axe_unselected'
     SelectedHudImage=Texture'KillingFloorHUD.WeaponSelect.Axe'
     Weight=5.000000
     StandardDisplayFOV=75.000000
     SleeveNum=4
     TraderInfoTexture=Texture'KillingFloorHUD.Trader_Weapon_Images.Trader_Axe'
     FireModeClass(0)=Class'KFOldModC.AxeFire'
     FireModeClass(1)=Class'KFMod.NoFire'
     SelectSound=SoundGroup'KF_AxeSnd.Axe_Select'
     AIRating=0.300000
     Description="A common two-handed fireman's axe."
     DisplayFOV=75.000000
     Priority=4
     GroupOffset=3
     PickupClass=Class'KFOldModC.AxePickup'
     PlayerViewOffset=(X=24.000000,Y=-10.000000,Z=-10.500000)
     BobDamping=8.000000
     AttachmentClass=Class'KFOldModC.AxeAttachment'
     IconCoords=(X1=169,Y1=39,X2=241,Y2=77)
     ItemName="Axe"
     Mesh=SkeletalMesh'KFWeaponModelsOldMod.Axe'
     Skins(0)=Shader'KillingFloorWeapons.Axe.AxeShineShader'
     Skins(1)=Texture'KillingFloorWeapons.Deagle.HandSkinNew'
     Skins(2)=Texture'KillingFloorWeapons.Deagle.ArmSkinNew'
}
