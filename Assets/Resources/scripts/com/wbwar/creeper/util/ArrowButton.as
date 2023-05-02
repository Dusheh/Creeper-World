package com.wbwar.creeper.util
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.media.Sound;
   
   public class ArrowButton extends Sprite
   {
      
      public static const DIRECTION_LEFT:int = 0;
      
      public static const DIRECTION_RIGHT:int = 1;
      
      public static const DIRECTION_UP:int = 2;
      
      public static const DIRECTION_DOWN:int = 3;
       
      
      public function ArrowButton(param1:int, param2:Boolean, param3:int)
      {
         super();
         graphics.beginFill(0,0);
         if(param2)
         {
            graphics.drawRect(0,0,2 * param3 + 3,param3);
         }
         else
         {
            graphics.drawRect(0,0,param3,param3);
         }
         graphics.endFill();
         this.drawArrow(param1,0,0,param3,param3);
         if(param2)
         {
            this.drawArrow(param1,param3 + 3,0,param3,param3);
         }
         filters = [new DropShadowFilter(2)];
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         useHandCursor = true;
         buttonMode = true;
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:Sound = new ClickSound();
         _loc2_.play();
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         ColorUtil.brighterColor(this,1);
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         ColorUtil.normalColor(this,1);
      }
      
      private function drawArrow(param1:int, param2:Number, param3:Number, param4:int, param5:int) : void
      {
         if(param1 == DIRECTION_LEFT)
         {
            graphics.beginFill(12632256);
            graphics.moveTo(param2,param3 + param5 / 2);
            graphics.lineTo(param2 + param4,param3 + param5);
            graphics.lineTo(param2 + param4,param3);
            graphics.lineTo(param2,param3 + param5 / 2);
            graphics.endFill();
         }
         else if(param1 == DIRECTION_RIGHT)
         {
            graphics.beginFill(12632256);
            graphics.moveTo(param2 + param4,param3 + param5 / 2);
            graphics.lineTo(param2,param3);
            graphics.lineTo(param2,param3 + param5);
            graphics.lineTo(param2 + param4,param3 + param5 / 2);
            graphics.endFill();
         }
         else if(param1 == DIRECTION_UP)
         {
            graphics.beginFill(12632256);
            graphics.moveTo(param2 + param4 / 2,param3);
            graphics.lineTo(param2,param3 + param5);
            graphics.lineTo(param2 + param4,param3 + param5);
            graphics.lineTo(param2 + param4 / 2,param3);
            graphics.endFill();
         }
         else
         {
            graphics.beginFill(12632256);
            graphics.moveTo(param2 + param4 / 2,param3 + param5);
            graphics.lineTo(param2 + param4,param3);
            graphics.lineTo(param2,param3);
            graphics.lineTo(param2 + param4 / 2,param3 + param5);
            graphics.endFill();
         }
      }
   }
}
