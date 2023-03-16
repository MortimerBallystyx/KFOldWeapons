// Zombie Monster for KF Invasion gametype
// GOREFAST.
// He's speedy, and swings with a Single enlongated arm, affording him slightly more range
class ZombieGoreFastold extends ZombieGorefast_STANDARD;

simulated function PostNetReceive()
{
	if (bRunning)
		MovementAnims[0]='ZombieRun';
	else MovementAnims[0]=default.MovementAnims[0];
}

function RangedAttack(Actor A)
{
	Super.RangedAttack(A);
	if( !bShotAnim && !bDecapitated && VSize(A.Location-Location)<=700 )
		GoToState('RunningState');
}

State RunningState
{
	// Don't override speed in this state
	function bool CanSpeedAdjust()
	{
		return false;
	}

	function BeginState()
	{
		GroundSpeed = OriginalGroundSpeed * 1.875;
		bRunning = true;
		if( Level.NetMode!=NM_DedicatedServer )
			PostNetReceive();
	}

	function EndState()
	{
		GroundSpeed = OriginalGroundSpeed;
		bRunning = False;
		if( Level.NetMode!=NM_DedicatedServer )
			PostNetReceive();
	}

	function RemoveHead()
	{
		GoToState('');
		Global.RemoveHead();
	}

	function RangedAttack(Actor A)
	{
		if ( bShotAnim || Physics == PHYS_Swimming)
			return;
		else if ( CanAttack(A) )
		{
			bShotAnim = true;
			SetAnimAction('Claw');
			//PlaySound(sound'Claw2s', SLOT_None); KFTODO: Replace this
			Controller.bPreparingMove = true;
			Acceleration = vect(0,0,0);
			// Once we attack stop running
			GoToState('');
			return;
		}
	}
Begin:
	GoTo('CheckCharge');
CheckCharge:
	if( Controller!=None && Controller.Target!=None && VSize(Controller.Target.Location-Location)<700 )
	{
		Sleep(0.5+ FRand() * 0.5);
		//log("Still charging");
		GoTo('CheckCharge');
	}
	else
	{
		//log("Done charging");
		GoToState('');
	}
}

simulated function HideBone(name boneName)
{
	local int BoneScaleSlot;
	local coords boneCoords;

	if( boneName == LeftThighBone )
	{
		boneScaleSlot = 0;
		if( SeveredLeftLeg == none )
		{
			SeveredLeftLeg = Spawn(SeveredLegAttachClass,self);
			SeveredLeftLeg.SetDrawScale(SeveredLegAttachScale);
			boneCoords = GetBoneCoords( 'lleg' );
			AttachEmitterEffect( LimbSpurtEmitterClass, 'lleg', boneCoords.Origin, rot(0,0,0) );
			AttachToBone(SeveredLeftLeg, 'lleg');
		}
	}
	else if ( boneName == RightThighBone )
	{
		boneScaleSlot = 1;
		if( SeveredRightLeg == none )
		{
			SeveredRightLeg = Spawn(SeveredLegAttachClass,self);
			SeveredRightLeg.SetDrawScale(SeveredLegAttachScale);
			boneCoords = GetBoneCoords( 'rleg' );
			AttachEmitterEffect( LimbSpurtEmitterClass, 'rleg', boneCoords.Origin, rot(0,0,0) );
			AttachToBone(SeveredRightLeg, 'rleg');
		}
	}
	else if( boneName == RightFArmBone )
	{
		boneScaleSlot = 2;
		if( SeveredRightArm == none )
		{
			SeveredRightArm = Spawn(SeveredArmAttachClass,self);
			SeveredRightArm.SetDrawScale(SeveredArmAttachScale);
			boneCoords = GetBoneCoords( 'rarm' );
			AttachEmitterEffect( LimbSpurtEmitterClass, 'rarm', boneCoords.Origin, rot(0,0,0) );
			AttachToBone(SeveredRightArm, 'rarm');
		}
	}
	else if ( boneName == LeftFArmBone )
	{
		// No LeftArm
		return;
	}
	else if ( boneName == HeadBone )
	{
		// Only scale the bone down once
		if( SeveredHead == none )
		{
			boneScaleSlot = 4;
			SeveredHead = Spawn(SeveredHeadAttachClass,self);
			SeveredHead.SetDrawScale(SeveredHeadAttachScale);
			boneCoords = GetBoneCoords( 'neck' );
			AttachEmitterEffect( NeckSpurtEmitterClass, 'neck', boneCoords.Origin, rot(0,0,0) );
			AttachToBone(SeveredHead, 'neck');
		}
		else
		{
			return;
		}
	}
	else if ( boneName == 'spine' )
		boneScaleSlot = 5;

	SetBoneScale(BoneScaleSlot, 0.0, BoneName);
}

defaultproperties
{
     RagMaxSpinAmount=200.000000
     KFRagdollName="ClotRag"
     RagDeathVel=200.000000
     RagShootStrength=6000.000000
     RagDeathUpKick=200.000000
     RagGravScale=2.000000
     Mesh=SkeletalMesh'KFCharactermodels.GoreFast'
     DrawScale=0.900000
     Skins(0)=Shader'KFCharacters.Zombie3Shader'
}
