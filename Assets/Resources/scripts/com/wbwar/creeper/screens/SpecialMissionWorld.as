package com.wbwar.creeper.screens
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.Terrain;
   import com.wbwar.creeper.games.Game;
   import com.wbwar.creeper.games.IndividualGameData;
   import com.wbwar.creeper.games.SpecialGame0;
   import com.wbwar.creeper.games.SpecialGame1;
   import com.wbwar.creeper.games.SpecialGame2;
   import com.wbwar.creeper.games.SpecialGame3;
   import com.wbwar.creeper.games.SpecialGame4;
   import com.wbwar.creeper.games.SpecialGame5;
   import com.wbwar.creeper.games.SpecialGame6;
   import com.wbwar.creeper.games.SpecialGame7;
   import com.wbwar.creeper.games.SpecialGame8;
   import com.wbwar.creeper.games.SpecialGame9;
   import com.wbwar.creeper.util.ColorUtil;
   import com.wbwar.creeper.util.Text;
   import com.wbwar.creeper.util.Time;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.media.Sound;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   
   public class SpecialMissionWorld extends Sprite
   {
      
      public static const WORLD_SIZE:int = 100;
       
      
      public var gameNumber:int;
      
      private var worldShape:Sprite;
      
      private var miniMap:Bitmap;
      
      private var popup:Sprite;
      
      private var scoreTitle:TextField;
      
      private var scoreTextField:TextField;
      
      private var timeTextField:TextField;
      
      private var playCountText:TextField;
      
      public var title:TextField;
      
      private var lockedCover:Sprite;
      
      private var _locked:Boolean;
      
      public function SpecialMissionWorld(param1:SpecialMissionSelection, param2:int, param3:Number, param4:Number)
      {
         var sg0:SpecialGame0 = null;
         var sg1:SpecialGame1 = null;
         var sg2:SpecialGame2 = null;
         var sg3:SpecialGame3 = null;
         var sg4:SpecialGame4 = null;
         var sg5:SpecialGame5 = null;
         var sg6:SpecialGame6 = null;
         var sg7:SpecialGame7 = null;
         var sg8:SpecialGame8 = null;
         var sg9:SpecialGame9 = null;
         var r:int = 0;
         var g:int = 0;
         var b:int = 0;
         var gc:Object = null;
         var sms:SpecialMissionSelection = param1;
         var gameNumber:int = param2;
         var x:Number = param3;
         var y:Number = param4;
         super();
         this.gameNumber = gameNumber;
         this.x = x;
         this.y = y;
         graphics.beginFill(0,0);
         graphics.drawCircle(0,0,26);
         graphics.endFill();
         var c:int = gameNumber;
         if(c == 0)
         {
            r = 150;
            g = 50;
            b = 50;
         }
         else if(c == 1)
         {
            r = 50;
            g = 150;
            b = 50;
         }
         else if(c == 2)
         {
            r = 250;
            g = 250;
            b = 0;
         }
         else if(c == 3)
         {
            r = 50;
            g = 200;
            b = 150;
         }
         else if(c == 4)
         {
            r = 150;
            g = 0;
            b = 150;
         }
         else if(c == 5)
         {
            r = 200;
            g = 200;
            b = 50;
         }
         else if(c == 6)
         {
            r = 0;
            g = 0;
            b = 250;
         }
         else if(c == 7)
         {
            r = 150;
            g = 150;
            b = 150;
         }
         else if(c == 8)
         {
            r = 0;
            g = 250;
            b = 0;
         }
         else if(c == 9)
         {
            r = 100;
            g = 200;
            b = 100;
         }
         var gname:String = "com.wbwar.creeper.games::SpecialGame" + gameNumber;
         try
         {
            gc = getDefinitionByName(gname);
            this.title = Text.text(gc["title"],12,16777215);
         }
         catch(e:Error)
         {
            title = Text.text("???",9,16777215);
         }
         this.title.filters = [new DropShadowFilter(1)];
         addChild(this.title);
         this.title.x = -this.title.width / 2;
         this.title.y = WORLD_SIZE / 2 + 3;
         this.worldShape = ColorUtil.world(gameNumber,50,r,g,b);
         this.worldShape.mouseEnabled = false;
         this.worldShape.width = WORLD_SIZE;
         this.worldShape.height = WORLD_SIZE;
         addChild(this.worldShape);
         this.worldShape.filters = [new DropShadowFilter(2),new GlowFilter(16777215,1,16,16)];
         this.popup = new Sprite();
         this.popup.filters = [new DropShadowFilter()];
         this.popup.mouseEnabled = false;
         this.popup.mouseChildren = false;
         this.popup.visible = false;
         this.popup.alpha = 0;
         sms.popupLayer.addChild(this.popup);
         this.popup.x = int(sms.x + this.x - 70);
         this.popup.y = int(sms.y + this.y - WORLD_SIZE / 2 - 100);
         this.scoreTitle = Text.text("Score: ",12,16777215);
         this.scoreTitle.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         this.popup.addChild(this.scoreTitle);
         this.scoreTitle.y = 0;
         this.scoreTextField = Text.text("",12,16777215);
         this.scoreTextField.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         this.popup.addChild(this.scoreTextField);
         this.scoreTextField.x = this.scoreTitle.x + this.scoreTitle.width - 2;
         this.scoreTextField.y = 0;
         this.timeTextField = Text.text("",10,16777215);
         this.timeTextField.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         this.popup.addChild(this.timeTextField);
         this.timeTextField.x = this.scoreTitle.x + this.scoreTitle.width - 2;
         this.timeTextField.y = 13;
         this.playCountText = Text.text("",10,16777215);
         this.playCountText.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         this.popup.addChild(this.playCountText);
         this.playCountText.y = 82;
         this.lockedCover = new Sprite();
         var lockedText1:TextField = Text.text("Locked",20,16776960);
         var lockedText2:TextField = Text.text("Complete",12,16777152);
         var lockedText3:TextField = Text.text(FreeplayMissionSelection.systemNames[int(gameNumber / 2)],12,16777152);
         var lockedText4:TextField = Text.text("Conquest",12,16777152);
         lockedText1.filters = [new GlowFilter(0,1,8,8)];
         lockedText2.filters = [new GlowFilter(0,1,8,8)];
         lockedText3.filters = [new GlowFilter(0,1,8,8)];
         lockedText4.filters = [new GlowFilter(0,1,8,8)];
         lockedText1.x = -lockedText1.width / 2;
         lockedText1.y = -lockedText1.height - 5;
         lockedText2.x = -lockedText2.width / 2;
         lockedText2.y = -5;
         lockedText3.x = -lockedText3.width / 2;
         lockedText3.y = 8;
         lockedText4.x = -lockedText4.width / 2;
         lockedText4.y = 21;
         this.lockedCover.addChild(lockedText1);
         this.lockedCover.addChild(lockedText2);
         this.lockedCover.addChild(lockedText3);
         this.lockedCover.addChild(lockedText4);
         this.lockedCover.visible = false;
         addChild(this.lockedCover);
         buttonMode = true;
         useHandCursor = true;
         addEventListener(MouseEvent.CLICK,this.onMouseClick);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      public function set locked(param1:Boolean) : void
      {
         this._locked = param1;
         buttonMode = !param1;
         useHandCursor = !param1;
         this.lockedCover.visible = param1;
      }
      
      public function get locked() : Boolean
      {
         return this._locked;
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(this._locked)
         {
            return;
         }
         try
         {
            _loc2_ = new ClickSound();
            _loc2_.play();
            Creeper.instance.gameScreen.launchSpecialGame(this.gameNumber);
         }
         catch(e:Error)
         {
         }
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
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
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         if(this.miniMap != null)
         {
            Tweener.addTween(this.popup,{
               "time":1,
               "_autoAlpha":0
            });
         }
      }
      
      public function reinit(param1:IndividualGameData) : void
      {
         this.scoreTextField.text = String(param1.highScore);
         this.timeTextField.text = "(" + Time.getTimeString(param1.minTime / 36) + ")";
         this.playCountText.text = "# Plays: " + String(param1.playCount);
         if(param1.highScore > 0)
         {
            this.worldShape.filters = [new DropShadowFilter(2),new GlowFilter(10551200,1,16,16)];
         }
         else
         {
            this.worldShape.filters = [new DropShadowFilter(2),new GlowFilter(255,1,16,16)];
         }
      }
      
      private function createMiniMap() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc1_:String = "com.wbwar.creeper.games::SpecialGame" + this.gameNumber;
         try
         {
            _loc2_ = getDefinitionByName(_loc1_);
            this.miniMap = new Bitmap(new BitmapData(0,0,false));
            this.miniMap.width = 140;
            this.miniMap.height = 96;
            _loc3_ = new Terrain();
            _loc4_ = new _loc2_();
            _loc3_.background = int(_loc4_.getBackground());
            _loc3_.setData(_loc4_.getTerrainHeight());
            _loc3_.update();
            (_loc5_ = new Matrix()).scale(0.2,0.2);
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
   }
}
