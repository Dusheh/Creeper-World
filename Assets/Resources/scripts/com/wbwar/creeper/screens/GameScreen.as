package com.wbwar.creeper.screens
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.games.CustomGame;
   import com.wbwar.creeper.games.Game;
   import com.wbwar.creeper.games.GameData;
   import com.wbwar.creeper.games.RandomGame;
   import com.wbwar.creeper.util.Text;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.system.System;
   import flash.text.TextField;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   
   public class GameScreen extends Sprite
   {
       
      
      private var loadingGameScreen:Sprite;
      
      private var mainMusic:Sound;
      
      private var mainMusicSC:SoundChannel;
      
      private var creditsMusic:Sound;
      
      private var creditsMusicSC:SoundChannel;
      
      public var gameMusicPlaying:Boolean;
      
      private var gameMusicCurrentTrack:int;
      
      private var gameMusicStartTrack:int;
      
      private var gameMusicFinishTrack:int;
      
      private var gameMusicSC:SoundChannel;
      
      private var gameMusic:Array;
      
      private var _gameMusicVolume:Number = 0.5;
      
      private var mainMenu:MainMenu;
      
      private var credits:Credits;
      
      private var missionSelection:MissionSelection;
      
      private var freeplayMissionSelection:FreeplayMissionSelection;
      
      private var specialMissionSelection:SpecialMissionSelection;
      
      private var unchartedMissionSelection:UnchartedMissionSelection;
      
      private var customMissionSelection:CustomMissionSelection;
      
      private var achievementsScreen:AchievementsScreen;
      
      private var gameSpace:GameSpace;
      
      private var resultsScreen:ResultsScreen;
      
      private var t:Timer;
      
      private var launchGameData:Object;
      
      public function GameScreen()
      {
         super();
         this.gameMusic = [];
         this.mainMusic = new MusicArcadia();
         this.creditsMusic = new MusicAfricanAfternoon();
         this.gameMusic[0] = new MusicBigMojo();
         this.gameMusic[1] = new MusicBloodRitual();
         this.gameMusic[2] = new MusicOgzTheme();
         this.gameMusic[3] = new MusicKillingMachines();
         this.gameMusic[4] = new MusicTakeFlight();
         this.gameMusic[5] = new MusicDeadlyTalk();
         this.gameMusic[6] = this.gameMusic[3];
         this.gameMusic[7] = new MusicAfterTheBattle();
         this.mainMenu = new MainMenu();
         addChild(this.mainMenu);
         this.credits = new Credits();
         addChild(this.credits);
         this.missionSelection = new MissionSelection();
         addChild(this.missionSelection);
         this.freeplayMissionSelection = new FreeplayMissionSelection();
         addChild(this.freeplayMissionSelection);
         this.specialMissionSelection = new SpecialMissionSelection();
         addChild(this.specialMissionSelection);
         this.unchartedMissionSelection = new UnchartedMissionSelection();
         addChild(this.unchartedMissionSelection);
         this.customMissionSelection = new CustomMissionSelection();
         addChild(this.customMissionSelection);
         this.achievementsScreen = new AchievementsScreen();
         addChild(this.achievementsScreen);
         this.resultsScreen = new ResultsScreen();
         addChild(this.resultsScreen);
         this.showMainMenu();
         this.loadingGameScreen = new Sprite();
         this.loadingGameScreen.graphics.beginFill(0);
         this.loadingGameScreen.graphics.drawRect(0,0,700,525);
         this.loadingGameScreen.graphics.endFill();
         this.loadingGameScreen.visible = false;
         var _loc1_:TextField = Text.text("Loading Mission...",24,0);
         _loc1_.filters = [new GlowFilter(16777215,1,4,4,3)];
         this.loadingGameScreen.addChild(_loc1_);
         _loc1_.x = 350 - _loc1_.width / 2;
         _loc1_.y = 200;
         GameData.load();
         this.gameMusicVolume = GameData.musicVolume;
      }
      
      public function set gameMusicVolume(param1:Number) : void
      {
         var _loc2_:* = null;
         this._gameMusicVolume = param1;
         if(this.gameMusicSC != null)
         {
            _loc2_ = new SoundTransform();
            _loc2_.volume = this.gameMusicVolume;
            this.gameMusicSC.soundTransform = _loc2_;
         }
      }
      
      public function get gameMusicVolume() : Number
      {
         return this._gameMusicVolume;
      }
      
      public function playGameMusic(param1:int, param2:int) : void
      {
         if(!this.gameMusicPlaying)
         {
            this.gameMusicPlaying = true;
            this.gameMusicStartTrack = param1;
            this.gameMusicFinishTrack = param2;
            if(this.gameMusicCurrentTrack < this.gameMusicStartTrack)
            {
               this.gameMusicCurrentTrack = this.gameMusicStartTrack;
            }
            else if(this.gameMusicCurrentTrack > this.gameMusicFinishTrack)
            {
               this.gameMusicCurrentTrack = this.gameMusicFinishTrack;
            }
            this.playTrack(this.gameMusicCurrentTrack);
         }
      }
      
      public function startGameMusic() : void
      {
         if(!this.gameMusicPlaying)
         {
            this.gameMusicPlaying = true;
            this.playTrack(this.gameMusicCurrentTrack);
         }
      }
      
      public function stopCreditsMusic() : void
      {
         if(this.creditsMusicSC != null)
         {
            this.creditsMusicSC.stop();
            this.creditsMusicSC = null;
         }
      }
      
      public function stopGameMusic() : void
      {
         if(this.gameMusicPlaying)
         {
            this.gameMusicPlaying = false;
            if(this.gameMusicSC != null)
            {
               this.gameMusicSC.stop();
            }
            ++this.gameMusicCurrentTrack;
            if(this.gameMusicCurrentTrack > this.gameMusicFinishTrack)
            {
               this.gameMusicCurrentTrack = this.gameMusicStartTrack;
            }
         }
      }
      
      public function toggleGameMusic() : void
      {
         if(this.gameMusicPlaying)
         {
            this.stopGameMusic();
         }
         else
         {
            this.startGameMusic();
         }
      }
      
      public function stopMainMusic() : void
      {
         if(this.mainMusicSC != null)
         {
            this.mainMusicSC.stop();
            this.mainMusicSC = null;
         }
      }
      
      public function startMainMusic() : void
      {
         if(this.mainMusicSC == null)
         {
            this.mainMusicSC = this.mainMusic.play(0,99999);
         }
      }
      
      private function playTrack(param1:int) : void
      {
         var _loc2_:* = null;
         this.gameMusicSC = (this.gameMusic[param1] as Sound).play();
         if(this.gameMusicSC != null)
         {
            this.gameMusicSC.addEventListener(Event.SOUND_COMPLETE,this.onGameMusicTrackComplete,false,0,true);
            _loc2_ = new SoundTransform();
            _loc2_.volume = this.gameMusicVolume;
            this.gameMusicSC.soundTransform = _loc2_;
         }
      }
      
      private function onGameMusicTrackComplete(param1:Event) : void
      {
         ++this.gameMusicCurrentTrack;
         if(this.gameMusicCurrentTrack > this.gameMusicFinishTrack)
         {
            this.gameMusicCurrentTrack = this.gameMusicStartTrack;
         }
         this.playTrack(this.gameMusicCurrentTrack);
      }
      
      public function showMainMenu() : void
      {
         System.gc();
         this.mainMenu.visible = true;
         this.credits.visible = false;
         this.missionSelection.visible = false;
         this.freeplayMissionSelection.visible = false;
         this.specialMissionSelection.visible = false;
         this.unchartedMissionSelection.visible = false;
         this.customMissionSelection.visible = false;
         this.achievementsScreen.visible = false;
         this.resultsScreen.visible = false;
         if(this.gameSpace != null)
         {
            this.gameSpace.finish();
            removeChild(this.gameSpace);
            this.gameSpace = null;
         }
         this.mainMenu.show();
         this.stopGameMusic();
         this.stopCreditsMusic();
         this.startMainMusic();
         if(false)
         {
            Creeper.setWindowTitleFunction("Creeper World");
         }
      }
      
      public function showCredits(param1:Event = null) : void
      {
         System.gc();
         this.mainMenu.visible = false;
         this.missionSelection.visible = false;
         this.freeplayMissionSelection.visible = false;
         this.specialMissionSelection.visible = false;
         this.unchartedMissionSelection.visible = false;
         this.customMissionSelection.visible = false;
         this.achievementsScreen.visible = false;
         this.resultsScreen.visible = false;
         if(this.gameSpace != null)
         {
            this.gameSpace.finish();
            removeChild(this.gameSpace);
            this.gameSpace = null;
         }
         this.stopGameMusic();
         this.stopCreditsMusic();
         this.stopMainMusic();
         if(this.creditsMusicSC == null)
         {
            this.creditsMusicSC = this.creditsMusic.play(0,99999);
         }
         this.credits.visible = true;
         if(false)
         {
            Creeper.setWindowTitleFunction("Creeper World: Credits");
         }
      }
      
      public function showMissionSelection(param1:int) : void
      {
         System.gc();
         this.mainMenu.visible = false;
         this.credits.visible = false;
         this.missionSelection.visible = true;
         this.missionSelection.reinit(param1);
         this.freeplayMissionSelection.visible = false;
         this.specialMissionSelection.visible = false;
         this.unchartedMissionSelection.visible = false;
         this.customMissionSelection.visible = false;
         this.achievementsScreen.visible = false;
         this.resultsScreen.visible = false;
         if(this.gameSpace != null)
         {
            this.gameSpace.finish();
            removeChild(this.gameSpace);
            this.gameSpace = null;
         }
         this.stopGameMusic();
         this.stopCreditsMusic();
         this.startMainMusic();
         if(false)
         {
            Creeper.setWindowTitleFunction("Creeper World: Mission Selection");
         }
      }
      
      public function showFreeplayMissionSelection(param1:int) : void
      {
         System.gc();
         this.mainMenu.visible = false;
         this.credits.visible = false;
         this.missionSelection.visible = false;
         this.specialMissionSelection.visible = false;
         this.unchartedMissionSelection.visible = false;
         this.customMissionSelection.visible = false;
         this.achievementsScreen.visible = false;
         this.freeplayMissionSelection.visible = true;
         this.freeplayMissionSelection.reinit(param1);
         this.resultsScreen.visible = false;
         if(this.gameSpace != null)
         {
            this.gameSpace.finish();
            removeChild(this.gameSpace);
            this.gameSpace = null;
         }
         this.stopGameMusic();
         this.stopCreditsMusic();
         this.startMainMusic();
         if(false)
         {
            Creeper.setWindowTitleFunction("Creeper World: Mission Selection");
         }
      }
      
      public function showSpecialMissionSelection(param1:int) : void
      {
         System.gc();
         this.mainMenu.visible = false;
         this.credits.visible = false;
         this.missionSelection.visible = false;
         this.specialMissionSelection.visible = true;
         this.specialMissionSelection.reinit(param1);
         this.unchartedMissionSelection.visible = false;
         this.customMissionSelection.visible = false;
         this.achievementsScreen.visible = false;
         this.freeplayMissionSelection.visible = false;
         this.resultsScreen.visible = false;
         if(this.gameSpace != null)
         {
            this.gameSpace.finish();
            removeChild(this.gameSpace);
            this.gameSpace = null;
         }
         this.stopGameMusic();
         this.stopCreditsMusic();
         this.startMainMusic();
         if(false)
         {
            Creeper.setWindowTitleFunction("Creeper World: Mission Selection");
         }
      }
      
      public function showUnchartedMissionSelection(param1:String, param2:int, param3:int, param4:String) : void
      {
         System.gc();
         this.mainMenu.visible = false;
         this.credits.visible = false;
         this.missionSelection.visible = false;
         this.specialMissionSelection.visible = false;
         this.unchartedMissionSelection.visible = true;
         this.unchartedMissionSelection.reinit(param1,param2,param3,param4);
         this.customMissionSelection.visible = false;
         this.achievementsScreen.visible = false;
         this.freeplayMissionSelection.visible = false;
         this.resultsScreen.visible = false;
         if(this.gameSpace != null)
         {
            this.gameSpace.finish();
            removeChild(this.gameSpace);
            this.gameSpace = null;
         }
         this.stopGameMusic();
         this.stopCreditsMusic();
         this.startMainMusic();
         if(false)
         {
            Creeper.setWindowTitleFunction("Creeper World: Mission Selection");
         }
      }
      
      public function showCustomMissionSelection() : void
      {
         this.showCustomMissionSelectionWithScore(null,null,0,0,null);
      }
      
      public function showCustomMissionSelectionWithScore(param1:String, param2:String, param3:int, param4:int, param5:String) : void
      {
         System.gc();
         this.mainMenu.visible = false;
         this.credits.visible = false;
         this.missionSelection.visible = false;
         this.specialMissionSelection.visible = false;
         this.unchartedMissionSelection.visible = false;
         this.customMissionSelection.visible = true;
         this.customMissionSelection.reinit(param1,param2,param3,param4,param5);
         this.achievementsScreen.visible = false;
         this.freeplayMissionSelection.visible = false;
         this.resultsScreen.visible = false;
         if(this.gameSpace != null)
         {
            this.gameSpace.finish();
            removeChild(this.gameSpace);
            this.gameSpace = null;
         }
         this.stopGameMusic();
         this.stopCreditsMusic();
         this.startMainMusic();
         if(false)
         {
            Creeper.setWindowTitleFunction("Creeper World: Mission Selection");
         }
      }
      
      public function showResultsScreen(param1:Boolean = false) : void
      {
         System.gc();
         this.mainMenu.visible = false;
         this.credits.visible = false;
         this.missionSelection.visible = false;
         this.freeplayMissionSelection.visible = false;
         this.specialMissionSelection.visible = false;
         this.unchartedMissionSelection.visible = false;
         this.customMissionSelection.visible = false;
         this.achievementsScreen.visible = false;
         this.resultsScreen.returnToGameMode = param1;
         if(param1)
         {
            if(this.gameSpace != null)
            {
               this.gameSpace.visible = false;
               this.gameSpace.paused = true;
            }
         }
         else
         {
            this.stopGameMusic();
            this.stopCreditsMusic();
            if(this.gameSpace != null)
            {
               this.gameSpace.finish();
               removeChild(this.gameSpace);
               this.gameSpace = null;
            }
         }
         this.resultsScreen.visible = true;
         if(false)
         {
            Creeper.setWindowTitleFunction("Creeper World: Results");
         }
      }
      
      public function showAchievementsScreen() : void
      {
         System.gc();
         this.mainMenu.visible = false;
         this.credits.visible = false;
         this.missionSelection.visible = false;
         this.freeplayMissionSelection.visible = false;
         this.specialMissionSelection.visible = false;
         this.unchartedMissionSelection.visible = false;
         this.customMissionSelection.visible = false;
         this.achievementsScreen.visible = true;
         this.achievementsScreen.refresh();
         this.resultsScreen.visible = false;
         if(this.gameSpace != null)
         {
            this.gameSpace.finish();
            removeChild(this.gameSpace);
            this.gameSpace = null;
         }
         this.stopGameMusic();
         this.stopCreditsMusic();
         this.startMainMusic();
         if(false)
         {
            Creeper.setWindowTitleFunction("Creeper World: Honors");
         }
      }
      
      public function showGame() : void
      {
         System.gc();
         this.mainMenu.visible = false;
         this.credits.visible = false;
         this.missionSelection.visible = false;
         this.freeplayMissionSelection.visible = false;
         this.specialMissionSelection.visible = false;
         this.unchartedMissionSelection.visible = false;
         this.customMissionSelection.visible = false;
         this.achievementsScreen.visible = false;
         this.resultsScreen.visible = false;
         if(this.gameSpace != null)
         {
            this.gameSpace.visible = true;
            this.gameSpace.paused = false;
            if(false)
            {
               Creeper.setWindowTitleFunction(this.gameSpace.gameTitle);
            }
         }
      }
      
      public function launchStoryGame(param1:int) : void
      {
         System.gc();
         var _loc2_:String = "com.wbwar.creeper.games::Game" + param1;
         var _loc3_:Object = getDefinitionByName(_loc2_);
         Creeper.instance.gameScreen.launchGame(new _loc3_(),true,false,false,false,false,param1);
      }
      
      public function launchConquestGame(param1:int) : void
      {
         System.gc();
         Creeper.instance.gameScreen.launchGame(new RandomGame(param1),false,true,false,false,false,param1);
      }
      
      public function launchSpecialGame(param1:int) : void
      {
         System.gc();
         var _loc2_:String = "com.wbwar.creeper.games::SpecialGame" + param1;
         var _loc3_:Object = getDefinitionByName(_loc2_);
         Creeper.instance.gameScreen.launchGame(new _loc3_(),false,false,true,false,false,param1);
      }
      
      public function launchCustomGame(param1:String) : void
      {
         var _loc2_:* = null;
         System.gc();
         if(param1 == null || param1 == "")
         {
            _loc2_ = new CustomGame();
            _loc2_.workingMap = true;
         }
         else
         {
            _loc2_ = new CustomGame(param1);
         }
         Creeper.instance.gameScreen.launchGame(_loc2_,false,false,false,false,true,-1);
      }
      
      public function launchUnchartedGame(param1:int, param2:String) : void
      {
         System.gc();
         var _loc3_:RandomGame = new RandomGame(100000000 + param1);
         _loc3_.gameTitle = param2;
         Creeper.instance.gameScreen.launchGame(_loc3_,false,false,false,true,false,param1);
      }
      
      public function launchGame(param1:Game, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean, param7:int) : void
      {
         var game:Game = param1;
         var storyGame:Boolean = param2;
         var conquestGame:Boolean = param3;
         var specialGame:Boolean = param4;
         var unchartedGame:Boolean = param5;
         var customGame:Boolean = param6;
         var gameNumber:int = param7;
         System.gc();
         if(this.mainMusicSC != null)
         {
            Tweener.addTween(this.mainMusicSC,{
               "time":1.5,
               "transition":"linear",
               "_sound_volume":0,
               "onComplete":function():void
               {
                  mainMusicSC.stop();
                  mainMusicSC = null;
               }
            });
         }
         this.mainMenu.visible = false;
         this.credits.visible = false;
         this.missionSelection.visible = false;
         this.freeplayMissionSelection.visible = false;
         this.specialMissionSelection.visible = false;
         this.unchartedMissionSelection.visible = false;
         this.customMissionSelection.visible = false;
         this.achievementsScreen.visible = false;
         this.resultsScreen.visible = false;
         if(this.gameSpace != null)
         {
            this.gameSpace.finish();
            removeChild(this.gameSpace);
            this.gameSpace = null;
         }
         this.launchGameData = {};
         this.launchGameData.game = game;
         this.launchGameData.storyGame = storyGame;
         this.launchGameData.conquestGame = conquestGame;
         this.launchGameData.specialGame = specialGame;
         this.launchGameData.unchartedGame = unchartedGame;
         this.launchGameData.customGame = customGame;
         this.launchGameData.gameNumber = gameNumber;
         addChild(this.loadingGameScreen);
         this.loadingGameScreen.visible = true;
         this.t = new Timer(50,1);
         this.t.addEventListener(TimerEvent.TIMER,this.onGameTimerStart,false,0,true);
         this.t.start();
      }
      
      private function onGameTimerStart(param1:TimerEvent = null) : void
      {
         System.gc();
         if(this.launchGameData.game.hasCustomBackground)
         {
            if(this.launchGameData.game.customBackground == null)
            {
               this.t = new Timer(50,1);
               this.t.addEventListener(TimerEvent.TIMER,this.onGameTimerStart,false,0,true);
               this.t.start();
               return;
            }
         }
         this.gameSpace = new GameSpace(this.launchGameData.game);
         this.gameSpace.storyGame = this.launchGameData.storyGame;
         this.gameSpace.conquestGame = this.launchGameData.conquestGame;
         this.gameSpace.specialGame = this.launchGameData.specialGame;
         this.gameSpace.unchartedGame = this.launchGameData.unchartedGame;
         this.gameSpace.customGame = this.launchGameData.customGame;
         this.gameSpace.gameNumber = this.launchGameData.gameNumber;
         addChild(this.gameSpace);
         this.gameSpace.loadGame(this.launchGameData.game);
         this.gameSpace.start();
         this.launchGameData.game.gameSpaceStarted();
         this.loadingGameScreen.visible = false;
         removeChild(this.loadingGameScreen);
      }
   }
}
