package com.wbwar.creeper.util
{
   import flash.display.BitmapData;
   import flash.display.BitmapDataChannel;
   import flash.display.Shape;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class MapMaker
   {
      
      private static var bigIslandMinR:int = 7;
      
      private static var bigIslandMaxR:int = 10;
      
      private static var smallIslandMinR:int = 3;
      
      private static var smallIslandMaxR:int = 5;
       
      
      public function MapMaker()
      {
         super();
      }
      
      public static function generateMap(param1:int, param2:Boolean) : Array
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc3_:* = [];
         var _loc4_:Rndm;
         (_loc4_ = new Rndm(param1)).random();
         if(param2)
         {
            _loc6_ = 0;
            while(_loc6_ < 3360)
            {
               _loc3_[_loc6_] = 2;
               _loc6_++;
            }
            _loc5_ = generageIslandBitmapData(param1,125,_loc4_);
            mapLayer(_loc3_,_loc5_,3);
         }
         else
         {
            _loc6_ = 0;
            while(_loc6_ < 3360)
            {
               _loc3_[_loc6_] = 1;
               _loc6_++;
            }
            if((param1 + 1) % 2 == 0)
            {
               _loc5_ = generateBitmapData(param1,100,_loc4_);
               mapLayer(_loc3_,_loc5_,2);
            }
            else
            {
               _loc6_ = 0;
               while(_loc6_ < 3360)
               {
                  _loc3_[_loc6_] = 2;
                  _loc6_++;
               }
            }
            _loc5_ = generateBitmapData(param1,125,_loc4_);
            mapLayer(_loc3_,_loc5_,3);
            _loc5_ = generateBitmapData(param1,150,_loc4_);
            mapLayer(_loc3_,_loc5_,4);
            if((param1 + 1) % 2 == 0)
            {
               _loc5_ = generateBitmapData(param1,175,_loc4_);
               mapLayer(_loc3_,_loc5_,5);
            }
         }
         return _loc3_;
      }
      
      private static function mapLayer(param1:Array, param2:BitmapData, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         while(_loc6_ < 3360)
         {
            _loc4_ = param2.getPixel(_loc6_ % 70,int(_loc6_ / 70));
            if((_loc5_ = int(_loc4_ & 255)) > 0)
            {
               param1[_loc6_] = param3;
            }
            _loc6_++;
         }
      }
      
      public static function generateBitmapData(param1:int, param2:int, param3:Rndm) : BitmapData
      {
         var _loc4_:BitmapData = new BitmapData(70,48,true,0);
         var _loc7_:int = 1 + (param1 + 1) % 2;
         var _loc8_:int = param1;
         var _loc11_:int = 0;
         var _loc13_:Point = new Point(0,0);
         var _loc14_:Point = new Point(0,0);
         var _loc15_:Array = [_loc13_,_loc14_];
         _loc4_.perlinNoise(30,20,_loc7_,_loc8_,false,true,_loc11_,true,_loc15_);
         var _loc16_:Number = param2;
         _loc4_.threshold(_loc4_,_loc4_.rect,new Point(),"<",_loc16_,4294901760,255,true);
         return _loc4_;
      }
      
      public static function generageIslandBitmapData(param1:int, param2:int, param3:Rndm) : BitmapData
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:* = null;
         var _loc4_:BitmapData = new BitmapData(70,48,true,0);
         var _loc7_:* = [];
         var _loc10_:int = 0;
         _loc11_ = 0;
         while(_loc11_ < 3)
         {
            do
            {
               _loc8_ = bigIslandMaxR + int((70 - 2 * bigIslandMaxR) * param3.random());
               _loc9_ = bigIslandMaxR + int((48 - 2 * bigIslandMaxR) * param3.random());
               _loc10_++;
            }
            while(!isLegalIslandLocation(_loc7_,_loc8_,_loc9_,true) && _loc10_ < 10000);
            
            _loc7_.push({
               "x":_loc8_,
               "y":_loc9_,
               "big":true,
               "thres":param2,
               "minR":bigIslandMinR,
               "maxR":bigIslandMaxR
            });
            _loc11_++;
         }
         _loc11_ = 0;
         while(_loc11_ < 6)
         {
            _loc10_ = 0;
            do
            {
               _loc8_ = smallIslandMaxR + int((70 - 2 * smallIslandMaxR) * param3.random());
               _loc9_ = smallIslandMaxR + int((48 - 2 * smallIslandMaxR) * param3.random());
               _loc10_++;
            }
            while(!isLegalIslandLocation(_loc7_,_loc8_,_loc9_,false) && _loc10_ < 10000);
            
            _loc7_.push({
               "x":_loc8_,
               "y":_loc9_,
               "big":false,
               "thres":param2,
               "minR":smallIslandMinR,
               "maxR":smallIslandMaxR
            });
            _loc11_++;
         }
         for each(_loc12_ in _loc7_)
         {
            generateIsland(_loc12_.x,_loc12_.y,_loc12_.thres,_loc12_.minR,_loc12_.maxR,!!_loc12_.big ? 3 : Number(1),param3,_loc4_);
         }
         return _loc4_;
      }
      
      private static function isLegalIslandLocation(param1:Array, param2:int, param3:int, param4:Boolean) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = null;
         for each(_loc9_ in param1)
         {
            _loc5_ = param2 - _loc9_.x;
            _loc6_ = param3 - _loc9_.y;
            _loc7_ = _loc5_ * _loc5_ + _loc6_ * _loc6_;
            if(param4)
            {
               _loc8_ = bigIslandMaxR;
            }
            else
            {
               _loc8_ = smallIslandMaxR;
            }
            if(_loc9_.big)
            {
               _loc8_ += bigIslandMaxR;
            }
            else
            {
               _loc8_ += smallIslandMaxR;
            }
            if(_loc7_ < _loc8_ * _loc8_)
            {
               return false;
            }
         }
         return true;
      }
      
      private static function generateIsland(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Number, param7:Rndm, param8:BitmapData) : void
      {
         var _loc9_:Array = generateUnevenEdge(param4,param5,3,param7);
         var _loc10_:Shape = drawIslandShape(param3,_loc9_);
         var _loc11_:Matrix;
         (_loc11_ = new Matrix()).translate(param1,param2);
         param8.draw(_loc10_,_loc11_);
      }
      
      private static function drawIslandShape(param1:Number, param2:Array) : Shape
      {
         var _loc3_:Shape = new Shape();
         var _loc4_:Number = 0 / param2.length;
         var _loc5_:* = 0;
         _loc3_.graphics.beginFill(param1);
         _loc3_.graphics.moveTo(param2[0] * Math.cos(_loc5_),param2[0] * Math.sin(_loc5_));
         var _loc6_:int = 1;
         while(_loc6_ < param2.length)
         {
            _loc3_.graphics.lineTo(param2[_loc6_] * Math.cos(_loc5_),param2[_loc6_] * Math.sin(_loc5_));
            _loc5_ += _loc4_;
            _loc6_++;
         }
         _loc3_.graphics.endFill();
         return _loc3_;
      }
      
      private static function generateUnevenEdge(param1:int, param2:int, param3:Number, param4:Rndm) : Array
      {
         var _loc5_:Number = param1 + (param2 - param1) / 2;
         var _loc6_:* = [];
         var _loc7_:int = 0;
         while(_loc7_ < 16)
         {
            _loc6_[_loc7_] = _loc5_;
            if((_loc5_ += param4.random() * param3 * 2 - param3) < param1)
            {
               _loc5_ = param1;
            }
            if(_loc5_ > param2)
            {
               _loc5_ = param2;
            }
            _loc7_++;
         }
         return _loc6_;
      }
   }
}
