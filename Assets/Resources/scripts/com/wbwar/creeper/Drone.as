package com.wbwar.creeper
{
   import com.wbwar.creeper.util.Navigation;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   
   public final class Drone extends AirWeapon
   {
      
      public static const STATE_LANDED:int = 0;
      
      public static const STATE_TAKEOFF:int = 1;
      
      public static const STATE_ATTACK:int = 2;
      
      public static const STATE_ALIGN:int = 3;
      
      public static const STATE_RETURN:int = 4;
      
      public static const STATE_LANDING:int = 5;
      
      private static const ATTACK_RADIUS:Number = 100;
      
      private static const BOMB_RADIUS:Number = 60;
      
      private static const TAKEOFF_SPEED:Number = 0.03;
      
      private static const LANDING_SPEED:Number = 0.03;
      
      private static const MOVE_SPEED:Number = 1;
      
      private static const ROT_SPEED:Number = 2;
      
      public static const BOMB_LOADOUT:int = 15;
      
      private static const BOMB_DROP_RATE:int = 40;
      
      private static var bodyImage:Class = Drone_bodyImage;
      
      private static const OVERRIDE_STRAIGHT_TIME:int = 72;
       
      
      public var state:int;
      
      private var bombCount:int;
      
      private var movementHeight:Number = 0;
      
      private var bombCounter:int;
      
      private var updateCount:int;
      
      private var droneBase:DroneBase;
      
      private var position:int;
      
      private var attackTargetX:int;
      
      private var attackTargetY:int;
      
      private var targetX:int;
      
      private var targetY:int;
      
      private var body:Sprite;
      
      private var destroyed:Boolean;
      
      private var safetyStraightOverrideCounter:int;
      
      private var safetyCounterTurn:Number = 0;
      
      private var MOVEMOD:Number;
      
      public function Drone(param1:DroneBase, param2:int)
      {
         var _loc3_:* = null;
         super();
         mouseEnabled = false;
         mouseChildren = false;
         this.droneBase = param1;
         this.position = param2;
         this.body = getBodyShape();
         addChild(this.body);
         this.state = STATE_LANDED;
         this.bombCount = BOMB_LOADOUT;
         _loc3_ = param1.getParkingSpot(param2);
         x = _loc3_.x + param1.x;
         y = _loc3_.y + param1.y;
         GameSpace.instance.landedDronesLayer.addChild(this);
      }
      
      public static function getBodyShape() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.mouseEnabled = false;
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(-10,-10,20,20);
         _loc1_.graphics.endFill();
         var _loc2_:Bitmap = new bodyImage() as Bitmap;
         _loc2_.smoothing = true;
         _loc2_.width = 18;
         _loc2_.height = 18;
         _loc2_.x = -9;
         _loc2_.y = -9;
         _loc1_.addChild(_loc2_);
         return _loc1_;
      }
      
      public function destroy() : void
      {
         if(this.destroyed)
         {
            return;
         }
         if(GameSpace.instance.airWeapons.contains(this))
         {
            GameSpace.instance.airWeapons.removeAirWeapon(this);
         }
         if(GameSpace.instance.landedDronesLayer.contains(this))
         {
            GameSpace.instance.landedDronesLayer.removeChild(this);
         }
         this.destroyed = true;
      }
      
      public function attack(param1:int, param2:int) : void
      {
         this.attackTargetX = param1 * 0 + 0;
         this.attackTargetY = param2 * 0 + 0;
         this.targetX = this.attackTargetX;
         this.targetY = this.attackTargetY;
         if(this.state == STATE_LANDED)
         {
            this.state = STATE_TAKEOFF;
            GameSpace.instance.airWeapons.addAirWeapon(this);
            this.body.filters = [new GlowFilter(16777215,1,8,8)];
         }
      }
      
      override public function update() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:* = null;
         ++this.updateCount;
         if(this.destroyed)
         {
            return;
         }
         if(this.bombCounter > 0)
         {
            --this.bombCounter;
         }
         if(this.state == STATE_TAKEOFF)
         {
            if(this.movementHeight >= 1)
            {
               this.state = STATE_ATTACK;
               this.movementHeight = 1;
               scaleX = 1.2;
               scaleY = scaleX;
            }
            else
            {
               this.movementHeight += TAKEOFF_SPEED;
               this.rotate();
               scaleX = 1 + this.movementHeight / 5;
               scaleY = scaleX;
            }
         }
         else if(this.state == STATE_ATTACK)
         {
            this.dropBomb();
            _loc1_ = this.move();
            if(_loc1_)
            {
               if(this.bombCount <= 0)
               {
                  this.state = STATE_RETURN;
                  _loc2_ = this.droneBase.getParkingSpot(this.position);
                  this.targetX = _loc2_.x + this.droneBase.x;
                  this.targetY = _loc2_.y + this.droneBase.y;
               }
               else
               {
                  this.state = STATE_ALIGN;
                  this.chooseAlignSpot();
               }
            }
         }
         else if(this.state == STATE_ALIGN)
         {
            this.dropBomb();
            _loc1_ = this.move();
            if(_loc1_)
            {
               if(this.bombCount <= 0)
               {
                  this.state = STATE_RETURN;
                  _loc2_ = this.droneBase.getParkingSpot(this.position);
                  this.targetX = _loc2_.x + this.droneBase.x;
                  this.targetY = _loc2_.y + this.droneBase.y;
               }
               else
               {
                  this.state = STATE_ATTACK;
                  this.targetX = this.attackTargetX;
                  this.targetY = this.attackTargetY;
               }
            }
         }
         else if(this.state == STATE_RETURN)
         {
            _loc1_ = this.move();
            if(_loc1_)
            {
               this.state = STATE_LANDING;
            }
         }
         else if(this.state == STATE_LANDING)
         {
            if(this.movementHeight <= 0)
            {
               this.state = STATE_LANDED;
               GameSpace.instance.landedDronesLayer.addChild(this);
               this.body.filters = [];
               this.bombCount = BOMB_LOADOUT;
               this.movementHeight = 0;
               scaleX = 1;
               scaleY = scaleX;
            }
            else
            {
               this.movementHeight -= LANDING_SPEED;
               scaleX = 1 + this.movementHeight / 5;
               scaleY = scaleX;
            }
         }
         else if(this.state == STATE_LANDED)
         {
         }
      }
      
      private function dropBomb() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(this.bombCounter <= 0 && this.bombCount > 0 && x > 0 && y > 0 && x < 0 * 0 && y < 0 * 0)
         {
            _loc1_ = x - this.attackTargetX;
            _loc2_ = y - this.attackTargetY;
            _loc3_ = _loc1_ * _loc1_ + _loc2_ * _loc2_;
            if(_loc3_ < BOMB_RADIUS * BOMB_RADIUS)
            {
               _loc4_ = Math.cos(rotation * 0 / 180) * MOVE_SPEED;
               _loc5_ = Math.sin(rotation * 0 / 180) * MOVE_SPEED;
               new DroneBomb(x,y,_loc4_,_loc5_);
               --this.bombCount;
               this.bombCounter = BOMB_DROP_RATE;
            }
         }
      }
      
      private function chooseAlignSpot() : void
      {
         var _loc1_:Number = Math.cos(rotation * 0 / 180) * ATTACK_RADIUS;
         var _loc2_:Number = Math.sin(rotation * 0 / 180) * ATTACK_RADIUS;
         this.targetX += _loc1_;
         this.targetY += _loc2_;
         this.targetX += Math.random() * 50 - 25;
         this.targetY += Math.random() * 50 - 25;
      }
      
      private function move() : Boolean
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(this.updateCount % 5 == 0)
         {
            GameSpace.instance.exhaustLayer.addExhaust(x,y);
         }
         if(GameSpace.instance.upgradeWeapon2)
         {
            this.MOVEMOD = 1.3;
         }
         else
         {
            this.MOVEMOD = 1;
         }
         if(this.safetyStraightOverrideCounter > 0)
         {
            --this.safetyStraightOverrideCounter;
         }
         else if(!this.rotate())
         {
            this.safetyCounterTurn += ROT_SPEED;
         }
         else
         {
            this.safetyCounterTurn = 0;
         }
         if(this.safetyCounterTurn > 400)
         {
            this.safetyCounterTurn = 0;
            this.safetyStraightOverrideCounter = OVERRIDE_STRAIGHT_TIME;
         }
         var _loc1_:Number = this.targetX - x;
         var _loc2_:Number = this.targetY - y;
         var _loc3_:Number = Math.sqrt(_loc1_ * _loc1_ + _loc2_ * _loc2_);
         if(_loc3_ < MOVE_SPEED * this.MOVEMOD)
         {
            x = this.targetX;
            y = this.targetY;
            return true;
         }
         _loc4_ = Math.cos(rotation * 0 / 180) * MOVE_SPEED * this.MOVEMOD;
         _loc5_ = Math.sin(rotation * 0 / 180) * MOVE_SPEED * this.MOVEMOD;
         x += _loc4_;
         y += _loc5_;
         return false;
      }
      
      private function rotate(param1:Boolean = false) : Boolean
      {
         var _loc2_:* = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(param1)
         {
            _loc2_ = 0;
         }
         else
         {
            _loc5_ = this.targetX - x;
            _loc6_ = this.targetY - y;
            _loc2_ = Number(Math.atan2(_loc6_,_loc5_) * 180 / 0);
         }
         var _loc3_:Number = Navigation.angleSpan(rotation,_loc2_);
         var _loc4_:Number;
         if((_loc4_ = _loc3_ < 0 ? Number(-_loc3_) : Number(_loc3_)) < ROT_SPEED)
         {
            rotation = _loc2_;
            this.body.scaleY = 1;
            return true;
         }
         if(_loc3_ < 0)
         {
            rotation -= ROT_SPEED;
         }
         else
         {
            rotation += ROT_SPEED;
         }
         this.body.scaleY = 0.9;
         return false;
      }
   }
}
