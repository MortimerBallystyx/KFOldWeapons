// Axe Fire //
class AxeFire extends KFMeleeFire;

var() array<name> FireAnims;

simulated event ModeDoFire()
{
    local int AnimToPlay;

    if(FireAnims.length > 0)
    {
        AnimToPlay = rand(FireAnims.length);
        FireAnim = FireAnims[AnimToPlay];
    }

    Super.ModeDoFire();

}

defaultproperties
{
     FireAnims(0)="Fire"
     FireAnims(1)="Fire"
     FireAnims(2)="Fire"
     FireAnims(3)="Fire"
     MeleeDamage=125
     ProxySize=0.150000
     weaponRange=90.000000
     DamagedelayMin=0.800000
     DamagedelayMax=0.800000
     hitDamageClass=Class'KFOldModC.DamTypeAxe'
     MeleeHitSounds(0)=SoundGroup'KF_AxeSnd.Axe_HitFlesh'
     HitEffectClass=Class'KFMod.AxeHitEffect'
     FireRate=1.120000
     BotRefireRate=0.850000
}
