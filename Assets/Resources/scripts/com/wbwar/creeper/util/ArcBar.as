package com.wbwar.creeper.util
{
   import flash.display.CapsStyle;
   import flash.display.LineScaleMode;
   import flash.display.Shape;
   
   public class ArcBar extends Shape
   {
       
      
      private var arc:Number;
      
      private var startAngle:Number;
      
      private var radius:Number;
      
      private var thickness:Number;
      
      private var solidColor:Number;
      
      private var backgroundColor:Number;
      
      public var border:Number = -1;
      
      public function ArcBar(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number = 9474256)
      {
         super();
         this.radius = param1;
         this.arc = param2;
         this.startAngle = param3;
         this.thickness = param4;
         this.solidColor = param5;
         this.backgroundColor = param6;
      }
      
      public function setValue(param1:Number, param2:Number) : void
      {
         graphics.clear();
         if(this.backgroundColor >= 0)
         {
            graphics.lineStyle(this.thickness,this.backgroundColor,1,false,LineScaleMode.NORMAL,CapsStyle.SQUARE);
            Arc.draw(graphics,0,0,this.radius,this.arc,this.startAngle);
         }
         graphics.lineStyle(this.thickness,this.solidColor,1,false,LineScaleMode.NORMAL,CapsStyle.SQUARE);
         Arc.draw(graphics,0,0,this.radius,param1 / param2 * this.arc,this.startAngle);
      }
   }
}
