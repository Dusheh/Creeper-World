package com.wbwar.creeper.util
{
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ButtonHighlight extends Sprite
   {
       
      
      private var hl:Shape;
      
      private var outerhl:Sprite;
      
      private var pulseRate:Number = 0.007;
      
      public function ButtonHighlight(param1:int, param2:int)
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         this.hl = new Shape();
         this.hl.graphics.lineStyle(2,16777215);
         this.hl.graphics.moveTo(0,5);
         this.hl.graphics.lineTo(0,0);
         this.hl.graphics.lineTo(5,0);
         this.hl.graphics.moveTo(param1,5);
         this.hl.graphics.lineTo(param1,0);
         this.hl.graphics.lineTo(param1 - 5,0);
         this.hl.graphics.moveTo(param1,param2 - 5);
         this.hl.graphics.lineTo(param1,param2);
         this.hl.graphics.lineTo(param1 - 5,param2);
         this.hl.graphics.moveTo(0,param2 - 5);
         this.hl.graphics.lineTo(0,param2);
         this.hl.graphics.lineTo(5,param2);
         this.outerhl = new Sprite();
         this.outerhl.mouseEnabled = false;
         this.outerhl.mouseChildren = false;
         this.outerhl.addChild(this.hl);
         this.hl.x = -param1 / 2;
         this.hl.y = -param2 / 2;
         addChild(this.outerhl);
         this.outerhl.x = param1 / 2;
         this.outerhl.y = param2 / 2;
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame,false,0,true);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(visible)
         {
            this.outerhl.scaleX += this.pulseRate;
            this.outerhl.scaleY += this.pulseRate * 3;
            if(this.outerhl.scaleX > 1.1 || this.outerhl.scaleX <= 1)
            {
               this.pulseRate = -this.pulseRate;
            }
         }
      }
   }
}
