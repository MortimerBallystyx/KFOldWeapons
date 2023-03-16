// Base Zombie Class.
class KFMonsterold extends KFMonster
	hidecategories(AnimTweaks,DeRes,Force,Gib,Karma,Udamage,UnrealPawn)
	Abstract;



    
simulated function DoDamageFX( Name boneName, int Damage, class<DamageType> DamageType, Rotator r )
{
	local float DismemberProbability;
    local int RandBone;
    local bool bDidSever;

	//log("DamageFX bonename = "$boneName$" "$Level.TimeSeconds$" Damage "$Damage);

    if( bDecapitated && !bPlayBrainSplash )
    {
        if( class<DamTypeMelee>(DamageType) != none )
        {
             HitFX[HitFxTicker].damtype = class'DamTypeMeleeDecapitation';
        }
        else
        {
            HitFX[HitFxTicker].damtype = class'DamTypeDecapitation';
        }

        if ( DamageType.default.bNeverSevers || class'GameInfo'.static.UseLowGore()
            || (Level.Game != none && Level.Game.PreventSever(self, boneName, Damage, DamageType)) )
        {
            HitFX[HitFxTicker].bSever = false;
        }
        else
        {
            HitFX[HitFxTicker].bSever = true;
        }

        HitFX[HitFxTicker].bone = HeadBone;
		HitFX[HitFxTicker].rotDir = r;
		HitFxTicker = HitFxTicker + 1;
		if( HitFxTicker > ArrayCount(HitFX)-1 )
			HitFxTicker = 0;

        bPlayBrainSplash = true;

        return;
    }

	if ( FRand() > 0.3f || Damage > 30 || Health <= 0 /*|| DamageType == class 'DamTypeCrossbowHeadshot'*/)
	{
		HitFX[HitFxTicker].damtype = DamageType;

		if( Health <= 0 /*|| DamageType == class 'DamTypeCrossbowHeadshot'*/)
		{
			switch( boneName )
			{


                        case 'Bip01 Head':
					boneName = HeadBone;
					break;

				case LeftFootBone:
				case 'Bip01 L Thigh':
					boneName = LeftThighBone;
					break;

				case RightFootBone:
				case 'Bip01 R Thigh':
					boneName = RightThighBone;
					break;

				case RightHandBone:
				case RightShoulderBone:
				case 'Bip01 R Hand':
					boneName = RightFArmBone;
					break;

				case LeftHandBone:
				case LeftShoulderBone:
				case 'Bip01 L Hand':
					boneName = LeftFArmBone;
					break;

				case 'None':
				case 'Bip01 Spine':
					boneName = FireRootBone;
					break;


			}

			if( DamageType.default.bAlwaysSevers || (Damage == 100) )
			{
				HitFX[HitFxTicker].bSever = true;
				bDidSever = true;
				if ( boneName == 'None' )
				{
					boneName = 'Bip01 R Forearm';
				}
			}
            else if( DamageType.Default.GibModifier > 0.0 )
            {
	            DismemberProbability = Abs( (Health - Damage*DamageType.Default.GibModifier) / 130.0f );

                if( FRand() < DismemberProbability )
                {
                	HitFX[HitFxTicker].bSever = true;
                	bDidSever = true;
                }
            }
        }

        if ( DamageType.default.bNeverSevers || class'GameInfo'.static.UseLowGore()
            || (Level.Game != none && Level.Game.PreventSever(self, boneName, Damage, DamageType)) )
        {
            HitFX[HitFxTicker].bSever = false;
			bDidSever = false;
        }

        if ( HitFX[HitFxTicker].bSever )
        {
	        if( !DamageType.default.bLocationalHit && (boneName == 'None' || boneName == 'Firerootbone' ||
				boneName == 'Bip01 Spine' || boneName == 'LeftFArmBone' || boneName == 'RightThighbone' ))
	        {
	        	RandBone = Rand(4);

				switch( RandBone )
	            {
	                case 0:
						boneName = LeftThighBone;
						break;
	                case 1:
						boneName = RightThighBone;
						break;
	                case 2:
						boneName = LeftFArmBone;
	                    break;
	                case 3:
						boneName = RightFArmBone;
	                    break;
	                case 4:
						boneName = HeadBone;
	                    break;
	                default:
	                	boneName = LeftThighBone;
	            }
	        }
        }

		if ( Health < 0 && Damage > DamageType.default.HumanObliterationThreshhold && Damage != 1000 && !class'GameInfo'.static.UseLowGore() )
		{
			boneName = 'obliterate';
		}

		HitFX[HitFxTicker].bone = boneName;
		HitFX[HitFxTicker].rotDir = r;
		HitFxTicker = HitFxTicker + 1;
		if( HitFxTicker > ArrayCount(HitFX)-1 )
			HitFxTicker = 0;

        // If this was a really hardcore damage from an explosion, randomly spawn some arms and legs
        if ( bDidSever && !DamageType.default.bLocationalHit && Damage > 200 && Damage != 1000 && !class'GameInfo'.static.UseLowGore() )
        {
			if ((Damage > 400 && FRand() < 0.3) || FRand() < 0.1 )
			{
				DoDamageFX(HeadBone,1000,DamageType,r);
				DoDamageFX(LeftThighBone,1000,DamageType,r);
				DoDamageFX(RightThighBone,1000,DamageType,r);
				DoDamageFX(LeftFArmBone,1000,DamageType,r);
				DoDamageFX(RightFArmBone,1000,DamageType,r);
			}
			if ( FRand() < 0.25 )
			{
				DoDamageFX(LeftThighBone,1000,DamageType,r);
				DoDamageFX(RightThighBone,1000,DamageType,r);
				if ( FRand() < 0.5 )
				{
					DoDamageFX(LeftFArmBone,1000,DamageType,r);
				}
				else
				{
					DoDamageFX(RightFArmBone,1000,DamageType,r);
				}
			}
			else if ( FRand() < 0.35 )
				DoDamageFX(LeftThighBone,1000,DamageType,r);
			else if ( FRand() < 0.5 )
				DoDamageFX(RightThighBone,1000,DamageType,r);
			else if ( FRand() < 0.75 )
			{
				if ( FRand() < 0.5 )
				{
					DoDamageFX(LeftFArmBone,1000,DamageType,r);
				}
				else
				{
					DoDamageFX(RightFArmBone,1000,DamageType,r);
				}
			}
		}
    }
}


function bool CanAttack(Actor A)
{
	if (A == none)
		return false;
	if(bSTUNNED)
		return false;
	if(KFDoorMover(A)!=none)
		return true;
	else if(KFHumanPawn(A)!=none && KFHumanPawn(A).Health <= 0)
		return ( VSize(A.Location - Location) < MeleeRange + CollisionRadius);
	else return ( VSize(A.Location - Location) < MeleeRange + CollisionRadius + A.CollisionRadius );
}





function DoorAttack(Actor A)
{
	if ( bShotAnim || Physics == PHYS_Swimming)
		return;
	else if ( A!=None )
	{
        bShotAnim = true;

        SetAnimAction('Claw');
        GotoState('DoorBashing');
		//PlaySound(sound'Claw2s', SLOT_None); KFTODO: Replace this
		return;
	}
}

defaultproperties
{
     MoanVolume=255.000000
     BleedOutDuration=-1.000000
     HeadLessDeathSound=SoundGroup'KFOldModSnd.ZED.ZombieDeath'
     LeftShoulderBone="Bip01 L UpperArm"
     RightShoulderBone="Bip01  UpperArm"
     LeftThighBone="Bip01 L Thigh"
     RightThighBone="Bip01 R Thigh"
     LeftFArmBone="Bip01 L Forearm"
     RightFArmBone="Bip01 R Forearm"
     LeftFootBone="Bip01 L Foot"
     RightFootBone="Bip01 R Foot"
     LeftHandBone="bip01 l hand"
     RightHandBone="Bip01 R Hand"
     NeckBone="Bip01 Neck"
     SeveredArmAttachClass=Class'KFOldModC.SeveredArmAttachment'
     SeveredLegAttachClass=Class'KFOldModC.SeveredArmAttachment'
     SeveredHeadAttachClass=Class'KFOldModC.SeveredArmAttachment'
     ObliteratedEffectClass=Class'KFOldModC.ClotGib'
     PoundRageBumpDamScale=0.000000
     GruntVolume=255.000000
     FootstepVolume=1.500000
     RagDeathVel=175.000000
     RagShootStrength=4000.000000
     RagDeathUpKick=240.000000
     JumpZ=300.000000
     MaxFallSpeed=600.000000
     HeadBone="Bip01_Head"
     SpineBone1="Bip01 Spine1"
     SpineBone2="bip01 Spine2"
     bFullVolume=True
     TransientSoundVolume=100.000000
}
