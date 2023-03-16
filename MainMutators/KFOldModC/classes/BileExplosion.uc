class BileExplosion extends FleshHitEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=BileExplosionEmitter
         UseCollisionPlanes=True
         FadeOut=True
         RespawnDeadParticles=False
         SpawnOnlyInDirectionOfNormal=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ScaleSizeYByVelocity=True
         ScaleSizeZByVelocity=True
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         Acceleration=(Z=-650.000000)
         ColorScale(0)=(Color=(R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(R=255,A=255))
         ColorMultiplierRange=(Z=(Min=0.670000,Max=2.000000))
         FadeOutStartTime=0.126500
         MaxParticles=65
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=1.000000)
         StartMassRange=(Min=11.000000,Max=11.000000)
         UseRotationFrom=PTRS_Normal
         SpinCCWorCW=(X=1.000000)
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.520000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=3.000000,Max=30.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ScaleSizeByVelocityMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         ScaleSizeByVelocityMax=3.000000
         ParticlesPerSecond=100.000000
         DrawStyle=PTDS_Modulated
         Texture=Texture'KFOldModAmmo.BileSpray'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.401000,Max=1.000000)
         StartVelocityRange=(X=(Min=-150.000000,Max=150.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Min=250.000000,Max=350.000000))
         MaxAbsVelocity=(X=100.000000,Y=100.000000)
     End Object
     Emitters(0)=SpriteEmitter'KFOldModC.BileExplosion.BileExplosionEmitter'

}
