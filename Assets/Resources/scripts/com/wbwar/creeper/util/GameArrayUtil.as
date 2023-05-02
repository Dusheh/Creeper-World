package com.wbwar.creeper.util
{
   public class GameArrayUtil
   {
       
      
      public function GameArrayUtil()
      {
         super();
      }
      
      public static function csvAsIntArray(param1:String) : Array
      {
         var _loc2_:* = null;
         if(param1 == null || param1.length == 0)
         {
            return new Array();
         }
         _loc2_ = param1.split(",");
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc2_[_loc3_] = int(_loc2_[_loc3_]);
            _loc3_++;
         }
         return _loc2_;
      }
   }
}
