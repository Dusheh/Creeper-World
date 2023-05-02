package com.wbwar.creeper.util
{
   public class Navigation
   {
       
      
      public function Navigation()
      {
         super();
      }
      
      public static function toStandardAngle(param1:Number) : Number
      {
         var _loc3_:* = param1 % 360;
         param1 %= 360;
         var _loc2_:Number = 360 - (_loc3_ < 0 ? param1 + 360 : param1);
         return _loc2_ == 360 ? 0 : Number(_loc2_);
      }
      
      public static function angleSpan(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = toStandardAngle(param1);
         var _loc4_:Number = toStandardAngle(param2);
         var _loc5_:Number = toStandardAngle(_loc3_ - _loc4_);
         var _loc6_:Number;
         if((_loc6_ = 360 - toStandardAngle(_loc3_ - _loc4_)) < _loc5_)
         {
            return _loc6_;
         }
         return -_loc5_;
      }
   }
}
