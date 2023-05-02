package com.wbwar.creeper
{
   import com.wbwar.creeper.util.Navigation;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.media.Sound;
   
   public final class Missile extends Projectile
   {
      
      private static const MOVE_SPEED:Number = 3;
      
      private static const ROT_SPEED:Number = 10;
      
      private static const LOCK_RANGE:Number = 1000;
      
      private static const EXPLODE_RANGE:Number = 10;
      
      private static const MAX_NOTARGET_TIME:Number = 100;
      
      private static var bodyImage:Class = Missile_bodyImage;
       
      
      private var projectile:Projectile;
      
      private var noTargetCounter:int;
      
      private var fireSound:Sound;
      
      public function Missile(param1:Number, param2:Number)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.findReplacementProjectile();
         addChild(getBodyShape());
         GameSpace.instance.projectiles.addProjectile(this);
         this.fireSound = new MissileLaunchSound();
         this.fireSound.play();
         var _loc3_:Number = this.projectile.x - param1;
         var _loc4_:Number = this.projectile.y - param2;
         rotation = Math.atan2(_loc4_,_loc3_) * 180 / 0;
         cacheAsBitmap = true;
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
      
      private function kaboom() : void
      {
         GameSpace.instance.projectiles.removeProjectile(this);
      }
      
      override public function update() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this.projectile == null || this.projectile.dead)
         {
            this.findReplacementProjectile();
         }
         if(this.projectile == null || this.projectile.dead)
         {
            ++this.noTargetCounter;
         }
         else
         {
            this.noTargetCounter = 0;
         }
         this.move();
         if(this.projectile != null && !this.projectile.dead)
         {
            _loc1_ = this.projectile.x - x;
            _loc2_ = this.projectile.y - y;
            _loc3_ = Math.sqrt(_loc1_ * _loc1_ + _loc2_ * _loc2_);
            if(_loc3_ < EXPLODE_RANGE)
            {
               this.projectile.destroy();
               this.kaboom();
            }
         }
         if(this.noTargetCounter >= MAX_NOTARGET_TIME)
         {
            this.kaboom();
         }
      }
      
      private function findReplacementProjectile() : Boolean
      {
         var _loc1_:* = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:* = null;
         var _loc6_:* = 0;
         var _loc7_:int = GameSpace.instance.projectiles.numChildren - 1;
         while(_loc7_ >= 0)
         {
            _loc1_ = GameSpace.instance.projectiles.getChildAt(_loc7_) as Projectile;
            if(_loc1_ is GlopBlob)
            {
               _loc2_ = _loc1_.x - x;
               _loc3_ = _loc1_.y - y;
               if((_loc4_ = _loc2_ * _loc2_ + _loc3_ * _loc3_) <= LOCK_RANGE * LOCK_RANGE && _loc4_ < _loc6_)
               {
                  _loc5_ = _loc1_;
                  _loc6_ = Number(_loc4_);
               }
            }
            _loc7_--;
         }
         this.projectile = _loc5_;
         return _loc5_ != null;
      }
      
      private function move() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         this.rotate();
         GameSpace.instance.exhaustLayer.addExhaust(x,y);
         if(this.projectile == null || this.projectile.dead)
         {
            _loc1_ = true;
         }
         else
         {
            _loc2_ = this.projectile.x - x;
            _loc3_ = this.projectile.y - y;
            _loc4_ = Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_);
            if(x < MOVE_SPEED)
            {
               _loc1_ = false;
            }
            else
            {
               _loc1_ = true;
            }
         }
         if(_loc1_)
         {
            _loc5_ = Math.cos(rotation * 0 / 180) * MOVE_SPEED;
            _loc6_ = Math.sin(rotation * 0 / 180) * MOVE_SPEED;
            x += _loc5_;
            y += _loc6_;
            return false;
         }
         x = this.projectile.x;
         y = this.projectile.y;
         return true;
      }
      
      private function rotate() : Boolean
      {
         var _loc1_:Number = NaN;
         if(this.projectile == null || this.projectile.dead)
         {
            return true;
         }
         var _loc2_:Number = this.projectile.x - x;
         var _loc3_:Number = this.projectile.y - y;
         _loc1_ = Math.atan2(_loc3_,_loc2_) * 180 / 0;
         var _loc5_:Number;
         var _loc4_:Number;
         if((_loc5_ = (_loc4_ = Navigation.angleSpan(rotation,_loc1_)) < 0 ? Number(-_loc4_) : Number(_loc4_)) < ROT_SPEED)
         {
            rotation = _loc1_;
            return true;
         }
         if(_loc4_ < 0)
         {
            rotation -= ROT_SPEED;
         }
         else
         {
            rotation += ROT_SPEED;
         }
         return false;
      }
   }
}
