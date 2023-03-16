class VomitDecal extends ProjectedDecal;

#exec OBJ LOAD File=KFOldModAmmo.utx

simulated function BeginPlay()
{
    if ( !Level.bDropDetail && (FRand() < 0.5) )
        ProjTexture = texture'Vomsplatold';
    Super.BeginPlay();
}

defaultproperties
{
     ProjTexture=Texture'KFOldModAmmo.VomSplatOld'
     bClipStaticMesh=True
     CullDistance=7000.000000
     LifeSpan=5.000000
     DrawScale=0.500000
}
