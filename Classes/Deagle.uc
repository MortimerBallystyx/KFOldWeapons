//=============================================================================
// Deagle Inventory class
//=============================================================================
class Deagle extends KFWeapon;


function float GetAIRating()
{
    local Bot B;


    B = Bot(Instigator.Controller);
    if ( (B == none) || (B.Enemy == none) )
        return AIRating;

    return (AIRating + 0.0003 * FClamp(1500 - VSize(B.Enemy.Location - Instigator.Location),0,1000));
}

function byte BestMode()
{
    return 0;
}

simulated function bool PutDown()
{
    if ( Instigator.PendingWeapon.class == class'DualDeagle' )
    {
        bIsReloading = false;
    }

    return super(KFWeapon).PutDown();
}

defaultproperties
{
     MagCapacity=8
     ReloadRate=2.100000
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     WeaponReloadAnim="Reload_Single9mm"
     HudImage=Texture'KillingFloorHUD.WeaponSelect.handcannon_unselected'
     SelectedHudImage=Texture'KillingFloorHUD.WeaponSelect.handcannon'
     Weight=4.000000
     IdleAimAnim="Idle_Iron"
     StandardDisplayFOV=60.000000
     bModeZeroCanDryFire=true
     TraderInfoTexture=Texture'KillingFloorHUD.Trader_Weapon_Images.Trader_Handcannon'
     ZoomedDisplayFOV=50.000000
     FireModeClass(0)=class'DeagleFire'
     FireModeClass(1)=class'KFMod.NoFire'
     PutDownAnim="PutDown"
     SelectSound=Sound'KF_HandcannonSnd.50AE_Select'
     AIRating=0.450000
     CurrentRating=0.450000
     bShowChargingBar=true
     Description=".50 calibre action express handgun. This is about as big and nasty as personal weapons are going to get. But with a 7 round magazine, it should be used conservatively.  "
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=60.000000
     Priority=5
     InventoryGroup=2
     GroupOffset=3
     PickupClass=class'DeaglePickup'
     PlayerViewOffset=(X=30.000000,Y=20.500000,Z=-8.000000)
     BobDamping=6.000000
     AttachmentClass=class'DeagleAttachment'
     IconCoords=(X1=250,Y1=110,X2=330,Y2=145)
     ItemName="Handcannon"
     bUseDynamicLights=true
     Mesh=SkeletalMesh'KFWeaponModelsOldMod.Deagle'
     Skins(0)=Shader'KillingFloorWeapons.Deagle.DeagleShineShader'
     Skins(1)=Shader'KillingFloorWeapons.Deagle.DeagleMagShader'
     Skins(2)=Texture'KillingFloorWeapons.Deagle.HandSkinNew'
     Skins(3)=Texture'KillingFloorWeapons.Deagle.ArmSkinNew'
     TransientSoundVolume=75.000000
}
