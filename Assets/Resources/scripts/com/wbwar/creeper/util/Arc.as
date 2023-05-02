package com.wbwar.creeper.util
{
   import flash.display.Graphics;
   
   public class Arc
   {
       
      
      public function Arc()
      {
         super();
      }
      
      public static function draw(param1:Graphics, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number = 0) : void
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         param1.moveTo(param2,param3);
         if(Math.abs(param5) > 360)
         {
            param5 = 360;
         }
         _loc10_ = Math.ceil(Math.abs(param5) / 45);
         _loc7_ = (_loc7_ = param5 / _loc10_) / 180 * 0;
         _loc8_ = param6 / 180 * 0;
         _loc11_ = param2 - Math.cos(_loc8_) * param4;
         _loc12_ = param3 - Math.sin(_loc8_) * param4;
         var _loc17_:int = 0;
         while(_loc17_ < _loc10_)
         {
            _loc9_ = (_loc8_ += _loc7_) - _loc7_ / 2;
            _loc13_ = _loc11_ + Math.cos(_loc8_) * param4;
            _loc14_ = _loc12_ + Math.sin(_loc8_) * param4;
            _loc15_ = _loc11_ + Math.cos(_loc9_) * (param4 / Math.cos(_loc7_ / 2));
            _loc16_ = _loc12_ + Math.sin(_loc9_) * (param4 / Math.cos(_loc7_ / 2));
            param1.curveTo(_loc15_,_loc16_,_loc13_,_loc14_);
            _loc17_++;
         }
      }
   }
}
