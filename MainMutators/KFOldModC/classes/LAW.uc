class LAW extends KFWeaponShotgun;

// Killing Floor's Light Anti Tank Weapon.
// This is probably about as badass as things get....


simulated event WeaponTick(float dt)
{
	if(AmmoAmount(0) == 0)
		MagAmmoRemaining = 0;
	super.Weapontick(dt);
}

/**
 * Handles all the functionality for zooming in including
 * setting the parameters for the weapon, pawn, and playercontroller
 *
 * @param bAnimateTransition whether or not to animate this zoom transition
 */
simulated function ZoomIn(bool bAnimateTransition)
{
    if( Level.TimeSeconds < FireMode[0].NextFireTime )
    {
        return;
    }

    super.ZoomIn(bAnimateTransition);

    if( bAnimateTransition )
    {
        if( bZoomOutInterrupted )
        {
            PlayAnim('Raise',1.0,0.1);
        }
        else
        {
            PlayAnim('Raise',1.0,0.1);
        }
    }
}


/**
 * Handles all the functionality for zooming out including
 * setting the parameters for the weapon, pawn, and playercontroller
 *
 * @param bAnimateTransition whether or not to animate this zoom transition
 */
simulated function ZoomOut(bool bAnimateTransition)
{
    super.ZoomOut(false);

    if( bAnimateTransition )
    {
        TweenAnim(IdleAnim,FastZoomOutTime);
    }
}

defaultproperties
{
     MagCapacity=1
     ReloadRate=3.000000
     WeaponReloadAnim="Reload_LAW"
     MinimumFireRange=300
     HudImage=Texture'KillingFloorHUD.WeaponSelect.law_unselected'
     SelectedHudImage=Texture'KillingFloorHUD.WeaponSelect.LAW'
     Weight=14.000000
     bHasAimingMode=True
     IdleAimAnim="AimIdle"
     StandardDisplayFOV=75.000000
     SleeveNum=8
     TraderInfoTexture=Texture'KillingFloorHUD.Trader_Weapon_Images.Trader_Law'
     PlayerIronSightFOV=90.000000
     ZoomTime=0.260000
     ZoomedDisplayFOV=65.000000
     FireModeClass(0)=Class'KFOldModC.LAWFire'
     FireModeClass(1)=Class'KFMod.NoFire'
     PutDownAnim="PutDown"
     SelectSound=Sound'KF_LAWSnd.LAW_Select'
     SelectForce="SwitchToRocketLauncher"
     AIRating=1.500000
     CurrentRating=1.500000
     bSniping=False
     Description="The Light Anti Tank Weapon is, as its name suggests, a military grade heavy weapons platform designed to disable or outright destroy armored vehicles."
     EffectOffset=(X=50.000000,Y=1.000000,Z=10.000000)
     DisplayFOV=75.000000
     Priority=50
     HudColor=(G=0)
     InventoryGroup=4
     GroupOffset=4
     PickupClass=Class'KFOldModC.LAWPickup'
     PlayerViewOffset=(X=40.000000,Y=17.000000)
     BobDamping=7.000000
     AttachmentClass=Class'KFOldModC.LAWAttachment'
     IconCoords=(X1=429,Y1=212,X2=508,Y2=251)
     ItemName="L.A.W"
     Mesh=SkeletalMesh'KFWeaponModelsOldMod.LAW'
     DrawScale=1.100000
     Skins(0)=Texture'KillingFloorWeapons.Deagle.HandSkinNew'
     Skins(1)=Texture'KillingFloorWeapons.Deagle.ArmSkinNew'
     Skins(2)=Texture'KillingFloorWeapons.Deagle.HandSkinNew'
     Skins(3)=Texture'KillingFloorWeapons.Deagle.ArmSkinNew'
     Skins(4)=Shader'KillingFloorWeapons.LAW.LawShineShader'
     Skins(5)=Shader'KillingFloorWeapons.LAW.LAWScope'
     Skins(6)=Texture'KillingFloorWeapons.LAW.RocketSkin'
     AmbientGlow=2
}
