package com.wbwar.creeper
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.util.Graph;
   import com.wbwar.creeper.util.MessageDialog;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.media.Sound;
   
   public final class SurvivalPod extends Place
   {
      
      private static const STATE_WAITING:int = 0;
      
      private static const STATE_APPLYING:int = 1;
      
      private static const STATE_REMOVE:int = 2;
      
      private static var bodyImage:Class = SurvivalPod_bodyImage;
       
      
      private var ascaleRate:Number = 0.05;
      
      private var state:int;
      
      private var pulseTimer:int;
      
      private var podShape:DisplayObject;
      
      public var md:MessageDialog;
      
      public function SurvivalPod(param1:Number, param2:Number, param3:int = 250)
      {
         super(param1,param2);
         this.podShape = getBodyShape();
         this.podShape.filters = [new GlowFilter(16777056,1,8,8,3),new DropShadowFilter(3)];
         addChild(this.podShape);
         GameSpace.instance.places.addPlace(this);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,param3,-1,true,true);
         this.md.okButton.removeEventListener(MouseEvent.CLICK,this.md.onOkClick);
         this.md.okButton.addEventListener(MouseEvent.CLICK,this.onMessageDialogOkClick);
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
         this.md.okButton.removeEventListener(MouseEvent.CLICK,this.onMessageDialogOkClick);
         GameSpace.instance.paused = false;
         this.md.hide(true);
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
                  this.applyPod();
               }
            }
         }
         else if(this.state == STATE_APPLYING)
         {
            ++this.pulseTimer;
            this.podShape.scaleX += this.ascaleRate;
            this.podShape.scaleY = this.podShape.scaleX;
            if(this.podShape.scaleX > 1.5 || this.podShape.scaleX <= 1)
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
            this.destroy(true);
         }
         if(this.state != STATE_APPLYING && this.state != STATE_REMOVE)
         {
            this.calculateDamage();
         }
      }
      
      private function applyPod() : void
      {
         this.state = STATE_APPLYING;
         var _loc1_:Sound = new UpgradeAvailableSound();
         _loc1_.play();
         this.md.show();
         GameSpace.instance.paused = true;
      }
      
      override public function destroy(param1:Boolean = false) : void
      {
         super.destroy(param1);
      }
      
      private function missionFailure() : void
      {
         this.md.textField.text = "SURVIVORS DESTROYED.\n       Mission Failure";
         this.md.show();
         GameSpace.instance.destroyedReason = GameSpace.DESTROYED_REASON_SURVIVALPOD_DESTROYED;
         GameSpace.instance.paused = true;
         this.md.okButton.removeEventListener(MouseEvent.CLICK,this.onMessageDialogOkClick);
         this.md.okButton.addEventListener(MouseEvent.CLICK,this.exitGame);
      }
      
      private function exitGame(param1:Event = null) : void
      {
         this.md.okButton.removeEventListener(MouseEvent.CLICK,this.exitGame);
         this.md.hide(true);
         GameSpace.instance.paused = false;
         Creeper.instance.gameScreen.showResultsScreen();
      }
      
      private function calculateDamage() : void
      {
         var _loc1_:Number = GameSpace.instance.glop.data[gameSpaceX + gameSpaceY * 0];
         if(_loc1_ >= Glop.MIN_HEAT)
         {
            Tweener.addTween(this,{
               "time":0.75,
               "onComplete":this.missionFailure
            });
            this.destroy();
         }
      }
   }
}
