package com.wbwar.creeper.util
{
   public class Time
   {
       
      
      public function Time()
      {
         super();
      }
      
      public static function getTimeString(param1:int) : String
      {
         var _loc2_:int = int(param1 / 60);
         var _loc3_:int = param1 - _loc2_ * 60;
         var _loc4_:String = _loc3_ >= 10 ? String(_loc3_) : "0" + String(_loc3_);
         return String(_loc2_) + ":" + _loc4_;
      }
   }
}
