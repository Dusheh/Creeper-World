package com.wbwar.creeper.util
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.GameSpace;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class PulsingArrowGameSpace extends Sprite
   {
       
      
      private var arrowShape:Shape;
      
      private var gameSpaceRect:Shape;
      
      public function PulsingArrowGameSpace(param1:Boolean = false)
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         graphics.beginFill(0);
         graphics.drawCircle(0,0,2);
         this.gameSpaceRect = new Shape();
         this.gameSpaceRect.graphics.lineStyle(2,65280);
         if(param1)
         {
            this.gameSpaceRect.graphics.drawRect(0,0,0,0);
         }
         else
         {
            this.gameSpaceRect.graphics.drawRect(0,0,0,0);
         }
         addChild(this.gameSpaceRect);
         this.arrowShape = new Shape();
         this.arrowShape.graphics.lineStyle(1,16777215);
         this.arrowShape.graphics.beginFill(5242880);
         this.arrowShape.graphics.moveTo(-9,-3);
         this.arrowShape.graphics.lineTo(0,-3);
         this.arrowShape.graphics.lineTo(0,-7);
         this.arrowShape.graphics.lineTo(9,0);
         this.arrowShape.graphics.lineTo(0,7);
         this.arrowShape.graphics.lineTo(0,3);
         this.arrowShape.graphics.lineTo(-9,3);
         this.arrowShape.graphics.lineTo(-9,-3);
         this.arrowShape.graphics.endFill();
         this.arrowShape.rotation = 90;
         this.arrowShape.y = -7;
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
            "y":-19,
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
               "y":-3,
               "transition":"linear",
               "onComplete":this.tweenOut
            });
         }
      }
   }
}
