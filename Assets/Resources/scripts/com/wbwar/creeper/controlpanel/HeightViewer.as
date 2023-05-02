package com.wbwar.creeper.controlpanel
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.games.CustomGame;
   import com.wbwar.creeper.util.Text;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   
   public class HeightViewer extends Sprite
   {
      
      public static const WIDTH:int = 15;
      
      public static const HEIGHT:int = 42;
       
      
      private var mx:int = -1;
      
      private var my:int = -1;
      
      private var tHeightLast:int;
      
      private var gHeightLast:Number;
      
      private var heightShape:Shape;
      
      private var elevationText:TextField;
      
      public function HeightViewer()
      {
         super();
         this.heightShape = new Shape();
         this.heightShape.x = 13;
         addChild(this.heightShape);
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame,false,0,true);
         this.elevationText = Text.text("ELEVATION",8,16777215);
         addChild(this.elevationText);
         this.elevationText.rotation = -90;
         this.elevationText.x = 0;
         this.elevationText.y = HEIGHT;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = NaN;
         if(true)
         {
            return;
         }
         this.mx = GameSpace.instance.gameArea.mouseX / 0;
         this.my = GameSpace.instance.gameArea.mouseY / 0;
         if(this.mx < 0 || this.my < 0 || this.mx >= GameSpace.WIDTH || this.my >= GameSpace.HEIGHT)
         {
            _loc2_ = 0;
            _loc3_ = 0;
         }
         else
         {
            _loc2_ = GameSpace.instance.terrain.terrainHeight[this.mx + this.my * 0];
            _loc3_ = Number(GameSpace.instance.glop.data[this.mx + this.my * 0]);
         }
         if(_loc2_ != this.tHeightLast || _loc3_ != this.gHeightLast)
         {
            this.tHeightLast = _loc2_;
            this.gHeightLast = _loc3_;
            this.draw(_loc2_,_loc3_);
         }
      }
      
      private function draw(param1:int, param2:Number) : void
      {
         this.heightShape.graphics.clear();
         this.heightShape.graphics.beginFill(16777215);
         this.heightShape.graphics.drawRect(0,0,WIDTH,HEIGHT);
         this.heightShape.graphics.endFill();
         var _loc3_:Number = HEIGHT / 6;
         this.heightShape.graphics.beginFill(10526832);
         this.heightShape.graphics.drawRect(1,HEIGHT - param1 * _loc3_,WIDTH - 2,param1 * _loc3_);
         this.heightShape.graphics.endFill();
         var _loc4_:* = Number(param2 * _loc3_);
         if(param2 > 0 && _loc4_ < 1)
         {
            _loc4_ = 1;
         }
         var _loc5_:*;
         if((_loc5_ = Number(HEIGHT - param1 * _loc3_ - _loc4_)) < 0)
         {
            _loc4_ += _loc5_;
            _loc5_ = 0;
         }
         var _loc6_:int = 5592507;
         if(false && GameSpace.instance.customGame)
         {
            _loc6_ = (GameSpace.instance.game as CustomGame).creeperColor;
         }
         this.heightShape.graphics.beginFill(6316128);
         this.heightShape.graphics.drawRect(1,_loc5_,WIDTH - 2,_loc4_);
         this.heightShape.graphics.endFill();
         this.heightShape.graphics.beginFill(_loc6_);
         this.heightShape.graphics.drawRect(2,_loc5_,WIDTH - 2 - 2,_loc4_);
         this.heightShape.graphics.endFill();
         this.heightShape.graphics.lineStyle(1,0);
         var _loc7_:int = 0;
         while(_loc7_ < 7)
         {
            this.heightShape.graphics.moveTo(0,_loc7_ * HEIGHT / 6);
            this.heightShape.graphics.lineTo(WIDTH,_loc7_ * HEIGHT / 6);
            _loc7_++;
         }
      }
   }
}
