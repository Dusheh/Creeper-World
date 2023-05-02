package com.wbwar.creeper
{
   import com.wbwar.creeper.util.ColorUtil;
   import com.wbwar.creeper.util.ObjectPool;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public final class MistLayer
   {
      
      public static const MAX_AGE:int = 20;
      
      private static const BMDWIDTH:int = 160;
      
      private static const BMDHEIGHT:int = 160;
      
      private static const VARIANTCOUNT:int = 5;
      
      private static const ALPHACOUNT:int = 32;
      
      private static var mistBMD:Array = [];
      
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
      
      public function MistLayer()
      {
         this.p = new Point();
         super();
         this.miPool = new ObjectPool(function():Mi
         {
            return new Mi();
         },null,1000,5000);
      }
      
      public static function setup() : void
      {
         setupCustom(5263568,5263600);
      }
      
      public static function setupCustom(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         mistBMD = [];
         fullRect = new Rectangle(0,0,0 * 0,0 * 0);
         sr = new Rectangle(0,0,BMDWIDTH,BMDHEIGHT);
         dp = new Point(0,0);
         var _loc4_:int = 0;
         while(_loc4_ < VARIANTCOUNT)
         {
            _loc3_ = 1 + int(Math.random() * 10000);
            _loc5_ = 0;
            while(_loc5_ < ALPHACOUNT)
            {
               if(_loc4_ < 4)
               {
                  _loc6_ = ColorUtil.cloud(0,param1,1 - _loc5_ / (ALPHACOUNT - 1),0,_loc3_);
               }
               else
               {
                  _loc6_ = ColorUtil.cloud(0,param2,1 - _loc5_ / (ALPHACOUNT - 1),0,_loc3_);
               }
               _loc7_ = new BitmapData(BMDWIDTH,BMDHEIGHT,true,0);
               (_loc8_ = new Matrix()).translate(BMDWIDTH / 2,BMDHEIGHT / 2);
               _loc7_.draw(_loc6_,_loc8_);
               mistBMD.push(_loc7_);
               _loc5_++;
            }
            _loc4_++;
         }
      }
      
      public function addMistRandom(param1:int, param2:int, param3:Number) : void
      {
         if(Math.random() < param3)
         {
            this.addMist(param1,param2);
         }
      }
      
      public function addMist(param1:int, param2:int, param3:int = -1) : Mi
      {
         if(param1 < 0 || param2 < 0 || param1 >= GameSpace.WIDTH || param2 >= GameSpace.HEIGHT)
         {
            return null;
         }
         var _loc4_:Mi;
         (_loc4_ = this.miPool.checkOut()).prev = null;
         _loc4_.next = null;
         _loc4_.age = 0;
         _loc4_.x = param1 * 0 + 0;
         _loc4_.y = param2 * 0 + 0;
         if(param3 == -1)
         {
            _loc4_.variant = int(Math.random() * 5);
         }
         else
         {
            _loc4_.variant = param3;
         }
         var _loc5_:Number = Math.random() * 2 * 0;
         var _loc6_:Number = Math.random() * 2;
         _loc4_.deltaX = Math.cos(_loc5_) * _loc6_;
         _loc4_.deltaY = Math.sin(_loc5_) * _loc6_;
         this.addMi(_loc4_);
         return _loc4_;
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
               this.p.x = this.mi.x + 0 - BMDWIDTH / 2;
               this.p.y = this.mi.y + 0 - BMDHEIGHT / 2;
               param1.copyPixels(mistBMD[_loc2_ + ALPHACOUNT * this.mi.variant],sr,this.p,null,null,true);
            }
            this.mi = this.mi.next;
         }
      }
   }
}
