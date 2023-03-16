// Zombie Monster for KF Invasion gametype
// He's speedy, and swings with a Single enlongated arm, affording him slightly more range
class ZombieGoreFastBase extends KFMonsterold;

#exec OBJ LOAD FILE=KFOldModSnd.uax

var bool bRunning;
var float RunAttackTimeout;

replication
{
	reliable if(Role == ROLE_Authority)
		bRunning;
}

//-------------------------------------------------------------------------------
// NOTE: All Code resides in the child class(this class was only created to
//         eliminate hitching caused by loading default properties during play)
//-------------------------------------------------------------------------------

defaultproperties
{
     MeleeAnims(0)="GoreAttack1"
     MeleeAnims(1)="GoreAttack2"
     MeleeAnims(2)="GoreAttack1"
     MoanVoice=SoundGroup'KFOldModSnd.ZedVoice.GoreFastMoan'
     MoanVolume=5.500000
     bCannibal=True
     MeleeDamage=10
     damageForce=5000
     KFRagdollName="GoreFast_Trip"
     MeleeAttackHitSound=SoundGroup'KFOldModSnd.Weapon.Knifehits'
     JumpSound=Sound'KFOldModSnd.ZED.ZomJump'
     CrispUpThreshhold=8
     bUseExtendedCollision=True
     ColOffset=(Z=52.000000)
     ColRadius=25.000000
     ColHeight=10.000000
     ExtCollAttachBoneName="Collision_Attach"
     SeveredArmAttachScale=0.900000
     SeveredLegAttachScale=0.900000
     OnlineHeadshotOffset=(X=5.000000,Z=53.000000)
     OnlineHeadshotScale=1.500000
     MotionDetectorThreat=0.500000
     HitSound(0)=SoundGroup'KFOldModSnd.ZED.ZomPain'
     DeathSound(0)=SoundGroup'KFOldModSnd.ZED.ZombieDeath'
     ChallengeSound(0)=SoundGroup'KFOldModSnd.ZedVoice.GoreFastMoan'
     ChallengeSound(1)=SoundGroup'KFOldModSnd.ZedVoice.GoreFastMoan'
     ChallengeSound(2)=SoundGroup'KFOldModSnd.ZedVoice.GoreFastMoan'
     ChallengeSound(3)=SoundGroup'KFOldModSnd.ZedVoice.GoreFastMoan'
     ScoringValue=3
     IdleHeavyAnim="GoreIdle"
     IdleRifleAnim="GoreIdle"
     MeleeRange=60.000000
     GroundSpeed=150.000000
     WaterSpeed=140.000000
     HealthMax=350.000000
     Health=350
     HeadHeight=2.500000
     HeadScale=1.500000
     MenuName="Gorefast"
     MovementAnims(0)="GoreWalk"
     WalkAnims(0)="GoreWalk"
     WalkAnims(1)="GoreWalk"
     WalkAnims(2)="GoreWalk"
     WalkAnims(3)="GoreWalk"
     IdleCrouchAnim="GoreIdle"
     IdleWeaponAnim="GoreIdle"
     IdleRestAnim="GoreIdle"
     AmbientSound=Sound'KF_BaseGorefast.Gorefast_Idle'
     Mesh=SkeletalMesh'KF_Freaks_Trip.GoreFast_Freak'
     PrePivot=(Z=0.000000)
     Skins(0)=Combiner'KF_Specimens_Trip_T.gorefast_cmb'
     Mass=350.000000
     RotationRate=(Yaw=45000,Roll=0)
}
