package com.wbwar.creeper
{
   import caurina.transitions.Tweener;
   import com.adobe.images.JPGEncoder;
   import com.wbwar.creeper.controlpanel.ControlPanel;
   import com.wbwar.creeper.dialogs.ExitDialog;
   import com.wbwar.creeper.dialogs.HelpDialog;
   import com.wbwar.creeper.dialogs.SettingsDialog;
   import com.wbwar.creeper.dialogs.UpgradesDialog;
   import com.wbwar.creeper.games.CustomGame;
   import com.wbwar.creeper.games.Game;
   import com.wbwar.creeper.games.GameData;
   import com.wbwar.creeper.games.RandomGame;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.utils.ByteArray;
   
   public final class GameSpace extends Sprite
   {
      
      public static const DESTROYED_REASON_NONE:int = 0;
      
      public static const DESTROYED_REASON_SHIP_DESTROYED:int = 1;
      
      public static const DESTROYED_REASON_SURVIVALPOD_DESTROYED:int = 2;
      
      public static var EVENT_GUN:String = "EVENT_GUN";
      
      public static const TOTALENERGY_LEVELS:Array = [0,2000,6000,14000,30000];
      
      public static var HEIGHT:int = 48;
      
      public static var WIDTH:int = 70;
      
      public static var CELL_WIDTH:int = 10;
      
      public static var CELL_HEIGHT:int = 10;
      
      public static var SCALE:int = 2;
      
      public static var CELL_WIDTH_S:int = CELL_WIDTH * SCALE;
      
      public static var CELL_HEIGHT_S:int = CELL_HEIGHT * SCALE;
      
      public static var instance:GameSpace;
       
      
      public var speedUp:Boolean = false;
      
      public var suppressCityExit:Boolean;
      
      public var normalTime:int = 3600;
      
      public var storyGame:Boolean;
      
      public var conquestGame:Boolean;
      
      public var specialGame:Boolean;
      
      public var unchartedGame:Boolean;
      
      public var customGame:Boolean;
      
      public var gameNumber:int;
      
      public var statsEnergyCollected:Array;
      
      public var statsEnergyUsed:Array;
      
      public var statsCreeperCoverage:Array;
      
      public var statsCreeperKilled:Array;
      
      private var lastTotalEnergyCollected:int = 0;
      
      private var lastEnergyConsumed:Number = 0;
      
      private var lastCreeperKilled:Number = 0;
      
      public var destroyedReason:int;
      
      public var currentUnitCount:int = 0;
      
      public var stashMax:Number = 100;
      
      public var energyPacketSpeed:Number = 2;
      
      public var totalEnergyCollected:Number = 0;
      
      public var energyConsumed:Number = 0;
      
      public var creeperKilled:Number = 0;
      
      public var creeperCoverage:Number = 0;
      
      public var energyQueueLength:int;
      
      public var upgradeEconomic0:Boolean;
      
      public var upgradeEconomic1:Boolean;
      
      public var upgradeEconomic2:Boolean;
      
      public var upgradeWeapon0:Boolean;
      
      public var upgradeWeapon1:Boolean;
      
      public var upgradeWeapon2:Boolean;
      
      private var _points:int;
      
      public var stash:Number;
      
      public var paused:Boolean;
      
      public var updateCount:int;
      
      public var elapsedTime:int;
      
      public var game:Game;
      
      private var controlFrame:Sprite;
      
      public var controlPanel:ControlPanel;
      
      public var gameArea:Sprite;
      
      public var dynamicContent:DynamicContent;
      
      public var dynamicContentUpper:DynamicContentUpper;
      
      public var terrain:Terrain;
      
      public var energyGrid:EnergyGrid;
      
      public var energyPackets:EnergyPackets;
      
      public var walls:Walls;
      
      public var glop:Glop;
      
      public var places:Places;
      
      public var landedDronesLayer:Sprite;
      
      public var upperPlacesLayer:Sprite;
      
      public var placesClickLayer:Sprite;
      
      public var glopProducerLayer:Sprite;
      
      public var projectiles:Projectiles;
      
      public var airWeapons:AirWeapons;
      
      public var paths:Paths;
      
      public var mistLayer:MistLayer;
      
      public var exhaustLayer:ExhaustLayer;
      
      public var moveLayer:Sprite;
      
      public var tutorialLayer:Sprite;
      
      private var glopProducers:Array;
      
      public var glopBlobProducer:GlopBlobProducer;
      
      public var hideGlopBlobWaveViewer:Boolean;
      
      public var upgradesDialog:UpgradesDialog;
      
      public var settingsDialog:SettingsDialog;
      
      public var exitDialog:ExitDialog;
      
      public var gameTitle:String;
      
      public var rift:Rift;
      
      private var guns:Array;
      
      public var baseGun:BaseGun;
      
      private var _musicMute:Boolean;
      
      private var _mute:Boolean;
      
      public var backgroundSound:Sound;
      
      public var backgroundSoundChannel:SoundChannel;
      
      public var gameDisabled:Boolean;
      
      public function GameSpace(param1:Game)
      {
         this.statsEnergyCollected = [];
         this.statsEnergyUsed = [];
         this.statsCreeperCoverage = [];
         this.statsCreeperKilled = [];
         this.stash = this.stashMax;
         this.glopProducers = [];
         this.guns = [];
         super();
         this.game = param1;
         this.gameTitle = param1.gameTitle;
         if(false)
         {
            Creeper.setWindowTitleFunction(this.gameTitle);
         }
         if(param1 is CustomGame)
         {
            MistLayer.setupCustom((param1 as CustomGame).creeperMistColor1,(param1 as CustomGame).creeperMistColor2);
         }
         else
         {
            MistLayer.setup();
         }
         Gun.setNormalRange();
         AreaGun.setNormalRange();
         ABM.setNormalRange();
         this.init();
      }
      
      public function set points(param1:int) : void
      {
         this._points = param1;
         if(this.controlPanel != null)
         {
            this.controlPanel.pointViewer.points = param1;
         }
      }
      
      public function get points() : int
      {
         return this._points;
      }
      
      public function set musicMute(param1:Boolean) : void
      {
         this._musicMute = param1;
      }
      
      public function get musicMute() : Boolean
      {
         return this._musicMute;
      }
      
      public function set mute(param1:Boolean) : void
      {
         var _loc2_:* = null;
         this._mute = param1;
         if(param1 > 0)
         {
            _loc2_ = new SoundTransform();
            _loc2_.volume = 0;
            SoundMixer.soundTransform = _loc2_;
         }
         else
         {
            _loc2_ = new SoundTransform();
            _loc2_.volume = 1;
            SoundMixer.soundTransform = _loc2_;
         }
      }
      
      public function get mute() : Boolean
      {
         return this._mute;
      }
      
      public function init() : void
      {
         instance = this;
         this.gameArea = new Sprite();
         this.gameArea.mouseEnabled = false;
         addChild(this.gameArea);
         this.gameArea.y = 0;
         this.walls = new Walls();
         this.terrain = new Terrain();
         this.glop = new Glop();
         this.energyGrid = new EnergyGrid();
         this.energyPackets = new EnergyPackets();
         this.placesClickLayer = new Sprite();
         this.placesClickLayer.graphics.beginFill(0,0);
         this.placesClickLayer.graphics.drawRect(0,0,WIDTH * CELL_WIDTH,HEIGHT * CELL_HEIGHT);
         this.placesClickLayer.graphics.endFill();
         this.placesClickLayer.visible = false;
         this.glopProducerLayer = new Sprite();
         this.glopProducerLayer.mouseEnabled = false;
         this.glopProducerLayer.mouseChildren = false;
         this.places = new Places(this);
         this.landedDronesLayer = new Sprite();
         this.landedDronesLayer.mouseEnabled = false;
         this.upperPlacesLayer = new Sprite();
         this.upperPlacesLayer.mouseEnabled = false;
         this.projectiles = new Projectiles();
         this.airWeapons = new AirWeapons();
         this.paths = new Paths();
         this.dynamicContent = new DynamicContent();
         this.dynamicContentUpper = new DynamicContentUpper();
         this.mistLayer = new MistLayer();
         this.exhaustLayer = new ExhaustLayer();
         this.moveLayer = new Sprite();
         this.moveLayer.mouseEnabled = false;
         this.moveLayer.mouseChildren = false;
         this.upgradesDialog = new UpgradesDialog();
         this.upgradesDialog.x = CELL_WIDTH * WIDTH / 2 - 0;
         this.upgradesDialog.y = CELL_HEIGHT * HEIGHT / 2 - 0;
         this.settingsDialog = new SettingsDialog();
         this.settingsDialog.x = CELL_WIDTH * WIDTH / 2 - 0;
         this.settingsDialog.y = CELL_HEIGHT * HEIGHT / 2 - 0;
         this.settingsDialog.addEventListener(SettingsDialog.DISMISS_CLICKED,this.onSettingsDismissClicked);
         this.exitDialog = new ExitDialog();
         this.exitDialog.x = CELL_WIDTH * WIDTH / 2 - 0;
         this.exitDialog.y = CELL_HEIGHT * HEIGHT / 2 - 0;
         this.exitDialog.addEventListener(ExitDialog.NO_CLICKED,this.onExitNoClicked);
         this.exitDialog.addEventListener(ExitDialog.YES_CLICKED,this.onExitYesClicked);
         this.exitDialog.addEventListener(ExitDialog.RESTART_CLICKED,this.onExitRestartClicked);
         HelpDialog.instance.addEventListener(HelpDialog.DISMISS_CLICKED,this.onHelpDismissed,false,0,true);
         this.tutorialLayer = new Sprite();
         this.tutorialLayer.mouseEnabled = false;
         this.controlFrame = new Sprite();
         this.controlFrame.mouseEnabled = false;
         this.controlPanel = new ControlPanel();
         this.gameArea.addChild(this.dynamicContent);
         this.gameArea.addChild(this.glopProducerLayer);
         this.gameArea.addChild(this.paths);
         this.gameArea.addChild(this.places);
         this.gameArea.addChild(this.landedDronesLayer);
         this.gameArea.addChild(this.energyPackets);
         this.gameArea.addChild(this.projectiles);
         this.gameArea.addChild(this.upperPlacesLayer);
         this.gameArea.addChild(this.placesClickLayer);
         if(false)
         {
            this.gameArea.addChild(this.dynamicContentUpper);
         }
         this.gameArea.addChild(this.airWeapons);
         this.gameArea.addChild(this.moveLayer);
         addChild(this.upgradesDialog);
         addChild(this.controlFrame);
         addChild(this.controlPanel);
         this.controlPanel.y = 480;
         addChild(this.tutorialLayer);
         addChild(this.settingsDialog);
         addChild(this.exitDialog);
         if(SoundMixer.soundTransform.volume == 0)
         {
            this.mute = true;
         }
      }
      
      private function onHelpDismissed(param1:Event) : void
      {
         this.paused = false;
      }
      
      public function takeSnapshot() : void
      {
         var _loc1_:BitmapData = new BitmapData(700,525,false,0);
         _loc1_.draw(this);
         var _loc2_:JPGEncoder = new JPGEncoder(100);
         var _loc3_:ByteArray = _loc2_.encode(_loc1_);
         if(false)
         {
            Creeper.saveScreenshotFunction(_loc3_);
         }
      }
      
      public function showSettingsDialog() : void
      {
         this.paused = true;
         this.settingsDialog.show();
      }
      
      private function onSettingsDismissClicked(param1:Event = null) : void
      {
         this.paused = false;
      }
      
      public function showExitDialog() : void
      {
         this.paused = true;
         this.exitDialog.visible = true;
      }
      
      private function onExitYesClicked(param1:Event = null) : void
      {
         if(this.storyGame)
         {
            Creeper.instance.gameScreen.showMissionSelection(-1);
         }
         else if(this.conquestGame)
         {
            Creeper.instance.gameScreen.showFreeplayMissionSelection(-1);
         }
         else if(this.specialGame)
         {
            Creeper.instance.gameScreen.showSpecialMissionSelection(-1);
         }
         else if(this.unchartedGame)
         {
            Creeper.instance.gameScreen.showUnchartedMissionSelection(null,0,0,null);
         }
         else if(this.customGame)
         {
            if((this.game as CustomGame).workingMap)
            {
               Creeper.instance.gameScreen.showMainMenu();
            }
            else
            {
               Creeper.instance.gameScreen.showCustomMissionSelection();
            }
         }
         else
         {
            Creeper.instance.gameScreen.showMainMenu();
         }
      }
      
      private function onExitNoClicked(param1:Event = null) : void
      {
         this.paused = false;
      }
      
      private function onExitRestartClicked(param1:Event = null) : void
      {
         if(this.storyGame)
         {
            Creeper.instance.gameScreen.launchStoryGame(this.gameNumber);
         }
         else if(this.conquestGame)
         {
            Creeper.instance.gameScreen.launchConquestGame(this.gameNumber);
         }
         else if(this.specialGame)
         {
            Creeper.instance.gameScreen.launchSpecialGame(this.gameNumber);
         }
         else if(this.unchartedGame)
         {
            Creeper.instance.gameScreen.launchUnchartedGame(this.gameNumber,(this.game as RandomGame).gameTitle);
         }
         else if(this.customGame)
         {
            Creeper.instance.gameScreen.launchCustomGame((this.game as CustomGame).gameName);
         }
      }
      
      public function start() : void
      {
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         addEventListener(MouseEvent.CLICK,this.onMouseClick,false,0,true);
      }
      
      public function finish() : void
      {
         var _loc1_:* = null;
         this.controlPanel.finish();
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         removeEventListener(MouseEvent.CLICK,this.onMouseClick);
         if(this.backgroundSoundChannel != null)
         {
            this.backgroundSoundChannel.stop();
            this.backgroundSoundChannel = null;
         }
         Tweener.removeAllTweens();
         var _loc2_:int = this.upperPlacesLayer.numChildren - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = this.upperPlacesLayer.getChildAt(_loc2_) as Place;
            if(_loc1_ is ThorsHammer)
            {
               if((_loc1_ as ThorsHammer).engineSoundChannel != null)
               {
                  (_loc1_ as ThorsHammer).engineSoundChannel.stop();
               }
            }
            _loc2_--;
         }
         if(this.rift != null)
         {
            if(this.rift.riftOpenSoundChannel != null)
            {
               this.rift.riftOpenSoundChannel.stop();
            }
            if(this.rift.activatingSoundChannel != null)
            {
               this.rift.activatingSoundChannel.stop();
            }
         }
      }
      
      public function calculateScore() : int
      {
         var _loc1_:Number = this.normalTime / (this.elapsedTime / 36 + this.normalTime);
         return int(int(10000 * _loc1_));
      }
      
      public function addGlopProducer(param1:GlopProducer) : void
      {
         this.glopProducers.push(param1);
         this.glopProducerLayer.addChild(param1);
      }
      
      public function addGun(param1:Weapon, param2:int) : void
      {
         this.guns[param2] = param1;
         dispatchEvent(new Event(EVENT_GUN));
      }
      
      public function removeGun(param1:int) : void
      {
         this.guns[param1] = null;
         dispatchEvent(new Event(EVENT_GUN));
      }
      
      public function getGun(param1:int) : Weapon
      {
         return this.guns[param1];
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
      }
      
      private function update() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(this.updateCount == 5)
         {
            _loc3_ = this.places.placesLayer.numChildren - 1;
            while(_loc3_ >= 0)
            {
               _loc2_ = this.places.placesLayer.getChildAt(_loc3_) as Place;
               if(_loc2_ is UpgradeBox)
               {
                  this.controlPanel.pointViewer.visible = true;
                  break;
               }
               _loc3_--;
            }
         }
         if(this.updateCount % 640 == 0)
         {
            this.statsEnergyCollected.push((this.totalEnergyCollected - this.lastTotalEnergyCollected) / 50);
            this.lastTotalEnergyCollected = this.totalEnergyCollected;
            this.statsEnergyUsed.push((this.energyConsumed - this.lastEnergyConsumed) / 50);
            this.lastEnergyConsumed = this.energyConsumed;
            this.statsCreeperCoverage.push(this.creeperCoverage);
            this.statsCreeperKilled.push(this.creeperKilled - this.lastCreeperKilled);
            this.lastCreeperKilled = this.creeperKilled;
         }
         ++this.updateCount;
         if(this.rift.state != Rift.STATE_ACTIVATED)
         {
            ++this.elapsedTime;
         }
         if(this.game != null)
         {
            this.game.update();
         }
         if(this.updateCount % 32 == 0)
         {
            this.controlPanel.update();
         }
         for each(_loc1_ in this.glopProducers)
         {
            _loc1_.update();
         }
         if(this.glopBlobProducer != null)
         {
            this.glopBlobProducer.update();
         }
         this.glop.update();
         this.energyPackets.update();
         this.walls.update();
         this.dynamicContent.update();
         this.dynamicContentUpper.update();
         this.places.update();
         this.projectiles.update();
         this.airWeapons.update();
         this.paths.update();
         this.dynamicContentUpper.update();
         if(this.stash > this.stashMax)
         {
            this.stash = this.stashMax;
         }
      }
      
      public function loadGame(param1:Game) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         this.game = param1;
         this.terrain.background = param1.getBackground();
         this.terrain.customBackground = param1.customBackground;
         this.terrain.edgeSize = param1.getEdgeSize();
         this.terrain.tints[1] = param1.getTint1();
         this.terrain.tints[2] = param1.getTint2();
         this.terrain.tints[3] = param1.getTint3();
         this.terrain.tints[4] = param1.getTint4();
         this.terrain.tints[5] = param1.getTint5();
         this.walls.setData(param1.getWallData());
         this.walls.update();
         this.terrain.setData(param1.getTerrainHeight());
         this.terrain.update();
         this.glop.setData(this.terrain.terrainHeight,this.walls.wallData);
         for each(_loc2_ in param1.xml.specialplaces.elements())
         {
            _loc3_ = Place.create(_loc2_);
            if(_loc3_ is BaseGun)
            {
               this.baseGun = _loc3_ as BaseGun;
            }
            else if(_loc3_ is Rift)
            {
               this.rift = _loc3_ as Rift;
               this.upperPlacesLayer.addChild(this.rift);
            }
            else
            {
               this.places.addPlace(_loc3_);
            }
         }
         for each(_loc2_ in param1.xml.places.elements())
         {
            _loc3_ = Place.create(_loc2_);
            this.places.addPlace(_loc3_);
         }
      }
      
      public function startGame() : void
      {
         this.paused = false;
      }
      
      public function pauseGame() : void
      {
         this.paused = true;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(!this.paused && !this.gameDisabled)
         {
            this.update();
            if(this.speedUp)
            {
               this.update();
            }
         }
      }
   }
}
