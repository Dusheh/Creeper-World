package com.wbwar.creeper
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.games.CustomGame;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public final class GlopProducer extends Sprite
   {
      
      private static var bodyImage:Class = GlopProducer_bodyImage;
       
      
      private var updateCount:int;
      
      public var gameSpaceX:int;
      
      public var gameSpaceY:int;
      
      public var startTime:int;
      
      private var finishTime:int = 2147483647;
      
      public var productionInterval:int;
      
      public var productionBaseAmt:Number = 0;
      
      public var productionModifierTime:Number = 0;
      
      public var productionModifierTimeMax:Number = 0;
      
      public var productionModifierEnergyResponse:Number = 0;
      
      public var productionModifierEnergyResponseMax:Number = 0;
      
      private var off:Boolean;
      
      private var alternateMode:Boolean;
      
      public function GlopProducer(param1:int, param2:int)
      {
         var _loc3_:int = 0;
         super();
         this.gameSpaceX = param1;
         this.gameSpaceY = param2;
         this.setScreenCoords();
         mouseEnabled = false;
         mouseChildren = false;
         addChild(getBodyShape());
         if(GameSpace.instance.game is CustomGame)
         {
            _loc3_ = int(GameSpace.instance.game.xml.version);
            if(_loc3_ >= 345)
            {
               this.alternateMode = true;
            }
         }
      }
      
      public static function getBodyShape() : Sprite
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
      
      public static function drawPlacementSprite(param1:Sprite) : void
      {
         param1.graphics.lineStyle(2,0);
         param1.graphics.moveTo(0,-6);
         param1.graphics.lineTo(0,6);
         param1.graphics.moveTo(-6,0);
         param1.graphics.lineTo(6,0);
         param1.graphics.moveTo(-4,-4);
         param1.graphics.lineTo(4,4);
         param1.graphics.moveTo(4,-4);
         param1.graphics.lineTo(-4,4);
         param1.graphics.lineStyle();
         param1.graphics.moveTo(0,0);
         param1.graphics.beginFill(2105504);
         param1.graphics.drawCircle(0,0,4);
         param1.graphics.endFill();
         param1.graphics.beginFill(7373055);
         param1.graphics.drawCircle(0,0,2);
         param1.graphics.endFill();
      }
      
      public function fallIntoHole() : void
      {
         this.off = true;
         var _loc1_:Number = Math.random() * 2;
         Tweener.addTween(this,{
            "time":6,
            "delay":_loc1_,
            "transition":"easeInExpo",
            "x":GameSpace.instance.rift.x,
            "y":GameSpace.instance.rift.y,
            "onComplete":this.holeComplete
         });
      }
      
      private function holeComplete() : void
      {
         visible = false;
      }
      
      public function snapTo() : void
      {
         var _loc1_:int = x / 0;
         var _loc2_:int = y / 0;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         if(_loc1_ > -1)
         {
            _loc1_ = -1;
         }
         if(_loc2_ > -1)
         {
            _loc2_ = -1;
         }
         this.gameSpaceX = _loc1_;
         this.gameSpaceY = _loc2_;
         this.setScreenCoords();
      }
      
      protected function setScreenCoords() : void
      {
         x = this.gameSpaceX * 0 + 0;
         y = this.gameSpaceY * 0 + 0;
      }
      
      public function update() : void
      {
         var _loc3_:int = 0;
         if(this.updateCount == 100)
         {
            if(false)
            {
               this.productionInterval = int(this.productionInterval / 2);
            }
         }
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         if(this.alternateMode)
         {
            _loc3_ = this.updateCount - this.startTime;
            if(!this.off && _loc3_ >= 0 && _loc3_ % this.productionInterval == 0)
            {
               _loc1_ = Number(this.productionModifierTime * (this.updateCount - this.startTime));
               if(_loc1_ > this.productionModifierTimeMax)
               {
                  _loc1_ = Number(this.productionModifierTimeMax);
               }
               _loc2_ = Number(this.productionModifierEnergyResponse * GameSpace.instance.dynamicContent.energyAccumulationRate);
               if(_loc2_ > this.productionModifierEnergyResponseMax)
               {
                  _loc2_ = Number(this.productionModifierEnergyResponseMax);
               }
               GameSpace.instance.glop.data[this.gameSpaceX + this.gameSpaceY * 0] = this.productionBaseAmt + _loc1_ + _loc2_;
            }
         }
         else if(!this.off && this.updateCount >= this.startTime && this.updateCount <= this.finishTime && this.updateCount % this.productionInterval == 0)
         {
            _loc1_ = Number(this.productionModifierTime * (this.updateCount - this.startTime));
            if(_loc1_ > this.productionModifierTimeMax)
            {
               _loc1_ = Number(this.productionModifierTimeMax);
            }
            _loc2_ = Number(this.productionModifierEnergyResponse * GameSpace.instance.dynamicContent.energyAccumulationRate);
            if(_loc2_ > this.productionModifierEnergyResponseMax)
            {
               _loc2_ = Number(this.productionModifierEnergyResponseMax);
            }
            GameSpace.instance.glop.data[this.gameSpaceX + this.gameSpaceY * 0] = this.productionBaseAmt + _loc1_ + _loc2_;
         }
         ++this.updateCount;
      }
   }
}
