package com.wbwar.creeper.util
{
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class SortTriangle extends Sprite
   {
      
      public static const STATE_DOWN:String = "down";
      
      public static const STATE_UP:String = "up";
      
      public static const STATE_NONE:String = "none";
      
      public static const TRIANGLE_WIDTH:int = 10;
      
      public static const TRIANGLE_HEIGHT:int = 10;
       
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      private var _state:String;
      
      public var cgssb:CustomGameSelectorSortBar;
      
      private var triangle:Shape;
      
      public function SortTriangle(param1:CustomGameSelectorSortBar, param2:int, param3:int)
      {
         super();
         this.cgssb = param1;
         this.WIDTH = param2;
         this.HEIGHT = CustomGameSelector.HEIGHT;
         this.onMouseOut(null);
         this.triangle = new Shape();
         addChild(this.triangle);
         this.triangle.x = param3;
         this.triangle.y = 8;
         this.state = STATE_NONE;
         addEventListener(MouseEvent.CLICK,this.onClick);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      public function set state(param1:String) : void
      {
         this._state = param1;
         this.render();
      }
      
      public function get state() : String
      {
         return this._state;
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         graphics.clear();
         graphics.beginFill(16736352,0.2);
         graphics.drawRect(0,0,this.WIDTH,this.HEIGHT);
         graphics.endFill();
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         graphics.clear();
         graphics.beginFill(16777215,0);
         graphics.drawRect(0,0,this.WIDTH,this.HEIGHT);
         graphics.endFill();
      }
      
      private function render() : void
      {
         this.triangle.graphics.clear();
         if(this._state == STATE_DOWN)
         {
            this.triangle.graphics.beginFill(10547440);
            this.triangle.graphics.moveTo(0,0);
            this.triangle.graphics.lineTo(TRIANGLE_WIDTH,0);
            this.triangle.graphics.lineTo(TRIANGLE_WIDTH / 2,TRIANGLE_HEIGHT);
            this.triangle.graphics.lineTo(0,0);
            this.triangle.graphics.endFill();
         }
         else if(this._state == STATE_UP)
         {
            this.triangle.graphics.beginFill(10547440);
            this.triangle.graphics.moveTo(0,TRIANGLE_HEIGHT);
            this.triangle.graphics.lineTo(TRIANGLE_WIDTH,TRIANGLE_HEIGHT);
            this.triangle.graphics.lineTo(TRIANGLE_WIDTH / 2,0);
            this.triangle.graphics.lineTo(0,TRIANGLE_HEIGHT);
            this.triangle.graphics.endFill();
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         this.cgssb.clearAllSorts(this);
         if(this.state == STATE_NONE)
         {
            this.state = STATE_DOWN;
         }
         else if(this.state == STATE_DOWN)
         {
            this.state = STATE_UP;
         }
         else
         {
            this.state = STATE_DOWN;
         }
         this.cgssb.sortChanged();
      }
   }
}
