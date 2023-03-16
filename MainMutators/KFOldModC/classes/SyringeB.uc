//=============================================================================
// Syringe Inventory class
//=============================================================================
class SyringeB extends Syringe;

defaultproperties
{
     SleeveNum=5
     FireModeClass(0)=Class'KFOldModC.SyringeFireB'
     FireModeClass(1)=Class'KFOldModC.SyringeAltFire'
     PickupClass=Class'KFOldModC.SyringePickup'
     PlayerViewOffset=(X=10.000000,Z=-10.000000)
     AttachmentClass=Class'KFOldModC.SyringeAttachment'
     Mesh=SkeletalMesh'KFWeaponModelsOldMod.Syringe'
     Skins(0)=Shader'KillingFloorWeapons.Syringe.SyringeShader'
     Skins(1)=Texture'KillingFloorWeapons.Deagle.HandSkinNew'
     Skins(2)=Texture'KillingFloorWeapons.Deagle.ArmSkinNew'
     Skins(3)=FinalBlend'KillingFloorWeapons.Syringe.TubeGoopFB'
}
