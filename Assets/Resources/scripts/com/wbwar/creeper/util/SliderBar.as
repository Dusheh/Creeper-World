package com.wbwar.creeper.util
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   
   public class SliderBar extends Sprite
   {
      
      public static const SLIDER_CHANGING:String = "SLIDERBAR_CHANGING";
      
      public static const SLIDER_CHANGED:String = "SLIDERBAR_CHANGED";
       
      
      private var handle:Sprite;
      
      private var boundsRect:Rectangle;
      
      private var lineColor:Number;
      
      private var dragging:Boolean;
      
      private var sliderWidth:int;
      
      private var handleColor:Number;
      
      private var dragBounds:Rectangle;
      
      private var _maxValue:Number;
      
      public function SliderBar(param1:Number, param2:Number, param3:int, param4:Number)
      {
         this.dragBounds = new Rectangle();
         super();
         this.handle = new Sprite();
         this.sliderWidth = param3;
         this.lineColor = param2;
         this.handleColor = param1;
         this.maxValue = param4;
         this.drawHandle();
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
      
      public function set maxValue(param1:Number) : void
      {
         this._maxValue = param1;
         this.drawHandle();
      }
      
      public function get maxValue() : Number
      {
         return this._maxValue;
      }
      
      public function set value(param1:Number) : void
      {
         this.handle.x = param1 / this.maxValue * this.sliderWidth;
      }
      
      public function get value() : Number
      {
         return this.handle.x / this.sliderWidth * this.maxValue;
      }
      
      private function drawHandle() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(this.maxValue != 0)
         {
            _loc1_ = this.sliderWidth / this.maxValue;
            if(_loc1_ < 1)
            {
               _loc2_ = _loc1_ * this.sliderWidth;
               this.dragBounds = new Rectangle(0,5,this.sliderWidth - _loc2_,0);
               this.handle.graphics.clear();
               this.handle.graphics.beginFill(this.handleColor);
               this.handle.graphics.drawRect(0,-3,_loc2_,6);
               this.handle.graphics.endFill();
            }
            else
            {
               this.handle.graphics.clear();
            }
         }
         else
         {
            this.handle.graphics.clear();
         }
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
         if(mouseX > this.handle.x + this.handle.width)
         {
            this.handle.x += 20;
            if(this.handle.x > this.dragBounds.width)
            {
               this.handle.x = this.dragBounds.width;
            }
         }
         else if(mouseX < this.handle.x)
         {
            this.handle.x -= 20;
            if(this.handle.x < 0)
            {
               this.handle.x = 0;
            }
         }
         else
         {
            this.handle.startDrag(false,this.dragBounds);
            this.dragging = true;
         }
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
