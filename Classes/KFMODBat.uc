//=============================================================================
// Bat Inventory class
//=============================================================================
class KFMODBat extends KFMeleeGun;

defaultproperties
{
     weaponRange=80.000000
     ChopSlowRate=0.350000
     bSpeedMeUp=true
     HudImage=Texture'KillingFloorHUD.WeaponSelect.machette'
     StandardDisplayFOV=70.000000
     SleeveNum=4
	 Weight=1.000000
     FireModeClass(0)=class'KFMODBatFire'
     FireModeClass(1)=class'KFMod.NoFire'
     AIRating=0.400000
     CurrentRating=0.400000
     Description="This bit of broken pipe looks like it was pried from a gas-line."
     DisplayFOV=70.000000
     Priority=8
     GroupOffset=2
     PickupClass=class'KFMODBatPickup'
     PlayerViewOffset=(X=20.000000,Y=29.000000,Z=-7.000000)
     BobDamping=8.000000
     AttachmentClass=class'KFMODBatAttachment'
     IconCoords=(Y1=407,X2=118,Y2=442)
     ItemName="Broken Pipe"
     Mesh=SkeletalMesh'KFWeaponModelsOldMod.Bat'
     Skins(0)=Texture'KillingFloorWeapons.Deagle.HandSkinNew'
     Skins(1)=Texture'KillingFloorWeapons.Deagle.ArmSkinNew'
     Skins(2)=Shader'KillingFloorWeapons.Bat.BatShineShader'
}
