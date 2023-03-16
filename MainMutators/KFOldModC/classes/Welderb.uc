//=============================================================================
// WelderB Inventory class
//=============================================================================
class WelderB extends Welder
	dependson(KFVoicePack);

defaultproperties
{
     SleeveNum=6
     PickupClass=Class'KFOldModC.WelderPickup'
     PlayerViewOffset=(X=20.000000,Y=25.000000,Z=-10.000000)
     AttachmentClass=Class'KFOldModC.WelderAttachment'
     Mesh=SkeletalMesh'KFWeaponModelsOldMod.Welder'
     Skins(0)=Texture'KillingFloorWeapons.Deagle.HandSkinNew'
     Skins(1)=Texture'KillingFloorWeapons.Deagle.ArmSkinNew'
     Skins(2)=Shader'KillingFloorWeapons.Welder.WelderShader'
     Skins(3)=FinalBlend'KillingFloorWeapons.Welder.WeldWindowFB'
     Skins(4)=Shader'KillingFloorWeapons.Welder.FlameShader'
}
