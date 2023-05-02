package com.wbwar.creeper
{
   import flash.display.Sprite;
   
   public class AirWeapons extends Sprite
   {
       
      
      public function AirWeapons()
      {
         super();
         mouseEnabled = false;
      }
      
      public function addAirWeapon(param1:AirWeapon) : void
      {
         addChild(param1);
      }
      
      public function removeAirWeapon(param1:AirWeapon) : void
      {
         removeChild(param1);
      }
      
      public function update() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = numChildren - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = getChildAt(_loc2_) as AirWeapon;
            _loc1_.update();
            _loc2_--;
         }
      }
   }
}
