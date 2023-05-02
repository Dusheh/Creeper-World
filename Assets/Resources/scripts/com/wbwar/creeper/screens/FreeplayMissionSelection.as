package com.wbwar.creeper.screens
{
   import com.wbwar.creeper.games.GameData;
   import com.wbwar.creeper.games.IndividualGameData;
   import com.wbwar.creeper.util.Button;
   import com.wbwar.creeper.util.Text;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   
   public class FreeplayMissionSelection extends Sprite
   {
      
      public static var backgroundImage:Class = FreeplayMissionSelection_backgroundImage;
      
      private static var backgroundBitmap:Bitmap = new backgroundImage() as Bitmap;
      
      private static const GRANDSCORE_WIDTH:int = 140;
      
      private static const GRANDSCORE_HEIGHT:int = 70;
      
      public static const systemNames:Array = ["Grim","Skuld","Frigg","Vidar","Gudrun"];
      
      private static const systemCoords:Array = [350,120,525,220,450,410,250,410,175,220];
       
      
      private var systems:Array;
      
      private var pathLayer:Shape;
      
      public var popupLayer:Sprite;
      
      private var exitButton:Button;
      
      private var viewScoresButton:Button;
      
      private var ddButton:Button;
      
      private var grandScoreText:TextField;
      
      private var grandPlayCountText:TextField;
      
      private var submitScoreScreen:SubmitScoreScreen;
      
      private var lockScreen:FreeplayLockScreen;
      
      public function FreeplayMissionSelection()
      {
         var ms:MissionSystem = null;
         super();
         addChild(backgroundBitmap);
         this.pathLayer = new Shape();
         addChild(this.pathLayer);
         this.popupLayer = new Sprite();
         this.popupLayer.mouseEnabled = false;
         this.popupLayer.mouseChildren = false;
         this.systems = [];
         var i:int = 0;
         while(i < 5)
         {
            ms = new MissionSystem(this,systemNames[i],i * 5 + 1,i * 5 + 5,systemCoords[i * 2],systemCoords[i * 2 + 1]);
            this.systems.push(ms);
            addChild(ms);
            if(i == 0)
            {
               this.pathLayer.graphics.moveTo(ms.x,ms.y);
            }
            else
            {
               this.pathLayer.graphics.lineStyle(3,6316128);
               this.pathLayer.graphics.moveTo(this.systems[i - 1].x,this.systems[i - 1].y);
               this.pathLayer.graphics.lineTo(ms.x,ms.y);
               this.pathLayer.graphics.lineStyle(1,10526880);
               this.pathLayer.graphics.moveTo(this.systems[i - 1].x,this.systems[i - 1].y);
               this.pathLayer.graphics.lineTo(ms.x,ms.y);
            }
            i++;
         }
         this.pathLayer.graphics.lineStyle(3,6316128);
         this.pathLayer.graphics.moveTo(this.systems[i - 1].x,this.systems[i - 1].y);
         this.pathLayer.graphics.lineTo(this.systems[0].x,this.systems[0].y);
         this.pathLayer.graphics.lineStyle(1,10526880);
         this.pathLayer.graphics.moveTo(this.systems[i - 1].x,this.systems[i - 1].y);
         this.pathLayer.graphics.lineTo(this.systems[0].x,this.systems[0].y);
         var grandScoreContainer:Sprite = new Sprite();
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
         addChild(this.popupLayer);
         this.submitScoreScreen = new SubmitScoreScreen();
         this.submitScoreScreen.hide();
         addChild(this.submitScoreScreen);
         this.lockScreen = new FreeplayLockScreen(Creeper.DEMO);
         addChild(this.lockScreen);
      }
      
      private function onViewScoresClick(param1:Event) : void
      {
         var _loc2_:URLRequest = new URLRequest("http://knucklecracker.com/creeperworld/viewscores.php?missionGroup=conquest");
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
      
      public function reinit(param1:int) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
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
               _loc2_ = GameData.getStoryGameData(_loc6_);
               if(_loc2_.highScore <= 0)
               {
                  this.lockScreen.visible = true;
                  break;
               }
               _loc6_++;
            }
         }
         for each(_loc3_ in this.systems)
         {
            _loc3_.reinit();
         }
         _loc4_ = 0;
         _loc5_ = 0;
         _loc6_ = 1;
         while(_loc6_ <= 25)
         {
            _loc2_ = GameData.getRandomGameData(_loc6_);
            _loc4_ += _loc2_.highScore;
            _loc5_ += _loc2_.playCount;
            _loc6_++;
         }
         this.grandScoreText.text = String(_loc4_);
         this.grandScoreText.x = GRANDSCORE_WIDTH / 2 - this.grandScoreText.width / 2;
         this.grandPlayCountText.text = "#Plays: " + String(_loc5_);
         if(param1 > 0)
         {
            _loc7_ = GameData.getRandomGameData(param1).lastScore;
            _loc8_ = GameData.getRandomGameData(param1).playCount;
            this.submitScoreScreen.show(false,false,_loc4_,_loc5_,_loc7_,_loc8_,param1 - 1);
         }
      }
   }
}
