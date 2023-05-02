package com.wbwar.creeper
{
   import flash.display.Shape;
   import flash.media.Sound;
   
   public final class Mortar extends Projectile
   {
      
      private static const STATE_MORTAR:int = 0;
      
      private static const STATE_EXPLOSION:int = 1;
      
      private static const SPEED:Number = 1.5;
       
      
      private var sourceX:int;
      
      private var sourceY:int;
      
      private var targetX:int;
      
      private var targetY:int;
      
      private var tx:Number;
      
      private var ty:Number;
      
      private var distance:Number;
      
      private var state:int;
      
      private var explosion:Shape;
      
      private var level:int;
      
      private var fireSound:Sound;
      
      private var explosionSound:Sound;
      
      private var explosionCounter:int;
      
      public function Mortar(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Boolean = false)
      {
         super();
         this.sourceX = param1;
         this.sourceY = param2;
         this.targetX = param3;
         this.targetY = param4;
         this.level = param5;
         graphics.beginFill(16711680);
         graphics.lineStyle(1,0);
         graphics.drawRect(-2,-2,4,4);
         graphics.endFill();
         graphics.beginFill(0);
         graphics.lineStyle();
         graphics.drawRect(-1,-1,2,2);
         graphics.endFill();
         x = param1 * 0 + 0;
         y = param2 * 0 + 0;
         this.tx = param3 * 0 + 0;
         this.ty = param4 * 0 + 0;
         this.distance = Math.sqrt((this.tx - x) * (this.tx - x) + (this.ty - y) * (this.ty - y));
         GameSpace.instance.projectiles.addProjectile(this);
         this.explosion = new Shape();
         addChild(this.explosion);
         this.explosion.visible = false;
         this.explosion.graphics.lineStyle(1,16711680);
         this.explosion.graphics.drawCircle(0,0,6);
         this.explosion.graphics.lineStyle(1,16732240);
         this.explosion.graphics.drawCircle(0,0,8);
         this.fireSound = new AreaGunSound();
         this.explosionSound = new AreaGunExplosionSound();
         if(!param6)
         {
            this.fireSound.play();
         }
      }
      
      private function kaboom() : void
      {
         this.state = STATE_EXPLOSION;
         this.explosion.visible = true;
         Weapon.damageGlop(this.targetX,this.targetY,36,8,-4,1);
         this.explosionSound.play();
      }
      
      override public function update() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(this.state == STATE_MORTAR)
         {
            rotation += 31;
            _loc1_ = this.tx - x;
            _loc2_ = this.ty - y;
            _loc3_ = Math.sqrt(_loc1_ * _loc1_ + _loc2_ * _loc2_);
            _loc4_ = this.distance - _loc3_;
            _loc5_ = Math.sin(_loc4_ / this.distance * 0);
            scaleX = 1 + _loc5_;
            scaleY = scaleX;
            if(_loc3_ <= SPEED)
            {
               this.kaboom();
            }
            else
            {
               x += _loc1_ / _loc3_ * SPEED;
               y += _loc2_ / _loc3_ * SPEED;
            }
         }
         else if(this.state == STATE_EXPLOSION)
         {
            this.explosion.scaleX += 0.8;
            this.explosion.scaleY = this.explosion.scaleX;
            this.explosion.alpha = 1 - this.explosionCounter / 8;
            ++this.explosionCounter;
            if(this.explosionCounter >= 8)
            {
               GameSpace.instance.projectiles.removeProjectile(this);
            }
         }
      }
   }
}
