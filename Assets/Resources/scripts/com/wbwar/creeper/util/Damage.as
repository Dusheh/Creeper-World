package com.wbwar.creeper.util
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.Projectile;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class Damage extends Projectile
   {
       
      
      private var maxAge:int;
      
      private var particleHead:Particle;
      
      private var bm:Bitmap;
      
      private var particleCount:int;
      
      public var active:Boolean;
      
      private var particles:Array;
      
      private var particleOffset:int;
      
      private var PARTICLE_COUNT:int = 15;
      
      private var age:int;
      
      public function Damage(param1:int, param2:int, param3:int)
      {
         this.particles = [];
         super();
         this.maxAge = param2;
         this.age = param3;
         this.PARTICLE_COUNT = param1;
         this.init();
      }
      
      private function init() : void
      {
         mouseChildren = false;
         mouseEnabled = false;
         graphics.lineStyle(2,16711680);
         var _loc1_:BitmapData = new BitmapData(50,50,true,0);
         this.bm = new Bitmap(_loc1_);
         this.bm.x = -25;
         this.bm.y = -25;
         addChild(this.bm);
         var _loc2_:int = 0;
         while(_loc2_ < this.PARTICLE_COUNT)
         {
            this.particles[this.particleOffset] = new Particle(this.age);
            ++this.particleOffset;
            _loc2_++;
         }
         GameSpace.instance.projectiles.addProjectile(this);
      }
      
      private function done() : void
      {
         GameSpace.instance.projectiles.removeProjectile(this);
      }
      
      override public function update() : void
      {
         var _loc1_:* = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:int = 0;
         this.bm.bitmapData.lock();
         this.bm.bitmapData.fillRect(new Rectangle(0,0,this.bm.bitmapData.width,this.bm.bitmapData.height),0);
         var _loc3_:int = 0;
         while(_loc3_ < this.PARTICLE_COUNT)
         {
            _loc1_ = this.particles[_loc3_];
            if(_loc1_.ready)
            {
               _loc2_++;
               _loc1_.update();
               if(_loc1_.age >= this.maxAge)
               {
                  _loc1_.ready = false;
                  if(this.active)
                  {
                     _loc1_.reset();
                  }
               }
               else
               {
                  _loc4_ = (1 - _loc1_.age / this.maxAge) * 255;
                  _loc5_ = int(_loc4_) << 24 | 16777215;
                  this.bm.bitmapData.fillRect(new Rectangle(_loc1_.x + this.bm.bitmapData.width / 2,_loc1_.y + this.bm.bitmapData.height / 2,2,2),_loc5_);
               }
            }
            _loc3_++;
         }
         this.bm.bitmapData.unlock();
         if(_loc2_ == 0)
         {
            this.done();
         }
      }
   }
}
