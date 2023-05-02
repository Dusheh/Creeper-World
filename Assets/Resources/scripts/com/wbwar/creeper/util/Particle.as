package com.wbwar.creeper.util
{
   public class Particle
   {
       
      
      public var prev:Particle;
      
      public var next:Particle;
      
      public var deltaX:Number = 0;
      
      public var deltaY:Number = 0;
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var age:int = 0;
      
      public var ready:Boolean;
      
      private var speed:Number;
      
      public function Particle(param1:Number)
      {
         super();
         this.speed = param1;
         this.reset();
      }
      
      public function reset() : void
      {
         this.ready = true;
         var _loc1_:Number = this.speed + Math.random();
         var _loc2_:Number = Math.random() * 2 * 0;
         this.deltaX = Math.cos(_loc2_) * _loc1_;
         this.deltaY = Math.sin(_loc2_) * _loc1_;
         this.x = 0;
         this.y = 0;
         this.age = 0;
      }
      
      public function update() : void
      {
         this.x += this.deltaX;
         this.y += this.deltaY;
         ++this.age;
      }
   }
}
