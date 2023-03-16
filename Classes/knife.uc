//=============================================================================
// Knife Inventory class
//=============================================================================
class Knife extends KFMeleeGun;

defaultproperties
{
     weaponRange=65.000000
     bSpeedMeUp=true
     HudImage=Texture'KillingFloorHUD.WeaponSelect.knife_unselected'
     SelectedHudImage=Texture'KillingFloorHUD.WeaponSelect.knife'
     Weight=0.000000
     bKFNeverThrow=true
     StandardDisplayFOV=75.000000
     SleeveNum=4
     TraderInfoTexture=Texture'KillingFloorHUD.Trader_Weapon_Images.Trader_Knife'
     FireModeClass(0)=class'KnifeFire'
     FireModeClass(1)=class'KnifeFireB'
     SelectSound=SoundGroup'KF_KnifeSnd.Knife_Select'
     AIRating=0.200000
     CurrentRating=0.200000
     Description="Military Combat Knife"
     DisplayFOV=75.000000
     Priority=2
     GroupOffset=1
     PickupClass=class'KnifePickup'
     PlayerViewOffset=(X=4.000000,Y=5.500000,Z=-4.000000)
     PlayerViewPivot=(Pitch=400)
     BobDamping=6.000000
     AttachmentClass=class'KnifeAttachment'
     IconCoords=(X1=246,Y1=80,X2=332,Y2=106)
     ItemName="Knife"
     Mesh=SkeletalMesh'KFWeaponModelsOldMod.knife'
     DrawScale=0.300000
     Skins(0)=Texture'KillingFloorWeapons.Deagle.HandSkinNew'
     Skins(1)=Texture'KillingFloorWeapons.Deagle.ArmSkinNew'
     Skins(2)=Shader'KillingFloorWeapons.knife.KnifeShineShader'
}
