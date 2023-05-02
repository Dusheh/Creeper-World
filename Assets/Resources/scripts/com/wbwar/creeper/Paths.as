package com.wbwar.creeper
{
   import caurina.transitions.Tweener;
   import flash.display.Sprite;
   
   public final class Paths extends Sprite
   {
       
      
      private var pathLayer:Sprite;
      
      public function Paths()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         this.pathLayer = new Sprite();
         this.pathLayer.mouseEnabled = false;
         addChild(this.pathLayer);
      }
      
      private function tweenOut() : void
      {
         Tweener.addTween(this,{
            "_Glow_blurX":6,
            "_Glow_blurY":6,
            "time":0.5,
            "transition":"linear",
            "onComplete":this.tweenIn
         });
      }
      
      private function tweenIn() : void
      {
         Tweener.addTween(this,{
            "_Glow_blurX":2,
            "_Glow_blurY":2,
            "time":0.5,
            "transition":"linear",
            "onComplete":this.tweenOut
         });
      }
      
      public function addPath(param1:Path) : void
      {
         this.pathLayer.addChild(param1);
      }
      
      public function removePath(param1:Path) : void
      {
         this.pathLayer.removeChild(param1);
      }
      
      public function update() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = this.pathLayer.numChildren - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = this.pathLayer.getChildAt(_loc2_) as Path;
            _loc1_.update();
            _loc2_--;
         }
      }
   }
}
