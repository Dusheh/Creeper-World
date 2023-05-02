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
   
   public class FreeplayLockScreen extends Sprite
   {
       
      
      public function FreeplayLockScreen(param1:Boolean = false)
      {
         var lockText2:TextField = null;
         var bbmgs:Button = null;
         var bb:Button = null;
         var demo:Boolean = param1;
         super();
         graphics.beginFill(0,0.6);
         graphics.drawRect(0,0,700,525);
         graphics.endFill();
         var lockText:TextField = Text.text("LOCKED",48,16711680);
         lockText.filters = [new DropShadowFilter(),new GlowFilter(10526880,1,32,32,4,BitmapFilterQuality.MEDIUM)];
         addChild(lockText);
         lockText.x = 350 - lockText.width / 2;
         lockText.y = 100;
         if(demo)
         {
            if(false)
            {
               lockText2 = Text.text(" Not available in DEMO\nBuy full game to unlock  ",24,13684944);
               bbmgs = new Button("Buy Full Game",20,300,30,0,0,true,32768,-1);
               bbmgs.filters = [new GlowFilter(3178560,1,32,32,2,BitmapFilterQuality.MEDIUM)];
               addChild(bbmgs);
               bbmgs.x = 350 - bbmgs.width / 2;
               bbmgs.y = 275;
               bbmgs.addEventListener(MouseEvent.CLICK,this.onBBMGSClick);
            }
            else
            {
               lockText2 = Text.text("                  Not available in DEMO\nBuy full game at knucklecracker.com to unlock  ",24,13684944);
               bb = new Button("Visit KnuckleCracker.com!",20,300,30,0,0,true,32768,-1);
               bb.filters = [new GlowFilter(3178560,1,32,32,2,BitmapFilterQuality.MEDIUM)];
               addChild(bb);
               bb.x = 350 - bb.width / 2;
               bb.y = 275;
               bb.addEventListener(MouseEvent.CLICK,this.onBBClick);
            }
         }
         else
         {
            lockText2 = Text.text("Complete the first leg of story mode to unlock.",24,13684944);
         }
         lockText2.filters = [new DropShadowFilter(),new GlowFilter(10526880,1,32,32,4,BitmapFilterQuality.MEDIUM)];
         addChild(lockText2);
         lockText2.x = 350 - lockText2.width / 2;
         lockText2.y = 200;
         var exitButton:Button = new Button("Exit",10,75,17,0,0,true,12587024,0);
         addChild(exitButton);
         exitButton.x = 695 - exitButton.width;
         exitButton.y = 5;
         exitButton.addEventListener(MouseEvent.CLICK,function():void
         {
            Creeper.instance.gameScreen.showMainMenu();
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
