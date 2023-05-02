package com.wbwar.creeper
{
   import com.wbwar.creeper.util.Graph;
   import com.wbwar.creeper.util.MessageDialog;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.media.Sound;
   
   public final class UpgradeBox extends Place
   {
      
      public static const UPGRADE_APPLIED:String = "UpgradeBox.UPGRADE_APPLIED";
      
      private static const STATE_WAITING:int = 0;
      
      private static const STATE_APPLYING:int = 1;
      
      private static const STATE_REMOVE:int = 2;
      
      private static var bodyImage:Class = UpgradeBox_bodyImage;
       
      
      private var ascaleRate:Number = 0.05;
      
      private var state:int;
      
      private var pulseTimer:int;
      
      private var upgradeShape:DisplayObject;
      
      private var md:MessageDialog;
      
      public function UpgradeBox(param1:Number, param2:Number)
      {
         super(param1,param2);
         this.upgradeShape = getBodyShape();
         this.upgradeShape.filters = [new GlowFilter(16736256,1,8,8,3),new DropShadowFilter(2)];
         addChild(this.upgradeShape);
         GameSpace.instance.places.addPlace(this);
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
      
      public static function drawPlacementShape(param1:Shape) : void
      {
         param1.graphics.beginFill(10119952);
         param1.graphics.drawRect(-5,-5,10,10);
         param1.graphics.endFill();
         param1.graphics.beginFill(0);
         param1.graphics.drawRect(-1,-3,2,6);
         param1.graphics.endFill();
         param1.graphics.beginFill(0);
         param1.graphics.drawRect(-3,-1,6,2);
         param1.graphics.endFill();
      }
      
      override public function update() : void
      {
         var _loc1_:* = null;
         this.upgradeShape.rotation -= 3;
         if(this.state == STATE_WAITING)
         {
            if(updateCount % 30 == 0)
            {
               _loc1_ = Graph.astar(GameSpace.instance.places,this,GameSpace.instance.baseGun);
               if(_loc1_ != null)
               {
                  this.applyUpgrade();
               }
            }
         }
         else if(this.state == STATE_APPLYING)
         {
            ++this.pulseTimer;
            this.upgradeShape.scaleX += this.ascaleRate;
            this.upgradeShape.scaleY = this.upgradeShape.scaleX;
            if(this.upgradeShape.scaleX > 1.5 || this.upgradeShape.scaleX <= 1)
            {
               this.ascaleRate = -this.ascaleRate;
            }
            if(this.pulseTimer > 50)
            {
               this.state = STATE_REMOVE;
            }
         }
         else if(this.state == STATE_REMOVE)
         {
            destroy(true);
         }
      }
      
      private function applyUpgrade() : void
      {
         this.state = STATE_APPLYING;
         ++GameSpace.instance.points;
         var _loc1_:Sound = new UpgradeAvailableSound();
         _loc1_.play();
         dispatchEvent(new Event(UPGRADE_APPLIED,true));
      }
   }
}
