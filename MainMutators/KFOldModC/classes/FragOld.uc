//=============================================================================
// Frag Grenade Inventory class
//=============================================================================
class FragOld extends Frag;

defaultproperties
{
     FireModeClass(0)=Class'KFOldModC.FragFire'
     PickupClass=Class'KFOldModC.FragPickup'
     AttachmentClass=Class'KFOldModC.FragAttachment'
     Mesh=SkeletalMesh'KFWeaponModelsOldMod.Frag'
     Skins(0)=Texture'KillingFloorWeapons.Deagle.HandSkinNew'
     Skins(1)=Texture'KillingFloorWeapons.Deagle.ArmSkinNew'
     Skins(2)=Shader'KillingFloorWeapons.Frag_Grenade.FragShader'
}
