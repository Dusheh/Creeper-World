package com.wbwar.creeper.screens
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.util.Button;
   import com.wbwar.creeper.util.ColorUtil;
   import com.wbwar.creeper.util.Text;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.BlurFilter;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class Credits extends Sprite
   {
      
      public static var ssImage1:Class = Credits_ssImage1;
      
      private static var ss1Bitmap:Bitmap = new ssImage1() as Bitmap;
      
      public static var ssImage2:Class = Credits_ssImage2;
      
      private static var ss2Bitmap:Bitmap = new ssImage2() as Bitmap;
      
      public static var ssImage3:Class = Credits_ssImage3;
      
      private static var ss3Bitmap:Bitmap = new ssImage3() as Bitmap;
      
      public static var ssImage4:Class = Credits_ssImage4;
      
      private static var ss4Bitmap:Bitmap = new ssImage4() as Bitmap;
      
      public static var ssImage5:Class = Credits_ssImage5;
      
      private static var ss5Bitmap:Bitmap = new ssImage5() as Bitmap;
      
      public static var ssImage6:Class = Credits_ssImage6;
      
      private static var ss6Bitmap:Bitmap = new ssImage6() as Bitmap;
      
      public static var ssImage7:Class = Credits_ssImage7;
      
      private static var ss7Bitmap:Bitmap = new ssImage7() as Bitmap;
      
      public static var ssImage8:Class = Credits_ssImage8;
      
      private static var ss8Bitmap:Bitmap = new ssImage8() as Bitmap;
      
      public static var ssImage9:Class = Credits_ssImage9;
      
      private static var ss9Bitmap:Bitmap = new ssImage9() as Bitmap;
      
      public static var ssImage10:Class = Credits_ssImage10;
      
      private static var ss10Bitmap:Bitmap = new ssImage10() as Bitmap;
      
      public static var ssImage11:Class = Credits_ssImage11;
      
      private static var ss11Bitmap:Bitmap = new ssImage11() as Bitmap;
      
      public static var ssImage12:Class = Credits_ssImage12;
      
      private static var ss12Bitmap:Bitmap = new ssImage12() as Bitmap;
      
      public static var ssImage13:Class = Credits_ssImage13;
      
      private static var ss13Bitmap:Bitmap = new ssImage13() as Bitmap;
      
      public static var ssImage14:Class = Credits_ssImage14;
      
      private static var ss14Bitmap:Bitmap = new ssImage14() as Bitmap;
      
      public static var ssImage15:Class = Credits_ssImage15;
      
      private static var ss15Bitmap:Bitmap = new ssImage15() as Bitmap;
      
      public static var ssImage16:Class = Credits_ssImage16;
      
      private static var ss16Bitmap:Bitmap = new ssImage16() as Bitmap;
      
      private static var titleBitmap:Bitmap = new MainMenu.titleImage() as Bitmap;
       
      
      private var started:Boolean;
      
      private var exitButton:Button;
      
      private var others:Sprite;
      
      private var othersText:TextField;
      
      private var ss:Array;
      
      private var currentSS:int;
      
      private var currentTitle:int;
      
      private var titleText:TextField;
      
      private var titles:Array;
      
      public function Credits()
      {
         var creeperTextField:TextField = null;
         var vw:TextField = null;
         var othersBox:Sprite = null;
         this.titles = ["Game Concept","Game Design","Game Story","Senior Developer(s)","Developer(s)","Testing Lead","Windows Development","Mac Development","Documentation Lead","Online Help","Web Site","IT Manager","Network Engineer(s)","Game Producer","PR Specialist","NCSU Graduate","Chief Nit-Picker","Lord of Detail","Physics Degree Holder","Finishing Refuser","SciFi Lover","Disbeliever","Primary Worrier","Comp. Science Degree Holder","Doubter in Chief","Schedule Misser","Cricket Treat Getter","ST(all), B5, FS, SG1, SGA, BSG Lover","Obsessed","Compulsive","ChopRaider Maker","Knuckle Cracker is:"];
         super();
         graphics.beginFill(3158064);
         graphics.drawRect(0,0,700,525);
         graphics.endFill();
         this.exitButton = new Button("Exit",10,75,17,0,0,true,12587024,0);
         addChild(this.exitButton);
         this.exitButton.x = 695 - this.exitButton.width;
         this.exitButton.y = 5;
         this.exitButton.addEventListener(MouseEvent.CLICK,function():void
         {
            Creeper.instance.gameScreen.showMainMenu();
         });
         titleBitmap.filters = [new BlurFilter(16,16)];
         ColorUtil.bwColor(titleBitmap,0);
         titleBitmap.alpha = 0.3;
         addChild(titleBitmap);
         creeperTextField = Text.text("Creeper World",48,5271807);
         creeperTextField.x = 350 - creeperTextField.width / 2;
         creeperTextField.y = 10;
         creeperTextField.filters = [new DropShadowFilter(),new BlurFilter(2,2),new GlowFilter(255,1,8,8)];
         addChild(creeperTextField);
         vw = Text.text("Virgil Wall",20,16777215);
         vw.filters = [new DropShadowFilter()];
         addChild(vw);
         vw.x = 350 - vw.width / 2;
         vw.y = 175;
         this.titleText = Text.text("",22,16777215);
         this.titleText.filters = [new DropShadowFilter()];
         this.titleText.y = 140;
         addChild(this.titleText);
         this.ss = [];
         this.ss[0] = ss1Bitmap;
         this.ss[1] = ss2Bitmap;
         this.ss[2] = ss3Bitmap;
         this.ss[3] = ss4Bitmap;
         this.ss[4] = ss5Bitmap;
         this.ss[5] = ss6Bitmap;
         this.ss[6] = ss7Bitmap;
         this.ss[7] = ss8Bitmap;
         this.ss[8] = ss9Bitmap;
         this.ss[9] = ss10Bitmap;
         this.ss[10] = ss11Bitmap;
         this.ss[11] = ss12Bitmap;
         this.ss[12] = ss13Bitmap;
         this.ss[13] = ss14Bitmap;
         this.ss[14] = ss15Bitmap;
         this.ss[15] = ss16Bitmap;
         var i:int = 0;
         while(i < this.ss.length)
         {
            addChild(this.ss[i]);
            this.ss[i].x = 440;
            this.ss[i].y = 265;
            this.ss[i].visible = false;
            this.ss[i].alpha = 0;
            i++;
         }
         othersBox = new Sprite();
         addChild(othersBox);
         othersBox.x = 50;
         othersBox.y = 290;
         othersBox.graphics.lineStyle(1,16777215,0.3);
         othersBox.graphics.moveTo(0,0);
         othersBox.graphics.lineTo(300,0);
         othersBox.graphics.moveTo(0,149);
         othersBox.graphics.lineTo(300,149);
         othersBox.scrollRect = new Rectangle(0,0,300,150);
         this.others = new Sprite();
         this.othersText = Text.text("",12,16777215,TextFieldAutoSize.CENTER);
         this.othersText.cacheAsBitmap = true;
         this.othersText.multiline = true;
         this.othersText.htmlText = "<body><p align=\'center\'><br><font size=\'14\' color=\'#90c0FF\'>Anniversary Unit Graphics</font><br/>Weston Tracy<br><br><br><br><font size=\'14\' color=\'#90c0FF\'>Awesome Title Music</font><br/>\'Arcadia\'  Kevin MacLeod (incompetech.com)<br><br><br><br><font size=\'14\' color=\'#90c0FF\'>Sweet Prelude Music</font><br/>\'Opera House\' (www.jimmyg.us)<br><br><br><br><font size=\'14\' color=\'#90c0FF\'>Excellent Mission 1 Music</font><br/>\'Big Mojo\'  Kevin MacLeod (incompetech.com)<br><br><br><br><font size=\'14\' color=\'#90c0FF\'>Perfect Credits Music</font><br/>\'African Afternoon\' (www.jimmyg.us)<br><br><br><br><font size=\'14\' color=\'#90c0FF\'>Milky Way Galaxy Image</font><br/>NASA/JPL-Caltech<br><br><br><br><font size=\'14\' color=\'#90c0FF\'>Testers and Idea machines</font><br/>April Wall<br/>David Patterson [dpstuff.com]<br/>Jason Walker [aristotlesaxis.com]<br/>Rob Ward<br/>Ricky Beam<br/>Byron Hargett<br/>Doug Hester<br/><br/><br/><br/><br/><font size=\'14\' color=\'#90c0FF\'>Special Dedication</font><br/>April Wall<br/><br/><br/><br/><br/><br/><br/>Words of wisdom:<br/><br/>Diplomacy is the art of saying<br/>\'Nice doggie\'<br/>until you can find a rock.<br/><br/><br/><br/>War is an art and as such is not susceptible<br/>to explanation by fixed formula.<br/><br/><br/><br/>Make your plans to fit the circumstances.<br/><br/><br/><br/>Fear accompanies the possibility of death.<br/>Calm shepherds its certainty.<br/><br/><br/><br/>.<br/>.<br/>.<br/>.<br/>.<br/>.<br/>.<br/>.<br/>.<br/>.<br/>.<br/>.<br/>Still Watching?<br/><br/>So how about those screen shots<br/>to the right---------><br/><br/>Those are from early stages of the game.<br/>As you can see, in the beginning it didn\'t look<br/>anything like it did in the end.<br/><br/><br/><br/>But, the core idea was there from the beginning<br/><br/>to<br/><br/>the end!<br/><br/><br/><br/><br/><br/>";
         othersBox.addChild(this.othersText);
         this.othersText.x = int(150 - this.othersText.width / 2);
         this.othersText.y = 0;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         if(param1)
         {
            this.start();
         }
         else
         {
            this.stop();
         }
      }
      
      private function start() : void
      {
         this.started = true;
         this.currentTitle = -1;
         this.nextTitle();
         this.currentSS = -1;
         this.nextSS();
         this.scrollOthers();
      }
      
      private function scrollOthers(param1:Event = null) : void
      {
         if(this.started)
         {
            this.othersText.y = 150;
            Tweener.addTween(this.othersText,{
               "transition":"linear",
               "time":130,
               "y":-this.othersText.height,
               "onComplete":this.scrollOthers
            });
         }
      }
      
      private function stop() : void
      {
         this.started = false;
         Tweener.removeTweens(this.titleText);
         Tweener.removeTweens(this.othersText);
      }
      
      private function nextSS() : void
      {
         if(this.started)
         {
            ++this.currentSS;
            if(this.currentSS >= this.ss.length)
            {
               this.currentSS = 0;
            }
            Tweener.addTween(this.ss[this.currentSS],{
               "time":2,
               "_autoAlpha":1,
               "onComplete":this.ssOut
            });
         }
      }
      
      private function ssOut() : void
      {
         if(this.started)
         {
            Tweener.addTween(this.ss[this.currentSS],{
               "delay":5,
               "time":1,
               "_autoAlpha":0,
               "onComplete":this.nextSS
            });
         }
      }
      
      private function nextTitle() : void
      {
         if(this.started)
         {
            ++this.currentTitle;
            if(this.currentTitle >= this.titles.length)
            {
               this.currentTitle = 0;
            }
            this.titleText.text = this.titles[this.currentTitle];
            this.titleText.x = 700;
            Tweener.addTween(this.titleText,{
               "time":0.5,
               "x":350 - this.titleText.width / 2,
               "onComplete":this.titleOut
            });
         }
      }
      
      private function titleOut() : void
      {
         if(this.started)
         {
            Tweener.addTween(this.titleText,{
               "delay":3,
               "time":0.5,
               "x":-this.titleText.width,
               "onComplete":this.nextTitle
            });
         }
      }
   }
}
