//=============================================================================
// L85 Inventory class
//=============================================================================
class Bullpup extends KFWeapon
	config(user);

#exec OBJ LOAD FILE=KillingFloorWeapons.utx
#exec OBJ LOAD FILE=KillingFloorHUD.utx
#exec OBJ LOAD FILE=Inf_Weapons_Foley.uax

replication
{
	reliable if(Role < ROLE_Authority)
		ServerChangeFireMode;
}

// Use alt fire to switch fire modes
simulated function AltFire(float F)
{
    if(ReadyToFire(0))
    {
        DoToggle();
    }
}

// Toggle semi/auto fire
simulated function DoToggle ()
{
	local PlayerController Player;

	Player = Level.GetLocalPlayerController();
	if ( Player!=None )
	{
		//PlayOwnedSound(sound'Inf_Weapons_Foley.stg44_firemodeswitch01',SLOT_None,2.0,,,,false);
		FireMode[0].bWaitForRelease = !FireMode[0].bWaitForRelease;
		if ( FireMode[0].bWaitForRelease )
			Player.ReceiveLocalizedMessage(class'KFmod.BullpupSwitchMessage',0);
		else Player.ReceiveLocalizedMessage(class'KFmod.BullpupSwitchMessage',1);
	}
	Super.DoToggle();

	ServerChangeFireMode(FireMode[0].bWaitForRelease);
}

// Set the new fire mode on the server
function ServerChangeFireMode(bool bNewWaitForRelease)
{
    FireMode[0].bWaitForRelease = bNewWaitForRelease;
}

function bool RecommendRangedAttack()
{
	return true;
}

//TODO: LONG ranged?
function bool RecommendLongRangedAttack()
{
	return true;
}

function float SuggestAttackStyle()
{
	return -1.0;
}

exec function SwitchModes()
{
	DoToggle();
}

function float GetAIRating()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	return AIRating;
}

function byte BestMode()
{
	return 0;
}

simulated function SetZoomBlendColor(Canvas c)
{
	local Byte    val;
	local Color   clr;
	local Color   fog;

	clr.R = 255;
	clr.G = 255;
	clr.B = 255;
	clr.A = 255;

	if( Instigator.Region.Zone.bDistanceFog )
	{
		fog = Instigator.Region.Zone.DistanceFogColor;
		val = 0;
		val = Max( val, fog.R);
		val = Max( val, fog.G);
		val = Max( val, fog.B);
		if( val > 128 )
		{
			val -= 128;
			clr.R -= val;
			clr.G -= val;
			clr.B -= val;
		}
	}
	c.DrawColor = clr;
}

simulated function bool CanZoomNow()
{
	Return (!FireMode[0].bIsFiring && Instigator!=None && Instigator.Physics!=PHYS_Falling);
}

defaultproperties
{
     MagCapacity=40
     ReloadRate=2.000000
     ReloadAnim="Reload"
     ReloadAnimRate=0.900000
     WeaponReloadAnim="Reload_BullPup"
     HudImage=Texture'KillingFloorHUD.WeaponSelect.bullpup_unselected'
     SelectedHudImage=Texture'KillingFloorHUD.WeaponSelect.Bullpup'
     Weight=6.000000
     bHasAimingMode=True
     IdleAimAnim="Idle"
     StandardDisplayFOV=70.000000
     bModeZeroCanDryFire=True
     SleeveNum=9
     TraderInfoTexture=Texture'KillingFloorHUD.Trader_Weapon_Images.Trader_Bullpup'
     PlayerIronSightFOV=65.000000
     ZoomedDisplayFOV=40.000000
     FireModeClass(0)=Class'KFOldModC.BullpupFire'
     FireModeClass(1)=Class'KFMod.NoFire'
     PutDownAnim="PutDown"
     SelectSound=Sound'KF_BullpupSnd.Bullpup_Select'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.550000
     CurrentRating=0.550000
     bShowChargingBar=True
     Description="A military grade automatic rifle. Can be fired in semi-auto or full auto firemodes and comes equipped with a scope for increased accuracy."
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=75.000000
     Priority=4
     CustomCrosshair=11
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross5"
     InventoryGroup=3
     GroupOffset=2
     PickupClass=Class'KFOldModC.BullpupPickup'
     PlayerViewOffset=(X=20.000000,Y=21.500000,Z=-9.000000)
     BobDamping=6.000000
     AttachmentClass=Class'KFOldModC.BullpupAttachment'
     IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
     ItemName="Bullpup"
     Mesh=SkeletalMesh'KFWeaponModelsOldMod.L85'
     Skins(0)=Texture'KillingFloorWeapons.Deagle.HandSkinNew'
     Skins(1)=Texture'KillingFloorWeapons.Deagle.ArmSkinNew'
     Skins(2)=Texture'KillingFloorWeapons.Deagle.Deagle'
     Skins(3)=Shader'KillingFloorWeapons.L85.CarbineShader'
     Skins(4)=Shader'KillingFloorWeapons.L85.l85XHairShader'
     TransientSoundVolume=1.250000
}
