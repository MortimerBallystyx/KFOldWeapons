class KFMODBullpupAttachment extends KFWeaponAttachment;

defaultproperties
{
     mMuzFlashClass=class'ROEffects.MuzzleFlash3rdMP'
     mTracerClass=class'KFMod.KFNewTracer'
     mShellCaseEmitterClass=class'KFMod.KFShellSpewer'
     TurnLeftAnim="TurnL_Bullpup"
     TurnRightAnim="TurnR_Bullpup"
     WalkAnims(0)="WalkF_Bullpup"
     WalkAnims(1)="WalkB_Bullpup"
     WalkAnims(2)="WalkL_Bullpup"
     WalkAnims(3)="WalkR_Bullpup"
     CrouchTurnRightAnim="CH_TurnR_Bullpup"
     CrouchTurnLeftAnim="CH_TurnL_Bullpup"
     bRapidFire=true
     bAltRapidFire=true
     SplashEffect=class'ROEffects.BulletSplashEmitter'
     CullDistance=5000.000000
     Mesh=SkeletalMesh'KFWeaponModelsOldMod.L853P'
}
