package com.wbwar.creeper
{
   import com.wbwar.creeper.util.ColorUtil;
   import com.wbwar.creeper.util.ObjectPool;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public final class ExhaustLayer
   {
      
      public static const MAX_AGE:int = 10;
      
      private static const BMDWIDTH:int = 60;
      
      private static const BMDHEIGHT:int = 60;
      
      private static const VARIANTCOUNT:int = 4;
      
      private static const ALPHACOUNT:int = 32;
      
      private static var exhaustBMD:Array = [];
      
      private static var fullRect:Rectangle;
      
      private static var sr:Rectangle;
      
      private static var dp:Point;
      
      {
         setup();
      }
      
      private var updateCount:int;
      
      private var miPool:ObjectPool;
      
      private var miHead:Mi = null;
      
      private var miTail:Mi = null;
      
      private var miCount:int = 0;
      
      private var p:Point;
      
      private var mi:Mi;
      
      public function ExhaustLayer()
      {
         this.p = new Point();
         super();
         this.miPool = new ObjectPool(function():Mi
         {
            return new Mi();
         },null,1000,5000);
      }
      
      private static function setup() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         fullRect = new Rectangle(0,0,0 * 0,0 * 0);
         sr = new Rectangle(0,0,BMDWIDTH,BMDHEIGHT);
         dp = new Point(0,0);
         var _loc2_:int = 0;
         while(_loc2_ < VARIANTCOUNT)
         {
            _loc1_ = 1 + int(Math.random() * 10000);
            _loc3_ = 0;
            while(_loc3_ < ALPHACOUNT)
            {
               _loc4_ = ColorUtil.cloud((1 - (_loc3_ + 1) / ALPHACOUNT) * 3 * 0,13684944,1 - _loc3_ / (ALPHACOUNT - 1),0,_loc1_);
               _loc5_ = new BitmapData(BMDWIDTH,BMDHEIGHT,true,0);
               (_loc6_ = new Matrix()).translate(BMDWIDTH / 2,BMDHEIGHT / 2);
               _loc5_.draw(_loc4_,_loc6_);
               exhaustBMD.push(_loc5_);
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function addExhaustMoving(param1:int, param2:int, param3:Number, param4:Number) : void
      {
         var _loc5_:Mi;
         (_loc5_ = this.miPool.checkOut()).prev = null;
         _loc5_.next = null;
         _loc5_.age = 0;
         _loc5_.x = param1;
         _loc5_.y = param2;
         _loc5_.deltaX = param3;
         _loc5_.deltaY = param4;
         _loc5_.variant = int(Math.random() * 4);
         this.addMi(_loc5_);
      }
      
      public function addExhaust(param1:int, param2:int) : void
      {
         var _loc3_:Mi = this.miPool.checkOut();
         _loc3_.prev = null;
         _loc3_.next = null;
         _loc3_.age = 0;
         _loc3_.x = param1;
         _loc3_.y = param2;
         _loc3_.variant = int(Math.random() * 4);
         this.addMi(_loc3_);
      }
      
      private function addMi(param1:Mi) : void
      {
         if(this.miHead == null)
         {
            param1.prev = null;
            param1.next = null;
         }
         else
         {
            param1.prev = null;
            param1.next = this.miHead;
            this.miHead.prev = param1;
         }
         this.miHead = param1;
         ++this.miCount;
      }
      
      private function removeMi(param1:Mi) : void
      {
         if(this.miHead == null)
         {
            return;
         }
         if(param1.prev == null && param1.next == null)
         {
            this.miHead = null;
         }
         else
         {
            if(param1.prev != null)
            {
               param1.prev.next = param1.next;
            }
            if(param1.next != null)
            {
               param1.next.prev = param1.prev;
            }
         }
         --this.miCount;
      }
      
      public function update(param1:BitmapData) : void
      {
         var _loc2_:int = 0;
         ++this.updateCount;
         this.mi = this.miHead;
         while(this.mi != null)
         {
            if(this.mi.age > MAX_AGE)
            {
               this.removeMi(this.mi);
               this.miPool.checkIn(this.mi);
            }
            else
            {
               ++this.mi.age;
               this.mi.x += this.mi.deltaX;
               this.mi.y += this.mi.deltaY;
               _loc2_ = int(this.mi.age / MAX_AGE * ALPHACOUNT);
               if(_loc2_ >= ALPHACOUNT)
               {
                  _loc2_ = ALPHACOUNT - 1;
               }
               this.p.x = this.mi.x * 0 - BMDWIDTH / 2;
               this.p.y = this.mi.y * 0 - BMDHEIGHT / 2;
               param1.copyPixels(exhaustBMD[_loc2_ + ALPHACOUNT * this.mi.variant],sr,this.p,null,null,true);
            }
            this.mi = this.mi.next;
         }
      }
   }
}
