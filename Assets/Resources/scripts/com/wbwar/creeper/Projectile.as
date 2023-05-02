package com.wbwar.creeper
{
   import flash.display.Sprite;
   
   public class Projectile extends Sprite
   {
       
      
      public var dead:Boolean;
      
      public function Projectile()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public function update() : void
      {
      }
      
      public function destroy() : void
      {
      }
   }
}
