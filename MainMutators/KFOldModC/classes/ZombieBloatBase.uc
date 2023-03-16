// Zombie Monster for KF Invasion gametype
class ZombieBloatBase extends KFMonsterold;



var BileJet BloatJet;
var bool bPlayBileSplash;
var bool bMovingPukeAttack;
var float RunAttackTimeout;

//-------------------------------------------------------------------------------
// NOTE: All Code resides in the child class(this class was only created to
//         eliminate hitching caused by loading default properties during play)
//-------------------------------------------------------------------------------

defaultproperties
{
     MeleeAnims(0)="BloatChop2"
     MeleeAnims(1)="BloatChop2"
     MeleeAnims(2)="BloatChop2"
     MoanVoice=SoundGroup'KFOldModSnd.ZedVoice.BloatMoan'
     MoanVolume=5.500000
     BleedOutDuration=0.000000
     ZombieFlag=1
     MeleeDamage=10
     damageForce=70000
     bFatAss=True
     KFRagdollName="Bloat_Trip"
     MeleeAttackHitSound=SoundGroup'KFOldModSnd.Damage.HurtSurvivor'
     JumpSound=Sound'KFOldModSnd.ZED.ZomJump'
     PuntAnim="BloatPunt"
     Intelligence=BRAINS_Stupid
     bCanDistanceAttackDoors=True
     bUseExtendedCollision=True
     ColOffset=(Z=60.000000)
     ColRadius=27.000000
     ColHeight=22.000000
     SeveredArmAttachScale=1.100000
     SeveredLegAttachScale=1.300000
     SeveredHeadAttachScale=1.700000
     OnlineHeadshotOffset=(X=5.000000,Z=70.000000)
     OnlineHeadshotScale=1.500000
     HitSound(0)=SoundGroup'KFOldModSnd.ZED.ZomPain'
     DeathSound(0)=SoundGroup'KFOldModSnd.ZED.ZombieDeath'
     ChallengeSound(0)=SoundGroup'KFOldModSnd.ZedVoice.BloatMoan'
     ChallengeSound(1)=SoundGroup'KFOldModSnd.ZedVoice.BloatMoan'
     ChallengeSound(2)=SoundGroup'KFOldModSnd.ZedVoice.BloatMoan'
     ChallengeSound(3)=SoundGroup'KFOldModSnd.ZedVoice.BloatMoan'
     AmmunitionClass=Class'KFMod.BZombieAmmo'
     ScoringValue=2
     IdleHeavyAnim="BloatIdle"
     IdleRifleAnim="BloatIdle"
     MeleeRange=55.000000
     GroundSpeed=105.000000
     WaterSpeed=102.000000
     HealthMax=400.000000
     Health=400
     HeadHeight=10.500000
     HeadScale=1.500000
     AmbientSoundScaling=50.000000
     MenuName="Bloat"
     MovementAnims(0)="WalkBloat"
     MovementAnims(1)="WalkBloat"
     WalkAnims(0)="WalkBloat"
     WalkAnims(1)="WalkBloat"
     WalkAnims(2)="WalkBloat"
     WalkAnims(3)="WalkBloat"
     IdleCrouchAnim="BloatIdle"
     IdleWeaponAnim="BloatIdle"
     IdleRestAnim="BloatIdle"
     AmbientSound=Sound'KF_BaseBloat.Bloat_Idle1Loop'
     Mesh=SkeletalMesh'KF_Freaks_Trip.Bloat_Freak'
     DrawScale=1.075000
     PrePivot=(Z=5.000000)
     Skins(0)=Combiner'KF_Specimens_Trip_T.bloat_cmb'
     SoundVolume=200
     Mass=400.000000
     RotationRate=(Yaw=45000,Roll=0)
}
