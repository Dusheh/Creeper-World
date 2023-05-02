package com.wbwar.creeper.util
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.GameSpace;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class PulsingArrow extends Sprite
   {
       
      
      private var arrowShape:Shape;
      
      public function PulsingArrow()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         this.arrowShape = new Shape();
         this.arrowShape.graphics.lineStyle(1,16777215);
         this.arrowShape.graphics.beginFill(5242880);
         this.arrowShape.graphics.moveTo(-7,-2);
         this.arrowShape.graphics.lineTo(0,-2);
         this.arrowShape.graphics.lineTo(0,-5);
         this.arrowShape.graphics.lineTo(7,0);
         this.arrowShape.graphics.lineTo(0,5);
         this.arrowShape.graphics.lineTo(0,2);
         this.arrowShape.graphics.lineTo(-7,2);
         this.arrowShape.graphics.lineTo(-7,-2);
         this.arrowShape.graphics.endFill();
         addChild(this.arrowShape);
         this.tweenOut();
         GameSpace.instance.tutorialLayer.addChild(this);
      }
      
      public function remove() : void
      {
         if(GameSpace.instance.tutorialLayer.contains(this))
         {
            GameSpace.instance.tutorialLayer.removeChild(this);
         }
      }
      
      private function tweenOut() : void
      {
         Tweener.addTween(this.arrowShape,{
            "time":0.5,
            "x":-15,
            "transition":"linear",
            "onComplete":this.tweenIn
         });
      }
      
      private function tweenIn() : void
      {
         if(parent != null)
         {
            Tweener.addTween(this.arrowShape,{
               "time":0.5,
               "x":0,
               "transition":"linear",
               "onComplete":this.tweenOut
            });
         }
      }
   }
}
