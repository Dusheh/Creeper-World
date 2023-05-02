package com.wbwar.creeper
{
   import caurina.transitions.Tweener;
   import flash.display.Shape;
   import flash.filters.DropShadowFilter;
   
   public final class MoveIndicator extends Shape
   {
       
      
      public function MoveIndicator(param1:int, param2:int, param3:int, param4:int)
      {
         super();
         var _loc5_:int;
         if((_loc5_ = (param3 - param1) * (param3 - param1) + (param4 - param2) * (param4 - param2)) > 525)
         {
            graphics.beginFill(32768);
            graphics.drawRect(-7,-2,7,4);
            graphics.moveTo(0,-7);
            graphics.lineTo(7,0);
            graphics.lineTo(0,7);
            graphics.lineTo(0,-7);
            graphics.endFill();
            alpha = 0.6;
            filters = [new DropShadowFilter()];
            x = param1;
            y = param2;
            rotation = Math.atan2(param4 - param2,param3 - param1) * 180 / 0;
            Tweener.addTween(this,{
               "x":param3,
               "y":param4,
               "time":0.8,
               "transition":"linear",
               "onComplete":this.moveComplete
            });
            GameSpace.instance.moveLayer.addChild(this);
         }
      }
      
      private function moveComplete() : void
      {
         GameSpace.instance.moveLayer.removeChild(this);
      }
      
      private function done() : void
      {
         GameSpace.instance.moveLayer.removeChild(this);
      }
   }
}
