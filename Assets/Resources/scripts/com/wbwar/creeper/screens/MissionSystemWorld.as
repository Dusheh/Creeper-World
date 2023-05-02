package com.wbwar.creeper.screens
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.Terrain;
   import com.wbwar.creeper.games.Game;
   import com.wbwar.creeper.games.IndividualGameData;
   import com.wbwar.creeper.games.RandomGame;
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
   import flash.text.TextField;
   
   public class MissionSystemWorld extends Sprite
   {
      
      public static const WORLD_SIZE:int = 20;
       
      
      public var gameNumber:int;
      
      private var worldShape:Sprite;
      
      private var miniMap:Bitmap;
      
      private var popup:Sprite;
      
      private var scoreTitle:TextField;
      
      private var scoreTextField:TextField;
      
      private var timeTextField:TextField;
      
      private var playCountText:TextField;
      
      public function MissionSystemWorld(param1:MissionSystem, param2:int, param3:Number, param4:Number)
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = null;
         super();
         this.gameNumber = param2;
         this.x = param3;
         this.y = param4;
         graphics.beginFill(0,0);
         graphics.drawCircle(0,0,26);
         graphics.endFill();
         var _loc5_:int;
         if((_loc5_ = (param2 - 1) % 5) == 0)
         {
            _loc6_ = 150;
            _loc7_ = 50;
            _loc8_ = 50;
         }
         else if(_loc5_ == 1)
         {
            _loc6_ = 50;
            _loc7_ = 150;
            _loc8_ = 50;
         }
         else if(_loc5_ == 2)
         {
            _loc6_ = 50;
            _loc7_ = 50;
            _loc8_ = 150;
         }
         else if(_loc5_ == 3)
         {
            _loc6_ = 50;
            _loc7_ = 150;
            _loc8_ = 150;
         }
         else if(_loc5_ == 4)
         {
            _loc6_ = 150;
            _loc7_ = 50;
            _loc8_ = 150;
         }
         this.worldShape = ColorUtil.world(param2,50,_loc6_,_loc7_,_loc8_);
         this.worldShape.mouseEnabled = false;
         this.worldShape.width = WORLD_SIZE;
         this.worldShape.height = WORLD_SIZE;
         addChild(this.worldShape);
         this.worldShape.filters = [new DropShadowFilter(2),new GlowFilter(16777215,1,16,16)];
         (_loc9_ = Text.text(String((param2 - 1) % 5 + 1),8,10526880)).filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         addChild(_loc9_);
         _loc9_.x = int(-_loc9_.width / 2);
         _loc9_.y = -int(WORLD_SIZE / 2) - _loc9_.height + 2;
         this.popup = new Sprite();
         this.popup.filters = [new DropShadowFilter()];
         this.popup.mouseEnabled = false;
         this.popup.mouseChildren = false;
         this.popup.visible = false;
         this.popup.alpha = 0;
         param1.fms.popupLayer.addChild(this.popup);
         this.popup.x = int(param1.x + this.x - 35);
         this.popup.y = int(param1.y + this.y - WORLD_SIZE / 2 - 48);
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
         this.timeTextField.x = this.scoreTitle.x + int(this.scoreTitle.width - 2);
         this.timeTextField.y = 10;
         this.playCountText = Text.text("",8,16777215);
         this.playCountText.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         this.popup.addChild(this.playCountText);
         this.playCountText.y = 34;
         buttonMode = true;
         useHandCursor = true;
         addEventListener(MouseEvent.CLICK,this.onMouseClick);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         Creeper.instance.gameScreen.launchConquestGame(this.gameNumber);
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         Tweener.addTween(this.worldShape,{
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
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         Tweener.addTween(this.worldShape,{
            "time":1,
            "width":WORLD_SIZE,
            "height":WORLD_SIZE
         });
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
         var _loc1_:Game = new RandomGame(this.gameNumber);
         var _loc2_:BitmapData = new BitmapData(0,0,false);
         var _loc3_:Terrain = new Terrain();
         _loc3_.background = int(_loc1_.getBackground());
         _loc3_.setData(_loc1_.getTerrainHeight());
         _loc3_.update();
         var _loc4_:Matrix;
         (_loc4_ = new Matrix()).scale(0.1,0.1);
         _loc2_.draw(_loc3_,_loc4_);
         this.miniMap = new Bitmap();
         this.miniMap.bitmapData = _loc2_;
         this.miniMap.width = 70;
         this.miniMap.height = 48;
         this.popup.addChild(this.miniMap);
         this.popup.addChild(this.scoreTitle);
         this.popup.addChild(this.scoreTextField);
         this.popup.addChild(this.timeTextField);
         this.popup.addChild(this.playCountText);
      }
   }
}
