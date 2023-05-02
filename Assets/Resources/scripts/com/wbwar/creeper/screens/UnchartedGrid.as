package com.wbwar.creeper.screens
{
   import com.wbwar.creeper.Terrain;
   import com.wbwar.creeper.games.Game;
   import com.wbwar.creeper.games.GameData;
   import com.wbwar.creeper.games.IndividualGameData;
   import com.wbwar.creeper.games.RandomGame;
   import com.wbwar.creeper.util.Text;
   import com.wbwar.creeper.util.Time;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.text.TextField;
   
   public class UnchartedGrid extends Sprite
   {
      
      public static const CLICKED:String = "com.wbwar.creeper.screens.CLICKED";
       
      
      public var scores:Array;
      
      private var coverShape:Shape;
      
      private var worldName:TextField;
      
      private var scoreTitle:TextField;
      
      private var scoreTextField:TextField;
      
      private var timeTextField:TextField;
      
      private var playCountText:TextField;
      
      private var miniMap:Bitmap;
      
      public var selectedWorld:int;
      
      public function UnchartedGrid()
      {
         this.scores = [];
         super();
         this.redraw();
         this.coverShape = new Shape();
         addChild(this.coverShape);
         this.miniMap = new Bitmap();
         addChild(this.miniMap);
         this.miniMap.x = 430;
         this.miniMap.y = 120;
         this.worldName = Text.text(" ",16,16777215);
         addChild(this.worldName);
         this.worldName.x = this.miniMap.x;
         this.worldName.y = this.miniMap.y - this.worldName.height - 2;
         var _loc1_:TextField = Text.text("(Click a Sector Below to Launch Mission)",16,14737663);
         addChild(_loc1_);
         _loc1_.x = 200 - int(_loc1_.width / 2);
         _loc1_.y = -_loc1_.height - 2;
         this.scoreTitle = Text.text("Score: ",10,16777215);
         this.scoreTitle.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         addChild(this.scoreTitle);
         this.scoreTitle.x = this.miniMap.x;
         this.scoreTitle.y = this.miniMap.y;
         this.scoreTitle.visible = false;
         this.scoreTextField = Text.text("",10,16777215);
         this.scoreTextField.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         addChild(this.scoreTextField);
         this.scoreTextField.x = this.scoreTitle.x + this.scoreTitle.width - 2;
         this.scoreTextField.y = this.scoreTitle.y;
         this.timeTextField = Text.text("",8,16777215);
         this.timeTextField.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         addChild(this.timeTextField);
         this.timeTextField.x = this.scoreTitle.x + int(this.scoreTitle.width - 2);
         this.timeTextField.y = this.scoreTitle.y + 10;
         this.playCountText = Text.text("",8,16777215);
         this.playCountText.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         addChild(this.playCountText);
         this.playCountText.x = this.miniMap.x;
         this.playCountText.y = this.miniMap.y + 144 - 14;
         addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:int = int(mouseX / 8);
         var _loc3_:int = int(mouseY / 8);
         this.selectedWorld = _loc2_ + _loc3_ * 50;
         dispatchEvent(new Event(CLICKED));
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         this.coverShape.graphics.clear();
         var _loc2_:int = int(mouseX / 8);
         var _loc3_:int = int(mouseY / 8);
         this.coverShape.graphics.beginFill(16711680,0.5);
         this.coverShape.graphics.drawRect(_loc2_ * 8,_loc3_ * 8,7,7);
         this.coverShape.graphics.endFill();
         this.setWorld(_loc2_,_loc3_);
      }
      
      private function setWorld(param1:int, param2:int) : void
      {
         this.worldName.text = "Uncharted World: " + param1 + "," + param2;
         this.createMiniMap(param1 + param2 * 50);
         var _loc3_:IndividualGameData = GameData.getUnchartedGameData(String(param1 + param2 * 50));
         this.scoreTextField.text = String(_loc3_.highScore);
         this.timeTextField.text = "(" + Time.getTimeString(_loc3_.minTime / 36) + ")";
         this.playCountText.text = "# Plays: " + String(_loc3_.playCount);
         this.scoreTitle.visible = true;
      }
      
      public function redraw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         graphics.clear();
         graphics.beginFill(2105376);
         graphics.drawRect(0,0,400,400);
         graphics.endFill();
         var _loc3_:int = 0;
         while(_loc3_ < 2500)
         {
            _loc1_ = _loc3_ % 50 * 8;
            _loc2_ = int(_loc3_ / 50) * 8;
            if(this.scores[_loc3_] > 0)
            {
               graphics.beginFill(2106879);
            }
            else
            {
               graphics.beginFill(10526880);
            }
            graphics.drawRect(_loc1_,_loc2_,7,7);
            graphics.endFill();
            _loc3_++;
         }
      }
      
      private function createMiniMap(param1:int) : void
      {
         var _loc2_:Game = new RandomGame(100000000 + param1);
         var _loc3_:BitmapData = new BitmapData(210,144,false);
         var _loc4_:Terrain;
         (_loc4_ = new Terrain()).background = int(_loc2_.getBackground());
         _loc4_.setData(_loc2_.getTerrainHeight());
         _loc4_.update();
         var _loc5_:Matrix;
         (_loc5_ = new Matrix()).scale(0.3,0.3);
         _loc3_.draw(_loc4_,_loc5_);
         this.miniMap.bitmapData = _loc3_;
      }
   }
}
