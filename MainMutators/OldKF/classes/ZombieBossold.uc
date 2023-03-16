// Zombie Monster for KF Invasion gametype
class ZombieBossold extends ZombieBoss_STANDARD;

simulated function CloakBoss()
{
	local Controller C;
	local int Index;

	if( bSpotted )
	{
		Visibility = 120;
		if( Level.NetMode==NM_DedicatedServer )
			Return;
		Skins[0] = Finalblend'KFX.StalkerGlow';
		Skins[1] = Finalblend'KFX.StalkerGlow';
		bUnlit = true;
		return;
	}

	Visibility = 1;
	bCloaked = true;
	if( Level.NetMode!=NM_Client )
	{
		For( C=Level.ControllerList; C!=None; C=C.NextController )
		{
			if( C.bIsPlayer && C.Enemy==Self )
				C.Enemy = None; // Make bots lose sight with me.
		}
	}
	if( Level.NetMode==NM_DedicatedServer )
		Return;

	Skins[0] = Shader'KF_Specimens_Trip_T.patriarch_invisible_gun';
	Skins[1] = Shader'KF_Specimens_Trip_T.patriarch_invisible';
	Skins[2] = Shader'KF_Specimens_Trip_T.patriarch_invisible_gun';
	Skins[3] = Shader'KF_Specimens_Trip_T.patriarch_invisible';
		Loopanim('runf',1.5);


	// Invisible - no shadow
	if(PlayerShadow != none)
		PlayerShadow.bShadowActive = false;

	// Remove/disallow projectors on invisible people
	Projectors.Remove(0, Projectors.Length);
	bAcceptsProjectors = false;
	SetOverlayMaterial(FinalBlend'KF_Specimens_Trip_T.patriarch_fizzle_FB', 1.0, true);

	// Randomly send out a message about Patriarch going invisible(10% chance)
	if ( FRand() < 0.10 )
	{
		// Pick a random Player to say the message
		Index = Rand(Level.Game.NumPlayers);

		for ( C = Level.ControllerList; C != none; C = C.NextController )
		{
			if ( PlayerController(C) != none )
			{
				if ( Index == 0 )
				{
					PlayerController(C).Speech('AUTO', 8, "");
					break;
				}

				Index--;
			}
		}
	}
}
function RangedAttack(Actor A)
{
	local float D;
	local bool bOnlyE;
	local bool bDesireChainGun;

	// Randomly make him want to chaingun more
	if( Controller.LineOfSightTo(A) && FRand() < 0.15 && LastChainGunTime<Level.TimeSeconds )
	{
		bDesireChainGun = true;
	}

	if ( bShotAnim )
		return;
	D = VSize(A.Location-Location);
	bOnlyE = (Pawn(A)!=None && OnlyEnemyAround(Pawn(A)));
	if ( IsCloseEnuf(A) )
	{
		bShotAnim = true;
		if( Health>1500 && Pawn(A)!=None && FRand() < 0.5 )
		{
			SetAnimAction('MeleeImpale');
		}
		else
		{
			SetAnimAction('MeleeClaw');
			//PlaySound(sound'Claw2s', SLOT_None); KFTODO: Replace this
		}
	}
	else if( Level.TimeSeconds - LastSneakedTime > 20.0 )
	{
		if( FRand() < 0.3 )
		{
			// Wait another 20 to try this again
			LastSneakedTime = Level.TimeSeconds;//+FRand()*120;
			Return;
		}
		SetAnimAction('VictoryLaugh');
		GoToState('SneakAround');
	}
	else if( bChargingPlayer && (bOnlyE || D<200) )
		Return;
	else if( !bDesireChainGun && !bChargingPlayer && (D<300 || (D<700 && bOnlyE)) &&
		(Level.TimeSeconds - LastChargeTime > (5.0 + 5.0 * FRand())) )  // Don't charge again for a few seconds
	{
		SetAnimAction('VictoryLaugh');
		GoToState('Charging');
	}
	else if( LastMissileTime<Level.TimeSeconds && D > 500 )
	{
		if( !Controller.LineOfSightTo(A) || FRand() > 0.75 )
		{
			LastMissileTime = Level.TimeSeconds+FRand() * 5;
			Return;
		}

		LastMissileTime = Level.TimeSeconds + 10 + FRand() * 15;

		bShotAnim = true;
		Acceleration = vect(0,0,0);
		SetAnimAction('PreFireMG');

		HandleWaitForAnim('PreFireMG');

		GoToState('FireMissile');
	}
	else if ( !bWaitForAnim && !bShotAnim && LastChainGunTime<Level.TimeSeconds )
	{
		if ( !Controller.LineOfSightTo(A) || FRand()> 0.85 )
		{
			LastChainGunTime = Level.TimeSeconds+FRand()*4;
			Return;
		}

		LastChainGunTime = Level.TimeSeconds + 5 + FRand() * 10;

		bShotAnim = true;
		Acceleration = vect(0,0,0);
		SetAnimAction('PreFireMG');

		HandleWaitForAnim('PreFireMG');
		MGFireCounter =  Rand(60) + 35;

		GoToState('FireChaingun');
	}
}

state FireChaingun
{
	function RangedAttack(Actor A)
	{
		Controller.Target = A;
		Controller.Focus = A;
	}

	// Chaingun mode handles this itself
	function bool ShouldChargeFromDamage()
	{
		return false;
	}

	function TakeDamage( int Damage, Pawn InstigatedBy, Vector Hitlocation, Vector Momentum, class<DamageType> damageType, optional int HitIndex)
	{
		local float EnemyDistSq, DamagerDistSq;

		global.TakeDamage(Damage,instigatedBy,hitlocation,vect(0,0,0),damageType);

		// if someone close up is shooting us, just charge them
		if( InstigatedBy != none )
		{
			DamagerDistSq = VSizeSquared(Location - InstigatedBy.Location);

			if( (ChargeDamage > 200 && DamagerDistSq < (500 * 500)) || DamagerDistSq < (100 * 100) )
			{
				SetAnimAction('VictoryLaugh');
				//log("Frak this shizz, Charging!!!!");
				GoToState('Charging');
				return;
			}
		}

		if( Controller.Enemy != none && InstigatedBy != none && InstigatedBy != Controller.Enemy )
		{
			EnemyDistSq = VSizeSquared(Location - Controller.Enemy.Location);
			DamagerDistSq = VSizeSquared(Location - InstigatedBy.Location);
		}

		if( InstigatedBy != none && (DamagerDistSq < EnemyDistSq || Controller.Enemy == none) )
		{
			MonsterController(Controller).ChangeEnemy(InstigatedBy,Controller.CanSee(InstigatedBy));
			Controller.Target = InstigatedBy;
			Controller.Focus = InstigatedBy;

			if( DamagerDistSq < (500 * 500) )
			{
				SetAnimAction('VictoryLaugh');
				GoToState('Charging');
			}
		}
	}

	function EndState()
	{
		TraceHitPos = vect(0,0,0);
		bMinigunning = False;

		AmbientSound = default.AmbientSound;
		SoundVolume=default.SoundVolume;
		SoundRadius=default.SoundRadius;
		MGFireCounter=0;

		LastChainGunTime = Level.TimeSeconds + 5 + (FRand()*10);
	}

	function BeginState()
	{
		bFireAtWill = False;
		Acceleration = vect(0,0,0);
		MGLostSightTimeout = 0.0;
		bMinigunning = True;
	}

	function AnimEnd( int Channel )
	{
		if( MGFireCounter <= 0 )
		{
			bShotAnim = true;
			Acceleration = vect(0,0,0);
			SetAnimAction('FireEndMG');
			HandleWaitForAnim('FireEndMG');
			GoToState('');
		}
		else
		{
			if ( Controller.Enemy != none )
			{
				if ( Controller.LineOfSightTo(Controller.Enemy) && FastTrace(GetBoneCoords('tip').Origin,Controller.Enemy.Location))
				{
					MGLostSightTimeout = 0.0;
					Controller.Focus = Controller.Enemy;
					Controller.FocalPoint = Controller.Enemy.Location;
				}
				else
				{
					MGLostSightTimeout = Level.TimeSeconds + (0.25 + FRand() * 0.35);
					Controller.Focus = None;
				}

				Controller.Target = Controller.Enemy;
			}
			else
			{
				MGLostSightTimeout = Level.TimeSeconds + (0.25 + FRand() * 0.35);
				Controller.Focus = None;
			}

			if( !bFireAtWill )
			{
				MGFireDuration = Level.TimeSeconds + (0.75 + FRand() * 0.5);
			}
			else if ( FRand() < 0.03 && Controller.Enemy != none && PlayerController(Controller.Enemy.Controller) != none )
			{
				// Randomly send out a message about Patriarch shooting chain gun(3% chance)
				PlayerController(Controller.Enemy.Controller).Speech('AUTO', 9, "");
			}

			bFireAtWill = True;
			bShotAnim = true;
			Acceleration = vect(0,0,0);

			SetAnimAction('FireMG');
			bWaitForAnim = true;
		}
	}

	function FireMGShot()
	{
		local vector Start,End,HL,HN,Dir;
		local rotator R;
		local Actor A;

		MGFireCounter--;

		if( AmbientSound != MiniGunFireSound )
		{
			SoundVolume=255;
			SoundRadius=400;
			AmbientSound = MiniGunFireSound;
		}

		Start = GetBoneCoords('tip').Origin;
		if( Controller.Focus!=None )
			R = rotator(Controller.Focus.Location-Start);
		else R = rotator(Controller.FocalPoint-Start);
		if( NeedToTurnFor(R) )
			R = Rotation;
		// KFTODO: Maybe scale this accuracy by his skill or the game difficulty
		Dir = Normal(vector(R)+VRand()*0.06); //*0.04
		End = Start+Dir*10000;

		A = Trace(HL,HN,End,Start,True);
		if( A==None )
			Return;
		TraceHitPos = HL;
		if( Level.NetMode!=NM_DedicatedServer )
			AddTraceHitFX(HL);

		if( A!=Level )
			A.TakeDamage(MGDamage+Rand(3),Self,HL,Dir*500,Class'DamageType');
	}

	function bool NeedToTurnFor( rotator targ )
	{
		local int YawErr;

		targ.Yaw = DesiredRotation.Yaw & 65535;
		YawErr = (targ.Yaw - (Rotation.Yaw & 65535)) & 65535;
		return !((YawErr < 2000) || (YawErr > 64535));
	}

Begin:
	While( True )
	{
		Acceleration = vect(0,0,0);

		if( MGLostSightTimeout > 0 && Level.TimeSeconds > MGLostSightTimeout )
		{
			bShotAnim = true;
			Acceleration = vect(0,0,0);
			SetAnimAction('FireEndMG');
			HandleWaitForAnim('FireEndMG');
			GoToState('');
		}

		if( MGFireCounter <= 0 )
		{
			bShotAnim = true;
			Acceleration = vect(0,0,0);
			SetAnimAction('FireEndMG');
			HandleWaitForAnim('FireEndMG');
			GoToState('');
		}

		// Give some randomness to the patriarch's firing
		if( Level.TimeSeconds > MGFireDuration )
		{
			if( AmbientSound != MiniGunSpinSound )
			{
				SoundVolume=185;
				SoundRadius=200;
				AmbientSound = MiniGunSpinSound;
			}
			Sleep(0.5 + FRand() * 0.75);
			MGFireDuration = Level.TimeSeconds + (0.75 + FRand() * 0.5);
		}
		else
		{
			if( bFireAtWill )
				FireMGShot();
			Sleep(0.05);
		}
	}
}

state FireMissile
{
Ignores RangedAttack;

	function bool ShouldChargeFromDamage()
	{
		return false;
	}

	function BeginState()
	{
		Acceleration = vect(0,0,0);
	}

	function AnimEnd( int Channel )
	{
		local vector Start;
		local Rotator R;

		Start = GetBoneCoords('tip').Origin;

		if ( !SavedFireProperties.bInitialized )
		{
			SavedFireProperties.AmmoClass = MyAmmo.Class;
			SavedFireProperties.ProjectileClass = MyAmmo.ProjectileClass;
			SavedFireProperties.WarnTargetPct = 0.15;
			SavedFireProperties.MaxRange = 10000;
			SavedFireProperties.bTossed = False;
			SavedFireProperties.bTrySplash = False;
			SavedFireProperties.bLeadTarget = True;
			SavedFireProperties.bInstantHit = True;
			SavedFireProperties.bInitialized = true;
		}

		R = AdjustAim(SavedFireProperties,Start,100);
		PlaySound(RocketFireSound,SLOT_Interact,2.0,,TransientSoundRadius,,false);
		Spawn(Class'BossLAWProj',,,Start,R);

		bShotAnim = true;
		Acceleration = vect(0,0,0);
		SetAnimAction('FireEndMg');
		HandleWaitForAnim('FireEndMg');

		// Randomly send out a message about Patriarch shooting a rocket(5% chance)
		if ( FRand() < 0.05 && Controller.Enemy != none && PlayerController(Controller.Enemy.Controller) != none )
		{
			PlayerController(Controller.Enemy.Controller).Speech('AUTO', 10, "");
		}

		GoToState('');
	}
Begin:
	while ( true )
	{
		Acceleration = vect(0,0,0);
		Sleep(0.1);
	}
}

function bool MeleeDamageTarget(int hitdamage, vector pushdir)
{
	local bool RetVal;

	if( Controller.Target!=None && Controller.Target.IsA('NetKActor') )
		pushdir = Normal(Controller.Target.Location-Location)*100000; // Fly bitch!
	RetVal = Super.MeleeDamageTarget(hitdamage, pushdir);
	MeleeRange = Default.MeleeRange;
	return RetVal;
}

state Charging
{
	// Don't override speed in this state
	function bool CanSpeedAdjust()
	{
		return false;
	}

	function bool ShouldChargeFromDamage()
	{
		return false;
	}

	function BeginState()
	{
		bChargingPlayer = True;
		if( Level.NetMode!=NM_DedicatedServer )
			PostNetReceive();

		// How many charge attacks we can do randomly 1-3
		NumChargeAttacks = Rand(2) + 1;
		SetAnimAction('runf');
	}

	function EndState()
	{
		GroundSpeed = OriginalGroundSpeed;
		bChargingPlayer = False;
		ChargeDamage = 0;
		if( Level.NetMode!=NM_DedicatedServer )
			PostNetReceive();

		LastChargeTime = Level.TimeSeconds;
playanim('walk');
	}

	function Tick( float Delta )
	{
loopanim('runf');
		if( NumChargeAttacks <= 0 )
		{
			GoToState('');
		}

		// Keep the flesh pound moving toward its target when attacking
		if( Role == ROLE_Authority && bShotAnim)
		{
			if( bChargingPlayer )
			{
				bChargingPlayer = false;
				if( Level.NetMode!=NM_DedicatedServer )
					PostNetReceive();
			}
			GroundSpeed = OriginalGroundSpeed * 1.25;
			if( LookTarget!=None )
			{
				Acceleration = AccelRate * Normal(LookTarget.Location - Location);
			}
		}
		else
		{
			if( !bChargingPlayer )
			{
				bChargingPlayer = true;
				if( Level.NetMode!=NM_DedicatedServer )
					PostNetReceive();
			}

			GroundSpeed = OriginalGroundSpeed * 2.5;
		}


		Global.Tick(Delta);
	}

	function bool MeleeDamageTarget(int hitdamage, vector pushdir)
	{
		local bool RetVal;

		NumChargeAttacks--;

		RetVal = Global.MeleeDamageTarget(hitdamage, pushdir*1.5);
		if( RetVal )
			GoToState('');
		return RetVal;
	}

	function RangedAttack(Actor A)
	{
		if( VSize(A.Location-Location)>700 && Level.TimeSeconds - LastForceChargeTime > 3.0 )
			GoToState('');
		Global.RangedAttack(A);
	}
Begin:
	Sleep(6);
	GoToState('');
}

function BeginHealing()
{
	MonsterController(Controller).WhatToDoNext(55);
}


state Healing // Healing
{
	function bool ShouldChargeFromDamage()
	{
		return false;
	}

Begin:
	Sleep(GetAnimDuration('Heal'));
	GoToState('');
}

state KnockDown // Knocked
{
	function bool ShouldChargeFromDamage()
	{
		return false;
	}

Begin:
	if( Health > 0 )
	{
		Sleep(GetAnimDuration('KnockDown'));
		CloakBoss();
		PlaySound(sound'KF_EnemiesFinalSnd.Patriarch.Kev_SaveMe', SLOT_Misc, 2.0,,500.0);
		if( KFGameType(Level.Game).FinalSquadNum == SyringeCount )
		{
			KFGameType(Level.Game).AddBossBuddySquad();
		}
		GotoState('Escaping');
	}
	else
	{
		GotoState('');
	}
}

defaultproperties
{
     RagMaxSpinAmount=200.000000
     KFRagdollName="SawZombieRag"
     RagShootStrength=6000.000000
     RagGravScale=2.000000
     TurnLeftAnim="WalkF"
     TurnRightAnim="RunF"
     Mesh=SkeletalMesh'kfboss.Boss'
     DrawScale=1.200000
     Skins(0)=FinalBlend'KFPatch2.BossHairFB'
     CollisionRadius=30.000000
     CollisionHeight=60.000000
}
