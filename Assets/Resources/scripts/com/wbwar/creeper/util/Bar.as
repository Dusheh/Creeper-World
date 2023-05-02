package com.wbwar.creeper.util
{
   import caurina.transitions.Tweener;
   import flash.display.Shape;
   
   public class Bar extends Shape
   {
       
      
      public var WIDTH:Number;
      
      public var HEIGHT:Number;
      
      private var solidColor:Number;
      
      private var backgroundColor:Number;
      
      public var border:Number = -1;
      
      private var maxValue:Number;
      
      private var _value:Number;
      
      public function Bar(param1:Number, param2:Number, param3:Number, param4:Number = 9474256)
      {
         super();
         this.WIDTH = param1;
         this.HEIGHT = param2;
         this.solidColor = param3;
         this.backgroundColor = param4;
      }
      
      public function set val(param1:Number) : void
      {
         this._value = param1;
         this._setValue(param1);
      }
      
      public function get val() : Number
      {
         return this._value;
      }
      
      public function setValue(param1:Number, param2:Number) : void
      {
         this.maxValue = param2;
         if(param1 > param2)
         {
            param1 = param2;
         }
         Tweener.addTween(this,{
            "val":param1,
            "time":0.75
         });
      }
      
      private function _setValue(param1:Number) : void
      {
         var _loc2_:* = NaN;
         var _loc3_:Number = NaN;
         graphics.clear();
         if(this.backgroundColor >= 0)
         {
            graphics.beginFill(this.backgroundColor,0.5);
            graphics.drawRect(0,0,this.WIDTH,this.HEIGHT);
            graphics.endFill();
         }
         if(this.maxValue == 0)
         {
            _loc2_ = 0;
         }
         else
         {
            _loc2_ = Number(param1 / this.maxValue);
         }
         if(this.solidColor != -1)
         {
            _loc3_ = this.solidColor;
         }
         else
         {
            _loc3_ = int((1 - _loc2_) * 255) << 16 | int(_loc2_ * 255) << 8;
         }
         graphics.beginFill(_loc3_,1);
         graphics.drawRect(0,0,this.WIDTH * _loc2_,this.HEIGHT);
         graphics.endFill();
         if(this.border >= 0)
         {
            graphics.lineStyle(1,this.border);
            graphics.drawRect(0,0,this.WIDTH,this.HEIGHT);
            graphics.lineStyle();
         }
      }
   }
}
