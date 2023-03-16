// Chainsaw Zombie Monster for KF Invasion gametype
// He's not quite as speedy as the other Zombies, But his attacks are TRULY damaging.
class ZombieScrakeold extends zombiescrake_STANDARD;

simulated Function PostNetBeginPlay()
{
	EnableChannelNotify ( 1,1);
	AnimBlendParams(1, 1.0, 0.0,, SpineBone1);
	super.PostNetBeginPlay();
}

// Make the scrakes's ambient scale higher, since there are just a few, and thier chainsaw need to be heard from a distance
simulated function CalcAmbientRelevancyScale()
{
	// Make the zed only relevant by thier ambient sound out to a range of 30 meters
	CustomAmbientRelevancyScale = 1500/(100 * SoundRadius);
}

simulated function PostNetReceive()
{
	MovementAnims[0]=default.MovementAnims[0];
}

function RangedAttack(Actor A)
{
	if ( bShotAnim || Physics == PHYS_Swimming)
		return;
	else if ( CanAttack(A) )
	{
		bShotAnim = true;
		SetAnimAction(MeleeAnims[Rand(2)]);
		CurrentDamType = ZombieDamType[0];
		//PlaySound(sound'Claw2s', SLOT_None); KFTODO: Replace this
		GoToState('SawingLoop');
	}

	if( !bShotAnim && !bDecapitated && Health/HealthMax < 0.35 )
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
		GroundSpeed = OriginalGroundSpeed * 3.5;
		bCharging = true;
		if( Level.NetMode!=NM_DedicatedServer )
			PostNetReceive();
	}

	function EndState()
	{
		GroundSpeed = OriginalGroundSpeed;
		bCharging = False;
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
			SetAnimAction(MeleeAnims[Rand(2)]);
			CurrentDamType = ZombieDamType[0];
			GoToState('SawingLoop');
		}
	}
}

State SawingLoop
{
	function RangedAttack(Actor A)
	{
		if ( bShotAnim )
			return;
		else if ( CanAttack(A) )
		{
			Acceleration = vect(0,0,0);
			bShotAnim = true;
			MeleeDamage = default.MeleeDamage*0.6;
			SetAnimAction('SawImpaleLoop');
			CurrentDamType = ZombieDamType[0];
			if( AmbientSound != SawAttackLoopSound )
			{
				AmbientSound=SawAttackLoopSound;
			}
		}
		else GoToState('');
	}
	function AnimEnd( int Channel )
	{
		Super.AnimEnd(Channel);
		if( Controller!=None && Controller.Enemy!=None )
			RangedAttack(Controller.Enemy); // Keep on attacking if possible.
	}
	function EndState()
	{
		AmbientSound=default.AmbientSound;
		MeleeDamage= default.MeleeDamage;
	}
}

function PlayTakeHit(vector HitLocation, int Damage, class<DamageType> DamageType)
{
	local int StunChance;

	StunChance = rand(5);

	if( Level.TimeSeconds - LastPainAnim < MinTimeBetweenPainAnims )
		return;

	if( Damage>=150 || (DamageType.name=='DamTypeStunNade' && StunChance>3) || (DamageType.name=='DamTypeCrossbowHeadshot' && Damage>=200) )
		PlayDirectionalHit(HitLocation);

	LastPainAnim = Level.TimeSeconds;

	if( Level.TimeSeconds - LastPainSound < MinTimeBetweenPainSounds )
		return;

	LastPainSound = Level.TimeSeconds;
	PlaySound(HitSound[0], SLOT_Pain,1.25,,400);
}

simulated function int DoAnimAction( name AnimName )
{
	if( AnimName=='SawZombieAttack1' || AnimName=='SawZombieAttack2' )
	{
		AnimBlendParams(1, 1.0, 0.0,, SpineBone1);
		PlayAnim(AnimName,, 0.1, 1);
		Return 1;
	}
	Return Super.DoAnimAction(AnimName);
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
	if( TestAnim == 'SawImpaleLoop' )
	{
		return true;
	}

	return false;
}

function PlayDyingSound()
{
	if( Level.NetMode!=NM_Client )
	{
		if ( bGibbed )
		{
			// Do nothing for now
			PlaySound(GibGroupClass.static.GibSound(), SLOT_Pain,2.0,true,525);
			return;
		}

		if( bDecapitated )
		{

			PlaySound(HeadlessDeathSound, SLOT_Pain,1.30,true,525);
		}
		else
		{
			PlaySound(DeathSound[0], SLOT_Pain,1.30,true,525);
		}

		PlaySound(ChainSawOffSound, SLOT_Misc, 2.0,,525.0);
	}
}

function Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	AmbientSound = none;

	super.Died( Killer, damageType, HitLocation );
}

simulated function ProcessHitFX()
{
	local Coords boneCoords;
	local class<xEmitter> HitEffects[4];
	local int i,j;
	local float GibPerterbation;

	if( (Level.NetMode == NM_DedicatedServer) || bSkeletized || (Mesh == SkeletonMesh))
	{
		SimHitFxTicker = HitFxTicker;
		return;
	}

	for ( SimHitFxTicker = SimHitFxTicker; SimHitFxTicker != HitFxTicker; SimHitFxTicker = (SimHitFxTicker + 1) % ArrayCount(HitFX) )
	{
		j++;
		if ( j > 30 )
		{
			SimHitFxTicker = HitFxTicker;
			return;
		}

		if( (HitFX[SimHitFxTicker].damtype == None) || (Level.bDropDetail && (Level.TimeSeconds - LastRenderTime > 3) && !IsHumanControlled()) )
			continue;

		//log("Processing effects for damtype "$HitFX[SimHitFxTicker].damtype);

		if( HitFX[SimHitFxTicker].bone == 'obliterate' && !class'GameInfo'.static.UseLowGore())
		{
			SpawnGibs( HitFX[SimHitFxTicker].rotDir, 1);
			bGibbed = true;
			Destroy();
			return;
		}

		boneCoords = GetBoneCoords( HitFX[SimHitFxTicker].bone );

		if ( !Level.bDropDetail && !class'GameInfo'.static.NoBlood() && !bSkeletized )
		{
			//AttachEmitterEffect( BleedingEmitterClass, HitFX[SimHitFxTicker].bone, boneCoords.Origin, HitFX[SimHitFxTicker].rotDir );

			HitFX[SimHitFxTicker].damtype.static.GetHitEffects( HitEffects, Health );

			if( !PhysicsVolume.bWaterVolume ) // don't attach effects under water
			{
				for( i = 0; i < ArrayCount(HitEffects); i++ )
				{
					if( HitEffects[i] == None )
						continue;

					AttachEffect( HitEffects[i], HitFX[SimHitFxTicker].bone, boneCoords.Origin, HitFX[SimHitFxTicker].rotDir );
				}
			}
		}
		if ( class'GameInfo'.static.UseLowGore() )
			HitFX[SimHitFxTicker].bSever = false;

		if( HitFX[SimHitFxTicker].bSever )
		{
			GibPerterbation = HitFX[SimHitFxTicker].damtype.default.GibPerterbation;

			switch( HitFX[SimHitFxTicker].bone )
			{
				case 'obliterate':
					break;

				case LeftThighBone:
					if( !bLeftLegGibbed )
					{
						SpawnSeveredGiblet( DetachedLegClass, boneCoords.Origin, HitFX[SimHitFxTicker].rotDir, GibPerterbation, GetBoneRotation(HitFX[SimHitFxTicker].bone) );
						KFSpawnGiblet( class 'KFMod.KFGibBrain',boneCoords.Origin, HitFX[SimHitFxTicker].rotDir, GibPerterbation, 250 ) ;
						KFSpawnGiblet( class 'KFMod.KFGibBrainb',boneCoords.Origin, HitFX[SimHitFxTicker].rotDir, GibPerterbation, 250 ) ;
						KFSpawnGiblet( class 'KFMod.KFGibBrain',boneCoords.Origin, HitFX[SimHitFxTicker].rotDir, GibPerterbation, 250 ) ;
						bLeftLegGibbed=true;
					}
					break;

				case RightThighBone:
					if( !bRightLegGibbed )
					{
						SpawnSeveredGiblet( DetachedLegClass, boneCoords.Origin, HitFX[SimHitFxTicker].rotDir, GibPerterbation, GetBoneRotation(HitFX[SimHitFxTicker].bone) );
						KFSpawnGiblet( class 'KFMod.KFGibBrain',boneCoords.Origin, HitFX[SimHitFxTicker].rotDir, GibPerterbation, 250 ) ;
						KFSpawnGiblet( class 'KFMod.KFGibBrainb',boneCoords.Origin, HitFX[SimHitFxTicker].rotDir, GibPerterbation, 250 ) ;
						KFSpawnGiblet( class 'KFMod.KFGibBrain',boneCoords.Origin, HitFX[SimHitFxTicker].rotDir, GibPerterbation, 250 ) ;
						bRightLegGibbed=true;
					}
					break;

				case LeftFArmBone:
					if( !bLeftArmGibbed )
					{
						SpawnSeveredGiblet( DetachedArmClass, boneCoords.Origin, HitFX[SimHitFxTicker].rotDir, GibPerterbation, GetBoneRotation(HitFX[SimHitFxTicker].bone) );
						KFSpawnGiblet( class 'KFMod.KFGibBrain',boneCoords.Origin, HitFX[SimHitFxTicker].rotDir, GibPerterbation, 250 ) ;
						KFSpawnGiblet( class 'KFMod.KFGibBrainb',boneCoords.Origin, HitFX[SimHitFxTicker].rotDir, GibPerterbation, 250 ) ;;
						bLeftArmGibbed=true;
					}
					break;

				case RightFArmBone:
					if( !bRightArmGibbed )
					{
						SpawnSeveredGiblet( DetachedSpecialArmClass, boneCoords.Origin, HitFX[SimHitFxTicker].rotDir, GibPerterbation, GetBoneRotation(HitFX[SimHitFxTicker].bone) );
						KFSpawnGiblet( class 'KFMod.KFGibBrain',boneCoords.Origin, HitFX[SimHitFxTicker].rotDir, GibPerterbation, 250 ) ;
						KFSpawnGiblet( class 'KFMod.KFGibBrainb',boneCoords.Origin, HitFX[SimHitFxTicker].rotDir, GibPerterbation, 250 ) ;
						bRightArmGibbed=true;
					}
					break;

				case 'head':
					if( !bHeadGibbed )
					{
						if ( HitFX[SimHitFxTicker].damtype == class'DamTypeDecapitation' )
						{
							DecapFX( boneCoords.Origin, HitFX[SimHitFxTicker].rotDir, false);
						}
						else if( HitFX[SimHitFxTicker].damtype == class'DamTypeMeleeDecapitation' )
						{
							DecapFX( boneCoords.Origin, HitFX[SimHitFxTicker].rotDir, true);
						}

						bHeadGibbed=true;
					}
					break;
			}


			if( HitFX[SimHitFXTicker].bone != 'Spine' && HitFX[SimHitFXTicker].bone != FireRootBone &&
				HitFX[SimHitFXTicker].bone != 'head')
				HideBone(HitFX[SimHitFxTicker].bone);
		}
	}
}

// Maybe spawn some chunks when the player gets obliterated
simulated function SpawnGibs(Rotator HitRotation, float ChunkPerterbation)
{
	bGibbed = true;
	PlayDyingSound();

	if ( class'GameInfo'.static.UseLowGore() )
		return;

	if( ObliteratedEffectClass != none )
		Spawn( ObliteratedEffectClass,,, Location, HitRotation );

	super.SpawnGibs(HitRotation,ChunkPerterbation);

	if ( FRand() < 0.1 )
	{
		KFSpawnGiblet( class 'KFMod.KFGibBrain',Location, HitRotation, ChunkPerterbation, 500 ) ;
		KFSpawnGiblet( class 'KFMod.KFGibBrainb',Location, HitRotation, ChunkPerterbation, 500 ) ;
		KFSpawnGiblet( class 'KFMod.KFGibBrain',Location, HitRotation, ChunkPerterbation, 500 ) ;
		KFSpawnGiblet( class 'KFMod.KFGibBrainb',Location, HitRotation, ChunkPerterbation, 500 ) ;
		KFSpawnGiblet( class 'KFMod.KFGibBrain',Location, HitRotation, ChunkPerterbation, 500 ) ;

		SpawnSeveredGiblet( DetachedLegClass, Location, HitRotation, ChunkPerterbation, HitRotation );
		SpawnSeveredGiblet( DetachedLegClass, Location, HitRotation, ChunkPerterbation, HitRotation );
		SpawnSeveredGiblet( DetachedSpecialArmClass, Location, HitRotation, ChunkPerterbation, HitRotation );
		SpawnSeveredGiblet( DetachedArmClass, Location, HitRotation, ChunkPerterbation, HitRotation );
	}
	else if ( FRand() < 0.25 )
	{
		KFSpawnGiblet( class 'KFMod.KFGibBrainb',Location, HitRotation, ChunkPerterbation, 500 ) ;
		KFSpawnGiblet( class 'KFMod.KFGibBrain',Location, HitRotation, ChunkPerterbation, 500 ) ;
		KFSpawnGiblet( class 'KFMod.KFGibBrainb',Location, HitRotation, ChunkPerterbation, 500 ) ;
		KFSpawnGiblet( class 'KFMod.KFGibBrain',Location, HitRotation, ChunkPerterbation, 500 ) ;

		SpawnSeveredGiblet( DetachedLegClass, Location, HitRotation, ChunkPerterbation, HitRotation );
		SpawnSeveredGiblet( DetachedLegClass, Location, HitRotation, ChunkPerterbation, HitRotation );
		if ( FRand() < 0.5 )
		{
			KFSpawnGiblet( class 'KFMod.KFGibBrain',Location, HitRotation, ChunkPerterbation, 500 ) ;
			SpawnSeveredGiblet( DetachedArmClass, Location, HitRotation, ChunkPerterbation, HitRotation );
		}
	}
	else if ( FRand() < 0.35 )
	{
		KFSpawnGiblet( class 'KFMod.KFGibBrainb',Location, HitRotation, ChunkPerterbation, 500 ) ;
		KFSpawnGiblet( class 'KFMod.KFGibBrain',Location, HitRotation, ChunkPerterbation, 500 ) ;
		SpawnSeveredGiblet( DetachedLegClass, Location, HitRotation, ChunkPerterbation, HitRotation );
	}
	else if ( FRand() < 0.5 )
	{
		KFSpawnGiblet( class 'KFMod.KFGibBrainb',Location, HitRotation, ChunkPerterbation, 500 ) ;
		KFSpawnGiblet( class 'KFMod.KFGibBrain',Location, HitRotation, ChunkPerterbation, 500 ) ;
		SpawnSeveredGiblet( DetachedArmClass, Location, HitRotation, ChunkPerterbation, HitRotation );
	}
}

defaultproperties
{
     RagMaxSpinAmount=200.000000
     KFRagdollName="SawZombieRag"
     RagShootStrength=6000.000000
     RagDeathUpKick=100.000000
     RagGravScale=2.000000
     Mesh=SkeletalMesh'KFCharactermodels.SawZombie'
     DrawScale=1.000000
     Skins(0)=Shader'KFCharacters.Zombie6Shader'
     Skins(1)=Texture'KillingFloorWeapons.Chainsaw.ChainSawSkin3PZombie'
     Skins(2)=TexOscillator'KillingFloorWeapons.Chainsaw.SAWCHAIN'
     Skins(3)=Texture'KFCharacters.ScrakeFrock'
}
