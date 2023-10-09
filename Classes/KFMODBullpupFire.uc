//=============================================================================
 //L85 Fire
//=============================================================================
class KFMODBullpupFire extends KFFire;

var float ClickTime;
var vector  KickMomentum;
var bool bZoomed;

// Calculate modifications to spread
simulated function float GetSpread()
{
    local float NewSpread;
    local float AccuracyMod;

    AccuracyMod = 1.0;

    // Spread bonus for firing aiming
    if( KFWeap.bAimingRifle )
    {
        AccuracyMod *= 0.5;
    }

    // Small spread bonus for firing crouched
    if( Instigator != none && Instigator.bIsCrouched )
    {
        AccuracyMod *= 0.85;
    }

    // Small spread bonus for firing in semi auto mode
    if( bWaitForRelease )
    {
        AccuracyMod *= 0.85;
    }


    NumShotsInBurst += 1;

    if ( Level.TimeSeconds - LastFireTime > 0.5 )
    {
        NewSpread = default.Spread;
        NumShotsInBurst=0;
    }
    else
    {
        // Decrease accuracy up to MaxSpread by the number of recent shots up to a max of six
        NewSpread = FMin(default.Spread + (NumShotsInBurst * (MaxSpread/6.0)),MaxSpread);
    }

    NewSpread *= AccuracyMod;

    return NewSpread;
}

defaultproperties
{
     FireAimedAnim="Fire"
     RecoilRate=0.070000
     maxVerticalRecoilAngle=200
     maxHorizontalRecoilAngle=75
     ShellEjectBoneName="Bullpup"
     StereoFireSound=SoundGroup'KFOldModSnd.Weapon.L85All'
     DamageType=class'KFMODDamTypeBullpup'
     DamageMin=22
     DamageMax=30
     Momentum=8500.000000
     bPawnRapidFireAnim=true
     TransientSoundVolume=30.799999
     FireLoopAnim="Fire"
     TweenTime=0.025000
     FireSound=SoundGroup'KFOldModSnd.Weapon.L85All'
     NoAmmoSound=Sound'KF_9MMSnd.9mm_DryFire'
     FireForce="AssaultRifleFire"
     FireRate=0.100000
     AmmoClass=class'KFMODBullpupAmmo'
     AmmoPerFire=1
     ShakeRotMag=(X=75.000000,Y=75.000000,Z=250.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=0.500000
     ShakeOffsetMag=(X=6.000000,Y=3.000000,Z=10.000000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.990000
     FlashEmitterClass=class'ROEffects.MuzzleFlash1stSTG'
     aimerror=42.000000
     Spread=0.009000
     SpreadStyle=SS_Random
}
