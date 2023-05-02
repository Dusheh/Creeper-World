package com.wbwar.creeper.util
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   
   public class Slider extends Sprite
   {
      
      public static const SLIDER_CHANGING:String = "SLIDER_CHANGING";
      
      public static const SLIDER_CHANGED:String = "SLIDER_CHANGED";
       
      
      private var handle:Sprite;
      
      private var boundsRect:Rectangle;
      
      private var lineColor:Number;
      
      private var dragging:Boolean;
      
      public var maxValue:Number;
      
      private var sliderWidth:int;
      
      public function Slider(param1:Number, param2:Number, param3:int, param4:Number)
      {
         super();
         this.maxValue = param4;
         this.sliderWidth = param3;
         this.lineColor = param2;
         this.handle = new Sprite();
         this.handle.graphics.beginFill(param1);
         this.handle.graphics.moveTo(-6,-4);
         this.handle.graphics.lineTo(6,-4);
         this.handle.graphics.lineTo(0,4);
         this.handle.graphics.lineTo(-6,-4);
         this.handle.graphics.endFill();
         this.handle.filters = [new GlowFilter(0,1,2,2)];
         this.handle.mouseEnabled = false;
         addChild(this.handle);
         this.handle.y = 5;
         this.boundsRect = new Rectangle(0,5,param3,0);
         this.draw();
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown,false,0,true);
         addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp,false,0,true);
         useHandCursor = true;
         buttonMode = true;
      }
      
      public function set value(param1:Number) : void
      {
         this.handle.x = param1 / this.maxValue * this.sliderWidth;
      }
      
      public function get value() : Number
      {
         return this.handle.x / this.sliderWidth * this.maxValue;
      }
      
      private function draw() : void
      {
         graphics.clear();
         graphics.beginFill(16777215,0.05);
         graphics.drawRect(-4,-2,this.boundsRect.width + 8,14);
         graphics.endFill();
         graphics.beginFill(16777215,0.05);
         graphics.drawRect(0,0,this.boundsRect.width,10);
         graphics.endFill();
         graphics.beginFill(this.lineColor);
         graphics.drawRect(0,4,this.boundsRect.width,2);
         graphics.endFill();
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         if(this.dragging)
         {
            dispatchEvent(new Event(SLIDER_CHANGING));
         }
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         this.handle.startDrag(true,this.boundsRect);
         this.handle.x = mouseX;
         this.dragging = true;
         dispatchEvent(new Event(SLIDER_CHANGING));
         this.draw();
         Creeper.instance.stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp,false,0,true);
         Creeper.instance.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove,false,0,true);
      }
      
      private function onMouseUp(param1:MouseEvent) : void
      {
         this.handle.stopDrag();
         this.dragging = false;
         Creeper.instance.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         Creeper.instance.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         dispatchEvent(new Event(SLIDER_CHANGED));
      }
   }
}
