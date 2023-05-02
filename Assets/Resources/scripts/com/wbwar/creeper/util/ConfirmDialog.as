package com.wbwar.creeper.util
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class ConfirmDialog extends Sprite
   {
       
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      public var shieldWidth:int;
      
      public var shieldHeight:int;
      
      private var messageText:TextField;
      
      private var yesButton:Button;
      
      private var noButton:Button;
      
      private var shield:Sprite;
      
      private var dialog:Sprite;
      
      private var yesCB:Function;
      
      private var noCB:Function;
      
      public function ConfirmDialog(param1:int, param2:int, param3:int, param4:int)
      {
         super();
         this.WIDTH = param1;
         this.HEIGHT = param2;
         this.shield = new Sprite();
         addChild(this.shield);
         this.shield.graphics.beginFill(0,0);
         this.shield.graphics.drawRect(0,0,param3,param4);
         this.shield.graphics.endFill();
         this.dialog = new Sprite();
         addChild(this.dialog);
         this.dialog.x = param3 / 2 - this.WIDTH / 2;
         this.dialog.y = param4 / 2 - this.HEIGHT / 2;
         this.dialog.graphics.beginFill(14737632,1);
         this.dialog.graphics.lineStyle(3,4210752);
         this.dialog.graphics.drawRoundRect(0,0,this.WIDTH,this.HEIGHT,10,10);
         this.dialog.graphics.endFill();
         this.messageText = Text.text("",18,0);
         this.dialog.addChild(this.messageText);
         this.yesButton = new Button("YES",14,50,20,0,0,true,32768,-1);
         this.yesButton.x = this.WIDTH / 2 - 5 - this.yesButton.width;
         this.yesButton.y = this.HEIGHT - 5 - this.yesButton.height;
         this.dialog.addChild(this.yesButton);
         this.yesButton.addEventListener(MouseEvent.CLICK,this.onYesClick);
         this.noButton = new Button("NO",14,50,20,0,0,true,8388608,-1);
         this.noButton.x = this.WIDTH / 2 + 5;
         this.noButton.y = this.HEIGHT - 5 - this.noButton.height;
         this.dialog.addChild(this.noButton);
         this.noButton.addEventListener(MouseEvent.CLICK,this.onNoClick);
      }
      
      public function set message(param1:String) : void
      {
         this.messageText.text = param1;
         this.messageText.x = this.WIDTH / 2 - this.messageText.width / 2;
         this.messageText.y = 5;
      }
      
      public function set yesCallback(param1:Function) : void
      {
         this.yesCB = param1;
      }
      
      public function set noCallback(param1:Function) : void
      {
         this.noCB = param1;
      }
      
      public function onYesClick(param1:MouseEvent) : void
      {
         if(this.yesCB != null)
         {
            this.yesCB();
         }
         visible = false;
      }
      
      public function onNoClick(param1:MouseEvent) : void
      {
         if(this.noCB != null)
         {
            this.noCB();
         }
         visible = false;
      }
   }
}
