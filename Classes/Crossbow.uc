class Crossbow extends KFWeapon;

//=============================================================================
// Execs
//=============================================================================

var transient float LastFOV;
var() bool zoomed;
var color ChargeColor;
var float ZoomLevel;
var float Range;
var float LastRangingTime;
var float LastRangeFound;
var() Material ZoomMat;
var() Sound ZoomSound;



simulated event RenderOverlays(Canvas Canvas)
{
        local PlayerController PC;


    PC = PlayerController(Instigator.Controller);


    if(PC == none)
        return;


    if(LastFOV != PC.DesiredFOV)
        PlaySound(ZoomSound, SLOT_Misc, 0.1,,,, false);

    LastFOV = PC.DesiredFOV;

    if (PC.DesiredFOV == PC.DefaultFOV || (Level.bClassicView && PC.DesiredFOV == 90))
    {
        super.RenderOverlays(Canvas);
        zoomed=false;
    }
    else
    {
        SetZoomBlendColor(Canvas);

        //Black-out either side of the main zoom circle.
        Canvas.Style = ERenderStyle.STY_Normal;
        Canvas.SetPos(0, 0);
        Canvas.DrawTile(ZoomMat, (Canvas.SizeX - Canvas.SizeY) / 2, Canvas.SizeY, 0.0, 0.0, 8, 8);
        Canvas.SetPos(Canvas.SizeX, 0);
        Canvas.DrawTile(ZoomMat, -(Canvas.SizeX - Canvas.SizeY) / 2, Canvas.SizeY, 0.0, 0.0, 8, 8);

        //The view through the scope itself.
        Canvas.Style = 255;
        Canvas.SetPos((Canvas.SizeX - Canvas.SizeY) / 2,0);
        Canvas.DrawTile(ZoomMat, Canvas.SizeY, Canvas.SizeY, 0.0, 0.0, 512, 512);

        //Draw some useful text.
        Canvas.Font = Canvas.MedFont;
        Canvas.SetDrawColor(200,150,0);

        Canvas.SetPos(Canvas.SizeX * 0.16, Canvas.SizeY * 0.43);
        Canvas.DrawText("Zoom: 2.50");

        Canvas.SetPos(Canvas.SizeX * 0.16, Canvas.SizeY * 0.47);

           Canvas.SetPos(Canvas.SizeX * 0.16, Canvas.SizeY * 0.51);
        Canvas.DrawText("Direction:"@normalize(Instigator.GetViewRotation()).Pitch / 182.0);

        zoomed = true;
    }
}


function float GetAIRating()
{
    local Bot B;


    B = Bot(Instigator.Controller);
    if ( (B == none) || (B.Enemy == none) )
        return AIRating;

    return (AIRating + 0.0003 * FMin(VSize(B.Enemy.Location - Instigator.Location),1000));
}

function byte BestMode()
{
    return 0;
}


simulated function BringUp(optional Weapon PrevWeapon)
{
    if ( PlayerController(Instigator.Controller) != none )
    {
        LastFOV = PlayerController(Instigator.Controller).DesiredFOV;
    }
    super.BringUp(PrevWeapon);
}

simulated function bool PutDown()
{
    if( Instigator.Controller.IsA( 'PlayerController' ) )
        PlayerController(Instigator.Controller).EndZoom();
    if ( super.PutDown() )
    {
        GotoState('');
        return true;
    }
    return false;
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

/**
 * Handles all the functionality for zooming in including
 * setting the parameters for the weapon, pawn, and playercontroller
 *
 * @param bAnimateTransition whether or not to animate this zoom transition
 */
simulated function ZoomIn(bool bAnimateTransition)
{
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
        TweenAnim('Lower',ZoomTime);
    }
}

defaultproperties
{
     ZoomMat=FinalBlend'KFOldModAmmo.CCFB'
     bHasScope=true
     MagCapacity=1
     Weight=9.000000
     ReloadRate=0.010000
     WeaponReloadAnim="Reload_Crossbow"
     HudImage=Texture'KillingFloorHUD.WeaponSelect.crossbow_unselected'
     SelectedHudImage=Texture'KillingFloorHUD.WeaponSelect.Crossbow'
     bHasAimingMode=true
     IdleAimAnim="Idle"
     StandardDisplayFOV=65.000000
     TraderInfoTexture=Texture'KillingFloorHUD.Trader_Weapon_Images.Trader_CrossBow'
     PlayerIronSightFOV=32.000000
     ZoomedDisplayFOV=60.000000
     FireModeClass(0)=class'CrossbowFire'
     FireModeClass(1)=class'KFMod.NoFire'
     PutDownAnim="PutDown"
     SelectSound=Sound'KF_XbowSnd.Xbow_Select'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.650000
     CurrentRating=0.650000
     Description="A recreational hunting weapon, featuring a firing trigger and a powerful integrated scope. "
     DisplayFOV=65.000000
     Priority=10
     InventoryGroup=4
     GroupOffset=3
     PickupClass=class'CrossbowPickup'
     PlayerViewOffset=(X=15.000000,Y=16.000000,Z=-12.000000)
     BobDamping=6.000000
     AttachmentClass=class'CrossbowAttachment'
     IconCoords=(X1=253,Y1=146,X2=333,Y2=181)
     ItemName="Crossbow"
     LightType=LT_None
     LightBrightness=0.000000
     LightRadius=0.000000
     Mesh=SkeletalMesh'KFWeaponModelsOldMod.Xbow'
     Skins(0)=Shader'KillingFloorWeapons.Xbow.XbowShineShader'
     Skins(1)=Texture'KillingFloorWeapons.Deagle.HandSkinNew'
     Skins(2)=Texture'KillingFloorWeapons.Deagle.ArmSkinNew'
     Skins(3)=Texture'KillingFloorWeapons.Xbow.ArrowSkin'
     Skins(4)=FinalBlend'KillingFloorWeapons.Xbow.XbowScopeFinal'
}
