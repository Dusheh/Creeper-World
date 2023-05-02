package com.wbwar.creeper
{
   import com.wbwar.creeper.util.LOS;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public final class WeaponDistIndicator extends Sprite
   {
       
      
      private var bm:Bitmap;
      
      private var bmd:BitmapData;
      
      private var color:Number;
      
      private var distCircles:Array;
      
      private var zeroPoint:Point;
      
      public function WeaponDistIndicator(param1:Number = 1627389951)
      {
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         this.distCircles = [];
         this.zeroPoint = new Point(0,0);
         super();
         mouseEnabled = false;
         mouseChildren = false;
         this.color = param1;
         this.bmd = new BitmapData(250,250,true,0);
         this.bm = new Bitmap(this.bmd);
         addChild(this.bm);
         var _loc2_:int = 1;
         while(_loc2_ < 20)
         {
            _loc3_ = new Shape();
            _loc3_.graphics.lineStyle(2,0,0.3);
            _loc3_.graphics.drawCircle(_loc2_ * 0,_loc2_ * 0,_loc2_ * 0);
            _loc4_ = _loc2_ * 0 * 2;
            (_loc5_ = new BitmapData(_loc4_,_loc4_,true,0)).draw(_loc3_);
            this.distCircles[_loc2_] = _loc5_;
            _loc2_++;
         }
      }
      
      public function refresh(param1:String, param2:int, param3:int, param4:int) : void
      {
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc5_:Boolean = true;
         var _loc6_:Boolean = false;
         if(param1 == "com.wbwar.creeper::AreaGun" || param1 == "com.wbwar.creeper::ABM" || param1 == "com.wbwar.creeper::ThorsHammer")
         {
            _loc5_ = false;
         }
         if(param1 == "com.wbwar.creeper::Node")
         {
            _loc6_ = true;
         }
         var _loc7_:BitmapData = this.distCircles[param2];
         this.bmd.lock();
         this.bmd.fillRect(new Rectangle(0,0,this.bmd.width,this.bmd.height),0);
         var _loc8_:int = param4 - param2;
         while(_loc8_ < param4 + param2)
         {
            _loc9_ = param3 - param2;
            while(_loc9_ < param3 + param2)
            {
               if(_loc9_ >= 0 && _loc8_ >= 0 && _loc9_ < GameSpace.WIDTH && _loc8_ < GameSpace.HEIGHT)
               {
                  if((_loc10_ = (param3 - _loc9_) * (param3 - _loc9_) + (param4 - _loc8_) * (param4 - _loc8_)) < param2 * param2)
                  {
                     if(!_loc5_ || LOS.hasLOS(param3,param4,_loc9_,_loc8_,false,_loc6_))
                     {
                        this.bmd.fillRect(new Rectangle((_loc9_ - param3 + param2) * 0 - 0,(_loc8_ - param4 + param2) * 0 - 0,GameSpace.CELL_WIDTH,GameSpace.CELL_HEIGHT),this.color);
                     }
                     else
                     {
                        this.bmd.fillRect(new Rectangle((_loc9_ - param3 + param2) * 0 - 0,(_loc8_ - param4 + param2) * 0 - 0,GameSpace.CELL_WIDTH,GameSpace.CELL_HEIGHT),1627324416);
                     }
                  }
               }
               _loc9_++;
            }
            _loc8_++;
         }
         if(_loc7_ != null)
         {
            this.bmd.copyPixels(_loc7_,_loc7_.rect,this.zeroPoint,null,null,true);
         }
         this.bmd.unlock();
         this.bm.x = -param2 * 0;
         this.bm.y = -param2 * 0;
      }
   }
}
