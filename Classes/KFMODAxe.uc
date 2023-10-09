//=============================================================================
// Axe Inventory class
//=============================================================================
class KFMODAxe extends KFMeleeGun;

defaultproperties
{
     weaponRange=80.000000
     ChopSlowRate=0.200000
     bSpeedMeUp=true
     HudImage=Texture'KillingFloorHUD.WeaponSelect.axe_unselected'
     SelectedHudImage=Texture'KillingFloorHUD.WeaponSelect.Axe'
     Weight=5.000000
     StandardDisplayFOV=75.000000
     SleeveNum=4
     TraderInfoTexture=Texture'KillingFloorHUD.Trader_Weapon_Images.Trader_Axe'
     FireModeClass(0)=class'KFMODAxeFire'
     FireModeClass(1)=class'KFMod.NoFire'
     SelectSound=SoundGroup'KF_AxeSnd.Axe_Select'
     AIRating=0.300000
     Description="A common two-handed fireman's axe."
     DisplayFOV=75.000000
     Priority=4
     GroupOffset=3
     PickupClass=class'KFMODAxePickup'
     PlayerViewOffset=(X=24.000000,Y=-10.000000,Z=-10.500000)
     BobDamping=8.000000
     AttachmentClass=class'KFMODAxeAttachment'
     IconCoords=(X1=169,Y1=39,X2=241,Y2=77)
     ItemName="Axe"
     Mesh=SkeletalMesh'KFWeaponModelsOldMod.Axe'
     Skins(0)=Shader'KillingFloorWeapons.Axe.AxeShineShader'
     Skins(1)=Texture'KillingFloorWeapons.Deagle.HandSkinNew'
     Skins(2)=Texture'KillingFloorWeapons.Deagle.ArmSkinNew'
}
