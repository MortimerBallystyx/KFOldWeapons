// Knife Stab //
class KnifeFireB extends KFMeleeFire;

defaultproperties
{
     MeleeDamage=55
     DamagedelayMin=0.500000
     DamagedelayMax=0.500000
     hitDamageClass=class'DamTypeKnife'
     MeleeHitSounds(0)=SoundGroup'KF_KnifeSnd.Knife_HitFlesh'
     HitEffectClass=class'KFMod.KnifeHitEffect'
     FireAnim="Stab"
     FireRate=1.100000
     BotRefireRate=1.100000
}
