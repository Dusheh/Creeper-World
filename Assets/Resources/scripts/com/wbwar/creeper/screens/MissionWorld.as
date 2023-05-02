package com.wbwar.creeper.screens
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.Terrain;
   import com.wbwar.creeper.games.Game;
   import com.wbwar.creeper.games.IndividualGameData;
   import com.wbwar.creeper.util.Random;
   import com.wbwar.creeper.util.Text;
   import com.wbwar.creeper.util.Time;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BitmapDataChannel;
   import flash.display.GradientType;
   import flash.display.Shape;
   import flash.display.SpreadMethod;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.media.Sound;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   
   public class MissionWorld extends Sprite
   {
      
      private static const seeds:Array = [100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,115,117,118,119,120,121,122,123,124,125,126,127,128,129];
       
      
      public var gameNumber:int;
      
      private var seed:int;
      
      public var random:Random;
      
      private var miniMap:Bitmap;
      
      private var popup:Sprite;
      
      private var scoreTitle:TextField;
      
      private var scoreTextField:TextField;
      
      private var timeTextField:TextField;
      
      private var playCountText:TextField;
      
      public var title:TextField;
      
      private var world:Sprite;
      
      private var planet:Shape;
      
      private var clouds:Shape;
      
      private var glare:Shape;
      
      private var highlightShape:Shape;
      
      private var _locked:Boolean;
      
      private var _highlighted:Boolean;
      
      public function MissionWorld(param1:MissionSelection, param2:int, param3:int, param4:int)
      {
         super();
         this.x = param3;
         this.y = param4;
         this.gameNumber = param2;
         this.seed = seeds[param2];
         this.random = new Random(this.seed > 0 ? uint(this.seed) : uint(1));
         buttonMode = true;
         useHandCursor = true;
         this.init();
         this.world.filters = [new DropShadowFilter(2),new GlowFilter(16777215,1,16,16)];
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.highlightShape = new Shape();
         addChild(this.highlightShape);
         this.highlightShape.visible = false;
         this.highlightShape.graphics.lineStyle(2,16777215);
         this.highlightShape.graphics.moveTo(2,-15);
         this.highlightShape.graphics.curveTo(13,-13,15,-2);
         this.highlightShape.graphics.moveTo(15,2);
         this.highlightShape.graphics.curveTo(13,13,2,15);
         this.highlightShape.graphics.moveTo(-2,-15);
         this.highlightShape.graphics.curveTo(-13,-13,-15,-2);
         this.highlightShape.graphics.moveTo(-15,2);
         this.highlightShape.graphics.curveTo(-13,13,-2,15);
         this.highlightShape.filters = [new GlowFilter(16711680,1,4,4)];
         this.popup = new Sprite();
         this.popup.filters = [new DropShadowFilter()];
         this.popup.mouseEnabled = false;
         this.popup.mouseChildren = false;
         this.popup.visible = false;
         this.popup.alpha = 0;
         param1.popupLayer.addChild(this.popup);
         this.popup.x = param3 - 35;
         this.popup.y = param4 + 20;
         this.scoreTitle = Text.text("Score: ",10,16777215);
         this.scoreTitle.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         this.popup.addChild(this.scoreTitle);
         this.scoreTitle.y = 0;
         this.scoreTextField = Text.text("",10,16777215);
         this.scoreTextField.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         this.popup.addChild(this.scoreTextField);
         this.scoreTextField.x = this.scoreTitle.x + this.scoreTitle.width - 2;
         this.scoreTextField.y = 0;
         this.timeTextField = Text.text("",8,16777215);
         this.timeTextField.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         this.popup.addChild(this.timeTextField);
         this.timeTextField.x = this.scoreTitle.x + this.scoreTitle.width - 2;
         this.timeTextField.y = 10;
         this.playCountText = Text.text("",8,16777215);
         this.playCountText.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         this.popup.addChild(this.playCountText);
         this.playCountText.y = 34;
         addEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
      
      public function set locked(param1:Boolean) : void
      {
         this._locked = param1;
         buttonMode = !param1;
         useHandCursor = !param1;
         if(param1)
         {
            alpha = 0.3;
         }
         else
         {
            alpha = 1;
         }
      }
      
      public function get locked() : Boolean
      {
         return this._locked;
      }
      
      public function set highlighted(param1:Boolean) : void
      {
         this._highlighted = param1;
         this.highlightShape.visible = param1;
         if(param1)
         {
            this.highlightShape.addEventListener(Event.ENTER_FRAME,this.onHighlightTween,false,0,true);
         }
         else
         {
            this.highlightShape.removeEventListener(Event.ENTER_FRAME,this.onHighlightTween);
         }
      }
      
      public function get highlighted() : Boolean
      {
         return this._highlighted;
      }
      
      public function reinit(param1:IndividualGameData) : void
      {
         this.scoreTextField.text = String(param1.highScore);
         this.timeTextField.text = "(" + Time.getTimeString(param1.minTime / 36) + ")";
         this.playCountText.text = "# Plays: " + String(param1.playCount);
         this.locked = MissionSelection.isGameLocked(param1.gameNumber);
      }
      
      private function onHighlightTween(param1:Event) : void
      {
         this.highlightShape.rotation += 3;
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(!this._locked)
         {
            try
            {
               _loc2_ = new ClickSound();
               _loc2_.play();
               Creeper.instance.gameScreen.launchStoryGame(this.gameNumber);
            }
            catch(e:Error)
            {
            }
         }
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         if(!this._locked)
         {
            Tweener.addTween(this.world,{
               "time":1,
               "width":30,
               "height":30
            });
            if(this.miniMap == null)
            {
               this.createMiniMap();
            }
            if(this.miniMap != null)
            {
               Tweener.addTween(this.popup,{
                  "time":1,
                  "_autoAlpha":1
               });
            }
         }
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         if(!this._locked)
         {
            Tweener.addTween(this.world,{
               "time":1,
               "width":20,
               "height":20
            });
            if(this.miniMap != null)
            {
               Tweener.addTween(this.popup,{
                  "time":1,
                  "_autoAlpha":0
               });
            }
         }
      }
      
      private function createMiniMap() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc1_:String = "com.wbwar.creeper.games::Game" + this.gameNumber;
         try
         {
            _loc2_ = getDefinitionByName(_loc1_);
            this.miniMap = new Bitmap(new BitmapData(0,0,false));
            this.miniMap.width = 70;
            this.miniMap.height = 48;
            _loc3_ = new Terrain();
            _loc4_ = new _loc2_();
            _loc3_.background = int(_loc4_.getBackground());
            _loc3_.setData(_loc4_.getTerrainHeight());
            _loc3_.update();
            (_loc5_ = new Matrix()).scale(0.1,0.1);
            this.miniMap.bitmapData.draw(_loc3_,_loc5_);
            this.popup.addChild(this.miniMap);
            this.popup.addChild(this.scoreTitle);
            this.popup.addChild(this.scoreTextField);
            this.popup.addChild(this.timeTextField);
            this.popup.addChild(this.playCountText);
         }
         catch(e:Error)
         {
         }
      }
      
      private function init() : void
      {
         var gc:Object = null;
         graphics.beginFill(0,0);
         graphics.drawCircle(0,0,17);
         var gname:String = "com.wbwar.creeper.games::Game" + this.gameNumber;
         try
         {
            gc = getDefinitionByName(gname);
            this.title = Text.text(gc["title"],9,16777215);
         }
         catch(e:Error)
         {
            title = Text.text("???",9,16777215);
         }
         this.title.filters = [new DropShadowFilter(1)];
         addChild(this.title);
         this.title.x = -this.title.width / 2;
         this.title.y = -30;
         this.world = new Sprite();
         addChild(this.world);
         this.planet = new Shape();
         this.planet.cacheAsBitmap = true;
         this.world.addChild(this.planet);
         this.clouds = new Shape();
         this.clouds.cacheAsBitmap = true;
         this.world.addChild(this.clouds);
         this.glare = new Shape();
         this.glare.cacheAsBitmap = true;
         this.world.addChild(this.glare);
         var bitmap:BitmapData = new BitmapData(200,200,true,0);
         var baseX:int = 120;
         var baseY:int = 80;
         var octaves:int = 3;
         var gseed:int = Math.floor(this.random.random() * 10000);
         var stitch:Boolean = false;
         var fractal:Boolean = false;
         var channels:int = 0;
         var grayScale:Boolean = false;
         var point1:Point = new Point(0,0);
         var point2:Point = new Point(0,0);
         var offset:Array = [point1,point2];
         bitmap.perlinNoise(baseX,baseY,octaves,gseed,stitch,fractal,channels,grayScale,offset);
         var c:ColorTransform = new ColorTransform();
         c.redOffset = this.random.random() * 255;
         c.blueOffset = this.random.random() * 25;
         bitmap.colorTransform(bitmap.rect,c);
         var oceanColor:Number = -16777216 | this.random.random() * 100 << 16 | this.random.random() * 150 << 8 | 255;
         var t:Number = this.random.random() * 50 + 50 << 8;
         bitmap.threshold(bitmap,bitmap.rect,new Point(),"<",t,oceanColor,65280,true);
         var bitmap2:BitmapData = new BitmapData(200,200,true,0);
         baseX = 180;
         baseY = 60;
         octaves = 3;
         gseed = Math.floor(this.random.random() * 10000);
         stitch = false;
         fractal = false;
         channels = 0;
         grayScale = true;
         point1 = new Point(0,0);
         point2 = new Point(0,0);
         offset = [point1,point2];
         bitmap2.perlinNoise(baseX,baseY,octaves,gseed,stitch,fractal,channels,grayScale,offset);
         bitmap2.threshold(bitmap2,bitmap2.rect,new Point(),"<",1342177280,0,4278190080,true);
         var cc:ColorTransform = new ColorTransform();
         cc.alphaOffset = 10;
         bitmap2.colorTransform(bitmap2.rect,cc);
         var m:Matrix = new Matrix();
         m.translate(-100,-100);
         this.planet.graphics.beginBitmapFill(bitmap,m);
         this.planet.graphics.drawCircle(0,0,100);
         this.planet.graphics.endFill();
         this.clouds.graphics.beginBitmapFill(bitmap2,m);
         this.clouds.graphics.drawCircle(0,0,100);
         this.clouds.graphics.endFill();
         var fillType:String = "null";
         var colors:Array = [16777200,2105376];
         var alphas:Array = [0.4,0.8];
         var ratios:Array = [0,255];
         var matr:Matrix = new Matrix();
         matr.createGradientBox(210,270,0,-160,-180);
         var spreadMethod:String = "null";
         this.glare.graphics.beginGradientFill(fillType,colors,alphas,ratios,matr,spreadMethod,"rgb",0.5);
         this.glare.graphics.drawCircle(1,1,104);
         this.glare.graphics.endFill();
         this.world.width = 20;
         this.world.height = 20;
      }
   }
}
