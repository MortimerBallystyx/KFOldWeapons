// Bat Fire //

class KFMODBatFire extends KFMeleeFire;

var() Name FireAnim2;

function PlayFiring()
{
    local name fa;

    if( FRand()<0.7 ) // Randomly swap animations.
    {
        fa = FireAnim2;
        FireAnim2 = FireAnim;
        FireAnim = fa;
    }
    super.PlayFiring();
}

defaultproperties
{
     FireAnim2="Fire2"
     MeleeDamage=70
     ProxySize=0.120000
     DamagedelayMin=0.500000
     DamagedelayMax=0.500000
     hitDamageClass=class'KFMODDamTypeBat'
     MeleeHitSounds(0)=Sound'KFOldModSnd.Damage.bathitflesh'
     MeleeHitSounds(1)=Sound'KFOldModSnd.Damage.bathitflesh2'
     MeleeHitSounds(2)=Sound'KFOldModSnd.Damage.bathitflesh3'
     FireRate=0.710000
     BotRefireRate=0.710000
}
