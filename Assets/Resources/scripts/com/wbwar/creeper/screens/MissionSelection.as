package com.wbwar.creeper.screens
{
   import com.wbwar.creeper.games.Game0;
   import com.wbwar.creeper.games.Game1;
   import com.wbwar.creeper.games.Game10;
   import com.wbwar.creeper.games.Game11;
   import com.wbwar.creeper.games.Game12;
   import com.wbwar.creeper.games.Game13;
   import com.wbwar.creeper.games.Game14;
   import com.wbwar.creeper.games.Game15;
   import com.wbwar.creeper.games.Game16;
   import com.wbwar.creeper.games.Game17;
   import com.wbwar.creeper.games.Game18;
   import com.wbwar.creeper.games.Game19;
   import com.wbwar.creeper.games.Game2;
   import com.wbwar.creeper.games.Game3;
   import com.wbwar.creeper.games.Game4;
   import com.wbwar.creeper.games.Game5;
   import com.wbwar.creeper.games.Game6;
   import com.wbwar.creeper.games.Game7;
   import com.wbwar.creeper.games.Game8;
   import com.wbwar.creeper.games.Game9;
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
   import flash.filters.GlowFilter;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   
   public class MissionSelection extends Sprite
   {
      
      public static var backgroundImage:Class = MissionSelection_backgroundImage;
      
      private static var backgroundBitmap:Bitmap = new backgroundImage() as Bitmap;
      
      private static const GRANDSCORE_WIDTH:int = 140;
      
      private static const GRANDSCORE_HEIGHT:int = 70;
      
      private static const LEGSCORE_WIDTH:int = 142;
      
      private static const LEGSCORE_HEIGHT:int = 140;
      
      public static const coords:Array = [[43,200],[101,142],[176,101],[267,79],[367,81],[462,107],[531,161],[563,237],[558,321],[511,388],[427,420],[333,424],[252,397],[199,346],[180,279],[202,213],[254,171],[315,158],[381,174],[420,218]];
      
      public static var mws:Array = [];
       
      
      private var g0:Game0;
      
      private var g1:Game1;
      
      private var g2:Game2;
      
      private var g3:Game3;
      
      private var g4:Game4;
      
      private var g5:Game5;
      
      private var g6:Game6;
      
      private var g7:Game7;
      
      private var g8:Game8;
      
      private var g9:Game9;
      
      private var g10:Game10;
      
      private var g11:Game11;
      
      private var g12:Game12;
      
      private var g13:Game13;
      
      private var g14:Game14;
      
      private var g15:Game15;
      
      private var g16:Game16;
      
      private var g17:Game17;
      
      private var g18:Game18;
      
      private var g19:Game19;
      
      private var paths:Shape;
      
      private var exitButton:Button;
      
      private var viewScoresButton:Button;
      
      private var ddButton:Button;
      
      private var systemScoreText:Array;
      
      private var systemPlayCountText:Array;
      
      private var grandScoreText:TextField;
      
      private var grandPlayCountText:TextField;
      
      private var submitScoreScreen:SubmitScoreScreen;
      
      public var popupLayer:Sprite;
      
      private var question:TextField;
      
      public function MissionSelection()
      {
         var mw:MissionWorld = null;
         this.systemScoreText = [];
         this.systemPlayCountText = [];
         super();
         addChild(backgroundBitmap);
         this.popupLayer = new Sprite();
         this.popupLayer.mouseEnabled = false;
         this.popupLayer.mouseChildren = false;
         this.paths = new Shape();
         addChild(this.paths);
         var i:int = 0;
         while(i < coords.length)
         {
            mw = new MissionWorld(this,i,coords[i][0],coords[i][1]);
            addChild(mw);
            mws.push(mw);
            i++;
         }
         this.question = Text.text("?",48,16777215);
         this.question.filters = [new GlowFilter(0,1,4,4)];
         addChild(this.question);
         this.question.visible = false;
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
      }
      
      public static function isGameLocked(param1:int) : Boolean
      {
         var _loc2_:* = null;
         if(param1 > 0)
         {
            _loc2_ = GameData.getStoryGameData(param1 - 1);
            if(_loc2_.highScore <= 0)
            {
               return true;
            }
         }
         return false;
      }
      
      private function onViewScoresClick(param1:Event) : void
      {
         var _loc2_:URLRequest = new URLRequest("http://knucklecracker.com/creeperworld/viewscores.php?missionGroup=story");
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
      
      private function drawPath(param1:int) : void
      {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         if(param1 >= -1)
         {
            return;
         }
         if(param1 >= 0 && param1 < 4)
         {
            _loc2_ = 16711680;
            _loc3_ = 4194304;
         }
         else if(param1 >= 5 && param1 < 9)
         {
            _loc2_ = 65280;
            _loc3_ = 16384;
         }
         else if(param1 >= 10 && param1 < 14)
         {
            _loc2_ = 255;
            _loc3_ = 64;
         }
         else if(param1 >= 15 && param1 < 19)
         {
            _loc2_ = 16776960;
            _loc3_ = 4210688;
         }
         else if(param1 >= 20 && param1 < 24)
         {
            _loc2_ = 65535;
            _loc3_ = 16448;
         }
         else if(param1 >= 25 && param1 < 29)
         {
            _loc2_ = 16711935;
            _loc3_ = 4194368;
         }
         else
         {
            _loc2_ = 7368816;
            _loc3_ = 2105376;
         }
         this.paths.graphics.lineStyle(3,_loc3_);
         this.paths.graphics.moveTo(coords[param1][0],coords[param1][1]);
         this.paths.graphics.lineTo(coords[param1 + 1][0],coords[param1 + 1][1]);
         this.paths.graphics.lineStyle(1,_loc2_);
         this.paths.graphics.moveTo(coords[param1][0],coords[param1][1]);
         this.paths.graphics.lineTo(coords[param1 + 1][0],coords[param1 + 1][1]);
      }
      
      public function reinit(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:Boolean = false;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:int = 0;
         var _loc11_:* = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         GameData.load();
         this.paths.graphics.clear();
         this.ddButton.visible = false;
         if((_loc8_ = GameData.getSpecialGameData(8)).highScore > 0)
         {
            if((_loc8_ = GameData.getSpecialGameData(9)).highScore > 0)
            {
               this.ddButton.visible = true;
               this.setDDButtonText();
            }
         }
         _loc2_ = 0;
         while(_loc2_ < mws.length)
         {
            (mws[_loc2_] as MissionWorld).highlighted = false;
            _loc2_++;
         }
         var _loc5_:* = [0,0,0,0,0,0];
         var _loc6_:* = [0,0,0,0,0,0];
         _loc2_ = 0;
         while(_loc2_ < mws.length)
         {
            _loc9_ = mws[_loc2_] as MissionWorld;
            _loc8_ = GameData.getStoryGameData(_loc2_);
            _loc9_.reinit(_loc8_);
            if(isGameLocked(_loc2_) && !_loc7_)
            {
               _loc7_ = true;
               (mws[_loc2_ - 1] as MissionWorld).highlighted = true;
            }
            if(_loc2_ == -1 && !_loc7_ && _loc8_.highScore <= 0)
            {
               (mws[_loc2_] as MissionWorld).highlighted = true;
            }
            if((_loc10_ = _loc2_ / 5) > 0)
            {
               if((_loc11_ = GameData.getStoryGameData(_loc10_ * 5 - 1)).highScore > 0)
               {
                  _loc9_.visible = true;
                  this.drawPath(_loc2_);
                  if(_loc10_ == 3)
                  {
                     this.question.visible = false;
                  }
                  else
                  {
                     this.question.x = coords[5 + _loc10_ * 5][0] - this.question.width / 2;
                     this.question.y = coords[5 + _loc10_ * 5][1] - this.question.height / 2;
                     this.question.visible = true;
                  }
               }
               else
               {
                  _loc9_.visible = false;
               }
            }
            else
            {
               this.drawPath(_loc2_);
               this.question.x = coords[5][0] - this.question.width / 2;
               this.question.y = coords[5][1] - this.question.height / 2;
               this.question.visible = true;
            }
            _loc5_[_loc10_] += _loc8_.highScore;
            _loc6_[_loc10_] += _loc8_.playCount;
            _loc3_ += _loc8_.highScore;
            _loc4_ += _loc8_.playCount;
            _loc2_++;
         }
         this.grandScoreText.text = String(_loc3_);
         this.grandScoreText.x = GRANDSCORE_WIDTH / 2 - this.grandScoreText.width / 2;
         this.grandPlayCountText.text = "#Plays: " + String(_loc4_);
         if(param1 >= 0)
         {
            _loc12_ = GameData.getStoryGameData(param1).lastScore;
            _loc13_ = GameData.getStoryGameData(param1).playCount;
            this.submitScoreScreen.show(true,false,_loc3_,_loc4_,_loc12_,_loc13_,param1);
         }
      }
   }
}
