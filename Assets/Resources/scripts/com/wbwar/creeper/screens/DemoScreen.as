package com.wbwar.creeper.screens
{
   import com.wbwar.creeper.util.Button;
   import com.wbwar.creeper.util.Text;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   
   public class DemoScreen extends Sprite
   {
       
      
      public function DemoScreen()
      {
         var demoText2:TextField = null;
         var demoText3:TextField = null;
         var demoText4:TextField = null;
         var demoText5:TextField = null;
         var exitButton:Button = null;
         var bb:Button = null;
         var bbmgs:Button = null;
         super();
         graphics.beginFill(0,0.8);
         graphics.drawRect(0,0,700,525);
         graphics.endFill();
         var demoText:TextField = Text.text("You think that was crazy???\nYou ain\'t seen nuthin yet!",48,16711680);
         demoText.filters = [new DropShadowFilter(),new GlowFilter(10526880,1,32,32,4,BitmapFilterQuality.MEDIUM)];
         addChild(demoText);
         demoText.x = 350 - demoText.width / 2;
         demoText.y = 50;
         demoText2 = Text.text("20 Story, 25 Conquest, and 10 Special Ops missions await...",18,13684944);
         demoText2.filters = [new DropShadowFilter(),new GlowFilter(10526880,1,32,32,4,BitmapFilterQuality.MEDIUM)];
         addChild(demoText2);
         demoText2.x = 350 - demoText2.width / 2;
         demoText2.y = 200;
         demoText3 = Text.text("Creeper Spores, Drones, Reactors and the ultimate mystery revealed...",18,13684944);
         demoText3.filters = [new DropShadowFilter(),new GlowFilter(10526880,1,32,32,4,BitmapFilterQuality.MEDIUM)];
         addChild(demoText3);
         demoText3.x = 350 - demoText3.width / 2;
         demoText3.y = 240;
         demoText4 = Text.text("Are you good enough to save EVERYTHING from the Creeper?",18,13684944);
         demoText4.filters = [new DropShadowFilter(),new GlowFilter(10526880,1,32,32,4,BitmapFilterQuality.MEDIUM)];
         addChild(demoText4);
         demoText4.x = 350 - demoText4.width / 2;
         demoText4.y = 280;
         if(false)
         {
            demoText5 = Text.text("Buy the full game Now!",22,13684944);
         }
         else
         {
            demoText5 = Text.text("Buy the full game at KnuckleCracker.com!",22,13684944);
         }
         demoText5.filters = [new DropShadowFilter(),new GlowFilter(10526880,1,32,32,4,BitmapFilterQuality.MEDIUM)];
         addChild(demoText5);
         demoText5.x = 350 - demoText5.width / 2;
         demoText5.y = 330;
         if(true)
         {
            bb = new Button("Visit KnuckleCracker.com!",20,300,30,0,0,true,32768,-1);
            bb.filters = [new GlowFilter(3178560,1,32,32,2,BitmapFilterQuality.MEDIUM)];
            addChild(bb);
            bb.x = 350 - bb.width / 2;
            bb.y = 400;
            bb.addEventListener(MouseEvent.CLICK,this.onBBClick);
         }
         else
         {
            bbmgs = new Button("Buy Full Game",20,300,30,0,0,true,32768,-1);
            bbmgs.filters = [new GlowFilter(3178560,1,32,32,2,BitmapFilterQuality.MEDIUM)];
            addChild(bbmgs);
            bbmgs.x = 350 - bbmgs.width / 2;
            bbmgs.y = 400;
            bbmgs.addEventListener(MouseEvent.CLICK,this.onBBMGSClick);
         }
         exitButton = new Button("Exit",10,75,17,0,0,true,12587024,0);
         addChild(exitButton);
         exitButton.x = 695 - exitButton.width;
         exitButton.y = 5;
         exitButton.addEventListener(MouseEvent.CLICK,function():void
         {
            visible = false;
         });
      }
      
      private function onBBMGSClick(param1:MouseEvent = null) : void
      {
         var _loc2_:URLRequest = new URLRequest("http://www.macgamestore.com/detail.php?ProductID=1252");
         navigateToURL(_loc2_,"_blank");
      }
      
      private function onBBClick(param1:MouseEvent = null) : void
      {
         var _loc2_:URLRequest = new URLRequest("http://knucklecracker.com");
         navigateToURL(_loc2_,"_blank");
      }
   }
}
