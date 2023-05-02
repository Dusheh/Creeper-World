package com.wbwar.creeper.controlpanel
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.util.PulsingArrow;
   import com.wbwar.creeper.util.Text;
   import flash.display.Sprite;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   
   public class GlopBlobWaveViewer extends Sprite
   {
      
      private static const WIDTH:int = 65;
      
      private static const HEIGHT:int = 21;
       
      
      private var timeText:TextField;
      
      private var scounter:int = 0;
      
      private var warn:Boolean;
      
      private var updateCount:int;
      
      private var arrow:PulsingArrow;
      
      public function GlopBlobWaveViewer()
      {
         var _loc1_:* = null;
         super();
         graphics.beginFill(8392720);
         graphics.lineStyle(1,7368816);
         graphics.drawRect(0,0,WIDTH,HEIGHT);
         graphics.endFill();
         _loc1_ = Text.text("Spore Attack",9,16777215);
         _loc1_.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         addChild(_loc1_);
         _loc1_.x = WIDTH / 2 - _loc1_.width / 2;
         _loc1_.y = -2;
         this.timeText = Text.text("",9,16760976);
         addChild(this.timeText);
         this.timeText.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         filters = [new GlowFilter(16777215,1,0,0)];
      }
      
      private function warnOut() : void
      {
         if(this.warn)
         {
            Tweener.addTween(this,{
               "time":0.5,
               "transition":"linear",
               "_Glow_blurX":8,
               "_Glow_blurY":8,
               "onComplete":this.warnIn
            });
         }
      }
      
      private function warnIn() : void
      {
         if(this.warn)
         {
            Tweener.addTween(this,{
               "time":0.5,
               "transition":"linear",
               "_Glow_blurX":0,
               "_Glow_blurY":0,
               "onComplete":this.warnOut
            });
         }
      }
      
      public function update() : void
      {
         if(GameSpace.instance.glopBlobProducer == null || GameSpace.instance.hideGlopBlobWaveViewer)
         {
            return;
         }
         ++this.updateCount;
         if(this.updateCount == 5)
         {
            this.arrow = new PulsingArrow();
            this.arrow.rotation = 60;
            this.arrow.scaleX = 2;
            this.arrow.scaleY = this.arrow.scaleX;
            this.arrow.x = int(WIDTH / 2) - 5;
            this.arrow.y = -10;
            addChild(this.arrow);
         }
         else if(this.updateCount == 10)
         {
            removeChild(this.arrow);
         }
         if(!visible)
         {
            visible = true;
         }
         var _loc1_:int = int(GameSpace.instance.glopBlobProducer.remainingTime / 36);
         if(_loc1_ < 30)
         {
            if(!this.warn)
            {
               this.warn = true;
               this.warnOut();
            }
         }
         else if(this.warn)
         {
            this.warnIn();
            this.warn = false;
         }
         var _loc2_:int = int(_loc1_ / 60);
         _loc1_ -= _loc2_ * 60;
         var _loc3_:String = _loc1_ >= 10 ? String(_loc1_) : "0" + String(_loc1_);
         this.timeText.text = String(_loc2_) + ":" + _loc3_;
         this.timeText.x = WIDTH / 2 - this.timeText.width / 2;
         this.timeText.y = 8;
      }
   }
}
