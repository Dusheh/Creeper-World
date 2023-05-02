package com.wbwar.creeper.dialogs
{
   import com.wbwar.creeper.util.Button;
   import com.wbwar.creeper.util.Text;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   
   public class ExitDialog extends Sprite
   {
      
      public static const YES_CLICKED:String = "YES_CLICKED";
      
      public static const NO_CLICKED:String = "NO_CLICKED";
      
      public static const RESTART_CLICKED:String = "RESTART_CLICKED";
      
      public static const WIDTH:int = 300;
      
      public static const HEIGHT:int = 110;
       
      
      private var yesButton:Button;
      
      private var noButton:Button;
      
      private var restartButton:Button;
      
      public function ExitDialog()
      {
         var _loc3_:* = null;
         super();
         graphics.beginFill(2105376);
         graphics.lineStyle(3,16777215);
         graphics.drawRect(0,0,WIDTH,HEIGHT);
         graphics.endFill();
         filters = [new GlowFilter(0,1,8,8)];
         var _loc1_:int = (WIDTH - 30) / 2;
         _loc3_ = Text.text("EXIT GAME?",24,16777152);
         addChild(_loc3_);
         _loc3_.x = WIDTH / 2 - _loc3_.width / 2;
         _loc3_.y = 5;
         this.restartButton = new Button("Restart Level",18,180,25,0,0,true,32768,-1);
         addChild(this.restartButton);
         this.restartButton.x = int(WIDTH / 2 - this.restartButton.width / 2);
         this.restartButton.y = HEIGHT - 5 - this.restartButton.height;
         this.restartButton.addEventListener(MouseEvent.CLICK,this.onRestartClick);
         this.yesButton = new Button("Yes",18,100,25,0,0,true,32768,-1);
         addChild(this.yesButton);
         this.yesButton.x = WIDTH / 2 - this.yesButton.width - 5;
         this.yesButton.y = HEIGHT - 5 - this.restartButton.height - 10 - this.yesButton.height;
         this.yesButton.addEventListener(MouseEvent.CLICK,this.onYesClick);
         this.noButton = new Button("No",18,100,25,0,0,true,32768,-1);
         addChild(this.noButton);
         this.noButton.x = WIDTH / 2 + 5;
         this.noButton.y = HEIGHT - 5 - this.restartButton.height - 10 - this.yesButton.height;
         this.noButton.addEventListener(MouseEvent.CLICK,this.onNoClick);
         visible = false;
      }
      
      private function onYesClick(param1:MouseEvent = null) : void
      {
         dispatchEvent(new Event(YES_CLICKED));
         visible = false;
      }
      
      private function onNoClick(param1:MouseEvent = null) : void
      {
         dispatchEvent(new Event(NO_CLICKED));
         visible = false;
      }
      
      private function onRestartClick(param1:MouseEvent = null) : void
      {
         dispatchEvent(new Event(RESTART_CLICKED));
         visible = false;
      }
   }
}
