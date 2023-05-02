package
{
   import caurina.transitions.properties.DisplayShortcuts;
   import caurina.transitions.properties.FilterShortcuts;
   import caurina.transitions.properties.SoundShortcuts;
   import com.wbwar.creeper.screens.GameScreen;
   import com.wbwar.creeper.screens.SplashScreen;
   import com.wbwar.creeper.util.RC4;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   
   public class Creeper extends Sprite
   {
      
      public static const MACGAMESTORE:Boolean = false;
      
      public static const DEMO:Boolean = false;
      
      private static var efont:String = "Creeper_efont";
      
      private static var efontsmall:String = "Creeper_efontsmall";
      
      public static var instance:Creeper;
      
      public static var airMode:Boolean;
      
      public static var saveGameDataFunction:Function;
      
      public static var loadGameDataFunction:Function;
      
      public static var optimalWindowSizeFunction:Function;
      
      public static var exitGameFunction:Function;
      
      public static var saveScreenshotFunction:Function;
      
      public static var hasWorkingCustomGameFunction:Function;
      
      public static var loadCustomGameFunction:Function;
      
      public static var getCustomGameUIDFunction:Function;
      
      public static var getCustomGamesFunction:Function;
      
      public static var importCustomGameFunction:Function;
      
      public static var deleteCustomGameFunction:Function;
      
      public static var setWindowTitleFunction:Function;
      
      public static var setupRightClickFunction:Function;
      
      public static var unlockAchievementFunction:Function;
      
      public static var doubleDownMode:Boolean;
      
      public static var version:String;
       
      
      public var gameScreen:GameScreen;
      
      public function Creeper()
      {
         super();
         tabEnabled = false;
         tabChildren = false;
         instance = this;
         FilterShortcuts.init();
         SoundShortcuts.init();
         DisplayShortcuts.init();
      }
      
      public function init() : void
      {
         this.onAddedToStage(null);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this.stage.scaleMode = StageScaleMode.NO_SCALE;
         this.stage.align = StageAlign.TOP_LEFT;
         var _loc2_:String = this.root.loaderInfo.url;
         var _loc3_:Array = _loc2_.split("://");
         var _loc4_:Array;
         var _loc5_:String = (_loc4_ = (_loc3_[1] as String).split("/"))[0];
         var _loc6_:int = this.root.loaderInfo.url.indexOf(RC4.decrypt("10de949754c17fedc8997488b3cf","spaceestate11"));
         var _loc7_:int = _loc5_.indexOf(RC4.decrypt("419f8591498259fcdf9d6786a4924fc86266","spaceestate11"));
         if(_loc6_ >= 0 || _loc7_ >= 0)
         {
            this.startGame();
         }
      }
      
      public function startGame() : void
      {
         var _loc1_:SplashScreen = new SplashScreen();
         addChild(_loc1_);
         _loc1_.show();
      }
      
      public function startActualGame() : void
      {
         this.gameScreen = new GameScreen();
         addChild(this.gameScreen);
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(0);
         _loc1_.graphics.drawRect(0,0,300,1125);
         _loc1_.graphics.endFill();
         addChild(_loc1_);
         _loc1_.x = -300;
         _loc1_.y = -300;
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.beginFill(0);
         _loc2_.graphics.drawRect(0,0,300,1125);
         _loc2_.graphics.endFill();
         addChild(_loc2_);
         _loc2_.x = 700;
         _loc2_.y = -300;
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.beginFill(0);
         _loc3_.graphics.drawRect(0,0,700,300);
         _loc3_.graphics.endFill();
         addChild(_loc3_);
         _loc3_.y = -300;
         var _loc4_:Shape;
         (_loc4_ = new Shape()).graphics.beginFill(0);
         _loc4_.graphics.drawRect(0,0,700,300);
         _loc4_.graphics.endFill();
         addChild(_loc4_);
         _loc4_.y = 525;
      }
   }
}
