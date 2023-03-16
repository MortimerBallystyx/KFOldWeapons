// Zombie Monster for KF Invasion gametype

class ZombieCrawlerold extends zombiecrawlerbase;


function bool DoPounce()
{
	if ( bIsCrouched || bWantsToCrouch || (Physics != PHYS_Walking) || VSize(Location - Controller.Target.Location) > (MeleeRange * 5) )
		return false;

	Velocity = Normal(Controller.Target.Location-Location)*PounceSpeed;
	Velocity.Z = JumpZ;
	SetPhysics(PHYS_Falling);
	ZombieSpringAnim();
	bPouncing=true;
	return true;
}

simulated function ZombieSpringAnim()
{
	SetAnimAction('ZombieSpring');
}

event Landed(vector HitNormal)
{
	bPouncing=false;
	super.Landed(HitNormal);
}

event Bump(actor Other)
{
	// TODO: is there a better way
	if(bPouncing && KFHumanPawn(Other)!=none )
	{
		KFHumanPawn(Other).TakeDamage(((MeleeDamage - (MeleeDamage * 0.05)) + (MeleeDamage * (FRand() * 0.1))), self ,self.Location,self.velocity, class 'KFmod.ZombieMeleeDamage');
		if (KFHumanPawn(Other).Health <=0)
		{
			//TODO - move this to humanpawn.takedamage? Also see KFMonster.MeleeDamageTarget
			KFHumanPawn(Other).SpawnGibs(self.rotation, 1);
		}
		//After impact, there'll be no momentum for further bumps
		bPouncing=false;
	}
}

// Blend his attacks so he can hit you in mid air.
simulated function int DoAnimAction( name AnimName )
{
	if( AnimName=='ZombieLeapAttack' || AnimName=='LeapAttack3' || AnimName=='ZombieLeapAttack' )
	{
		AnimBlendParams(1, 1.0, 0.0,, 'Bip01 Spine1');
		PlayAnim(AnimName,, 0.0, 1);
		return 1;
	}

    if( AnimName=='HitF' )
	{
		AnimBlendParams(1, 1.0, 0.0,, NeckBone);
		PlayAnim(AnimName,, 0.0, 1);
		return 1;
	}

	if( AnimName=='ZombieSpring' )
	{
        PlayAnim(AnimName,,0.02);
        return 0;
	}

	return Super.DoAnimAction(AnimName);
}

simulated event SetAnimAction(name NewAction)
{
	local int meleeAnimIndex;

	if( NewAction=='' )
		Return;
	if(NewAction == 'Claw')
	{
		meleeAnimIndex = Rand(2);
		if( Physics == PHYS_Falling )
		{
            NewAction = MeleeAirAnims[meleeAnimIndex];
		}
		else
		{
            NewAction = meleeAnims[meleeAnimIndex];
		}
		CurrentDamtype = ZombieDamType[meleeAnimIndex];
	}
	ExpectingChannel = DoAnimAction(NewAction);

    if( AnimNeedsWait(NewAction) )
    {
        bWaitForAnim = true;
    }

	if( Level.NetMode!=NM_Client )
	{
		AnimAction = NewAction;
		bResetAnimAct = True;
		ResetAnimActTime = Level.TimeSeconds+0.3;
	}
}

// The animation is full body and should set the bWaitForAnim flag
simulated function bool AnimNeedsWait(name TestAnim)
{
    if( TestAnim == 'ZombieSpring' )
    {
        return true;
    }

    return false;
}

function bool FlipOver()
{
	Return False;
}

defaultproperties
{
     RagMaxSpinAmount=200.000000
     KFRagdollName="CrawlerRag"
     RagShootStrength=6000.000000
     RagDeathUpKick=100.000000
     RagGravScale=2.000000
     MovementAnims(1)="ZombieScuttle"
     MovementAnims(2)="ZombieScuttle"
     MovementAnims(3)="ZombieScuttle"
     TurnLeftAnim="ZombieLeapIdle"
     TurnRightAnim="ZombieLeapIdle"
     WalkAnims(1)="ZombieScuttle"
     WalkAnims(2)="ZombieScuttle"
     WalkAnims(3)="ZombieScuttle"
     AirAnims(0)="ZombieLeap"
     AirAnims(1)="ZombieLeap"
     AirAnims(2)="ZombieLeap"
     AirAnims(3)="ZombieLeap"
     TakeoffAnims(0)="ZombieLeap"
     TakeoffAnims(1)="ZombieLeap"
     TakeoffAnims(2)="ZombieLeap"
     TakeoffAnims(3)="ZombieLeap"
     LandAnims(0)="ZombieLeapIdle"
     LandAnims(1)="ZombieLeapIdle"
     LandAnims(2)="ZombieLeapIdle"
     LandAnims(3)="ZombieLeapIdle"
     AirStillAnim="ZombieLeapIdle"
     Mesh=SkeletalMesh'KFCharactermodelsoldC.Shade'
     DrawScale=1.000000
     Skins(0)=Shader'KFCharacters.Zombie9Shader'
     Skins(1)=FinalBlend'KFCharacters.CrawlerHairFB'
}
