package com.wbwar.creeper
{
   import flash.media.Sound;
   
   public final class DroneBomb extends Projectile
   {
      
      private static const SPEED:Number = 0.5;
      
      private static const DROP_TIME:int = 20;
       
      
      private var updateCount:int;
      
      private var dx:Number;
      
      private var dy:Number;
      
      private var explosionSound:Sound;
      
      public function DroneBomb(param1:Number, param2:Number, param3:Number, param4:Number)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.dx = param3 * SPEED;
         this.dy = param4 * SPEED;
         graphics.beginFill(16711680);
         graphics.drawCircle(0,0,5);
         graphics.endFill();
         GameSpace.instance.projectiles.addProjectile(this);
         this.explosionSound = new AreaGunExplosionSound();
      }
      
      private function kaboom() : void
      {
         GameSpace.instance.projectiles.removeProjectile(this);
         var _loc1_:int = x / 0;
         var _loc2_:int = y / 0;
         Weapon.damageGlop(_loc1_,_loc2_,50,8,-4,1);
         new Explosion(x,y,16732240,10493984,0.5,10);
         this.explosionSound.play();
      }
      
      override public function update() : void
      {
         ++this.updateCount;
         if(this.updateCount >= DROP_TIME)
         {
            this.kaboom();
         }
         else
         {
            scaleX = 1 - this.updateCount / DROP_TIME;
            scaleY = scaleX;
            x += this.dx;
            y += this.dy;
         }
      }
   }
}
