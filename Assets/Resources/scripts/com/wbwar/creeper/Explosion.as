package com.wbwar.creeper
{
   public final class Explosion extends Projectile
   {
       
      
      private var explosionCounter:int;
      
      private var rate:Number;
      
      private var duration:int;
      
      public function Explosion(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:int)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.rate = param5;
         this.duration = param6;
         graphics.lineStyle(1,param3);
         graphics.drawCircle(0,0,6);
         graphics.lineStyle(1,param4);
         graphics.drawCircle(0,0,8);
         GameSpace.instance.projectiles.addProjectile(this);
      }
      
      override public function update() : void
      {
         scaleX += this.rate;
         scaleY = scaleX;
         alpha = 1 - this.explosionCounter / this.duration;
         ++this.explosionCounter;
         if(this.explosionCounter >= this.duration)
         {
            GameSpace.instance.projectiles.removeProjectile(this);
         }
      }
   }
}
