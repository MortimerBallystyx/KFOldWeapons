// Zombie Monster for KF Invasion gametype
class ZombieClotold extends zombieclotbase;



function ClawDamageTarget()
{
	local vector PushDir;
	local KFPawn KFP;
	local float UsedMeleeDamage;


	if( MeleeDamage > 1 )
    {
	   UsedMeleeDamage = (MeleeDamage - (MeleeDamage * 0.05)) + (MeleeDamage * (FRand() * 0.1));
	}
	else
	{
	   UsedMeleeDamage = MeleeDamage;
	}

	// If zombie has latched onto us...
	if ( MeleeDamageTarget( UsedMeleeDamage, PushDir))
	{
		KFP = KFPawn(Controller.Target);

        PlaySound(MeleeAttackHitSound, SLOT_Interact, 2.0);

        if( !bDecapitated && KFP != none )
        {
			if ( KFPlayerReplicationInfo(KFP.PlayerReplicationInfo) == none ||
				 KFP.GetVeteran().static.CanBeGrabbed(KFPlayerReplicationInfo(KFP.PlayerReplicationInfo), self))
			{
				if( DisabledPawn != none )
				{
				     DisabledPawn.bMovementDisabled = false;
				}

				KFP.DisableMovement(GrappleDuration);
				DisabledPawn = KFP;
			}
		}
	}
}

function RangedAttack(Actor A)
{
	if ( bShotAnim || Physics == PHYS_Swimming)
		return;
	else if ( CanAttack(A) )
	{
		bShotAnim = true;
		SetAnimAction('Claw');
		return;
	}
}

function DoorAttack(Actor A)
{
	if ( bShotAnim || Physics == PHYS_Swimming)
		return;
	else if ( A!=None )
	{
		bShotAnim = true;
		SetAnimAction('ClawDoor');
		//PlaySound(sound'Claw2s', SLOT_None); KFTODO: Replace this
		return;
	}
}

simulated event SetAnimAction(name NewAction)
{
	local int meleeAnimIndex;

	if( NewAction=='' )
		Return;
	if(NewAction == 'Claw')
	{
		meleeAnimIndex = Rand(3);
		NewAction = meleeAnims[meleeAnimIndex];
		CurrentDamtype = ZombieDamType[meleeAnimIndex];
	}
	// Do a claw attack on door, not a grapple
	else if (NewAction == 'ClawDoor')
	{
		if( FRand() < 0.5 )
		{
		  	NewAction = 'Claw';
		}
		else
		{
            NewAction ='Claw2';
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

simulated function bool AnimNeedsWait(name TestAnim)
{
    if( TestAnim == 'KnockDown' )
    {
        return true;
    }

    return false;
}

simulated function int DoAnimAction( name AnimName )
{
	if( AnimName=='ClotGrapple' || AnimName=='ClotGrappleTwo' || AnimName=='ClotGrappleThree' )
	{
		AnimBlendParams(1, 1.0, 0.1,, SpineBone1);
		PlayAnim(AnimName,, 0.1, 1);

		// Randomly send out a message about Clot grabbing you(10% chance)
		if ( FRand() < 0.10 && LookTarget != none && KFPlayerController(LookTarget.Controller) != none &&
			 VSizeSquared(Location - LookTarget.Location) < 2500 /* (MeleeRange + 20)^2 */ &&
			 Level.TimeSeconds - KFPlayerController(LookTarget.Controller).LastClotGrabMessageTime > ClotGrabMessageDelay &&
			 KFPlayerController(LookTarget.Controller).SelectedVeterancy != class'KFVetBerserker' )
		{
			PlayerController(LookTarget.Controller).Speech('AUTO', 11, "");
			KFPlayerController(LookTarget.Controller).LastClotGrabMessageTime = Level.TimeSeconds;
		}

        bGrappling = true;
        GrappleEndTime = Level.TimeSeconds + GrappleDuration;

		return 1;
	}

	return super.DoAnimAction( AnimName );
}

simulated function Tick(float DeltaTime)
{
    super.Tick(DeltaTime);

	if( bShotAnim && Role == ROLE_Authority )
	{
		if( LookTarget!=None )
		{
		    Acceleration = AccelRate * Normal(LookTarget.Location - Location);
		}
    }

	if( Role == ROLE_Authority && bGrappling )
	{
		if( Level.TimeSeconds > GrappleEndTime )
		{
		    bGrappling = false;
		}
    }

    // if we move out of melee range, stop doing the grapple animation
    if( bGrappling && LookTarget != none )
    {
        if( VSize(LookTarget.Location - Location) > MeleeRange + CollisionRadius + LookTarget.CollisionRadius )
        {
            bGrappling = false;
            AnimEnd(1);
        }
    }
}

function RemoveHead()
{
	Super.RemoveHead();
	MeleeAnims[0] = 'Claw';
	MeleeAnims[1] = 'Claw';
	MeleeAnims[2] = 'Claw2';

    MeleeDamage *= 2;
    MeleeRange *= 2;

	if( DisabledPawn != none )
	{
	     DisabledPawn.bMovementDisabled = false;
	     DisabledPawn = none;
	}
}

function Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	if( DisabledPawn != none )
	{
	     DisabledPawn.bMovementDisabled = false;
	     DisabledPawn = none;
	}

    super.Died(Killer, damageType, HitLocation);

}

simulated function Destroyed()
{
    super.Destroyed();

	if( DisabledPawn != none )
	{
	     DisabledPawn.bMovementDisabled = false;
	     DisabledPawn = none;
	}
}

defaultproperties
{
     MeleeAnims(1)="ClotGrapple"
     MeleeAnims(2)="ClotGrapple"
     RagMaxSpinAmount=200.000000
     KFRagdollName="ClotRag"
     RagDeathVel=200.000000
     RagShootStrength=6000.000000
     RagDeathUpKick=200.000000
     RagGravScale=2.000000
     Mesh=SkeletalMesh'KFCharactermodelsoldC.InfectedWhiteMale1'
     Skins(0)=Shader'KFCharacters.Zombie1Shader'
}
