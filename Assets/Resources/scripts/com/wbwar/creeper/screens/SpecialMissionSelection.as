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
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   
   public class SpecialMissionSelection extends Sprite
   {
      
      public static var backgroundImage:Class = SpecialMissionSelection_backgroundImage;
      
      private static var backgroundBitmap:Bitmap = new backgroundImage() as Bitmap;
      
      private static const GRANDSCORE_WIDTH:int = 140;
      
      private static const GRANDSCORE_HEIGHT:int = 70;
      
      public static var missionWorlds:Array = [];
       
      
      public var popupLayer:Sprite;
      
      private var submitScoreScreen:SubmitScoreScreen;
      
      private var exitButton:Button;
      
      private var viewScoresButton:Button;
      
      private var ddButton:Button;
      
      private var lockScreen:FreeplayLockScreen;
      
      private var grandScoreText:TextField;
      
      private var grandPlayCountText:TextField;
      
      public function SpecialMissionSelection()
      {
         var grandScoreContainer:Sprite = null;
         var title:TextField = null;
         var smw:SpecialMissionWorld = null;
         super();
         addChild(backgroundBitmap);
         this.popupLayer = new Sprite();
         this.popupLayer.mouseEnabled = false;
         this.popupLayer.mouseChildren = false;
         grandScoreContainer = new Sprite();
         grandScoreContainer.filters = [new DropShadowFilter(4,45,3178544)];
         grandScoreContainer.graphics.lineStyle(2,16777215);
         grandScoreContainer.graphics.beginFill(2109472);
         grandScoreContainer.graphics.drawRoundRect(0,0,GRANDSCORE_WIDTH,GRANDSCORE_HEIGHT,14,8);
         grandScoreContainer.graphics.endFill();
         addChild(grandScoreContainer);
         grandScoreContainer.x = 10;
         grandScoreContainer.y = 10;
         var grandScoreTitle:TextField = Text.text("Total Score",18,16777215);
         grandScoreTitle.filters = [new DropShadowFilter()];
         grandScoreContainer.addChild(grandScoreTitle);
         grandScoreTitle.x = GRANDSCORE_WIDTH / 2 - grandScoreTitle.width / 2;
         grandScoreTitle.y = 0;
         this.grandScoreText = Text.text("",24,16777215);
         this.grandScoreText.filters = [new DropShadowFilter()];
         grandScoreContainer.addChild(this.grandScoreText);
         this.grandScoreText.y = 20;
         this.grandPlayCountText = Text.text("",14,16777215);
         this.grandPlayCountText.filters = [new DropShadowFilter()];
         grandScoreContainer.addChild(this.grandPlayCountText);
         this.grandPlayCountText.x = 12;
         this.grandPlayCountText.y = 48;
         this.exitButton = new Button("Exit",10,75,17,0,0,true,12587024,0);
         addChild(this.exitButton);
         this.exitButton.x = 695 - this.exitButton.width;
         this.exitButton.y = 5;
         this.exitButton.addEventListener(MouseEvent.CLICK,function():void
         {
            Creeper.instance.gameScreen.showMainMenu();
         });
         if(true)
         {
            this.viewScoresButton = new Button("View Online Scores",12,135,20,0,0,true,1097744,0);
            addChild(this.viewScoresButton);
            this.viewScoresButton.x = int(350 - this.viewScoresButton.width / 2);
            this.viewScoresButton.y = 5;
            this.viewScoresButton.addEventListener(MouseEvent.CLICK,this.onViewScoresClick);
         }
         this.ddButton = new Button("Double Down [OFF]",10,150,17,0,0,true,12603408,0);
         addChild(this.ddButton);
         this.ddButton.x = 695 - this.ddButton.width;
         this.ddButton.y = 25;
         this.ddButton.addEventListener(MouseEvent.CLICK,this.ddClick);
         this.ddButton.visible = false;
         title = Text.text("Special Ops",36,16777215);
         title.filters = [new GlowFilter(65280,1,16,16)];
         addChild(title);
         title.x = 350 - title.width / 2;
         title.y = 40;
         missionWorlds.push(new SpecialMissionWorld(this,0,100,200));
         missionWorlds.push(new SpecialMissionWorld(this,1,225,200));
         missionWorlds.push(new SpecialMissionWorld(this,2,350,200));
         missionWorlds.push(new SpecialMissionWorld(this,3,475,200));
         missionWorlds.push(new SpecialMissionWorld(this,4,600,200));
         missionWorlds.push(new SpecialMissionWorld(this,5,100,410));
         missionWorlds.push(new SpecialMissionWorld(this,6,225,410));
         missionWorlds.push(new SpecialMissionWorld(this,7,350,410));
         missionWorlds.push(new SpecialMissionWorld(this,8,475,410));
         missionWorlds.push(new SpecialMissionWorld(this,9,600,410));
         for each(smw in missionWorlds)
         {
            addChild(smw);
         }
         addChild(this.popupLayer);
         this.submitScoreScreen = new SubmitScoreScreen();
         this.submitScoreScreen.hide();
         addChild(this.submitScoreScreen);
         if(false)
         {
            this.lockScreen = new FreeplayLockScreen(Creeper.DEMO);
            addChild(this.lockScreen);
         }
      }
      
      private function onViewScoresClick(param1:Event) : void
      {
         var _loc2_:URLRequest = new URLRequest("http://knucklecracker.com/creeperworld/viewscores.php?missionGroup=special");
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
      
      public function reinit(param1:int) : void
      {
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         GameData.load();
         this.ddButton.visible = false;
         _loc2_ = GameData.getSpecialGameData(8);
         if(_loc2_.highScore > 0)
         {
            _loc2_ = GameData.getSpecialGameData(9);
            if(_loc2_.highScore > 0)
            {
               this.ddButton.visible = true;
               this.setDDButtonText();
            }
         }
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < 10)
         {
            _loc2_ = GameData.getSpecialGameData(_loc5_);
            _loc3_ += _loc2_.highScore;
            _loc4_ += _loc2_.playCount;
            _loc5_++;
         }
         this.grandScoreText.text = String(_loc3_);
         this.grandScoreText.x = GRANDSCORE_WIDTH / 2 - this.grandScoreText.width / 2;
         this.grandPlayCountText.text = "#Plays: " + String(_loc4_);
         _loc5_ = 0;
         while(_loc5_ < missionWorlds.length)
         {
            _loc6_ = missionWorlds[_loc5_] as SpecialMissionWorld;
            _loc2_ = GameData.getSpecialGameData(_loc5_);
            _loc6_.reinit(_loc2_);
            _loc6_.locked = this.isGameLocked(_loc5_);
            _loc5_++;
         }
         if(param1 >= 0)
         {
            _loc7_ = GameData.getSpecialGameData(param1).lastScore;
            _loc8_ = GameData.getSpecialGameData(param1).playCount;
            this.submitScoreScreen.show(false,true,_loc3_,_loc4_,_loc7_,_loc8_,param1);
         }
      }
   }
}
