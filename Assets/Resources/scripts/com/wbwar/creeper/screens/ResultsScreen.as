package com.wbwar.creeper.screens
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.games.CustomGame;
   import com.wbwar.creeper.games.GameData;
   import com.wbwar.creeper.games.IndividualGameData;
   import com.wbwar.creeper.util.Button;
   import com.wbwar.creeper.util.GraphLegendButton;
   import com.wbwar.creeper.util.LineGraph;
   import com.wbwar.creeper.util.Text;
   import com.wbwar.creeper.util.Time;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class ResultsScreen extends Sprite
   {
      
      public static const WIDTH:int = 700;
      
      public static const HEIGHT:int = 525;
       
      
      private var graph:LineGraph;
      
      private var energyCollectedLegend:GraphLegendButton;
      
      private var energyUsedLegend:GraphLegendButton;
      
      private var creeperCoverageLegend:GraphLegendButton;
      
      private var creeperKilledLegend:GraphLegendButton;
      
      private var elapsedTimeText:TextField;
      
      private var elapsedTimeTitleText:TextField;
      
      private var scoreText:TextField;
      
      private var scoreTitleText:TextField;
      
      private var returnToGameButton:Button;
      
      private var continueButton:Button;
      
      private var resultAchievements:ResultAchievements;
      
      private var demoScreen:DemoScreen;
      
      private var gameTitle:TextField;
      
      private var cwVersion:TextField;
      
      private var lastScore:int;
      
      private var playCount:int;
      
      private var customTitle:String;
      
      private var unchartedTitle:String;
      
      private var _returnToGameMode:Boolean;
      
      public function ResultsScreen()
      {
         super();
         graphics.beginFill(12288);
         graphics.drawRect(0,0,WIDTH,HEIGHT);
         graphics.endFill();
         this.energyCollectedLegend = new GraphLegendButton("Energy Collected",65280);
         addChild(this.energyCollectedLegend);
         this.energyCollectedLegend.x = 20;
         this.energyCollectedLegend.y = 5;
         this.energyCollectedLegend.addEventListener(MouseEvent.CLICK,function():void
         {
            energyCollectedLegend.selected = true;
            renderGraph();
         });
         this.energyUsedLegend = new GraphLegendButton("Energy Used",16777215);
         addChild(this.energyUsedLegend);
         this.energyUsedLegend.x = this.energyCollectedLegend.x + this.energyCollectedLegend.width + 5;
         this.energyUsedLegend.y = 5;
         this.energyUsedLegend.addEventListener(MouseEvent.CLICK,function():void
         {
            energyUsedLegend.selected = true;
            renderGraph();
         });
         this.creeperCoverageLegend = new GraphLegendButton("Creeper Coverage",255);
         addChild(this.creeperCoverageLegend);
         this.creeperCoverageLegend.x = this.energyUsedLegend.x + this.energyUsedLegend.width + 5;
         this.creeperCoverageLegend.y = 5;
         this.creeperCoverageLegend.addEventListener(MouseEvent.CLICK,function():void
         {
            creeperCoverageLegend.selected = true;
            renderGraph();
         });
         this.creeperKilledLegend = new GraphLegendButton("Creeper Killed",16711680);
         addChild(this.creeperKilledLegend);
         this.creeperKilledLegend.x = this.creeperCoverageLegend.x + this.creeperCoverageLegend.width + 5;
         this.creeperKilledLegend.y = 5;
         this.creeperKilledLegend.addEventListener(MouseEvent.CLICK,function():void
         {
            creeperKilledLegend.selected = true;
            renderGraph();
         });
         this.graph = new LineGraph(690,400,[65280,16711680,255,16736511],2105408,null);
         addChild(this.graph);
         this.graph.x = 5;
         this.graph.y = 30;
         this.gameTitle = Text.text("",16,16777215);
         addChild(this.gameTitle);
         this.gameTitle.x = 5;
         this.gameTitle.y = 435;
         this.cwVersion = Text.text("Creeper World Ver: undefined",8,16777215);
         addChild(this.cwVersion);
         this.cwVersion.x = 5;
         this.cwVersion.y = 510;
         this.elapsedTimeTitleText = Text.text("Time: ",18,11579568);
         addChild(this.elapsedTimeTitleText);
         this.elapsedTimeText = Text.text("",18,16777215);
         addChild(this.elapsedTimeText);
         this.scoreTitleText = Text.text("Score: ",18,11579568);
         addChild(this.scoreTitleText);
         this.scoreText = Text.text("",22,9502608);
         addChild(this.scoreText);
         this.returnToGameButton = new Button("Return To Game",10,100,18,0,0,true,32768,-1);
         addChild(this.returnToGameButton);
         this.returnToGameButton.x = 350 - this.returnToGameButton.width / 2;
         this.returnToGameButton.y = 520 - this.returnToGameButton.height;
         this.returnToGameButton.addEventListener(MouseEvent.CLICK,this.onReturnToGameClick);
         this.returnToGameButton.visible = false;
         this.continueButton = new Button("Continue",10,100,18,0,0,true,32768,-1);
         addChild(this.continueButton);
         this.continueButton.x = 350 - this.continueButton.width / 2;
         this.continueButton.y = 520 - this.continueButton.height;
         this.continueButton.addEventListener(MouseEvent.CLICK,this.onContinueClick);
         this.resultAchievements = new ResultAchievements();
         addChild(this.resultAchievements);
         this.demoScreen = new DemoScreen();
         addChild(this.demoScreen);
         this.demoScreen.visible = false;
      }
      
      public static function formatNumber(param1:Number) : String
      {
         var _loc4_:* = null;
         var _loc2_:String = param1.toString();
         var _loc3_:String = "";
         while(_loc2_.length > 3)
         {
            _loc4_ = _loc2_.substr(-3);
            _loc2_ = _loc2_.substr(0,_loc2_.length - 3);
            _loc3_ = "," + _loc4_ + _loc3_;
         }
         if(_loc2_.length > 0)
         {
            _loc3_ = _loc2_ + _loc3_;
         }
         return _loc3_;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         if(param1)
         {
            this.update();
         }
      }
      
      public function set returnToGameMode(param1:Boolean) : void
      {
         this._returnToGameMode = param1;
         if(param1)
         {
            this.returnToGameButton.visible = true;
            this.continueButton.visible = false;
         }
         else
         {
            this.returnToGameButton.visible = false;
            this.continueButton.visible = true;
         }
      }
      
      public function get returnToGameMode() : Boolean
      {
         return this._returnToGameMode;
      }
      
      private function renderGraph() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:* = null;
         var _loc9_:* = null;
         if(false)
         {
            _loc1_ = GameSpace.instance.statsCreeperKilled;
            _loc2_ = GameSpace.instance.statsCreeperCoverage;
            _loc3_ = GameSpace.instance.statsEnergyCollected;
            _loc4_ = GameSpace.instance.statsEnergyUsed;
            _loc5_ = this.maxInArray(_loc3_);
            _loc6_ = this.maxInArray(_loc4_);
            _loc7_ = _loc5_ > _loc6_ ? Number(_loc5_) : Number(_loc6_);
            this.graph.yMax = _loc7_;
            _loc8_ = [];
            _loc9_ = [];
            if(this.energyCollectedLegend.selected)
            {
               _loc8_.push(65280);
               _loc9_.push(_loc3_);
            }
            if(this.energyUsedLegend.selected)
            {
               _loc8_.push(16777215);
               _loc9_.push(_loc4_);
            }
            if(this.creeperCoverageLegend.selected)
            {
               _loc8_.push(255);
               _loc9_.push(this.normalizeArray(_loc2_,_loc7_));
            }
            if(this.creeperKilledLegend.selected)
            {
               _loc8_.push(16711680);
               _loc9_.push(this.normalizeArray(_loc1_,_loc7_));
            }
            this.graph.lineColor = _loc8_;
            this.graph.data = _loc9_;
         }
      }
      
      private function update() : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:Boolean = false;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         this.demoScreen.visible = false;
         this.renderGraph();
         this.gameTitle.text = GameSpace.instance.gameTitle;
         var _loc1_:String = Time.getTimeString(GameSpace.instance.elapsedTime / 36);
         this.elapsedTimeText.text = _loc1_;
         this.elapsedTimeText.x = WIDTH / 2 - this.elapsedTimeText.width / 2;
         this.elapsedTimeText.y = 435;
         this.elapsedTimeTitleText.x = this.elapsedTimeText.x - this.elapsedTimeTitleText.width - 5;
         this.elapsedTimeTitleText.y = this.elapsedTimeText.y;
         var _loc2_:int = GameSpace.instance.calculateScore();
         if(GameSpace.instance.destroyedReason == GameSpace.DESTROYED_REASON_SHIP_DESTROYED)
         {
            this.scoreText.text = "ODIN CITY DESTROYED!";
            _loc3_ = false;
         }
         else if(GameSpace.instance.destroyedReason == GameSpace.DESTROYED_REASON_SURVIVALPOD_DESTROYED)
         {
            this.scoreText.text = "SURVIVAL POD DESTROYED!";
            _loc3_ = false;
         }
         else
         {
            this.scoreText.text = formatNumber(_loc2_);
            _loc3_ = true;
         }
         if(!_loc3_)
         {
            _loc2_ = 0;
         }
         this.scoreText.x = this.elapsedTimeText.x;
         this.scoreText.y = 460;
         this.scoreTitleText.x = this.scoreText.x - this.scoreTitleText.width - 5;
         this.scoreTitleText.y = this.scoreText.y + 4;
         if(!this._returnToGameMode && _loc3_)
         {
            if(!this.returnToGameMode)
            {
               _loc5_ = AchievementsScreen.getSnapshot();
            }
            GameData.load();
            if(GameSpace.instance.storyGame)
            {
               _loc4_ = GameData.getStoryGameData(GameSpace.instance.gameNumber);
            }
            else if(GameSpace.instance.conquestGame)
            {
               _loc4_ = GameData.getRandomGameData(GameSpace.instance.gameNumber);
            }
            else if(GameSpace.instance.specialGame)
            {
               _loc4_ = GameData.getSpecialGameData(GameSpace.instance.gameNumber);
            }
            else if(GameSpace.instance.unchartedGame)
            {
               _loc4_ = GameData.getUnchartedGameData(String(GameSpace.instance.gameNumber));
               this.unchartedTitle = GameSpace.instance.game.gameTitle;
            }
            else if(GameSpace.instance.customGame)
            {
               if(!(_loc6_ = GameSpace.instance.game as CustomGame).workingMap)
               {
                  _loc4_ = GameData.getCustomGameData(_loc6_.gameName);
                  this.customTitle = _loc6_.gameTitle;
               }
               else
               {
                  _loc4_ = null;
               }
            }
            else
            {
               _loc4_ = null;
            }
            if(_loc4_ != null)
            {
               ++_loc4_.playCount;
               _loc4_.lastScore = _loc2_;
               this.lastScore = _loc4_.lastScore;
               this.playCount = _loc4_.playCount;
               if(_loc2_ > _loc4_.highScore)
               {
                  _loc4_.scoreSubmitted = 0;
                  _loc4_.highScore = _loc2_;
                  _loc4_.minTime = GameSpace.instance.elapsedTime;
               }
               _loc7_ = new Date();
               _loc4_.lastPlayed = _loc7_.getTime();
               GameData.save();
            }
            if(!this.returnToGameMode)
            {
               _loc8_ = AchievementsScreen.getSnapshot();
               _loc11_ = 0;
               while(_loc11_ < 20)
               {
                  if(_loc8_.storyMissionComplete(_loc11_))
                  {
                     Creeper.unlockAchievementFunction("ACH_" + _loc11_);
                  }
                  _loc11_++;
               }
               _loc11_ = 0;
               while(_loc11_ < 5)
               {
                  if(_loc8_.conquestMissionComplete(_loc11_))
                  {
                     Creeper.unlockAchievementFunction("ACH_" + (21 + _loc11_));
                  }
                  _loc11_++;
               }
               _loc11_ = 0;
               while(_loc11_ < 10)
               {
                  if(_loc8_.specialMissionComplete(_loc11_))
                  {
                     Creeper.unlockAchievementFunction("ACH_" + (27 + _loc11_));
                  }
                  _loc11_++;
               }
               if(_loc8_.allStory)
               {
                  Creeper.unlockAchievementFunction("ACH_20");
               }
               if(_loc8_.allConquest)
               {
                  Creeper.unlockAchievementFunction("ACH_26");
               }
               if(_loc8_.allSpecial)
               {
                  Creeper.unlockAchievementFunction("ACH_37");
               }
               if(_loc8_.all)
               {
                  Creeper.unlockAchievementFunction("ACH_38");
               }
               this.resultAchievements.clearAchievements();
               if((_loc10_ = _loc5_.getConquestDifference(_loc8_)) >= 0)
               {
                  this.showAchievement(AchievementsBox.TYPE_CONQUEST,_loc10_);
                  _loc9_ = true;
               }
               if((_loc10_ = _loc5_.getStoryDifference(_loc8_)) >= 0)
               {
                  this.showAchievement(AchievementsBox.TYPE_STORY,_loc10_);
                  _loc9_ = true;
               }
               if((_loc10_ = _loc5_.getSpecialDifference(_loc8_)) >= 0)
               {
                  this.showAchievement(AchievementsBox.TYPE_SPECIAL,_loc10_);
                  _loc9_ = true;
               }
               if(!_loc5_.allConquest && _loc8_.allConquest)
               {
                  this.showAchievement(AchievementsBox.TYPE_ALLCONQUEST);
                  _loc9_ = true;
               }
               if(!_loc5_.allStory && _loc8_.allStory)
               {
                  this.showAchievement(AchievementsBox.TYPE_ALLSTORY);
                  _loc9_ = true;
               }
               if(!_loc5_.allSpecial && _loc8_.allSpecial)
               {
                  this.showAchievement(AchievementsBox.TYPE_ALLSPECIAL);
                  _loc9_ = true;
               }
               if(!_loc5_.all && _loc8_.all)
               {
                  this.showAchievement(AchievementsBox.TYPE_ALL);
                  _loc9_ = true;
               }
               if(_loc9_)
               {
                  this.resultAchievements.show();
               }
               if(false && GameSpace.instance.gameNumber == 4)
               {
                  this.demoScreen.visible = true;
               }
            }
         }
      }
      
      private function showAchievement(param1:String, param2:int = -1) : void
      {
         this.resultAchievements.setAchievement(param1,param2);
      }
      
      private function normalizeArray(param1:Array, param2:Number) : Array
      {
         var _loc3_:* = Number(this.maxInArray(param1));
         if(_loc3_ == 0)
         {
            _loc3_ = 1;
         }
         var _loc4_:Number = param2 / _loc3_;
         var _loc5_:Array = [param1.length];
         var _loc6_:int = 0;
         while(_loc6_ < param1.length)
         {
            _loc5_[_loc6_] = param1[_loc6_] * _loc4_;
            _loc6_++;
         }
         return _loc5_;
      }
      
      private function maxInArray(param1:Array) : Number
      {
         var _loc2_:int = 0;
         var _loc5_:Number = NaN;
         var _loc3_:int = param1.length;
         var _loc4_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if((_loc5_ = param1[_loc2_]) > _loc4_)
            {
               _loc4_ = Number(_loc5_);
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      private function onReturnToGameClick(param1:MouseEvent) : void
      {
         Creeper.instance.gameScreen.showGame();
      }
      
      private function onContinueClick(param1:MouseEvent) : void
      {
         if(true)
         {
            Creeper.instance.gameScreen.showMainMenu();
         }
         else if(GameSpace.instance.storyGame)
         {
            if(GameSpace.instance.destroyedReason != GameSpace.DESTROYED_REASON_NONE)
            {
               Creeper.instance.gameScreen.showMissionSelection(-1);
            }
            else
            {
               Creeper.instance.gameScreen.showMissionSelection(GameSpace.instance.gameNumber);
            }
         }
         else if(GameSpace.instance.conquestGame)
         {
            if(GameSpace.instance.destroyedReason != GameSpace.DESTROYED_REASON_NONE)
            {
               Creeper.instance.gameScreen.showFreeplayMissionSelection(-1);
            }
            else
            {
               Creeper.instance.gameScreen.showFreeplayMissionSelection(GameSpace.instance.gameNumber);
            }
         }
         else if(GameSpace.instance.specialGame)
         {
            if(GameSpace.instance.destroyedReason != GameSpace.DESTROYED_REASON_NONE)
            {
               Creeper.instance.gameScreen.showSpecialMissionSelection(-1);
            }
            else
            {
               Creeper.instance.gameScreen.showSpecialMissionSelection(GameSpace.instance.gameNumber);
            }
         }
         else if(GameSpace.instance.unchartedGame)
         {
            if(GameSpace.instance.destroyedReason != GameSpace.DESTROYED_REASON_NONE)
            {
               Creeper.instance.gameScreen.showUnchartedMissionSelection(null,0,0,null);
            }
            else
            {
               Creeper.instance.gameScreen.showUnchartedMissionSelection(String(GameSpace.instance.gameNumber),this.lastScore,this.playCount,this.unchartedTitle);
            }
         }
         else if(GameSpace.instance.customGame)
         {
            if((GameSpace.instance.game as CustomGame).workingMap)
            {
               Creeper.instance.gameScreen.showMainMenu();
            }
            else if(GameSpace.instance.destroyedReason != GameSpace.DESTROYED_REASON_NONE)
            {
               Creeper.instance.gameScreen.showCustomMissionSelection();
            }
            else
            {
               Creeper.instance.gameScreen.showCustomMissionSelectionWithScore((GameSpace.instance.game as CustomGame).gameName,(GameSpace.instance.game as CustomGame).hash,this.lastScore,this.playCount,this.customTitle);
            }
         }
      }
   }
}
