//=============================================================================
// Shotgun Inventory class
//=============================================================================
class Shotgun extends KFWeaponShotgun;

defaultproperties
{
     FirstPersonFlashlightOffset=(X=-25.000000,Y=-18.000000,Z=8.000000)
     MagCapacity=8
     ReloadRate=0.600000
     ReloadAnim="Reload"
     ReloadAnimRate=0.600000
     WeaponReloadAnim="Reload_Shotgun"
     HudImage=Texture'KillingFloorHUD.WeaponSelect.combat_shotgun_unselected'
     SelectedHudImage=Texture'KillingFloorHUD.WeaponSelect.combat_shotgun'
     Weight=8.000000
     IdleAimAnim="Idle_Iron"
     StandardDisplayFOV=65.000000
     bModeZeroCanDryFire=true
     TraderInfoTexture=Texture'KillingFloorHUD.Trader_Weapon_Images.Trader_Combat_Shotgun'
     PlayerIronSightFOV=70.000000
     ZoomedDisplayFOV=40.000000
     FireModeClass(0)=class'ShotgunFire'
     FireModeClass(1)=class'KFMod.NoFire'
     PutDownAnim="PutDown"
     SelectSound=Sound'KFOldModSnd.Weapon.getweaponout'
     AIRating=0.600000
     CurrentRating=0.600000
     bShowChargingBar=true
     Description="A rugged tactical pump action shotgun common to police divisions the world over. It accepts a maximum of 8 shells and can fire in rapid succession. "
     DisplayFOV=75.000000
     Priority=8
     InventoryGroup=3
     GroupOffset=2
     PickupClass=class'ShotgunPickup'
     PlayerViewOffset=(X=2.000000,Y=18.750000,Z=-7.500000)
     BobDamping=7.000000
     AttachmentClass=class'ShotgunAttachment'
     IconCoords=(X1=169,Y1=172,X2=245,Y2=208)
     ItemName="Shotgun"
     Mesh=SkeletalMesh'KFWeaponModelsOldMod.Shotgun'
     Skins(0)=Texture'KillingFloorWeapons.Deagle.HandSkinNew'
     Skins(1)=Texture'KillingFloorWeapons.Deagle.ArmSkinNew'
     Skins(2)=Texture'KillingFloorWeapons.Deagle.HandSkinNew'
     Skins(3)=Texture'KillingFloorWeapons.Deagle.ArmSkinNew'
     Skins(4)=Shader'KillingFloorWeapons.Shotgun.ShotgunShineShader'
     TransientSoundVolume=1.000000
}
