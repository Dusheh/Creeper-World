package com.wbwar.creeper
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.util.ClassUtil;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.media.Sound;
   import flash.utils.getQualifiedClassName;
   
   public class MovingPlace extends Place
   {
      
      public static const STATE_PLACED:int = 0;
      
      public static const STATE_TAKEOFF:int = 1;
      
      public static const STATE_MOVING:int = 2;
      
      public static const STATE_LANDING:int = 3;
      
      public static const STATE_RIFT1:int = 4;
      
      public static const STATE_RIFT2:int = 5;
      
      public static const STATE_RIFT3:int = 6;
      
      protected static const TAKEOFF_SPEED:Number = 0.1;
      
      protected static const LANDING_SPEED:Number = 0.1;
      
      protected static const MOVE_SPEED:Number = 0.5;
      
      private static const RIFTMOVE_SPEED:Number = 1;
      
      private static var moveSound:Sound;
      
      private static var landSound:Sound;
       
      
      public var state:int;
      
      public var rifted:Boolean;
      
      private var showRange:Boolean;
      
      public var canMove:Boolean = true;
      
      protected var movementHeight:Number = 0;
      
      protected var moveX:Number;
      
      protected var moveY:Number;
      
      public var targetGameSpaceX:int;
      
      public var targetGameSpaceY:int;
      
      private var rangeIndicator:WeaponDistIndicator;
      
      public var movePlaceIndicator:Shape;
      
      private var counter:int;
      
      private var playMoveSound:Boolean;
      
      private var MOVEMOD:Number;
      
      public function MovingPlace(param1:Number, param2:Number)
      {
         super(param1,param2);
         if(false)
         {
            addEventListener(MouseEvent.CLICK,this.onMPMouseClick);
            this.rangeIndicator = new WeaponDistIndicator(1622212528);
            addChild(this.rangeIndicator);
            this.rangeIndicator.visible = false;
            this.rangeIndicator.alpha = 0.4;
            this.movePlaceIndicator = new Shape();
            this.movePlaceIndicator.graphics.lineStyle(2,32768);
            this.movePlaceIndicator.graphics.drawRect(-10,-10,20,20);
            GameSpace.instance.moveLayer.addChild(this.movePlaceIndicator);
            this.movePlaceIndicator.visible = false;
            if(moveSound == null)
            {
               moveSound = new MoveSound();
            }
            if(landSound == null)
            {
               landSound = new LandSound();
            }
         }
      }
      
      public function showRangeIndicator(param1:Boolean) : void
      {
         if(!param1)
         {
            this.rangeIndicator.visible = false;
            this.showRange = false;
         }
         else
         {
            if(!(this is ABM))
            {
               return;
            }
            if(this.state == STATE_PLACED)
            {
               this.rangeIndicator.visible = param1;
               this.rangeIndicator.refresh(getQualifiedClassName(this),RANGE,gameSpaceX,gameSpaceY);
            }
            else
            {
               this.showRange = param1;
            }
         }
      }
      
      override protected function buildComplete() : void
      {
         super.buildComplete();
         if(this.showRange)
         {
            this.showRange = false;
            this.showRangeIndicator(true);
         }
      }
      
      override public function destroy(param1:Boolean = false) : void
      {
         super.destroy();
         GameSpace.instance.moveLayer.removeChild(this.movePlaceIndicator);
      }
      
      public function onMPMouseClick(param1:MouseEvent) : void
      {
         if(_locked)
         {
            if(param1 != null)
            {
               param1.stopImmediatePropagation();
            }
            return;
         }
         if(!this.canMove)
         {
            if(param1 != null)
            {
               param1.stopImmediatePropagation();
            }
            return;
         }
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
         else
         {
            GameSpace.instance.places.showRanges(null,false,null);
            GameSpace.instance.places.showRanges(ClassUtil.getClass(this),true,null);
         }
         selected = true;
      }
      
      override public function setScreenCoords() : void
      {
         super.setScreenCoords();
         this.moveX = x;
         this.moveY = y;
      }
      
      override public function move(param1:int, param2:int) : void
      {
         super.move(param1,param2);
         if(!this.canMove)
         {
            return;
         }
         if(building)
         {
            return;
         }
         this.targetGameSpaceX = param1;
         this.targetGameSpaceY = param2;
         if(this.state == STATE_PLACED || this.state == STATE_LANDING)
         {
            this.state = STATE_TAKEOFF;
            GameSpace.instance.places.raisePlace(this);
            placeBody.filters = [new GlowFilter(16777215,1,8,8)];
         }
         this.movePlaceIndicator.x = this.targetGameSpaceX * 0 + 0;
         this.movePlaceIndicator.y = this.targetGameSpaceY * 0 + 0;
         if(this.state != STATE_PLACED)
         {
            this.movePlaceIndicator.visible = true;
         }
         else
         {
            this.movePlaceIndicator.visible = false;
         }
         this.playMoveSound = true;
      }
      
      override protected function upgrade() : void
      {
         if(this.state == STATE_PLACED)
         {
            super.upgrade();
         }
      }
      
      override public function update() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:* = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:* = null;
         super.update();
         if(this.playMoveSound)
         {
            moveSound.play();
            this.playMoveSound = false;
         }
         if(GameSpace.instance.upgradeWeapon2)
         {
            this.MOVEMOD = 1.3;
         }
         else
         {
            this.MOVEMOD = 1;
         }
         if(this.state != STATE_PLACED)
         {
            this.movePlaceIndicator.visible = true;
         }
         else
         {
            this.movePlaceIndicator.visible = false;
         }
         if(this.state == STATE_TAKEOFF)
         {
            if(this.movementHeight >= 1)
            {
               this.state = STATE_MOVING;
               this.movementHeight = 1;
               scaleX = 1.2;
               scaleY = scaleX;
            }
            else
            {
               this.movementHeight += TAKEOFF_SPEED;
               scaleX = 1 + this.movementHeight / 5;
               scaleY = scaleX;
            }
         }
         else if(this.state == STATE_MOVING)
         {
            if(updateCount % 20 == 0)
            {
               new MoveIndicator(x,y,this.targetGameSpaceX * 0 + 0,this.targetGameSpaceY * 0 + 0);
            }
            _loc1_ = this.targetGameSpaceX * 0 + 0 - this.moveX;
            _loc2_ = this.targetGameSpaceY * 0 + 0 - this.moveY;
            _loc3_ = Math.sqrt(_loc1_ * _loc1_ + _loc2_ * _loc2_);
            if(_loc3_ <= MOVE_SPEED * this.MOVEMOD)
            {
               gameSpaceX = this.targetGameSpaceX;
               gameSpaceY = this.targetGameSpaceY;
               this.setScreenCoords();
               this.state = STATE_LANDING;
            }
            else
            {
               _loc4_ = _loc1_ / _loc3_ * MOVE_SPEED * this.MOVEMOD;
               _loc5_ = _loc2_ / _loc3_ * MOVE_SPEED * this.MOVEMOD;
               this.moveX += _loc4_;
               this.moveY += _loc5_;
               x = this.moveX;
               y = this.moveY;
            }
            hookUp();
         }
         else if(this.state == STATE_LANDING)
         {
            if(this.movementHeight <= 0)
            {
               placeBody.filters = [];
               this.state = STATE_PLACED;
               if(this.showRange)
               {
                  this.showRange = false;
                  this.showRangeIndicator(true);
               }
               GameSpace.instance.places.lowerPlace(this);
               this.movementHeight = 0;
               scaleX = 1;
               scaleY = scaleX;
               landSound.play();
            }
            else
            {
               this.movementHeight -= LANDING_SPEED;
               scaleX = 1 + this.movementHeight / 5;
               scaleY = scaleX;
            }
         }
         else if(this.state != STATE_PLACED)
         {
            if(this.state == STATE_RIFT1)
            {
               _loc1_ = GameSpace.instance.rift.gameSpaceX * 0 + 0 - this.moveX;
               _loc2_ = GameSpace.instance.rift.gameSpaceY * 0 + 0 - this.moveY;
               _loc3_ = Math.sqrt(_loc1_ * _loc1_ + _loc2_ * _loc2_);
               if(_loc3_ <= RIFTMOVE_SPEED)
               {
                  gameSpaceX = GameSpace.instance.rift.gameSpaceX;
                  gameSpaceY = GameSpace.instance.rift.gameSpaceY;
                  this.setScreenCoords();
                  this.state = STATE_RIFT2;
                  _loc9_ = 0;
                  while(_loc9_ < 32)
                  {
                     if((_loc6_ = GameSpace.instance.mistLayer.addMist(gameSpaceX,gameSpaceY,4)) != null)
                     {
                        _loc7_ = Math.random() * 2 * 0;
                        _loc8_ = 1 + Math.random() * 4;
                        _loc6_.deltaX = Math.cos(_loc7_) * _loc8_;
                        _loc6_.deltaY = Math.sin(_loc7_) * _loc8_;
                     }
                     _loc9_++;
                  }
                  (_loc10_ = new CityInRiftSound()).play();
                  if(GameSpace.instance.rift.riftOpenSoundChannel != null)
                  {
                     Tweener.addTween(GameSpace.instance.rift.riftOpenSoundChannel,{
                        "_sound_volume":0,
                        "time":2,
                        "onComplete":GameSpace.instance.rift.riftOpenSoundChannel.stop()
                     });
                  }
               }
               else
               {
                  _loc4_ = _loc1_ / _loc3_ * RIFTMOVE_SPEED;
                  _loc5_ = _loc2_ / _loc3_ * RIFTMOVE_SPEED;
                  this.moveX += _loc4_;
                  this.moveY += _loc5_;
                  x = this.moveX;
                  y = this.moveY;
                  hookUp();
               }
            }
            else if(this.state == STATE_RIFT2)
            {
               this.rifted = true;
               scaleX -= 0.05;
               scaleY -= 0.05;
               if(scaleX > 0.5)
               {
                  GameSpace.instance.rift.scaleX += 0.05;
               }
               else
               {
                  GameSpace.instance.rift.scaleX -= 0.15;
                  if(GameSpace.instance.rift.scaleX < 0)
                  {
                     GameSpace.instance.rift.scaleX = 0;
                  }
               }
               GameSpace.instance.rift.scaleY = GameSpace.instance.rift.scaleX;
               if(scaleX < 0)
               {
                  scaleX = 0;
               }
               if(scaleY < 0)
               {
                  scaleY = 0;
                  this.state = STATE_RIFT3;
                  destroyAllPaths();
                  this.counter = 0;
               }
            }
            else if(this.state == STATE_RIFT3)
            {
               ++this.counter;
               if(this.counter >= 108)
               {
                  this.state = STATE_PLACED;
                  Creeper.instance.gameScreen.showResultsScreen();
                  if(GameSpace.instance.rift.riftOpenSoundChannel != null)
                  {
                     GameSpace.instance.rift.riftOpenSoundChannel.stop();
                  }
               }
            }
         }
      }
   }
}
