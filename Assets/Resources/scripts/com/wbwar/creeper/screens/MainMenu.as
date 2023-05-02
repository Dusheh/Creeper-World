package com.wbwar.creeper.screens
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.dialogs.HelpDialog;
   import com.wbwar.creeper.games.GameData;
   import com.wbwar.creeper.util.Button;
   import com.wbwar.creeper.util.Text;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.utils.Timer;
   
   public class MainMenu extends Sprite
   {
      
      public static var titleImage:Class = MainMenu_titleImage;
      
      private static var titleBitmap:Bitmap = new titleImage() as Bitmap;
      
      public static var titleTextImage:Class = MainMenu_titleTextImage;
      
      private static var titleTextBitmap:Bitmap = new titleTextImage() as Bitmap;
       
      
      private var creeperTextFieldContainer:Sprite;
      
      private var worldTextFieldContainer:Sprite;
      
      private var creeperTextField:TextField;
      
      private var worldTextField:TextField;
      
      private var startButton:Button;
      
      private var randomButton:Button;
      
      private var survivalButton:Button;
      
      private var unchartedButton:Button;
      
      private var customButton:Button;
      
      private var achievementsButton:Button;
      
      private var creditsButton:Button;
      
      private var exitGameButton:Button;
      
      private var howToPlayButton:Button;
      
      private var launchEditorMapButton:Button;
      
      private var versionText:TextField;
      
      private var muteText:TextField;
      
      private var timer:Timer;
      
      public function MainMenu()
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         super();
         graphics.beginFill(0);
         graphics.drawRect(0,0,700,525);
         graphics.endFill();
         addChild(titleBitmap);
         titleBitmap.scaleX = 0.5;
         titleBitmap.scaleY = 0.5;
         addChild(titleTextBitmap);
         titleTextBitmap.scaleX = 0.4;
         titleTextBitmap.scaleY = 0.4;
         if(false)
         {
            (_loc4_ = Text.text("DEMO",48,16711680)).x = 70;
            _loc4_.y = 200;
            _loc4_.rotation = -15;
            addChild(_loc4_);
         }
         this.startButton = new Button("STORY",24,250,35,0,0,true,32768,-1);
         this.startButton.filters = [new GlowFilter(3178560,1,32,32,2,BitmapFilterQuality.MEDIUM)];
         addChild(this.startButton);
         this.startButton.x = 440;
         this.startButton.y = -50;
         this.startButton.addEventListener(MouseEvent.CLICK,this.onStartClick);
         this.randomButton = new Button("CONQUEST",24,250,35,0,0,true,32768,-1);
         this.randomButton.filters = [new GlowFilter(3178560,1,32,32,2,BitmapFilterQuality.MEDIUM)];
         addChild(this.randomButton);
         this.randomButton.x = 705;
         this.randomButton.y = 60;
         this.randomButton.addEventListener(MouseEvent.CLICK,this.onRandomClick);
         this.survivalButton = new Button("SPECIAL OPS",24,250,35,0,0,true,32768,-1);
         this.survivalButton.filters = [new GlowFilter(3178560,1,32,32,2,BitmapFilterQuality.MEDIUM)];
         addChild(this.survivalButton);
         this.survivalButton.x = 440;
         this.survivalButton.y = 526;
         this.survivalButton.addEventListener(MouseEvent.CLICK,this.onSpecialClick);
         this.unchartedButton = new Button("CHRONOM",24,250,35,0,0,true,32768,-1);
         this.unchartedButton.filters = [new GlowFilter(3178560,1,32,32,2,BitmapFilterQuality.MEDIUM)];
         addChild(this.unchartedButton);
         this.unchartedButton.x = -200;
         this.unchartedButton.y = 160;
         this.unchartedButton.addEventListener(MouseEvent.CLICK,this.onUnchartedClick);
         this.customButton = new Button("CUSTOM MAPS",24,250,35,0,0,true,32768,-1);
         this.customButton.filters = [new GlowFilter(3178560,1,32,32,2,BitmapFilterQuality.MEDIUM)];
         addChild(this.customButton);
         this.customButton.x = 440;
         this.customButton.y = -50;
         this.customButton.addEventListener(MouseEvent.CLICK,this.onCustomClick);
         this.customButton.visible = false;
         this.achievementsButton = new Button("Hall of Honor",20,200,30,0,0,true,128,-1);
         this.achievementsButton.filters = [new GlowFilter(4214944,1,32,32,2,BitmapFilterQuality.MEDIUM)];
         addChild(this.achievementsButton);
         this.achievementsButton.x = -this.achievementsButton.width;
         this.achievementsButton.y = 410;
         this.achievementsButton.addEventListener(MouseEvent.CLICK,this.onAchievementsClick);
         this.exitGameButton = new Button("Exit Game",16,130,25,0,0,true,8388608,-1);
         this.exitGameButton.filters = [new GlowFilter(10502208,1,32,32,2,BitmapFilterQuality.MEDIUM)];
         addChild(this.exitGameButton);
         this.exitGameButton.x = 560;
         this.exitGameButton.y = 460;
         this.exitGameButton.addEventListener(MouseEvent.CLICK,this.onExitGameClick);
         if(true)
         {
            this.exitGameButton.visible = false;
         }
         this.creditsButton = new Button("Credits",16,150,25,0,0,true,32768,-1);
         this.creditsButton.filters = [new GlowFilter(3178560,1,32,32,2,BitmapFilterQuality.MEDIUM)];
         addChild(this.creditsButton);
         this.creditsButton.x = -this.creditsButton.width;
         this.creditsButton.y = 460;
         this.creditsButton.addEventListener(MouseEvent.CLICK,this.onCreditsClick);
         this.howToPlayButton = new Button("How To Play",20,200,30,0,0,true,8421376,-1);
         this.howToPlayButton.filters = [new GlowFilter(8421440,1,32,32,2,BitmapFilterQuality.MEDIUM)];
         addChild(this.howToPlayButton);
         this.howToPlayButton.x = 700;
         this.howToPlayButton.y = 270;
         this.howToPlayButton.addEventListener(MouseEvent.CLICK,this.onHowToPlayClick);
         var _loc1_:Logo = new Logo();
         addChild(_loc1_);
         _loc1_.x = 300;
         _loc1_.y = 520 - _loc1_.height;
         if(false)
         {
            this.versionText = Text.text("Ver: undefined",8,12636384);
            addChild(this.versionText);
            this.versionText.x = 5;
            this.versionText.y = int(520 - this.versionText.height);
         }
         var _loc2_:Sprite = new Sprite();
         this.muteText = Text.text("MUTE MENU MUSIC",8,16777215);
         _loc2_.addChild(this.muteText);
         _loc2_.x = 70;
         _loc2_.y = int(520 - this.muteText.height);
         _loc2_.useHandCursor = true;
         _loc2_.buttonMode = true;
         addChild(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.onMuteClick);
         _loc2_.graphics.beginFill(0,0);
         _loc2_.graphics.drawRect(0,0,this.muteText.width,this.muteText.height);
         _loc2_.graphics.endFill();
         _loc3_ = Text.text("Copyright © 2016 Knuckle Cracker, LLC",8,9474192);
         addChild(_loc3_);
         _loc3_.x = int(350 - _loc3_.width / 2);
         _loc3_.y = int(520 - _loc3_.height);
         this.launchEditorMapButton = new Button("Launch Your Custom Game",16,250,35,0,5,true,32768,-1);
         this.launchEditorMapButton.filters = [new GlowFilter(3178560,1,32,32,2,BitmapFilterQuality.MEDIUM)];
         addChild(this.launchEditorMapButton);
         this.launchEditorMapButton.x = 440;
         this.launchEditorMapButton.y = 410;
         this.launchEditorMapButton.addEventListener(MouseEvent.CLICK,this.onLaunchEditorMapButtonClick);
         this.launchEditorMapButton.visible = false;
         if(false)
         {
            this.timer = new Timer(1000,9999999999);
            this.timer.addEventListener(TimerEvent.TIMER,this.onTimer);
            this.timer.start();
         }
         GameData.load();
         if(false)
         {
            this.muteText.text = "UNMUTE MENU MUSIC";
         }
      }
      
      private function onMuteClick(param1:MouseEvent) : void
      {
         if(true)
         {
            this.muteText.text = "UNMUTE MENU MUSIC";
            Creeper.instance.gameScreen.stopMainMusic();
            GameData.muteMainMusic = true;
         }
         else
         {
            this.muteText.text = "MUTE MENU MUSIC";
            Creeper.instance.gameScreen.startMainMusic();
            GameData.muteMainMusic = false;
            Creeper.instance.gameScreen.startMainMusic();
         }
         GameData.save();
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         if(false)
         {
            this.launchEditorMapButton.visible = Creeper.hasWorkingCustomGameFunction() as Boolean;
         }
      }
      
      public function show() : void
      {
         this.startButton.y = -50;
         this.randomButton.x = 705;
         this.survivalButton.y = 526;
         this.unchartedButton.x = -200;
         this.customButton.y = -50;
         this.achievementsButton.x = -this.achievementsButton.width;
         this.creditsButton.x = -this.creditsButton.width;
         this.howToPlayButton.x = 700;
         Tweener.removeTweens(this.creeperTextField);
         Tweener.removeTweens(this.worldTextField);
         Tweener.addTween(this.startButton,{
            "time":1.5,
            "y":10
         });
         Tweener.addTween(this.randomButton,{
            "time":1.5,
            "x":440
         });
         Tweener.addTween(this.survivalButton,{
            "time":1.5,
            "y":110
         });
         Tweener.addTween(this.unchartedButton,{
            "time":1.5,
            "x":440
         });
         Tweener.addTween(this.customButton,{
            "time":1.5,
            "y":210
         });
         Tweener.addTween(this.achievementsButton,{
            "time":1.5,
            "x":10
         });
         Tweener.addTween(this.creditsButton,{
            "time":1.5,
            "x":35
         });
         Tweener.addTween(this.howToPlayButton,{
            "time":1.5,
            "x":465
         });
         if(false)
         {
            this.launchEditorMapButton.visible = Creeper.hasWorkingCustomGameFunction() as Boolean;
         }
      }
      
      private function onStartClick(param1:MouseEvent) : void
      {
         Creeper.instance.gameScreen.showMissionSelection(-1);
      }
      
      private function onRandomClick(param1:MouseEvent) : void
      {
         Creeper.instance.gameScreen.showFreeplayMissionSelection(-1);
      }
      
      private function onSpecialClick(param1:MouseEvent) : void
      {
         Creeper.instance.gameScreen.showSpecialMissionSelection(-1);
      }
      
      private function onUnchartedClick(param1:MouseEvent) : void
      {
         Creeper.instance.gameScreen.showUnchartedMissionSelection(null,0,0,null);
      }
      
      private function onCustomClick(param1:MouseEvent) : void
      {
         Creeper.instance.gameScreen.showCustomMissionSelection();
      }
      
      private function onAchievementsClick(param1:MouseEvent) : void
      {
         Creeper.instance.gameScreen.showAchievementsScreen();
      }
      
      private function onExitGameClick(param1:MouseEvent) : void
      {
         if(false)
         {
            Creeper.exitGameFunction();
         }
      }
      
      private function onCreditsClick(param1:MouseEvent) : void
      {
         Creeper.instance.gameScreen.showCredits();
      }
      
      private function onHowToPlayClick(param1:MouseEvent) : void
      {
         addChild(HelpDialog.instance);
         HelpDialog.instance.x = 350;
         HelpDialog.instance.y = 250;
         HelpDialog.instance.visible = true;
      }
      
      private function onLaunchEditorMapButtonClick(param1:MouseEvent) : void
      {
         Creeper.instance.gameScreen.launchCustomGame("");
      }
   }
}
