package
{
   import com.amanitadesign.steam.FRESteamWorks;
   import com.amanitadesign.steam.SteamEvent;
   import com.hurlant.crypto.hash.MD5;
   import com.hurlant.util.Hex;
   import com.wbwar.creeper.util.CustomGameSelector;
   import flash.desktop.NativeApplication;
   import flash.display.DisplayObject;
   import flash.display.NativeWindowDisplayState;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageDisplayState;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.InvokeEvent;
   import flash.events.MouseEvent;
   import flash.events.NativeWindowBoundsEvent;
   import flash.events.NativeWindowDisplayStateEvent;
   import flash.events.TimerEvent;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.net.FileFilter;
   import flash.system.Capabilities;
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.unescapeMultiByte;
   import mx.core.IFlexModuleFactory;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.styles.CSSCondition;
   import mx.styles.CSSSelector;
   import mx.styles.CSSStyleDeclaration;
   import spark.components.WindowedApplication;
   
   public class Launcher extends WindowedApplication
   {
      
      private static var efont:String = "Launcher_efont";
       
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public var debugText:TextField;
      
      public var Steamworks:FRESteamWorks;
      
      public var creeper:Creeper;
      
      private var background:Shape;
      
      private var infoPane:Sprite;
      
      private var shownPressEscape:Boolean;
      
      private var key:Key;
      
      private var t:Timer;
      
      private var importCB:Function;
      
      private var alphabet:Array;
      
      private var rightClickFunction:Function;
      
      mx_internal var _Launcher_StylesInit_done:Boolean = false;
      
      public function Launcher()
      {
         this.debugText = text("DEBUG",24,12632256);
         this.alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
         super();
         mx_internal::_document = this;
         this.showStatusBar = false;
         this.width = 100;
         this.height = 100;
         this.addEventListener("creationComplete",this.___Launcher_WindowedApplication1_creationComplete);
      }
      
      public static function saveKeyData(param1:String) : void
      {
         var f:File = null;
         var key:String = param1;
         var fs:FileStream = new FileStream();
         try
         {
            f = getDataStorageDirectory();
            f = f.resolvePath("keyData.dat");
            fs.open(f,FileMode.WRITE);
            fs.writeUTF(key);
         }
         catch(e:Error)
         {
         }
         finally
         {
            try
            {
               var _loc5_:* = §§pop();
               fs.close();
            }
            catch(e2:Error)
            {
            }
            switch(int(_loc5_))
            {
               case 0:
                  throw _loc4_;
               default:
                  return;
            }
         }
      }
      
      public static function loadKeyData() : String
      {
         var data:String = null;
         var f:File = null;
         var fs:FileStream = new FileStream();
         try
         {
            f = getDataStorageDirectory();
            f = f.resolvePath("keyData.dat");
            fs.open(f,FileMode.READ);
            data = fs.readUTF();
            var _loc2_:* = data;
         }
         catch(e:Error)
         {
            _loc2_ = e;
         }
         finally
         {
            try
            {
               var _loc4_:* = §§pop();
               fs.close();
            }
            catch(e2:Error)
            {
            }
            switch(int(_loc4_))
            {
               case 0:
                  return _loc2_;
               case 1:
                  throw _loc3_;
               default:
                  return null;
            }
         }
      }
      
      public static function getDataStorageDirectory() : File
      {
         var _loc1_:File = File.applicationStorageDirectory;
         var _loc2_:* = _loc1_.nativePath.toString() + "/../../CreeperWorld";
         var _loc3_:File = new File(_loc2_);
         if(!_loc3_.exists)
         {
            _loc3_.createDirectory();
         }
         return _loc3_;
      }
      
      public static function getCustomGameDirectory() : File
      {
         var _loc1_:File = File.applicationStorageDirectory;
         var _loc2_:* = _loc1_.nativePath.toString() + "/../../CreeperWorld/customgames";
         var _loc3_:File = new File(_loc2_);
         if(!_loc3_.exists)
         {
            _loc3_.createDirectory();
         }
         return _loc3_;
      }
      
      public static function getApplicationDirectory() : File
      {
         var _loc1_:File = File.applicationDirectory;
         var _loc2_:String = _loc1_.nativePath.toString();
         return new File(_loc2_);
      }
      
      public static function text(param1:String, param2:uint, param3:uint, param4:String = "left") : TextField
      {
         var _loc6_:* = null;
         var _loc5_:TextField;
         (_loc5_ = new TextField()).mouseEnabled = false;
         _loc6_ = new TextFormat();
         if(param2 <= 8)
         {
            _loc6_.font = "befontsmall";
         }
         else
         {
            _loc6_.font = "befont";
         }
         _loc6_.color = param3;
         _loc6_.size = param2;
         _loc5_.embedFonts = true;
         if(param2 <= 8)
         {
            _loc5_.antiAliasType = AntiAliasType.NORMAL;
         }
         else
         {
            _loc5_.antiAliasType = AntiAliasType.ADVANCED;
         }
         if(param2 <= 8)
         {
            _loc5_.sharpness = 400;
         }
         else if(param2 <= 14)
         {
            _loc5_.sharpness = 200;
         }
         _loc5_.defaultTextFormat = _loc6_;
         _loc5_.autoSize = param4;
         _loc5_.selectable = false;
         _loc5_.mouseEnabled = false;
         if(param1 != null)
         {
            _loc5_.text = param1;
         }
         return _loc5_;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         mx_internal::_Launcher_StylesInit();
      }
      
      override public function initialize() : void
      {
         super.initialize();
      }
      
      public function RestartAppIfNecessary(param1:uint) : void
      {
         if(!param1)
         {
            NativeApplication.nativeApplication.exit(1);
         }
         if(this.Steamworks.restartAppIfNecessary(param1))
         {
            NativeApplication.nativeApplication.exit(0);
         }
      }
      
      private function OnComplete() : void
      {
         this.SetupSteam(null);
         this.RestartAppIfNecessary(422910);
         this.CreateGame();
      }
      
      private function onValidKey(param1:Event = null) : void
      {
         saveKeyData(this.key.key);
         this.CreateGame();
      }
      
      private function CreateGame() : void
      {
         this.background = new Shape();
         this.background.graphics.beginFill(0);
         this.background.graphics.drawRect(0,0,700,525);
         this.background.graphics.endFill();
         nativeWindow.stage.addChild(this.background);
         this.SetBestSize();
         this.loadState();
         nativeWindow.title = "Creeper World";
         this.creeper = new Creeper();
         nativeWindow.stage.addChild(this.creeper);
         this.infoPane = new Sprite();
         this.infoPane.mouseEnabled = false;
         this.infoPane.mouseChildren = false;
         var _loc1_:TextField = text("Press ESC to exit full screen mode",24,16777215);
         _loc1_.filters = [new GlowFilter(0,1,16,16,10)];
         this.infoPane.addChild(_loc1_);
         _loc1_.x = 350 - _loc1_.width / 2;
         _loc1_.y = 200;
         this.scale();
         Creeper.airMode = true;
         Creeper.version = "0800";
         Creeper.loadGameDataFunction = this.loadGameData;
         Creeper.saveGameDataFunction = this.saveGameData;
         Creeper.optimalWindowSizeFunction = this.setOptimalWindowSize;
         Creeper.exitGameFunction = this.exitGame;
         Creeper.saveScreenshotFunction = this.saveScreenshot;
         Creeper.hasWorkingCustomGameFunction = this.hasWorkingCustomGame;
         Creeper.loadCustomGameFunction = this.loadCustomGame;
         Creeper.getCustomGameUIDFunction = this.getCustomGameUID;
         Creeper.getCustomGamesFunction = this.getCustomGames;
         Creeper.importCustomGameFunction = this.importCustomGame;
         Creeper.deleteCustomGameFunction = this.deleteCustomGame;
         Creeper.setWindowTitleFunction = this.setWindowTitle;
         Creeper.setupRightClickFunction = this.setupRightClick;
         Creeper.unlockAchievementFunction = this.unlockAchievement;
         nativeWindow.addEventListener(Event.CLOSING,this.onNativeWindowClosing);
         nativeWindow.addEventListener(Event.CLOSE,this.onNativeWindowClose);
         nativeWindow.addEventListener(Event.ACTIVATE,this.onNativeWindowActivate);
         nativeWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE,this.onNativeWindowDisplayStateChange);
         nativeWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING,this.onNativeWindowDisplayStateChanging);
         nativeWindow.addEventListener(NativeWindowBoundsEvent.RESIZING,this.onNativeWindowResizing);
         nativeWindow.addEventListener(NativeWindowBoundsEvent.RESIZE,this.onNativeWindowResize);
         nativeWindow.stage.scaleMode = StageScaleMode.NO_SCALE;
         nativeWindow.stage.align = StageAlign.TOP_LEFT;
         nativeWindow.stage.frameRate = 36;
         this.creeper.startGame();
      }
      
      public function SetupSteam(param1:InvokeEvent) : void
      {
         this.Steamworks = new FRESteamWorks();
         this.debugText.text = "onInvoke";
         this.Steamworks.addEventListener(SteamEvent.STEAM_RESPONSE,this.onSteamResponse);
         this.Steamworks.addOverlayWorkaround(nativeWindow.stage,true);
         if(!this.Steamworks.init())
         {
            this.debugText.text = "STEAMWORKS API is NOT available";
            return;
         }
         var _loc2_:String = this.Steamworks.getUserID();
         var _loc3_:uint = this.Steamworks.getAppID();
         this.debugText.text = _loc2_ + " " + _loc3_;
      }
      
      private function onSteamResponse(param1:SteamEvent) : void
      {
         this.debugText.text = "onSteamResponse " + param1.response;
      }
      
      private function scale() : void
      {
         this.background.width = nativeWindow.stage.stageWidth;
         this.background.height = nativeWindow.stage.stageHeight;
         var _loc1_:Number = nativeWindow.stage.stageWidth / 700;
         var _loc2_:Number = nativeWindow.stage.stageHeight / 525;
         if(nativeWindow.stage.stageWidth / nativeWindow.stage.stageHeight > 1.3333333333333333)
         {
            this.creeper.scaleX = _loc2_;
            this.creeper.scaleY = _loc2_;
            this.creeper.x = nativeWindow.stage.stageWidth / 2 - 700 * this.creeper.scaleX / 2;
            this.creeper.y = 0;
         }
         else
         {
            this.creeper.scaleX = _loc1_;
            this.creeper.scaleY = _loc1_;
            this.creeper.x = 0;
            this.creeper.y = nativeWindow.stage.stageHeight / 2 - 525 * this.creeper.scaleY / 2;
         }
         this.infoPane.scaleX = this.creeper.scaleX;
         this.infoPane.scaleY = this.creeper.scaleY;
         this.infoPane.x = this.creeper.x;
         this.infoPane.y = this.creeper.y;
      }
      
      private function onShowPressEscapeComplete(param1:Event = null) : void
      {
         nativeWindow.stage.removeChild(this.infoPane);
      }
      
      private function jumpToFull() : void
      {
         nativeWindow.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
         if(!this.shownPressEscape)
         {
            this.shownPressEscape = true;
            nativeWindow.stage.addChild(this.infoPane);
            this.t = new Timer(2000,1);
            this.t.addEventListener(TimerEvent.TIMER,this.onShowPressEscapeComplete);
            this.t.start();
         }
      }
      
      public function SetBestSize() : void
      {
         if(nativeWindow.stage.fullScreenWidth > 1024)
         {
            nativeWindow.stage.stageWidth = 1024;
            nativeWindow.stage.stageHeight = 768;
         }
         else
         {
            nativeWindow.stage.stageWidth = 800;
            nativeWindow.stage.stageHeight = 600;
         }
      }
      
      public function setOptimalWindowSize(param1:int) : void
      {
         nativeWindow.stage.displayState = StageDisplayState.NORMAL;
         if(param1 == 3)
         {
            nativeWindow.stage.stageWidth = 1600;
            nativeWindow.stage.stageHeight = 1200;
         }
         else if(param1 == 2)
         {
            nativeWindow.stage.stageWidth = 1440;
            nativeWindow.stage.stageHeight = 1080;
         }
         else if(param1 == 1)
         {
            nativeWindow.stage.stageWidth = 1024;
            nativeWindow.stage.stageHeight = 768;
         }
         else
         {
            nativeWindow.stage.stageWidth = 800;
            nativeWindow.stage.stageHeight = 600;
         }
      }
      
      public function saveGameData(param1:String) : void
      {
         var f:File = null;
         var data:String = param1;
         var fs:FileStream = new FileStream();
         try
         {
            f = getDataStorageDirectory();
            f = f.resolvePath("gameData.dat");
            fs.open(f,FileMode.WRITE);
            if(data.length < 60000)
            {
               fs.writeUTF(data);
            }
            else
            {
               fs.writeShort(0);
               fs.writeUTFBytes(data);
            }
         }
         catch(e:Error)
         {
         }
         finally
         {
            try
            {
               var _loc5_:* = §§pop();
               fs.close();
            }
            catch(e2:Error)
            {
            }
            switch(int(_loc5_))
            {
               case 0:
                  throw _loc4_;
               default:
                  return;
            }
         }
      }
      
      public function loadGameData() : String
      {
         var data:String = null;
         var f:File = null;
         var prefix:int = 0;
         var fs:FileStream = new FileStream();
         try
         {
            f = getDataStorageDirectory();
            f = f.resolvePath("gameData.dat");
            fs.open(f,FileMode.READ);
            prefix = fs.readUnsignedShort();
            if(prefix == 0)
            {
               fs.position = 2;
               data = fs.readUTFBytes(fs.bytesAvailable);
            }
            else
            {
               fs.position = 0;
               data = fs.readUTF();
            }
            var _loc2_:* = data;
         }
         catch(e:Error)
         {
            _loc2_ = e;
         }
         finally
         {
            try
            {
               var _loc4_:* = §§pop();
               fs.close();
            }
            catch(e2:Error)
            {
            }
            switch(int(_loc4_))
            {
               case 0:
                  return _loc2_;
               case 1:
                  throw _loc3_;
               default:
                  return null;
            }
         }
      }
      
      public function hasWorkingCustomGame() : Boolean
      {
         var _loc1_:* = null;
         _loc1_ = getDataStorageDirectory();
         _loc1_ = _loc1_.resolvePath("workingmap.cwm");
         return _loc1_.exists;
      }
      
      public function getCustomGameUID(param1:String = null) : String
      {
         var data:String = null;
         var f:File = null;
         var fileData:ByteArray = null;
         var m:MD5 = null;
         var h:ByteArray = null;
         var fi:String = null;
         var gameName:String = param1;
         var fs:FileStream = new FileStream();
         try
         {
            if(gameName == null)
            {
               f = getDataStorageDirectory();
               f = f.resolvePath("workingmap.cwm");
            }
            else
            {
               f = getCustomGameDirectory();
               f = f.resolvePath(gameName);
            }
            fs.open(f,FileMode.READ);
            fileData = new ByteArray();
            fs.readBytes(fileData);
            m = new MD5();
            h = m.hash(fileData);
            fi = Hex.fromArray(h);
            var _loc3_:* = fi;
         }
         catch(e:Error)
         {
            _loc3_ = e;
         }
         finally
         {
            try
            {
               var _loc5_:* = §§pop();
               fs.close();
            }
            catch(e2:Error)
            {
            }
            switch(int(_loc5_))
            {
               case 0:
                  return _loc3_;
               case 1:
                  throw _loc4_;
               default:
                  return null;
            }
         }
      }
      
      public function loadCustomGame(param1:String = null) : XML
      {
         var data:String = null;
         var f:File = null;
         var compressedData:ByteArray = null;
         var gameName:String = param1;
         var fs:FileStream = new FileStream();
         try
         {
            if(gameName == null)
            {
               f = getDataStorageDirectory();
               f = f.resolvePath("workingmap.cwm");
            }
            else
            {
               f = getCustomGameDirectory();
               f = f.resolvePath(gameName);
            }
            fs.open(f,FileMode.READ);
            compressedData = new ByteArray();
            fs.readBytes(compressedData);
            compressedData.uncompress();
            data = compressedData.readUTFBytes(compressedData.bytesAvailable);
            var _loc3_:* = new XML(data);
         }
         catch(e:Error)
         {
            _loc3_ = e;
         }
         finally
         {
            try
            {
               var _loc5_:* = §§pop();
               fs.close();
            }
            catch(e2:Error)
            {
            }
            switch(int(_loc5_))
            {
               case 0:
                  return _loc3_;
               case 1:
                  throw _loc4_;
               default:
                  return null;
            }
         }
      }
      
      public function getCustomGames() : Array
      {
         var f:File = null;
         var cgs:CustomGameSelector = null;
         var stream:FileStream = null;
         var compressedData:ByteArray = null;
         var data:String = null;
         var d:XML = null;
         var title:String = null;
         var cgd:File = getCustomGameDirectory();
         var files:Array = cgd.getDirectoryListing();
         var r:Array = [];
         var i:int = 0;
         for each(f in files)
         {
            if(!f.isDirectory)
            {
               try
               {
                  stream = new FileStream();
                  stream.open(f,FileMode.READ);
                  compressedData = new ByteArray();
                  stream.readBytes(compressedData);
                  compressedData.uncompress();
                  data = compressedData.readUTFBytes(compressedData.bytesAvailable);
                  stream.close();
                  d = new XML(data);
                  title = unescapeMultiByte(d.title);
                  r.push(new CustomGameSelector(f.name,title,f.creationDate));
               }
               catch(e:Error)
               {
               }
            }
         }
         r.sort(function(param1:CustomGameSelector, param2:CustomGameSelector):int
         {
            return param1.creationDate.getTime() > param2.creationDate.getTime() ? 1 : -1;
         });
         i = 0;
         for each(cgs in r)
         {
            cgs.number = ++i;
         }
         return r;
      }
      
      public function deleteCustomGame(param1:String = null) : void
      {
         var f:File = null;
         var gameName:String = param1;
         try
         {
            if(gameName == null)
            {
               f = getDataStorageDirectory();
               f = f.resolvePath("workingmap.cwm");
            }
            else
            {
               f = getCustomGameDirectory();
               f = f.resolvePath(gameName);
            }
            f.deleteFile();
         }
         catch(e:Error)
         {
         }
      }
      
      public function setWindowTitle(param1:String) : void
      {
         nativeWindow.title = param1;
      }
      
      public function importCustomGame(param1:Function = null) : void
      {
         this.importCB = param1;
         var _loc2_:File = new File();
         _loc2_.addEventListener(Event.SELECT,this.onCustomGameFileLoad);
         _loc2_.browseForOpen("Open",[new FileFilter("CWM","*.cwm")]);
      }
      
      private function onCustomGameFileLoad(param1:Event) : void
      {
         var _loc2_:File = getCustomGameDirectory();
         var _loc3_:File = param1.target as File;
         _loc3_.copyTo(this.getCustomGameFile());
         if(this.importCB != null)
         {
            this.importCB();
         }
      }
      
      private function getCustomGameFile() : File
      {
         var _loc1_:File = getCustomGameDirectory();
         var _loc2_:* = "";
         var _loc3_:int = 0;
         while(_loc3_ < 8)
         {
            _loc2_ += this.alphabet[int(Math.random() * 26)];
            _loc3_++;
         }
         _loc2_ += ".cwm";
         return new File(_loc1_.nativePath.toString() + "/" + _loc2_);
      }
      
      public function unlockAchievement(param1:String) : void
      {
         if(!this.Steamworks.isReady)
         {
            return;
         }
         this.Steamworks.setAchievement(param1);
      }
      
      public function setupRightClick(param1:DisplayObject, param2:Function) : void
      {
         this.rightClickFunction = param2;
         param1.addEventListener(MouseEvent.RIGHT_CLICK,this.rightClick);
      }
      
      private function rightClick(param1:MouseEvent) : void
      {
         if(param1.type == MouseEvent.RIGHT_CLICK)
         {
            this.rightClickFunction();
         }
      }
      
      public function saveScreenshot(param1:ByteArray) : void
      {
         var _loc2_:File = File.documentsDirectory.resolvePath("creeperworld_screens");
         _loc2_.createDirectory();
         var _loc3_:Array = _loc2_.getDirectoryListing();
         var _loc4_:* = this.getNextScreenNumber(_loc3_) + ".jpg";
         var _loc5_:File = File.documentsDirectory.resolvePath("creeperworld_screens/" + _loc4_);
         var _loc6_:FileStream;
         (_loc6_ = new FileStream()).open(_loc5_,FileMode.WRITE);
         _loc6_.writeBytes(param1);
         _loc6_.close();
      }
      
      private function getNextScreenNumber(param1:Array) : int
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc4_:int = 0;
         for each(_loc5_ in param1)
         {
            _loc2_ = _loc5_.name.split(".");
            _loc3_ = int(_loc2_[0]);
            if(_loc3_ > _loc4_)
            {
               _loc4_ = _loc3_;
            }
         }
         return _loc4_ + 1;
      }
      
      public function exitGame() : void
      {
         this.saveState();
         this.onNativeWindowClose();
      }
      
      private function saveState() : void
      {
         var f:File = null;
         var windowState:Object = {};
         if(true)
         {
            windowState.windowDisplayState = NativeWindowDisplayState.NORMAL;
            windowState.windowBounds = new Rectangle(10,10,-1,-1);
         }
         else
         {
            windowState.windowDisplayState = nativeWindow.displayState;
            windowState.windowBounds = nativeWindow.bounds;
         }
         var fs:FileStream = new FileStream();
         try
         {
            f = getDataStorageDirectory();
            f = f.resolvePath("gameState.dat");
            fs.open(f,FileMode.WRITE);
            fs.writeObject(windowState);
         }
         catch(e:Error)
         {
         }
         finally
         {
            try
            {
               var _loc4_:* = §§pop();
               fs.close();
            }
            catch(e2:Error)
            {
            }
            switch(int(_loc4_))
            {
               case 0:
                  throw _loc3_;
               default:
                  return;
            }
         }
      }
      
      private function loadState() : void
      {
         var data:Object = null;
         var windowState:Object = null;
         var fs:FileStream = null;
         var b:Object = null;
         var f:File = null;
         var wx:int = 0;
         var wy:int = 0;
         try
         {
            fs = new FileStream();
            try
            {
               f = getDataStorageDirectory();
               f = f.resolvePath("gameState.dat");
               fs.open(f,FileMode.READ);
               windowState = fs.readObject();
            }
            catch(e:Error)
            {
            }
            finally
            {
               try
               {
                  var _loc4_:* = §§pop();
                  fs.close();
               }
               catch(e2:Error)
               {
               }
               switch(int(_loc4_))
               {
                  case 0:
                     throw _loc3_;
                  default:
                     if(windowState == null)
                     {
                        return;
                     }
                     b = windowState.windowBounds;
                     if(b != null)
                     {
                        wx = b.x;
                        wy = b.y;
                        if(wx < 0)
                        {
                           wx = 0;
                        }
                        if(wy < 0)
                        {
                           wy = 0;
                        }
                        if(wx > -200)
                        {
                           wx = -205;
                        }
                        if(wy > -200)
                        {
                           wy = -205;
                        }
                        nativeWindow.x = wx;
                        nativeWindow.y = wy;
                        if(windowState.windowDisplayState == NativeWindowDisplayState.MAXIMIZED)
                        {
                           nativeWindow.maximize();
                           this.jumpToFull();
                        }
                        else
                        {
                           if(b.width > 0)
                           {
                              nativeWindow.width = b.width;
                           }
                           if(b.height > 0)
                           {
                              nativeWindow.height = b.height;
                           }
                        }
                     }
               }
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function onNativeWindowDisplayStateChanging(param1:NativeWindowDisplayStateEvent) : void
      {
         if(param1.afterDisplayState == "maximized")
         {
            param1.stopImmediatePropagation();
            this.jumpToFull();
         }
      }
      
      private function onNativeWindowDisplayStateChange(param1:NativeWindowDisplayStateEvent) : void
      {
      }
      
      private function onNativeWindowActivate(param1:Event) : void
      {
      }
      
      private function onNativeWindowClosing(param1:Event) : void
      {
         this.saveState();
      }
      
      private function onNativeWindowClose(param1:Event = null) : void
      {
         NativeApplication.nativeApplication.exit();
      }
      
      private function onNativeWindowResize(param1:NativeWindowBoundsEvent) : void
      {
         this.scale();
      }
      
      private function onNativeWindowResizing(param1:NativeWindowBoundsEvent) : void
      {
         this.scale();
      }
      
      public function ___Launcher_WindowedApplication1_creationComplete(param1:FlexEvent) : void
      {
         this.OnComplete();
      }
      
      mx_internal function _Launcher_StylesInit() : void
      {
         if(mx_internal::_Launcher_StylesInit_done)
         {
            return;
         }
         mx_internal::_Launcher_StylesInit_done = true;
         styleManager.initProtoChainRoots();
      }
   }
}
