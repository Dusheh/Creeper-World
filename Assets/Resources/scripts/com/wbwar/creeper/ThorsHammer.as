package com.wbwar.creeper
{
   import com.wbwar.creeper.games.GameData;
   import com.wbwar.creeper.util.Bar;
   import com.wbwar.creeper.util.ColorUtil;
   import com.wbwar.creeper.util.Damage;
   import com.wbwar.creeper.util.Graph;
   import com.wbwar.creeper.util.Navigation;
   import flash.display.Bitmap;
   import flash.display.CapsStyle;
   import flash.display.DisplayObject;
   import flash.display.LineScaleMode;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   
   public final class ThorsHammer extends Place
   {
      
      public static const AT_DESTINATION:String = "AT_DESTINATION";
      
      public static const STATE_PLACED:int = 0;
      
      public static const STATE_TAKEOFF:int = 1;
      
      public static const STATE_ACTIVE:int = 2;
      
      public static const STATE_RESTING:int = 3;
      
      protected static const TAKEOFF_SPEED:Number = 0.1;
      
      private static const MOVE_SPEED:Number = 0.5;
      
      private static const ROT_SPEED:Number = 2;
      
      private static const FIRE_RATE:int = 0;
      
      private static const MISSILE_FIRE_TIME:int = 10;
      
      public static const START_RANGE:int = 12;
      
      public static const BASE_COST:int = 800;
      
      public static var unitCost:int = 1;
      
      private static var bodyImage:Class = ThorsHammer_bodyImage;
       
      
      private var state:int;
      
      protected var movementHeight:Number = 0;
      
      private var targetX:Number;
      
      private var targetY:Number;
      
      private var sx:Number;
      
      private var sy:Number;
      
      private var bulletShape:Shape;
      
      private var upperBulletShape:Shape;
      
      private var bulletShapeVisibleCounter:int;
      
      private var fireCounter:int;
      
      private var missileFireCounter:int;
      
      private var MISSILE_RANGE:int = 20;
      
      private var bodyShape:DisplayObject;
      
      private var healthBar:Bar;
      
      private var lastHealth:Number = 0;
      
      private var mortarFireCounter:int;
      
      private var mortarFirePoint:Point;
      
      private var firedMortars:int;
      
      public var engineSoundChannel:SoundChannel;
      
      public function ThorsHammer(param1:int, param2:int)
      {
         super(param1,param2);
         this.sx = x;
         this.sy = y;
         RANGE = START_RANGE;
         this.healthBar = new Bar(20,3,65280,0);
         this.healthBar.x = -10;
         this.healthBar.y = 7;
         this.healthBar.setValue(0,20);
         this.bulletShape = new Shape();
         this.bulletShape.filters = [new GlowFilter(9474303,1,4,4,2,1)];
         addChild(this.bulletShape);
         addChild(placeBody);
         addChild(turnedOffShape);
         this.upperBulletShape = new Shape();
         addChild(this.upperBulletShape);
         this.bodyShape = getBodyShape();
         placeBody.addChild(this.bodyShape);
         if(false)
         {
            GameSpace.instance.places.addPlace(this);
         }
         hookUp();
         selectedShape.scaleX = 2;
         selectedShape.scaleY = 2;
         addChild(selectedShape);
         addEventListener(MouseEvent.CLICK,this.onTHMouseClick);
         addChild(this.healthBar);
      }
      
      public static function getPlacementSprite(param1:Boolean = true) : Sprite
      {
         var _loc2_:* = null;
         _loc2_ = new Sprite();
         _loc2_.addChild(getBodyShape());
         if(param1)
         {
            ColorUtil.bwColor(_loc2_,0);
         }
         _loc2_.mouseEnabled = false;
         return _loc2_;
      }
      
      public static function getBodyShape() : DisplayObject
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.mouseEnabled = false;
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(-21,-21,42,42);
         _loc1_.graphics.endFill();
         var _loc3_:Bitmap = new bodyImage() as Bitmap;
         _loc3_.smoothing = true;
         _loc3_.width = 37.800000000000004;
         _loc3_.height = 37.800000000000004;
         _loc3_.x = -18.900000000000002;
         _loc3_.y = -18.900000000000002;
         _loc1_.addChild(_loc3_);
         return _loc1_;
      }
      
      public static function getBarrelShape() : DisplayObject
      {
         return null;
      }
      
      override public function get maxHealth() : Number
      {
         return BASE_COST;
      }
      
      override public function get operateEnergy() : Number
      {
         return 0;
      }
      
      public function onTHMouseClick(param1:MouseEvent) : void
      {
         if(GameSpace.instance.places.placeToMove == this)
         {
            return;
         }
         var _loc2_:Boolean = selected;
         GameSpace.instance.places.removeAllSelections();
         selected = !_loc2_;
         if(param1 != null)
         {
            param1.stopImmediatePropagation();
         }
         if(!building)
         {
            GameSpace.instance.places.placeToMove = this;
         }
         selected = true;
      }
      
      override public function destroy(param1:Boolean = false) : void
      {
         super.destroy(param1);
         if(this.engineSoundChannel != null)
         {
            this.engineSoundChannel.stop();
         }
      }
      
      private function takeoff() : void
      {
         if(building)
         {
            return;
         }
         if(this.state == STATE_PLACED)
         {
            this.state = STATE_TAKEOFF;
            GameSpace.instance.places.raisePlace(this);
            placeBody.filters = [new GlowFilter(16777215,1,8,8)];
         }
         var _loc1_:Sound = new MoveSound();
         _loc1_.play();
      }
      
      override public function move(param1:int, param2:int) : void
      {
         this.targetX = param1 * 0 + 0;
         this.targetY = param2 * 0 + 0;
         this.state = STATE_ACTIVE;
      }
      
      private function motion() : Boolean
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc1_:Number = this.targetX - this.sx;
         var _loc2_:Number = this.targetY - this.sy;
         var _loc3_:Number = Math.sqrt(_loc1_ * _loc1_ + _loc2_ * _loc2_);
         if(_loc3_ < MOVE_SPEED || _loc3_ <= 1)
         {
            return true;
         }
         if(!this.rotate())
         {
            return false;
         }
         var _loc4_:Number = Math.cos(this.bodyShape.rotation / 180 * 0 + Math.PI) * 25;
         var _loc5_:Number = Math.sin(this.bodyShape.rotation / 180 * 0 + Math.PI) * 25;
         GameSpace.instance.exhaustLayer.addExhaust(x + _loc4_,y + _loc5_);
         if(_loc3_ < MOVE_SPEED * 2)
         {
            this.sx = this.targetX;
            this.sy = this.targetY;
            x = this.sx;
            y = this.sy;
            return true;
         }
         _loc6_ = Math.cos(this.bodyShape.rotation * 0 / 180) * MOVE_SPEED;
         _loc7_ = Math.sin(this.bodyShape.rotation * 0 / 180) * MOVE_SPEED;
         this.sx += _loc6_;
         this.sy += _loc7_;
         x = this.sx;
         y = this.sy;
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
            _loc5_ = this.targetX - this.sx;
            _loc6_ = this.targetY - this.sy;
            _loc2_ = Number(Math.atan2(_loc6_,_loc5_) * 180 / 0);
         }
         var _loc3_:Number = Navigation.angleSpan(this.bodyShape.rotation,_loc2_);
         var _loc4_:Number;
         if((_loc4_ = _loc3_ < 0 ? Number(-_loc3_) : Number(_loc3_)) < ROT_SPEED)
         {
            this.bodyShape.rotation = _loc2_;
            return true;
         }
         if(_loc3_ < 0)
         {
            this.bodyShape.rotation -= ROT_SPEED;
         }
         else
         {
            this.bodyShape.rotation += ROT_SPEED;
         }
         return false;
      }
      
      override public function update() : void
      {
         var _loc1_:* = null;
         super.update();
         if(updateCount % 30 == 0)
         {
            if(turnedOn)
            {
               _loc1_ = Graph.astar(GameSpace.instance.places,this,GameSpace.instance.baseGun);
               if(_loc1_ == null)
               {
                  requestEnergy = false;
               }
               else
               {
                  requestEnergy = true;
               }
            }
         }
         if(this.state == STATE_PLACED)
         {
         }
         if(building)
         {
            this.healthBar.visible = true;
         }
         else
         {
            this.healthBar.visible = false;
         }
         if(health != this.lastHealth)
         {
            this.healthBar.setValue(health,this.maxHealth);
         }
         this.lastHealth = health;
         ++this.bulletShapeVisibleCounter;
         if(this.bulletShapeVisibleCounter >= 5)
         {
            this.bulletShape.visible = false;
            this.upperBulletShape.visible = false;
         }
         if(turnedOn && !building)
         {
            this.handleStates();
         }
         if(building)
         {
            this.calculateDamage();
         }
      }
      
      private function calculateDamage() : void
      {
         var _loc1_:Number = GameSpace.instance.glop.data[gameSpaceX + gameSpaceY * 0];
         if(_loc1_ >= Glop.MIN_HEAT)
         {
            this.destroy();
         }
      }
      
      private function handleStates() : void
      {
         if(this.state != STATE_PLACED)
         {
         }
         if(this.state == STATE_TAKEOFF)
         {
            if(this.movementHeight >= 1)
            {
               this.state = STATE_ACTIVE;
               this.movementHeight = 1;
               this.bodyShape.scaleX = 1.2;
               this.bodyShape.scaleY = this.bodyShape.scaleX;
            }
            else
            {
               this.movementHeight += TAKEOFF_SPEED;
               this.bodyShape.scaleX = 1 + this.movementHeight / 5;
               this.bodyShape.scaleY = this.bodyShape.scaleX;
            }
         }
         else if(this.state == STATE_ACTIVE)
         {
            if(this.motion())
            {
               this.state = STATE_RESTING;
               dispatchEvent(new Event(AT_DESTINATION));
            }
            gameSpaceX = x / 0;
            gameSpaceY = y / 0;
            this.firePhaser();
            this.fireMissile();
         }
         else if(this.state == STATE_RESTING)
         {
            this.firePhaser();
            this.fireMissile();
         }
      }
      
      override protected function buildComplete() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         super.buildComplete();
         this.takeoff();
         var _loc1_:Array = paths.concat();
         for each(_loc2_ in _loc1_)
         {
            _loc2_.destroy();
         }
         this.targetX = x;
         this.targetY = y;
         _loc3_ = new ThorLaunchSound();
         _loc3_.play();
         _loc4_ = new ThorEngineSound();
         this.engineSoundChannel = _loc4_.play(0,9999999);
      }
      
      private function firePhaser() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:* = null;
         var _loc9_:* = null;
         if(this.fireCounter < 7)
         {
            ++this.fireCounter;
            return;
         }
         var _loc1_:Point = findDeepestGlop(true);
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.x - gameSpaceX;
            _loc3_ = _loc1_.y - gameSpaceY;
            Weapon.damageGlop(_loc1_.x,_loc1_.y,200,17,-4,0.5);
            this.bulletShape.visible = true;
            this.upperBulletShape.visible = true;
            _loc4_ = Math.cos(this.bodyShape.rotation / 180 * 0) * 22;
            _loc5_ = Math.sin(this.bodyShape.rotation / 180 * 0) * 22;
            _loc6_ = _loc2_ * 0;
            _loc7_ = _loc3_ * 0;
            if(false)
            {
               (_loc9_ = new Damage(30,30,1)).x = x + _loc6_;
               _loc9_.y = y + _loc7_;
            }
            this.bulletShapeVisibleCounter = 0;
            this.bulletShape.graphics.clear();
            this.bulletShape.graphics.lineStyle(3,16711680,1,false,LineScaleMode.NORMAL,CapsStyle.SQUARE);
            this.bulletShape.graphics.moveTo(_loc4_,_loc5_);
            this.bulletShape.graphics.lineTo(_loc6_,_loc7_);
            this.upperBulletShape.graphics.clear();
            this.upperBulletShape.graphics.beginFill(8388608,0.2);
            this.upperBulletShape.graphics.drawCircle(_loc4_,_loc5_,10);
            this.upperBulletShape.graphics.endFill();
            this.upperBulletShape.graphics.beginFill(8388608,0.4);
            this.upperBulletShape.graphics.drawCircle(_loc4_,_loc5_,6);
            this.upperBulletShape.graphics.endFill();
            this.upperBulletShape.graphics.beginFill(8388608);
            this.upperBulletShape.graphics.drawCircle(_loc4_,_loc5_,3);
            this.upperBulletShape.graphics.endFill();
            this.fireCounter = 0;
            energyLevel -= 1 - 0.33333333 * level;
            if(energyLevel < 0)
            {
               energyLevel = 0;
            }
            (_loc8_ = new ThorGunSound()).play();
         }
      }
      
      private function fireMissile() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         if(this.missileFireCounter > 0)
         {
            --this.missileFireCounter;
            return;
         }
         var _loc5_:int = GameSpace.instance.projectiles.numChildren - 1;
         while(_loc5_ >= 0)
         {
            if((_loc4_ = GameSpace.instance.projectiles.getChildAt(_loc5_) as Projectile) is GlopBlob)
            {
               _loc2_ = _loc4_.x - x;
               _loc3_ = _loc4_.y - y;
               _loc1_ = _loc2_ * _loc2_ + _loc3_ * _loc3_;
               if(_loc1_ <= this.MISSILE_RANGE * 0 * this.MISSILE_RANGE * 0)
               {
                  this.missileFireCounter = MISSILE_FIRE_TIME;
                  new Missile(x,y);
                  _loc2_ = _loc4_.x - x;
                  _loc3_ = _loc4_.y - y;
                  break;
               }
            }
            _loc5_--;
         }
      }
      
      override protected function getXMLRoot() : XML
      {
         return <ThorsHammer/>;
      }
   }
}
