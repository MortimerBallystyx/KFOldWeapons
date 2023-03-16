class ClotGib extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter38
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-600.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.300000
         MaxParticles=5
         SizeScale(0)=(RelativeSize=0.250000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Max=150.000000),Y=(Max=150.000000),Z=(Max=150.000000))
         InitialParticlesPerSecond=2000.000000
         DrawStyle=PTDS_Modulated
         Texture=Texture'Effects_Tex.GoreEmitters.BloodPuff'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=1.000000,Max=1.500000)
         StartVelocityRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=150.000000,Max=350.000000))
     End Object
     Emitters(0)=SpriteEmitter'KFOldModC.ClotGib.SpriteEmitter38'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter39
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-500.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.200000
         MaxParticles=2
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'Effects_Tex.GoreEmitters.BloodCircle'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=150.000000,Max=300.000000))
     End Object
     Emitters(1)=SpriteEmitter'KFOldModC.ClotGib.SpriteEmitter39'

     Begin Object Class=MeshEmitter Name=MeshEmitter5
         StaticMesh=StaticMesh'kf_gore_trip_sm.gibbs.intestines'
         UseCollision=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-1000.000000)
         DampingFactorRange=(X=(Min=0.200000,Max=0.500000),Y=(Min=0.200000,Max=0.500000),Z=(Min=0.200000,Max=0.500000))
         MaxCollisions=(Max=2.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=3
         SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_Regular
         LifetimeRange=(Min=7.000000,Max=7.000000)
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=250.000000,Max=500.000000))
     End Object
     Emitters(2)=MeshEmitter'KFOldModC.ClotGib.MeshEmitter5'

     Begin Object Class=MeshEmitter Name=MeshEmitter6
         StaticMesh=StaticMesh'EffectsSM.PlayerGibbs.Chunk1_Gibb'
         UseCollision=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-1000.000000)
         DampingFactorRange=(X=(Min=0.200000,Max=0.500000),Y=(Min=0.200000,Max=0.500000),Z=(Min=0.200000,Max=0.500000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=30
         SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=0.500000,Max=2.000000),Y=(Min=0.500000,Max=2.000000),Z=(Min=0.500000,Max=2.000000))
         InitialParticlesPerSecond=1000.000000
         LifetimeRange=(Min=7.000000,Max=7.000000)
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=1000.000000))
         VelocityLossRange=(Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(3)=MeshEmitter'KFOldModC.ClotGib.MeshEmitter6'

     Begin Object Class=MeshEmitter Name=ClotArm
         StaticMesh=StaticMesh'22Patch.ClotGibArm'
         UseCollision=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-1000.000000)
         DampingFactorRange=(X=(Min=0.200000,Max=0.500000),Y=(Min=0.200000,Max=0.500000),Z=(Min=0.200000,Max=0.500000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=2
         SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         InitialParticlesPerSecond=1000.000000
         LifetimeRange=(Min=7.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=1000.000000))
         VelocityLossRange=(Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(4)=MeshEmitter'KFOldModC.ClotGib.ClotArm'

     Begin Object Class=MeshEmitter Name=clothead
         StaticMesh=StaticMesh'22Patch.ClotGibHead'
         UseCollision=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-1000.000000)
         DampingFactorRange=(X=(Min=0.200000,Max=0.500000),Y=(Min=0.200000,Max=0.500000),Z=(Min=0.200000,Max=0.500000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         InitialParticlesPerSecond=1000.000000
         LifetimeRange=(Min=7.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=-200.000000,Max=1000.000000),Y=(Min=-200.000000,Max=1000.000000),Z=(Min=1000.000000))
         VelocityLossRange=(Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(5)=MeshEmitter'KFOldModC.ClotGib.clothead'

     Begin Object Class=MeshEmitter Name=ClotLeg
         StaticMesh=StaticMesh'22Patch.ClotGibLeg'
         UseCollision=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-1000.000000)
         DampingFactorRange=(X=(Min=0.200000,Max=0.500000),Y=(Min=0.200000,Max=0.500000),Z=(Min=0.200000,Max=0.500000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=2
         SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         InitialParticlesPerSecond=1000.000000
         LifetimeRange=(Min=7.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=-200.000000,Max=500.000000),Y=(Min=-200.000000,Max=700.000000),Z=(Min=1000.000000))
         VelocityLossRange=(Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(6)=MeshEmitter'KFOldModC.ClotGib.ClotLeg'

     Begin Object Class=MeshEmitter Name=ClotTorso
         StaticMesh=StaticMesh'22Patch.ClotGibLowerTorso'
         UseCollision=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-1000.000000)
         DampingFactorRange=(X=(Min=0.200000,Max=0.500000),Y=(Min=0.200000,Max=0.500000),Z=(Min=0.200000,Max=0.500000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         InitialParticlesPerSecond=1000.000000
         LifetimeRange=(Min=7.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=-200.000000,Max=500.000000),Y=(Min=-200.000000,Max=1000.000000),Z=(Min=1000.000000))
         VelocityLossRange=(Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(7)=MeshEmitter'KFOldModC.ClotGib.ClotTorso'

     Begin Object Class=MeshEmitter Name=ClotThigh
         StaticMesh=StaticMesh'22Patch.ClotGibThigh'
         UseCollision=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-1000.000000)
         DampingFactorRange=(X=(Min=0.200000,Max=0.500000),Y=(Min=0.200000,Max=0.500000),Z=(Min=0.200000,Max=0.500000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=3
         SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         InitialParticlesPerSecond=1000.000000
         LifetimeRange=(Min=7.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=-200.000000,Max=700.000000),Y=(Min=-200.000000,Max=500.000000),Z=(Min=1000.000000))
         VelocityLossRange=(Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(8)=MeshEmitter'KFOldModC.ClotGib.ClotThigh'

     Begin Object Class=MeshEmitter Name=ClotChest
         StaticMesh=StaticMesh'22Patch.ClotGibTorso'
         UseCollision=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-1000.000000)
         DampingFactorRange=(X=(Min=0.200000,Max=0.500000),Y=(Min=0.200000,Max=0.500000),Z=(Min=0.200000,Max=0.500000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         InitialParticlesPerSecond=1000.000000
         LifetimeRange=(Min=7.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=-200.000000,Max=500.000000),Y=(Min=-200.000000,Max=500.000000),Z=(Min=1000.000000))
         VelocityLossRange=(Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(9)=MeshEmitter'KFOldModC.ClotGib.ClotChest'

     AutoDestroy=True
     bNoDelete=False
     bNetTemporary=True
     LifeSpan=10.000000
     Style=STY_Masked
     bUnlit=False
     bDirectional=True
}
