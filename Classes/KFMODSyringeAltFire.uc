// self Healing Fire //
class KFMODSyringeAltFire extends WeaponFire;

var float InjectDelay;
var float HealeeRange;

function DoFireEffect()
{
    SetTimer(InjectDelay, false);

    if ( Level.NetMode != NM_StandAlone && Level.Game.NumPlayers > 1 && KFPlayerController(Instigator.Controller) != none &&
         KFSteamStatsAndAchievements(KFPlayerController(Instigator.Controller).SteamStatsAndAchievements) != none )
    {
        KFSteamStatsAndAchievements(KFPlayerController(Instigator.Controller).SteamStatsAndAchievements).AddSelfHeal();
    }
}

Function Timer()
{
    local float HealSum;

    HealSum = Syringe(Weapon).HealBoostAmount;

    if ( KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo) != none && KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill != none )
    {
        HealSum *= KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill.Static.GetHealPotency(KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo));
    }

    Weapon.ConsumeAmmo(ThisModeNum, AmmoPerFire);
    Instigator.GiveHealth(HealSum, 100);
}

function bool AllowFire()
{
    if (Instigator.Health >= Instigator.HealthMax)
     return false;

        return Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire;
}

event ModeDoFire()
{
    Load = 0;
    super.ModeDoFire(); // We don't consume the ammo just yet.
}

function PlayFiring()
{
    if ( Weapon.Mesh != none )
    {
        if ( FireCount > 0 )
        {
            if ( Weapon.HasAnim(FireLoopAnim) )
            {
                Weapon.PlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0);
            }
            else
            {
                Weapon.PlayAnim(FireAnim, FireAnimRate, 0.0);
            }
        }
        else
        {
            Weapon.PlayAnim(FireAnim, FireAnimRate, 0.0);
        }
    }
    Weapon.PlayOwnedSound(FireSound,SLOT_Interact,TransientSoundVolume,,TransientSoundRadius,default.FireAnimRate/FireAnimRate,false);
    ClientPlayForceFeedback(FireForce);  // jdf

    FireCount++;
}

defaultproperties
{
     InjectDelay=1.000000
     HealeeRange=70.000000
     TransientSoundVolume=100.000000
     FireAnim="AltFire"
     FireRate=4.160000
     AmmoPerFire=500
}
