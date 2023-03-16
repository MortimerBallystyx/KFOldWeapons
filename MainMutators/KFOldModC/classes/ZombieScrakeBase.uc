// Chainsaw Zombie Monster for KF Invasion gametype
// He's not quite as speedy as the other Zombies, But his attacks are TRULY damaging.
class ZombieScrakeBase extends KFMonsterold;

#exec OBJ LOAD FILE=KFOldModSnd

var(Sounds) sound   SawAttackLoopSound; // THe sound for the saw revved up, looping
var(Sounds) sound   ChainSawOffSound;   //The sound of this zombie dieing without a head

var         bool    bCharging;          // Scrake charges when his health gets low
var()       float   AttackChargeRate;   // Ratio to increase scrake movement speed when charging and attacking

// Exhaust effects
var()	class<VehicleExhaustEffect>	ExhaustEffectClass; // Effect class for the exhaust emitter
var()	VehicleExhaustEffect 		ExhaustEffect;
var 		bool	bNoExhaustRespawn;

replication
{
	reliable if(Role == ROLE_Authority)
		bCharging;
}

//-------------------------------------------------------------------------------
// NOTE: All Code resides in the child class(this class was only created to
//         eliminate hitching caused by loading default properties during play)
//-------------------------------------------------------------------------------

defaultproperties
{
     SawAttackLoopSound=Sound'KF_BaseScrake.Chainsaw.Scrake_Chainsaw_Impale'
     ChainSawOffSound=SoundGroup'KF_ChainsawSnd.Chainsaw_Deselect'
     AttackChargeRate=2.500000
     MeleeAnims(0)="SawZombieAttack1"
     MeleeAnims(1)="SawZombieAttack2"
     MoanVoice=SoundGroup'KFOldModSnd.ZedVoice.ScrakeMoan'
     BleedOutDuration=0.000000
     ZombieFlag=3
     MeleeDamage=13
     damageForce=-400000
     bFatAss=True
     KFRagdollName="Scrake_Trip"
     MeleeAttackHitSound=SoundGroup'KFOldModSnd.Damage.HurtSurvivor'
     JumpSound=Sound'KFOldModSnd.ZED.ZomJump'
     bMeleeStunImmune=True
     Intelligence=BRAINS_Mammal
     bUseExtendedCollision=True
     ColOffset=(Z=39.000000)
     ColRadius=29.000000
     ColHeight=40.000000
     SeveredArmAttachScale=1.100000
     SeveredLegAttachScale=1.100000
     OnlineHeadshotOffset=(X=22.000000,Y=5.000000,Z=58.000000)
     OnlineHeadshotScale=1.500000
     HeadHealth=650.000000
     PlayerNumHeadHealthScale=0.250000
     MotionDetectorThreat=3.000000
     HitSound(0)=SoundGroup'KFOldModSnd.ZED.ZomPain'
     DeathSound(0)=SoundGroup'KFOldModSnd.ZED.ZombieDeath'
     ChallengeSound(0)=SoundGroup'KFOldModSnd.ZedVoice.ScrakeMoan'
     ChallengeSound(1)=SoundGroup'KFOldModSnd.ZedVoice.ScrakeMoan'
     ChallengeSound(2)=SoundGroup'KFOldModSnd.ZedVoice.ScrakeMoan'
     ChallengeSound(3)=SoundGroup'KFOldModSnd.ZedVoice.ScrakeMoan'
     ScoringValue=5
     IdleHeavyAnim="SawZombieIdle"
     IdleRifleAnim="SawZombieIdle"
     MeleeRange=60.000000
     GroundSpeed=85.000000
     WaterSpeed=75.000000
     HealthMax=1500.000000
     Health=1500
     HeadHeight=2.200000
     MenuName="Scrake"
     MovementAnims(0)="SawZombieWalk"
     MovementAnims(1)="SawZombieWalk"
     MovementAnims(2)="SawZombieWalk"
     MovementAnims(3)="SawZombieWalk"
     WalkAnims(0)="SawZombieWalk"
     WalkAnims(1)="SawZombieWalk"
     WalkAnims(2)="SawZombieWalk"
     WalkAnims(3)="SawZombieWalk"
     IdleCrouchAnim="SawZombieIdle"
     IdleWeaponAnim="SawZombieIdle"
     IdleRestAnim="SawZombieIdle"
     AmbientSound=Sound'KFOldModSnd.Weapon.SawIdle'
     Mesh=SkeletalMesh'KF_Freaks_Trip.Scrake_Freak'
     PrePivot=(Z=8.000000)
     Skins(0)=Shader'KF_Specimens_Trip_T.scrake_FB'
     Skins(1)=TexPanner'KF_Specimens_Trip_T.scrake_saw_panner'
     SoundVolume=255
     SoundRadius=600.000000
     Mass=500.000000
     RotationRate=(Yaw=45000,Roll=0)
}
