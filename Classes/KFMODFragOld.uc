//=============================================================================
// Frag Grenade Inventory class
//=============================================================================
class KFMODFragOld extends Frag;

defaultproperties
{
     FireModeClass(0)=class'KFMODFragFire'
     PickupClass=class'KFMODFragPickup'
     AttachmentClass=class'KFMODFragAttachment'
     Mesh=SkeletalMesh'KFWeaponModelsOldMod.Frag'
     Skins(0)=Texture'KillingFloorWeapons.Deagle.HandSkinNew'
     Skins(1)=Texture'KillingFloorWeapons.Deagle.ArmSkinNew'
     Skins(2)=Shader'KillingFloorWeapons.Frag_Grenade.FragShader'
}
