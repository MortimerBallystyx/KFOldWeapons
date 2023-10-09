class KFMODDualiesAttachment extends KFWeaponAttachment;

var bool bIsOffHand,bMyFlashTurn;
var bool bBeamEnabled;
var DualiesAttachment brother;
var () Mesh BrotherMesh;

var Actor TacShine;

var  Effects TacShineCorona;

simulated function DoFlashEmitter()
{
    if(bIsOffHand)
        return;
    if(bMyFlashTurn)
        ActuallyFlash();
    else if(brother != none)
        brother.ActuallyFlash();
    bMyFlashTurn = !bMyFlashTurn;
}

simulated function ActuallyFlash()
{
    super.DoFlashEmitter();
}

simulated function Destroyed()
{
    if ( TacShineCorona != none )
        TacShineCorona.Destroy();
    if ( TacShine != none )
        TacShine.Destroy();
    super.Destroyed();
}

// Overriden to support having two weapon attachments firing and playing anims
simulated event ThirdPersonEffects()
{
    local PlayerController PC;

    // Prevents tracers from spawning if player is using the flashlight function of the 9mm
    if( FiringMode==1 )
        return;

    if ( (Level.NetMode == NM_DedicatedServer) || (Instigator == none) )
        return;

    // new Trace FX - Ramm
    if (FiringMode == 0)
    {
        if ( OldSpawnHitCount != SpawnHitCount )
        {
            OldSpawnHitCount = SpawnHitCount;
            GetHitInfo();
            PC = Level.GetLocalPlayerController();
            if ( ((Instigator != none) && (Instigator.Controller == PC)) || (VSize(PC.ViewTarget.Location - mHitLocation) < 4000) )
            {

                    Spawn(class'ROBulletHitEffect',,, mHitLocation, Rotator(-mHitNormal));
                    CheckForSplash();
            }
        }
    }

      if ( FlashCount>0 )
    {
        if( KFPawn(Instigator)!=none )
        {
            // We don't really have alt fire, but use the alt fire anims as the left hand firing anims
            if( bMyFlashTurn )
            {
                KFPawn(Instigator).StartFiringX(false,bRapidFire);
            }
            else
            {
                KFPawn(Instigator).StartFiringX(true,bRapidFire);
            }
        }

        if( bDoFiringEffects )
        {
            PC = Level.GetLocalPlayerController();

            if ( (Level.TimeSeconds - LastRenderTime > 0.2) && (Instigator.Controller != PC) )
                return;

            WeaponLight();
            DoFlashEmitter();
            SpawnTracer();

            if ( (mShellCaseEmitter == none) && (Level.DetailMode != DM_Low) && !Level.bDropDetail )
            {
                mShellCaseEmitter = Spawn(mShellCaseEmitterClass);
                if ( mShellCaseEmitter != none )
                    AttachToBone(mShellCaseEmitter, 'ShellPort');
            }
            if (mShellCaseEmitter != none)
                mShellCaseEmitter.mStartParticles++;
        }
    }
    else
    {
        GotoState('');
        if( KFPawn(Instigator)!=none )
            KFPawn(Instigator).StopFiring();
    }
}

simulated function vector GetTracerStart()
{
    local Pawn p;

    p = Pawn(Owner);

    if ( (p != none) && p.IsFirstPerson() && p.Weapon != none )
    {
        return p.Weapon.GetEffectStart();
    }

    // 3rd person
    if ( mMuzFlash3rd != none && bMyFlashTurn)
        return mMuzFlash3rd.Location;
    else
    if ( brother != none && brother.mMuzFlash3rd != none && !bMyFlashTurn)
        return  brother.mMuzFlash3rd.Location;
    //   return Location;
}

simulated function UpdateTacBeam( float Dist )
{
    local vector Sc;
    local DualiesAttachment DA;

    if( Mesh==BrotherMesh )
    {
        if( bBeamEnabled )
        {
            if (TacShine!=none )
                TacShine.bHidden = true;
            if (TacShineCorona!=none )
                TacShineCorona.bHidden = true;
            bBeamEnabled = false;
        }
        if( brother==none )
        {
            ForEach DynamicActors(class'DualiesAttachment',DA)
            {
                if( DA!=self && DA.Instigator==Instigator && DA.Mesh!=BrotherMesh )
                {
                    brother = DA;
                    Break;
                }
            }
        }
        if( brother!=none )
            brother.UpdateTacBeam(Dist);
        return;
    }
    if( !bBeamEnabled )
    {
        if (TacShine == none )
        {
            TacShine = Spawn(class'KFMODDualies'.default.TacShineClass,Owner,,,);
            AttachToBone(TacShine,'FlashBone3P');
            TacShine.RemoteRole = ROLE_None;
        }
        else TacShine.bHidden = false;
        if (TacShineCorona == none )
        {
            TacShineCorona = Spawn(class 'KFTacLightCorona',Owner,,,);
            AttachToBone(TacShineCorona,'FlashBone3P');
            TacShineCorona.RemoteRole = ROLE_None;
        }
        TacShineCorona.bHidden = false;
        bBeamEnabled = true;
    }
    Sc = TacShine.DrawScale3D;
    Sc.Y = FClamp(Dist/90.f,0.02,1.f);
    if( TacShine.DrawScale3D!=Sc )
        TacShine.SetDrawScale3D(Sc);
}

simulated function TacBeamGone()
{
    local DualiesAttachment DA;

    if( Mesh==BrotherMesh )
    {
        if( brother==none )
        {
            ForEach DynamicActors(class'DualiesAttachment',DA)
            {
                if( DA!=self && DA.Instigator==Instigator && DA.Mesh!=BrotherMesh )
                {
                    brother = DA;
                    Break;
                }
            }
        }
        if( brother!=none )
            brother.TacBeamGone();
        return;
    }
    if( bBeamEnabled )
    {
        if (TacShine!=none )
            TacShine.bHidden = true;
        if (TacShineCorona!=none )
            TacShineCorona.bHidden = true;
        bBeamEnabled = false;
    }
}

defaultproperties
{
     bMyFlashTurn=true
     BrotherMesh=SkeletalMesh'KFWeaponModelsOldMod.9mm3P'
     mMuzFlashClass=class'ROEffects.MuzzleFlash3rdPistol'
     mTracerClass=class'KFMod.KFNewTracer'
     mShellCaseEmitterClass=class'KFMod.KFShellSpewer'
     MovementAnims(0)="JogF_Dual9mm"
     MovementAnims(1)="JogB_Dual9mm"
     MovementAnims(2)="JogL_Dual9mm"
     MovementAnims(3)="JogR_Dual9mm"
     TurnLeftAnim="TurnL_Dual9mm"
     TurnRightAnim="TurnR_Dual9mm"
     CrouchAnims(0)="CHwalkF_Dual9mm"
     CrouchAnims(1)="CHwalkB_Dual9mm"
     CrouchAnims(2)="CHwalkL_Dual9mm"
     CrouchAnims(3)="CHwalkR_Dual9mm"
     WalkAnims(0)="WalkF_Dual9mm"
     WalkAnims(1)="WalkB_Dual9mm"
     WalkAnims(2)="WalkL_Dual9mm"
     WalkAnims(3)="WalkR_Dual9mm"
     CrouchTurnRightAnim="CH_TurnR_Dual9mm"
     CrouchTurnLeftAnim="CH_TurnL_Dual9mm"
     IdleCrouchAnim="CHIdle_Dual9mm"
     IdleWeaponAnim="Idle_Dual9mm"
     IdleRestAnim="Idle_Dual9mm"
     IdleChatAnim="Idle_Dual9mm"
     IdleHeavyAnim="Idle_Dual9mm"
     IdleRifleAnim="Idle_Dual9mm"
     FireAnims(0)="DualiesAttackRight"
     FireAnims(1)="DualiesAttackRight"
     FireAnims(2)="DualiesAttackRight"
     FireAnims(3)="DualiesAttackRight"
     FireAltAnims(0)="DualiesAttackLeft"
     FireAltAnims(1)="DualiesAttackLeft"
     FireAltAnims(2)="DualiesAttackLeft"
     FireAltAnims(3)="DualiesAttackLeft"
     FireCrouchAnims(0)="CHDualiesAttackRight"
     FireCrouchAnims(1)="CHDualiesAttackRight"
     FireCrouchAnims(2)="CHDualiesAttackRight"
     FireCrouchAnims(3)="CHDualiesAttackRight"
     FireCrouchAltAnims(0)="CHDualiesAttackLeft"
     FireCrouchAltAnims(1)="CHDualiesAttackLeft"
     FireCrouchAltAnims(2)="CHDualiesAttackLeft"
     FireCrouchAltAnims(3)="CHDualiesAttackLeft"
     HitAnims(0)="HitF_Dual9mmm"
     HitAnims(1)="HitB_Dual9mm"
     HitAnims(2)="HitL_Dual9mm"
     HitAnims(3)="HitR_Dual9mm"
     PostFireBlendStandAnim="Blend_Dual9mm"
     PostFireBlendCrouchAnim="CHBlend_Dual9mm"
     Mesh=SkeletalMesh'KFWeaponModelsOldMod.Single3P'
}
