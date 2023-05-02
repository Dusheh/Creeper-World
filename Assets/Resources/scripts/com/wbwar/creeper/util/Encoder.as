package com.wbwar.creeper.util
{
   import flash.utils.ByteArray;
   
   public class Encoder
   {
      
      public static var ALPHABET:Array = ["J","N","D","M","G","H","B","K","F","C","P","Z","R","Y","W","X"];
       
      
      public function Encoder()
      {
         super();
      }
      
      public static function encode(param1:ByteArray) : String
      {
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ += alphaMap(param1[_loc3_]);
            _loc3_++;
         }
         return insertDashes(_loc2_);
      }
      
      public static function decode(param1:String) : ByteArray
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc2_:String = removeDashes(param1);
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = _loc2_.charAt(_loc4_);
            _loc6_ = _loc2_.charAt(_loc4_ + 1);
            _loc3_.writeByte(alphaUnmap(_loc5_,_loc6_));
            _loc4_ += 2;
         }
         return _loc3_;
      }
      
      private static function alphaMap(param1:int) : String
      {
         var _loc2_:* = (param1 & 240) >>> 4 & 15;
         var _loc3_:* = param1 & 15;
         return NaN;
      }
      
      private static function alphaUnmap(param1:String, param2:String) : int
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < ALPHABET.length)
         {
            if(ALPHABET[_loc3_] == param1)
            {
               break;
            }
            _loc3_++;
         }
         var _loc4_:int = int((_loc3_ & 15) << 4);
         _loc3_ = 0;
         while(_loc3_ < ALPHABET.length)
         {
            if(ALPHABET[_loc3_] == param2)
            {
               break;
            }
            _loc3_++;
         }
         return int(int(_loc4_ | _loc3_ & 15));
      }
      
      private static function insertDashes(param1:String) : String
      {
         var _loc2_:* = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ += param1.charAt(_loc3_);
            if((_loc3_ + 1) % 4 == 0 && _loc3_ != param1.length - 1)
            {
               _loc2_ += "-";
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private static function removeDashes(param1:String) : String
      {
         var _loc4_:* = null;
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if((_loc4_ = param1.charAt(_loc3_)) != "-")
            {
               _loc2_ += _loc4_;
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}
