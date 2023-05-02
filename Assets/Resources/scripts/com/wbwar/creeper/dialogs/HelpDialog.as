package com.wbwar.creeper.dialogs
{
   import com.wbwar.creeper.dialogs.help.AdvPage;
   import com.wbwar.creeper.dialogs.help.BasicPage;
   import com.wbwar.creeper.dialogs.help.TipsPage;
   import com.wbwar.creeper.dialogs.help.UnitsPage;
   import com.wbwar.creeper.util.Button;
   import com.wbwar.creeper.util.ButtonHighlight;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   
   public class HelpDialog extends Sprite
   {
      
      public static const DISMISS_CLICKED:String = "DISMISS_CLICKED";
      
      public static const WIDTH:int = 600;
      
      public static const HEIGHT:int = 450;
      
      private static var _instance:HelpDialog;
       
      
      private var exitButton:Button;
      
      private var basicButton:Button;
      
      private var advButton:Button;
      
      private var tipsButton:Button;
      
      private var unitsButton:Button;
      
      private var basicButtonCover:Shape;
      
      private var advButtonCover:Shape;
      
      private var tipsButtonCover:Shape;
      
      private var unitsButtonCover:Shape;
      
      private var basicPage:BasicPage;
      
      private var advPage:AdvPage;
      
      private var tipsPage:TipsPage;
      
      private var unitsPage:UnitsPage;
      
      private var buttonHighlight:ButtonHighlight;
      
      public function HelpDialog()
      {
         super();
         graphics.beginFill(3158064);
         graphics.lineStyle(3,16777215);
         graphics.drawRect(0,0,WIDTH,HEIGHT);
         graphics.endFill();
         filters = [new GlowFilter(0,1,8,8)];
         this.basicButton = new Button("Basic Gameplay",12,100,18,0,0,true,4210943,16777215);
         addChild(this.basicButton);
         this.basicButton.x = 5;
         this.basicButton.y = 5;
         this.basicButton.addEventListener(MouseEvent.CLICK,this.onBasicButtonClick);
         this.advButton = new Button("Adv Gameplay",12,100,18,0,0,true,4210943,16777215);
         addChild(this.advButton);
         this.advButton.x = 110;
         this.advButton.y = 5;
         this.advButton.addEventListener(MouseEvent.CLICK,this.onAdvButtonClick);
         this.tipsButton = new Button("Strategy Tips",12,100,18,0,0,true,4210943,16777215);
         addChild(this.tipsButton);
         this.tipsButton.x = 215;
         this.tipsButton.y = 5;
         this.tipsButton.addEventListener(MouseEvent.CLICK,this.onTipsButtonClick);
         this.unitsButton = new Button("Units",12,100,18,0,0,true,4210943,16777215);
         addChild(this.unitsButton);
         this.unitsButton.x = 320;
         this.unitsButton.y = 5;
         this.unitsButton.addEventListener(MouseEvent.CLICK,this.onUnitsButtonClick);
         this.basicButtonCover = new Shape();
         this.basicButtonCover.graphics.beginFill(0,0.4);
         this.basicButtonCover.graphics.drawRect(0,0,100,18);
         this.basicButtonCover.graphics.endFill();
         addChild(this.basicButtonCover);
         this.basicButtonCover.x = this.basicButton.x;
         this.basicButtonCover.y = this.basicButton.y;
         this.advButtonCover = new Shape();
         this.advButtonCover.graphics.beginFill(0,0.4);
         this.advButtonCover.graphics.drawRect(0,0,100,18);
         this.advButtonCover.graphics.endFill();
         addChild(this.advButtonCover);
         this.advButtonCover.x = this.advButton.x;
         this.advButtonCover.y = this.advButton.y;
         this.tipsButtonCover = new Shape();
         this.tipsButtonCover.graphics.beginFill(0,0.4);
         this.tipsButtonCover.graphics.drawRect(0,0,100,18);
         this.tipsButtonCover.graphics.endFill();
         addChild(this.tipsButtonCover);
         this.tipsButtonCover.x = this.tipsButton.x;
         this.tipsButtonCover.y = this.tipsButton.y;
         this.unitsButtonCover = new Shape();
         this.unitsButtonCover.graphics.beginFill(0,0.4);
         this.unitsButtonCover.graphics.drawRect(0,0,100,18);
         this.unitsButtonCover.graphics.endFill();
         addChild(this.unitsButtonCover);
         this.unitsButtonCover.x = this.unitsButton.x;
         this.unitsButtonCover.y = this.unitsButton.y;
         this.basicPage = new BasicPage(WIDTH - 6,HEIGHT - 33);
         this.basicPage.x = 3;
         this.basicPage.y = 30;
         addChild(this.basicPage);
         this.advPage = new AdvPage(WIDTH - 6,HEIGHT - 33);
         this.advPage.x = 3;
         this.advPage.y = 30;
         addChild(this.advPage);
         this.tipsPage = new TipsPage(WIDTH - 6,HEIGHT - 33);
         this.tipsPage.x = 3;
         this.tipsPage.y = 30;
         addChild(this.tipsPage);
         this.unitsPage = new UnitsPage(WIDTH - 6,HEIGHT - 33);
         this.unitsPage.x = 3;
         this.unitsPage.y = 30;
         addChild(this.unitsPage);
         this.exitButton = new Button("Exit",10,75,17,0,0,true,12587024,0);
         addChild(this.exitButton);
         this.exitButton.x = WIDTH - 5 - this.exitButton.width;
         this.exitButton.y = 5;
         this.exitButton.addEventListener(MouseEvent.CLICK,this.onExitClick);
         visible = false;
         this.showPage(0);
         this.setSelectedButton(this.basicButton);
      }
      
      public static function get instance() : HelpDialog
      {
         if(_instance == null)
         {
            _instance = new HelpDialog();
         }
         return _instance;
      }
      
      private function setSelectedButton(param1:Button) : void
      {
         this.basicButtonCover.visible = true;
         this.advButtonCover.visible = true;
         this.tipsButtonCover.visible = true;
         this.unitsButtonCover.visible = true;
         if(param1 == this.basicButton)
         {
            this.basicButtonCover.visible = false;
         }
         else if(param1 == this.advButton)
         {
            this.advButtonCover.visible = false;
         }
         else if(param1 == this.tipsButton)
         {
            this.tipsButtonCover.visible = false;
         }
         else if(param1 == this.unitsButton)
         {
            this.unitsButtonCover.visible = false;
         }
      }
      
      private function onBasicButtonClick(param1:Event = null) : void
      {
         this.showPage(0);
         this.setSelectedButton(this.basicButton);
      }
      
      private function onAdvButtonClick(param1:Event = null) : void
      {
         this.showPage(1);
         this.setSelectedButton(this.advButton);
      }
      
      private function onTipsButtonClick(param1:Event = null) : void
      {
         this.showPage(2);
         this.setSelectedButton(this.tipsButton);
      }
      
      private function onUnitsButtonClick(param1:Event = null) : void
      {
         this.showPage(3);
         this.setSelectedButton(this.unitsButton);
      }
      
      public function showPage(param1:int) : void
      {
         this.basicPage.visible = false;
         this.advPage.visible = false;
         this.tipsPage.visible = false;
         this.unitsPage.visible = false;
         if(param1 == 0)
         {
            this.basicPage.visible = true;
         }
         else if(param1 == 1)
         {
            this.advPage.visible = true;
         }
         else if(param1 == 2)
         {
            this.tipsPage.visible = true;
         }
         else if(param1 == 3)
         {
            this.unitsPage.visible = true;
         }
      }
      
      private function onExitClick(param1:MouseEvent = null) : void
      {
         dispatchEvent(new Event(DISMISS_CLICKED));
         visible = false;
      }
   }
}
