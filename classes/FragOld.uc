//=============================================================================
// Frag Grenade Inventory class
//=============================================================================
class FragOld extends Frag;

defaultproperties
{
     FireModeClass(0)=class'FragFire'
     PickupClass=class'FragPickup'
     AttachmentClass=class'FragAttachment'
     Mesh=SkeletalMesh'KFWeaponModelsOldMod.Frag'
     Skins(0)=Texture'KillingFloorWeapons.Deagle.HandSkinNew'
     Skins(1)=Texture'KillingFloorWeapons.Deagle.ArmSkinNew'
     Skins(2)=Shader'KillingFloorWeapons.Frag_Grenade.FragShader'
}
