package com.wbwar.creeper.controlpanel
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.util.Text;
   import com.wbwar.creeper.util.Time;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   
   public class MissionTimeViewer extends Sprite
   {
      
      private static const WIDTH:int = 69;
      
      private static const HEIGHT:int = 21;
       
      
      private var timeText:TextField;
      
      private var scoreText:TextField;
      
      private var scounter:int = 0;
      
      private var updateCount:int;
      
      private var missionTimeSprite:Sprite;
      
      private var missionScoreSprite:Sprite;
      
      public function MissionTimeViewer()
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         super();
         this.missionTimeSprite = new Sprite();
         this.missionTimeSprite.graphics.beginFill(1052800);
         this.missionTimeSprite.graphics.lineStyle(1,7368816);
         this.missionTimeSprite.graphics.drawRect(0,0,WIDTH,HEIGHT);
         this.missionTimeSprite.graphics.endFill();
         this.missionScoreSprite = new Sprite();
         this.missionScoreSprite.graphics.beginFill(1052800);
         this.missionScoreSprite.graphics.lineStyle(1,7368816);
         this.missionScoreSprite.graphics.drawRect(0,0,WIDTH,HEIGHT);
         this.missionScoreSprite.graphics.endFill();
         _loc1_ = Text.text("Mission Time",9,16777215);
         _loc1_.filters = [new DropShadowFilter(1)];
         this.missionTimeSprite.addChild(_loc1_);
         _loc1_.x = WIDTH / 2 - _loc1_.width / 2;
         _loc1_.y = -2;
         this.timeText = Text.text("",9,16760976);
         this.missionTimeSprite.addChild(this.timeText);
         this.timeText.filters = [new DropShadowFilter(1)];
         _loc2_ = Text.text("Mission Score",9,16777215);
         _loc2_.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         this.missionScoreSprite.addChild(_loc2_);
         _loc2_.x = WIDTH / 2 - _loc2_.width / 2;
         _loc2_.y = -2;
         this.scoreText = Text.text("",9,16760976);
         this.missionScoreSprite.addChild(this.scoreText);
         this.scoreText.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         addChild(this.missionScoreSprite);
         addChild(this.missionTimeSprite);
         addEventListener(MouseEvent.CLICK,this.onMouseClick);
         useHandCursor = true;
         buttonMode = true;
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         Creeper.instance.gameScreen.showResultsScreen(true);
      }
      
      public function update() : void
      {
         ++this.updateCount;
         if(this.updateCount % 3 == 0)
         {
            this.swap();
         }
         var _loc1_:int = int(GameSpace.instance.elapsedTime / 36);
         this.timeText.text = Time.getTimeString(_loc1_);
         this.timeText.x = WIDTH / 2 - this.timeText.width / 2;
         this.timeText.y = 8;
         this.scoreText.text = String(GameSpace.instance.calculateScore());
         this.scoreText.x = WIDTH / 2 - this.scoreText.width / 2;
         this.scoreText.y = 8;
      }
      
      private function swap() : void
      {
         if(this.missionTimeSprite.visible)
         {
            Tweener.addTween(this.missionTimeSprite,{
               "time":0.5,
               "_autoAlpha":0
            });
            Tweener.addTween(this.missionScoreSprite,{
               "time":0.5,
               "_autoAlpha":1
            });
         }
         else
         {
            Tweener.addTween(this.missionTimeSprite,{
               "time":0.5,
               "_autoAlpha":1
            });
            Tweener.addTween(this.missionScoreSprite,{
               "time":0.5,
               "_autoAlpha":0
            });
         }
      }
   }
}
