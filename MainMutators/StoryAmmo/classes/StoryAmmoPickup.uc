class StoryAmmoPickup extends KFAmmoPickup;

var() class<KFAmmunition> AmmoClass;

state Pickup
{
	// When touched by an actor.
	function Touch(Actor Other)
	{
		local Inventory CurInv;
		local KFAmmunition KFAmmo;
		local bool bPickedUp;
		local int AmmoPickupAmount;
		local Boomstick DBShotty;
		local bool bResuppliedBoomstick;

		if ( Pawn(Other) != none && Pawn(Other).bCanPickupInventory && Pawn(Other).Controller != none &&
			 FastTrace(Other.Location, Location) )
		{
			for ( CurInv = Other.Inventory; CurInv != none; CurInv = CurInv.Inventory )
			{
        if( AmmoClass == CurInv.class )
        {
            KFAmmo = KFAmmunition(CurInv);
  				if( Boomstick(CurInv) != none )
  				{
  				    DBShotty = Boomstick(CurInv);
  				}
            if ( KFAmmo.bAcceptsAmmoPickups )
    				{
    					if ( KFAmmo.AmmoPickupAmount > 1 )
    					{
    						if ( KFAmmo.AmmoAmount < KFAmmo.MaxAmmo )
    						{
    							if ( KFPlayerReplicationInfo(Pawn(Other).PlayerReplicationInfo) != none && KFPlayerReplicationInfo(Pawn(Other).PlayerReplicationInfo).ClientVeteranSkill != none )
    							{
    								AmmoPickupAmount = float(KFAmmo.AmmoPickupAmount) * KFPlayerReplicationInfo(Pawn(Other).PlayerReplicationInfo).ClientVeteranSkill.static.GetAmmoPickupMod(KFPlayerReplicationInfo(Pawn(Other).PlayerReplicationInfo), KFAmmo);
    							}
    							else
    							{
    								AmmoPickupAmount = KFAmmo.AmmoPickupAmount;
    							}
  
    							KFAmmo.AmmoAmount = Min(KFAmmo.MaxAmmo, KFAmmo.AmmoAmount + AmmoPickupAmount);
    							if( DBShotgunAmmo(CurInv) != none )
    							{
                    bResuppliedBoomstick = true;
    							}
    							bPickedUp = true;
    						}
    					}
    					else if ( KFAmmo.AmmoAmount < KFAmmo.MaxAmmo )
    					{
    						bPickedUp = true;
  
    						if ( FRand() <= (1.0 / Level.Game.GameDifficulty) )
    						{
    							KFAmmo.AmmoAmount++;
    						}
    					}
          }
        }

  			if ( bPickedUp )
  			{
                  if( bResuppliedBoomstick && DBShotty != none )
                  {
                      DBShotty.AmmoPickedUp();
                  }

                  AnnouncePickup(Pawn(Other));
  				GotoState('Sleeping', 'Begin');
  
  				if ( KFGameType(Level.Game) != none )
  				{
  					KFGameType(Level.Game).AmmoPickedUp(self);
  				}
  			}
  		}
  	}
  }
}

defaultproperties
{
     AmmoClass=Class'KFMod.BullpupAmmo'
}
