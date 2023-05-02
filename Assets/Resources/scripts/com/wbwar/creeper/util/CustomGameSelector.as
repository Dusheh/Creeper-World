package com.wbwar.creeper.util
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.Terrain;
   import com.wbwar.creeper.games.CustomGame;
   import com.wbwar.creeper.games.GameData;
   import com.wbwar.creeper.games.IndividualGameData;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import flash.utils.Timer;
   
   public class CustomGameSelector extends Sprite
   {
      
      public static const HEIGHT:int = 25;
      
      public static const WIDTH:int = 580;
       
      
      public var file:String;
      
      public var title:String;
      
      public var creationDate:Date;
      
      public var playCount:int;
      
      public var score:int;
      
      public var scoreSubmitted:Number;
      
      public var miniMap:BitmapData;
      
      private var numberText:TextField;
      
      private var deleteButton:Button;
      
      private var scoreButton:Button;
      
      private var resubmitButton:Button;
      
      private var t:Terrain;
      
      private var itimer:Timer;
      
      private var cg:CustomGame;
      
      public function CustomGameSelector(param1:String, param2:String, param3:Date)
      {
         var _loc5_:* = null;
         super();
         this.file = param1;
         this.title = param2;
         this.creationDate = param3;
         graphics.lineStyle(1,16777215);
         graphics.beginFill(5263440);
         graphics.drawRect(0,0,WIDTH,HEIGHT);
         graphics.endFill();
         this.numberText = Text.text(" ",18,10535167);
         addChild(this.numberText);
         this.numberText.x = 2;
         this.numberText.y = int(HEIGHT / 2 - this.numberText.height / 2);
         var _loc4_:TextField = Text.text(param2,18,16777215);
         addChild(_loc4_);
         _loc4_.x = 50;
         _loc4_.y = int(HEIGHT / 2 - _loc4_.height / 2);
         _loc5_ = GameData.getCustomGameData(param1);
         this.playCount = _loc5_.playCount;
         this.score = _loc5_.highScore;
         this.scoreSubmitted = _loc5_.scoreSubmitted;
         var _loc6_:TextField = Text.text(String(_loc5_.playCount),18,10535167);
         addChild(_loc6_);
         _loc6_.x = WIDTH - 160 - _loc6_.width;
         _loc6_.y = int(HEIGHT / 2 - _loc6_.height / 2);
         var _loc7_:TextField = Text.text(String(_loc5_.highScore),18,16777104);
         addChild(_loc7_);
         _loc7_.x = WIDTH - 70 - _loc7_.width;
         _loc7_.y = int(HEIGHT / 2 - _loc7_.height / 2);
         this.deleteButton = new Button("X",10,14,15,0,0,true,15675440,0);
         addChild(this.deleteButton);
         this.deleteButton.x = WIDTH - this.deleteButton.width - 3;
         this.deleteButton.y = 5;
         this.deleteButton.addEventListener(MouseEvent.CLICK,this.onDeleteClick);
         this.deleteButton.visible = false;
         this.scoreButton = new Button("Online",10,40,15,0,0,true,1064976,0);
         addChild(this.scoreButton);
         this.scoreButton.x = this.deleteButton.x - this.scoreButton.width - 3;
         this.scoreButton.y = 5;
         this.scoreButton.addEventListener(MouseEvent.CLICK,this.onScoreClick);
         this.scoreButton.visible = false;
         this.resubmitButton = new Button("Resubmit Score",10,85,17,0,0,true,1064976,0);
         addChild(this.resubmitButton);
         this.resubmitButton.x = WIDTH - 160 - 60 - this.resubmitButton.width;
         this.resubmitButton.y = 5;
         this.resubmitButton.visible = false;
         this.resubmitButton.addEventListener(MouseEvent.CLICK,this.onResubmitClick);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         addEventListener(MouseEvent.CLICK,this.onMouseClick);
         useHandCursor = true;
         buttonMode = true;
      }
      
      public function set number(param1:int) : void
      {
         this.numberText.text = String(param1);
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         ColorUtil.brighterColor(this,1);
         this.deleteButton.visible = true;
         this.scoreButton.visible = true;
         if(this.score > 0 && this.scoreSubmitted == 0)
         {
            this.resubmitButton.visible = true;
         }
         else
         {
            this.resubmitButton.visible = false;
         }
         if(this.miniMap == null)
         {
            if(!this.createMiniMap())
            {
               return;
            }
         }
         dispatchEvent(new CustomGameSelectorEvent(this,CustomGameSelectorEvent.OVER));
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         ColorUtil.normalColor(this,1);
         this.deleteButton.visible = false;
         this.scoreButton.visible = false;
         this.resubmitButton.visible = false;
         dispatchEvent(new CustomGameSelectorEvent(this,CustomGameSelectorEvent.OUT));
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         dispatchEvent(new CustomGameSelectorEvent(this));
      }
      
      private function onResubmitClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:CustomGameSelectorEvent = new CustomGameSelectorEvent(this);
         _loc2_.resubmit = true;
         dispatchEvent(_loc2_);
      }
      
      private function onScoreClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:CustomGameSelectorEvent = new CustomGameSelectorEvent(this);
         _loc2_.score = true;
         dispatchEvent(_loc2_);
      }
      
      private function onDeleteClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:CustomGameSelectorEvent = new CustomGameSelectorEvent(this);
         _loc2_.deleteGame = true;
         dispatchEvent(_loc2_);
      }
      
      private function createMiniMap() : Boolean
      {
         var _loc1_:* = null;
         this.miniMap = new BitmapData(0,0,false);
         this.cg = new CustomGame(this.file);
         this.t = new Terrain();
         this.t.background = int(this.cg.getBackground());
         this.t.setData(this.cg.getTerrainHeight());
         if(this.cg.hasCustomBackground)
         {
            this.itimer = new Timer(50,1);
            this.itimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimer);
            this.itimer.start();
            return false;
         }
         this.t.update();
         _loc1_ = new Matrix();
         _loc1_.scale(0.2,0.2);
         this.miniMap.draw(this.t,_loc1_);
         this.cg = null;
         return true;
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         var _loc2_:* = null;
         if(this.cg.customBackground != null)
         {
            this.t.customBackground = this.cg.customBackground;
            this.t.update();
            _loc2_ = new Matrix();
            _loc2_.scale(0.2,0.2);
            this.miniMap.draw(this.t,_loc2_);
            this.cg = null;
            if(mouseX >= 0 && mouseX < WIDTH && mouseY >= 0 && mouseY < HEIGHT)
            {
               dispatchEvent(new CustomGameSelectorEvent(this,CustomGameSelectorEvent.OVER));
            }
         }
         else
         {
            this.itimer = new Timer(50,1);
            this.itimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimer);
            this.itimer.start();
         }
      }
   }
}
