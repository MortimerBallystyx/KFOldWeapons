class KFMODKFAmmoPickupOld extends Ammo;

var() Material KFPickupImage;
var Bool ShowPickup ;
var Controller OtherPlayer;
var() localized string PickupMSG1;
var bool bfound;

State Sleeping
{
    ignores Touch;

    function bool ReadyToPickup(float MaxWait)
    {
        return ( bPredictRespawns && (LatentFloat < MaxWait) );
    }

    function StartSleeping() {}

    function BeginState()
    {
        local int i;
    if(bfound)
        destroy();

        NetUpdateTime = Level.TimeSeconds - 1;
        bHidden = true;
        for ( i=0; i<4; i++ )
            TeamOwner[i] = none;
    }

    function EndState()
    {
        NetUpdateTime = Level.TimeSeconds - 1;
        bHidden = false;
    }

DelayedSpawn:
    if ( Level.NetMode == NM_Standalone )
        Sleep(FMin(30, Level.Game.GameDifficulty * 8));
    else
        Sleep(30);
    Goto('Respawn');
Begin:
    Sleep( GetReSpawnTime() - RespawnEffectTime );
Respawn:
   for ( OtherPlayer=Level.ControllerList; OtherPlayer!=none; OtherPlayer=OtherPlayer.NextController)
   {
    if (OtherPlayer.pawn != none)
    {
     if(!FastTrace(self.Location,OtherPlayer.Pawn.Location))
     {
      RespawnEffect();
      Sleep(RespawnEffectTime);
      if (PickUpBase != none)
        PickUpBase.TurnOn();
      GotoState('Pickup');
     }
     else
         Sleep(rand(5) + 5);   // Crafty randomization...you'll never know when the next respawn attempt will be !  (5-10 seconds)
      Goto('Respawn');
    }
   }
}

function inventory SpawnCopy( pawn Other )
{
    local inventory i;
    i=super.SpawnCopy(Other);
    ShowPickup = true;
    return i;
}

function PostRender(Canvas C)
{
  if (ShowPickup == true )
  {
    C.SetPos((C.SizeX - C.SizeY) / 2,0);
    C.DrawTile( KFPickupImage , C.SizeY, C.SizeY, 0.0, 0.0, 256, 256);
  }
}

simulated function PostBeginPlay()
{
 AmmoAmount = (rand(0.5 * default.AmmoAmount) + default.AmmoAmount);
 default.PickupMSG1 = "Found ("$AmmoAmount$") ";
}



static function string GetLocalString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2
    )
{
    return default.PickupMSG1$default.PickupMessage;
}

defaultproperties
{
     InventoryType=class'KFMod.BullpupAmmo'
     bOnlyReplicateHidden=false
     PickupMessage="Found Some Ammo!"
     PickupSound=Sound'KF_InventorySnd.Ammo_GenericPickup'
     PickupForce="AssaultAmmoPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'kf_generic_sm.pickups.Metal_Ammo_Box'
     bDynamicLight=true
     Physics=PHYS_Falling
     PrePivot=(Y=21.000000,Z=12.000000)
     AmbientGlow=40
     UV2Texture=FadeColor'PatchTex.Common.PickupOverlay'
     TransientSoundVolume=100.000000
     CollisionRadius=20.000000
     CollisionHeight=10.000000
     MessageClass=class'UnrealGame.PickupMessagePlus'
}
