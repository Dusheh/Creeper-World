package com.wbwar.creeper.screens
{
   import com.wbwar.creeper.games.GameData;
   import com.wbwar.creeper.games.IndividualGameData;
   import com.wbwar.creeper.util.Button;
   import com.wbwar.creeper.util.Text;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.utils.getTimer;
   
   public class UnchartedMissionSelection extends Sprite
   {
      
      public static var backgroundImage:Class = UnchartedMissionSelection_backgroundImage;
      
      private static var backgroundBitmap:Bitmap = new backgroundImage() as Bitmap;
      
      private static const GRANDSCORE_WIDTH:int = 140;
      
      private static const GRANDSCORE_HEIGHT:int = 70;
      
      public static var missionWorlds:Array = [];
       
      
      public var popupLayer:Sprite;
      
      private var submitScoreScreen:UnchartedSubmitScoreScreen;
      
      private var exitButton:Button;
      
      private var viewScoresButton:Button;
      
      private var ddButton:Button;
      
      private var lockScreen:FreeplayLockScreen;
      
      private var grandScoreText:TextField;
      
      private var grandPlayCountText:TextField;
      
      private var unchartedGrid:UnchartedGrid;
      
      public var unchartedMapSelector:UnchartedMapSelector;
      
      private var lastTime:Number = 0;
      
      public function UnchartedMissionSelection()
      {
         super();
         addChild(backgroundBitmap);
         this.popupLayer = new Sprite();
         this.popupLayer.mouseEnabled = false;
         this.popupLayer.mouseChildren = false;
         this.unchartedMapSelector = new UnchartedMapSelector();
         addChild(this.unchartedMapSelector);
         this.unchartedMapSelector.x = int(350 - this.unchartedMapSelector.WIDTH / 2);
         this.unchartedMapSelector.y = 100;
         this.unchartedMapSelector.addEventListener(UnchartedMapSelector.LAUNCHMAP,this.onLaunchMap);
         this.unchartedMapSelector.addEventListener(UnchartedMapSelector.RESUBMIT,this.onResubmit);
         this.exitButton = new Button("Exit",10,75,17,0,0,true,12587024,0);
         addChild(this.exitButton);
         this.exitButton.x = 695 - this.exitButton.width;
         this.exitButton.y = 5;
         this.exitButton.addEventListener(MouseEvent.CLICK,function():void
         {
            Creeper.instance.gameScreen.showMainMenu();
         });
         this.ddButton = new Button("Double Down [OFF]",10,150,17,0,0,true,12603408,0);
         addChild(this.ddButton);
         this.ddButton.x = 695 - this.ddButton.width;
         this.ddButton.y = 25;
         this.ddButton.addEventListener(MouseEvent.CLICK,this.ddClick);
         this.ddButton.visible = false;
         var title:TextField = Text.text("Chronom Missions",36,16777215);
         title.filters = [new GlowFilter(65280,1,16,16)];
         addChild(title);
         title.x = 350 - title.width / 2;
         title.y = 40;
         addChild(this.popupLayer);
         this.submitScoreScreen = new UnchartedSubmitScoreScreen(this);
         this.submitScoreScreen.hide();
         addChild(this.submitScoreScreen);
         this.lockScreen = new FreeplayLockScreen(Creeper.DEMO);
         addChild(this.lockScreen);
      }
      
      private function onLaunchMap(param1:Event) : void
      {
         Creeper.instance.gameScreen.launchUnchartedGame(this.unchartedMapSelector.selectedMap,"Chronom: " + this.unchartedMapSelector.selectedDate);
      }
      
      private function onResubmit(param1:Event) : void
      {
         var _loc2_:Number = getTimer();
         if(_loc2_ - this.lastTime < 5000)
         {
            return;
         }
         this.lastTime = _loc2_;
         var _loc3_:IndividualGameData = GameData.getUnchartedGameData(String(this.unchartedMapSelector.selectedMap));
         var _loc4_:String = String(this.unchartedMapSelector.selectedMap);
         var _loc5_:int = _loc3_.highScore;
         var _loc6_:int = _loc3_.playCount;
         var _loc7_:String = "Chronom: " + this.unchartedMapSelector.selectedDate;
         this.submitScoreScreen.show(_loc4_,_loc5_,_loc6_,_loc7_);
      }
      
      private function onViewScoresClick(param1:Event) : void
      {
         var _loc2_:URLRequest = new URLRequest("http://knucklecracker.com/creeperworld/viewscores.php?missionGroup=uncharted");
         navigateToURL(_loc2_,"creeperworldscores");
      }
      
      private function setDDButtonText() : void
      {
         if(false)
         {
            this.ddButton.text.text = "Double Down [ON!!!]";
         }
         else
         {
            this.ddButton.text.text = "Double Down [OFF]";
         }
      }
      
      private function ddClick(param1:Event) : void
      {
         Creeper.doubleDownMode = true;
         this.setDDButtonText();
      }
      
      private function isGameLocked(param1:int) : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:int = int(param1 / 2) * 5 + 1;
         var _loc4_:int = _loc2_;
         while(_loc4_ < _loc2_ + 5)
         {
            _loc3_ = GameData.getRandomGameData(_loc4_);
            if(_loc3_.highScore <= 0)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function reinit(param1:String, param2:int, param3:int, param4:String) : void
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         GameData.load();
         this.ddButton.visible = false;
         if((_loc5_ = GameData.getSpecialGameData(8)).highScore > 0)
         {
            if((_loc5_ = GameData.getSpecialGameData(9)).highScore > 0)
            {
               this.ddButton.visible = true;
               this.setDDButtonText();
            }
         }
         if(false)
         {
            this.lockScreen.visible = true;
         }
         else
         {
            this.lockScreen.visible = false;
            _loc6_ = 0;
            while(_loc6_ < 5)
            {
               if((_loc5_ = GameData.getStoryGameData(_loc6_)).highScore <= 0)
               {
                  this.lockScreen.visible = true;
                  break;
               }
               _loc6_++;
            }
         }
         this.unchartedMapSelector.reinit();
         if(param1 != null)
         {
            this.submitScoreScreen.show(param1,param2,param3,param4);
         }
      }
   }
}
