package com.wbwar.creeper
{
   import com.wbwar.creeper.util.Graph;
   import com.wbwar.creeper.util.MessageDialog;
   import com.wbwar.creeper.util.MessageDialogScrolling;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.media.Sound;
   
   public final class Ruin extends Place
   {
      
      private static const STATE_WAITING:int = 0;
      
      private static const STATE_APPLYING:int = 1;
      
      private static const STATE_REMOVE:int = 2;
      
      private static var bodyImage:Class = Ruin_bodyImage;
       
      
      private var ascaleRate:Number = 0.05;
      
      private var state:int;
      
      private var pulseTimer:int;
      
      private var ruinShape:DisplayObject;
      
      public var md:MessageDialogScrolling;
      
      public function Ruin(param1:Number, param2:Number)
      {
         super(param1,param2);
         this.ruinShape = getBodyShape();
         this.ruinShape.filters = [new GlowFilter(6356832,1,8,8,3),new DropShadowFilter(2)];
         addChild(this.ruinShape);
         GameSpace.instance.places.addPlace(this);
         this.md = new MessageDialogScrolling(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.okButton.addEventListener(MouseEvent.CLICK,this.onMessageDialogOkClick,false,99,true);
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
      
      private function onMessageDialogOkClick(param1:MouseEvent) : void
      {
         GameSpace.instance.paused = false;
         this.md.okButton.removeEventListener(MouseEvent.CLICK,this.onMessageDialogOkClick);
      }
      
      override public function update() : void
      {
         var _loc1_:* = null;
         if(this.state == STATE_WAITING)
         {
            if(updateCount % 30 == 0)
            {
               _loc1_ = Graph.astar(GameSpace.instance.places,this,GameSpace.instance.baseGun);
               if(_loc1_ != null)
               {
                  this.applyRuin();
               }
            }
         }
         else if(this.state == STATE_APPLYING)
         {
            ++this.pulseTimer;
            this.ruinShape.scaleX += this.ascaleRate;
            this.ruinShape.scaleY = this.ruinShape.scaleX;
            if(this.ruinShape.scaleX > 1.5 || this.ruinShape.scaleX <= 1)
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
      
      private function applyRuin() : void
      {
         this.state = STATE_APPLYING;
         var _loc1_:Sound = new UpgradeAvailableSound();
         _loc1_.play();
         this.md.show();
         GameSpace.instance.paused = true;
      }
   }
}
