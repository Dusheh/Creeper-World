package com.wbwar.creeper
{
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.media.Sound;
   
   public final class GlopBlob extends Projectile
   {
      
      private static const STATE_FLIGHT:int = 0;
      
      private static const STATE_APPLY:int = 1;
      
      private static const SPEED:Number = 1.5;
      
      private static var bodyImage:Class = GlopBlob_bodyImage;
       
      
      private var targetX:int;
      
      private var targetY:int;
      
      private var tx:Number;
      
      private var ty:Number;
      
      private var distance:Number;
      
      private var state:int;
      
      private var applyCounter:int;
      
      private var strength:Number;
      
      private var duration:int;
      
      public function GlopBlob(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:int)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.tx = param3;
         this.ty = param4;
         this.targetX = param3 / 0;
         this.targetY = param4 / 0;
         this.strength = param5;
         this.duration = param6;
         addChild(getBodyShape());
         this.distance = Math.sqrt((param3 - param1) * (param3 - param1) + (param4 - param2) * (param4 - param2));
         GameSpace.instance.projectiles.addProjectile(this);
      }
      
      public static function getBodyShape() : DisplayObject
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         _loc1_ = new Sprite();
         _loc1_.mouseEnabled = false;
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(-10,-10,20,20);
         _loc1_.graphics.endFill();
         _loc2_ = new bodyImage() as Bitmap;
         _loc2_.smoothing = true;
         _loc2_.width = 18;
         _loc2_.height = 18;
         _loc2_.x = -9;
         _loc2_.y = -9;
         _loc1_.addChild(_loc2_);
         return _loc1_;
      }
      
      override public function destroy() : void
      {
         super.destroy();
         visible = false;
         dead = true;
         GameSpace.instance.projectiles.removeProjectile(this);
         var _loc1_:int = x / 0;
         var _loc2_:int = y / 0;
         GameSpace.instance.mistLayer.addMist(_loc1_,_loc2_);
         GameSpace.instance.mistLayer.addMist(_loc1_ - 2,_loc2_);
         GameSpace.instance.mistLayer.addMist(_loc1_ + 2,_loc2_);
         GameSpace.instance.mistLayer.addMist(_loc1_,_loc2_ - 2);
         GameSpace.instance.mistLayer.addMist(_loc1_,_loc2_ + 2);
         GameSpace.instance.mistLayer.addMist(_loc1_ - 2,_loc2_ - 2);
         GameSpace.instance.mistLayer.addMist(_loc1_ - 2,_loc2_ + 2);
         GameSpace.instance.mistLayer.addMist(_loc1_ + 2,_loc2_ - 2);
         GameSpace.instance.mistLayer.addMist(_loc1_ + 2,_loc2_ + 2);
         GameSpace.instance.mistLayer.addMist(_loc1_,_loc2_ - 3);
         GameSpace.instance.mistLayer.addMist(_loc1_,_loc2_ + 3);
         GameSpace.instance.mistLayer.addMist(_loc1_ - 3,_loc2_);
         GameSpace.instance.mistLayer.addMist(_loc1_ + 3,_loc2_);
         new Explosion(x,y,12543,16711680,1,5);
         var _loc3_:Sound = new BlobExplosionSound();
         _loc3_.play();
      }
      
      private function kaboom() : void
      {
         this.state = STATE_APPLY;
         visible = false;
         dead = true;
      }
      
      override public function update() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(this.state == STATE_FLIGHT)
         {
            rotation += 5;
            _loc1_ = this.tx - x;
            _loc2_ = this.ty - y;
            _loc3_ = Math.sqrt(_loc1_ * _loc1_ + _loc2_ * _loc2_);
            _loc4_ = this.distance - _loc3_;
            _loc5_ = Math.cos(_loc4_ / this.distance * 0 / 2) / 2;
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
         else if(this.state == STATE_APPLY)
         {
            ++this.applyCounter;
            GameSpace.instance.glop.data[this.targetX + this.targetY * 0] += this.strength;
            if(this.applyCounter >= this.duration)
            {
               GameSpace.instance.projectiles.removeProjectile(this);
            }
         }
      }
   }
}
