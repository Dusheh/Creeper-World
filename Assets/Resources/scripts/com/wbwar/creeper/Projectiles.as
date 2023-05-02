package com.wbwar.creeper
{
   import flash.display.Sprite;
   
   public final class Projectiles extends Sprite
   {
       
      
      public function Projectiles()
      {
         super();
         mouseEnabled = false;
      }
      
      public function addProjectile(param1:Projectile) : void
      {
         addChild(param1);
      }
      
      public function removeProjectile(param1:Projectile) : void
      {
         removeChild(param1);
      }
      
      public function update() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = numChildren - 1;
         while(_loc2_ >= 0)
         {
            if(_loc2_ < numChildren)
            {
               _loc1_ = getChildAt(_loc2_) as Projectile;
               _loc1_.update();
            }
            _loc2_--;
         }
      }
   }
}
