package com.wbwar.creeper
{
   import flash.display.Shape;
   
   public final class Path extends Shape
   {
       
      
      public var startPlace:Place;
      
      public var endPlace:Place;
      
      private var lastStartX:Number;
      
      private var lastStartY:Number;
      
      private var lastEndX:Number;
      
      private var lastEndY:Number;
      
      public var destroyed:Boolean;
      
      private var sqrt:Function;
      
      private var dx:Number;
      
      private var dy:Number;
      
      public function Path(param1:Place, param2:Place)
      {
         this.sqrt = Math.sqrt;
         super();
         this.startPlace = param1;
         this.endPlace = param2;
         GameSpace.instance.paths.addPath(this);
         this.update();
         cacheAsBitmap = true;
      }
      
      public function getOtherEnd(param1:Place) : Place
      {
         if(param1 == this.startPlace)
         {
            return this.endPlace;
         }
         return this.startPlace;
      }
      
      public function getDistance() : Number
      {
         this.dx = this.endPlace.x - this.startPlace.x;
         this.dy = this.endPlace.y - this.startPlace.y;
         return this.sqrt(this.dx * this.dx + this.dy * this.dy);
      }
      
      private function render() : void
      {
         x = this.startPlace.x;
         y = this.startPlace.y;
         graphics.clear();
         graphics.lineStyle(3,0,0.5);
         graphics.moveTo(0,0);
         graphics.lineTo(this.endPlace.x - this.startPlace.x,this.endPlace.y - this.startPlace.y);
         graphics.lineStyle(1,16777215,1);
         graphics.moveTo(0,0);
         graphics.lineTo(this.endPlace.x - this.startPlace.x,this.endPlace.y - this.startPlace.y);
      }
      
      public function update() : void
      {
         if(this.startPlace.x != this.lastStartX || this.startPlace.y != this.lastStartY || this.endPlace.x != this.lastEndX || this.endPlace.y != this.lastEndY)
         {
            this.lastStartX = this.startPlace.x;
            this.lastStartY = this.startPlace.y;
            this.lastEndX = this.endPlace.x;
            this.lastEndY = this.endPlace.y;
            this.render();
         }
      }
      
      public function destroy() : void
      {
         this.destroyed = true;
         this.startPlace.removePath(this);
         this.endPlace.removePath(this);
         GameSpace.instance.paths.removePath(this);
      }
   }
}
