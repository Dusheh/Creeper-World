package com.wbwar.creeper.util
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import flash.utils.Timer;
   
   public class Spinner extends Sprite
   {
      
      public static const CHANGE:String = "com.wbwar.creeper.util.Spinner.CHANGE";
       
      
      private var textWidth:int;
      
      private var valueText:TextField;
      
      private var upButton:ArrowButton;
      
      private var downButton:ArrowButton;
      
      public var values:Array;
      
      public var valueBased:Boolean;
      
      private var _min:int;
      
      private var _max:int;
      
      private var _valueIndex:int;
      
      private var _value:int;
      
      private var upDown:Boolean;
      
      private var downDown:Boolean;
      
      private var upTimer:Timer;
      
      private var downTimer:Timer;
      
      public function Spinner(param1:int, param2:int)
      {
         super();
         this.textWidth = param1;
         this.valueText = Text.text("0",param2,16777215);
         addChild(this.valueText);
         this.valueText.filters = [new DropShadowFilter()];
         graphics.lineStyle(1,10526975);
         graphics.beginFill(2105472,0.5);
         graphics.drawRect(0,0,param1,this.valueText.height);
         graphics.endFill();
         this.upButton = new ArrowButton(ArrowButton.DIRECTION_UP,false,10);
         this.upButton.x = param1 + 2;
         this.upButton.y = 0;
         addChild(this.upButton);
         this.downButton = new ArrowButton(ArrowButton.DIRECTION_DOWN,false,10);
         this.downButton.x = param1 + 2;
         this.downButton.y = this.valueText.height - 10;
         addChild(this.downButton);
         this.upButton.addEventListener(MouseEvent.MOUSE_DOWN,this.onUpButtonDown);
         this.upButton.addEventListener(MouseEvent.MOUSE_UP,this.onUpButtonUp);
         this.downButton.addEventListener(MouseEvent.MOUSE_DOWN,this.onDownButtonDown);
         this.downButton.addEventListener(MouseEvent.MOUSE_UP,this.onDownButtonUp);
         this.value = 0;
         this.valueIndex = 0;
      }
      
      public function set value(param1:int) : void
      {
         this._value = param1;
         this.refresh();
      }
      
      public function get value() : int
      {
         return this._value;
      }
      
      public function set valueIndex(param1:int) : void
      {
         this._valueIndex = param1;
         this.refresh();
      }
      
      public function get valueIndex() : int
      {
         return this._valueIndex;
      }
      
      public function set max(param1:int) : void
      {
         this._max = param1;
         if(this.value > this.max)
         {
            this.value = this.max;
         }
      }
      
      public function get max() : int
      {
         return this._max;
      }
      
      public function set min(param1:int) : void
      {
         this._min = param1;
         if(this.value < this.min)
         {
            this.value = this.min;
         }
      }
      
      public function get min() : int
      {
         return this._min;
      }
      
      public function refresh() : void
      {
         if(this.valueBased)
         {
            if(this.valueIndex >= 0 && this.valueIndex < this.values.length)
            {
               this.valueText.text = this.values[this.valueIndex];
            }
         }
         else
         {
            this.valueText.text = String(this.value);
         }
         this.valueText.x = this.textWidth - this.valueText.width - 3;
      }
      
      public function decrease() : void
      {
         if(this.valueBased)
         {
            --this.valueIndex;
            if(this.valueIndex < 0)
            {
               this.valueIndex = this.values.length - 1 >= 0 ? int(this.values.length - 1) : 0;
            }
         }
         else
         {
            --this.value;
            if(this.value < this.min)
            {
               this.value = this.max;
            }
         }
         dispatchEvent(new Event(CHANGE));
      }
      
      public function increase() : void
      {
         if(this.valueBased)
         {
            ++this.valueIndex;
            if(this.valueIndex > this.values.length - 1)
            {
               this.valueIndex = 0;
            }
         }
         else
         {
            ++this.value;
            if(this.value > this.max)
            {
               this.value = this.min;
            }
         }
         dispatchEvent(new Event(CHANGE));
      }
      
      private function onUpTimer(param1:TimerEvent) : void
      {
         this.upTimer.removeEventListener(TimerEvent.TIMER,this.onUpTimer);
         if(this.upDown)
         {
            this.upTimer = new Timer(250,1);
            this.upTimer.addEventListener(TimerEvent.TIMER,this.onUpTimer);
            this.upTimer.start();
            this.increase();
         }
         else
         {
            this.upTimer = null;
         }
      }
      
      private function onDownTimer(param1:TimerEvent) : void
      {
         this.downTimer.removeEventListener(TimerEvent.TIMER,this.onDownTimer);
         if(this.downDown)
         {
            this.downTimer = new Timer(250,1);
            this.downTimer.addEventListener(TimerEvent.TIMER,this.onDownTimer);
            this.downTimer.start();
            this.decrease();
         }
         else
         {
            this.downTimer = null;
         }
      }
      
      private function onUpButtonDown(param1:MouseEvent) : void
      {
         this.increase();
         if(this.upDown)
         {
         }
         this.upDown = true;
      }
      
      private function onUpButtonUp(param1:MouseEvent) : void
      {
         this.upDown = false;
         if(this.upTimer != null)
         {
         }
      }
      
      private function onDownButtonDown(param1:MouseEvent) : void
      {
         this.decrease();
         if(this.downDown)
         {
         }
         this.downDown = true;
      }
      
      private function onDownButtonUp(param1:MouseEvent) : void
      {
         this.downDown = false;
         if(this.downTimer != null)
         {
         }
      }
   }
}
