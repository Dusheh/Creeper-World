package com.wbwar.creeper.controlpanel
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.util.Text;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.media.Sound;
   import flash.text.TextField;
   
   public class PointViewer extends Sprite
   {
      
      public static const WIDTH:int = 29;
      
      public static const HEIGHT:int = 42;
       
      
      private var _points:int;
      
      private var pointsText:TextField;
      
      private var tweening:Boolean;
      
      private var box:Sprite;
      
      public function PointViewer()
      {
         super();
         this.box = new Sprite();
         addChild(this.box);
         this.box.graphics.beginFill(3166256);
         this.box.graphics.lineStyle(1,3170352);
         this.box.graphics.drawRect(9,0,WIDTH - 9,HEIGHT);
         this.box.graphics.endFill();
         var _loc1_:TextField = Text.text("UPGRADES",8,16777215);
         addChild(_loc1_);
         _loc1_.rotation = -90;
         _loc1_.x = -5;
         _loc1_.y = HEIGHT + 1;
         this.pointsText = Text.text("",28,16777215);
         this.box.addChild(this.pointsText);
         this.points = 0;
         useHandCursor = true;
         buttonMode = true;
         this.box.filters = [new GlowFilter(9502608,1,0,0)];
         addEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
      
      public function set points(param1:int) : void
      {
         this._points = param1;
         this.pointsText.text = String(param1);
         this.pointsText.x = 9 + (WIDTH - 9) / 2 - this.pointsText.width / 2;
         this.pointsText.y = 2;
         if(param1 > 0)
         {
            this.startTweening();
         }
      }
      
      public function get points() : int
      {
         return this._points;
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:Sound = new ClickSound();
         _loc2_.play();
         GameSpace.instance.upgradesDialog.visible = true;
         GameSpace.instance.paused = true;
      }
      
      public function startTweening() : void
      {
         if(!this.tweening)
         {
            this.tweening = true;
            this.tweenOut();
         }
      }
      
      public function tweenOut() : void
      {
         if(this.points > 0)
         {
            Tweener.addTween(this.box,{
               "time":0.5,
               "transition":"linear",
               "_Glow_blurX":4,
               "_Glow_blurY":4,
               "onComplete":this.tweenIn
            });
         }
         else
         {
            Tweener.addTween(this.box,{
               "time":0.5,
               "transition":"linear",
               "_Glow_blurX":0,
               "_Glow_blurY":0
            });
            this.tweening = false;
         }
      }
      
      public function tweenIn() : void
      {
         if(this.points > 0)
         {
            Tweener.addTween(this.box,{
               "time":0.5,
               "transition":"linear",
               "_Glow_blurX":0,
               "_Glow_blurY":0,
               "onComplete":this.tweenOut
            });
         }
         else
         {
            Tweener.addTween(this.box,{
               "time":0.5,
               "transition":"linear",
               "_Glow_blurX":0,
               "_Glow_blurY":0
            });
            this.tweening = false;
         }
      }
   }
}
