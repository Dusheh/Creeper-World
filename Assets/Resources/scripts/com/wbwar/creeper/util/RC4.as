package com.wbwar.creeper.util
{
   import flash.utils.ByteArray;
   
   public class RC4
   {
      
      protected static var sbox:Array = new Array(255);
      
      protected static var mykey:Array = new Array(255);
       
      
      public function RC4()
      {
         super();
      }
      
      private static function arrayToByteArray(param1:Array) : ByteArray
      {
         var _loc3_:int = 0;
         var _loc2_:ByteArray = new ByteArray();
         for each(_loc3_ in param1)
         {
            _loc2_.writeByte(_loc3_);
         }
         return _loc2_;
      }
      
      public static function encryptBANoHex(param1:ByteArray, param2:String) : ByteArray
      {
         var _loc3_:Array = baToChars(param1);
         var _loc4_:Array = strToChars(param2);
         return arrayToByteArray(calculate(_loc3_,_loc4_));
      }
      
      public static function encryptBA(param1:ByteArray, param2:String) : String
      {
         var _loc3_:Array = baToChars(param1);
         var _loc4_:Array = strToChars(param2);
         var _loc5_:Array = calculate(_loc3_,_loc4_);
         return charsToHex(_loc5_);
      }
      
      public static function decryptBA(param1:String, param2:String) : ByteArray
      {
         var _loc3_:Array = hexToChars(param1);
         var _loc4_:Array = strToChars(param2);
         var _loc5_:Array = calculate(_loc3_,_loc4_);
         return charsToBa(_loc5_);
      }
      
      public static function encrypt(param1:String, param2:String) : String
      {
         var _loc3_:Array = strToChars(param1);
         var _loc4_:Array = strToChars(param2);
         var _loc5_:Array = calculate(_loc3_,_loc4_);
         return charsToHex(_loc5_);
      }
      
      public static function decrypt(param1:String, param2:String) : String
      {
         var _loc3_:Array = hexToChars(param1);
         var _loc4_:Array = strToChars(param2);
         var _loc5_:Array = calculate(_loc3_,_loc4_);
         return charsToStr(_loc5_);
      }
      
      protected static function initialize(param1:Array) : void
      {
         var _loc3_:* = NaN;
         var _loc5_:* = NaN;
         var _loc2_:* = 0;
         var _loc4_:Number = param1.length;
         _loc5_ = 0;
         while(_loc5_ <= 255)
         {
            mykey[_loc5_] = param1[_loc5_ % _loc4_];
            sbox[_loc5_] = _loc5_;
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ <= 255)
         {
            _loc2_ = Number((_loc2_ + sbox[_loc5_] + mykey[_loc5_]) % 256);
            _loc3_ = 0;
            sbox[_loc5_] = sbox[_loc2_];
            sbox[_loc2_] = _loc3_;
            _loc5_++;
         }
      }
      
      protected static function calculate(param1:Array, param2:Array) : Array
      {
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:Number = NaN;
         var _loc10_:* = NaN;
         initialize(param2);
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:Array = new Array();
         var _loc9_:* = 0;
         while(_loc9_ < param1.length)
         {
            _loc3_ = Number((_loc3_ + 1) % 256);
            _loc4_ = Number((_loc4_ + sbox[_loc3_]) % 256);
            _loc7_ = 0;
            sbox[_loc3_] = sbox[_loc4_];
            sbox[_loc4_] = _loc7_;
            _loc10_ = 0;
            _loc6_ = 0;
            _loc8_ = param1[_loc9_] ^ _loc6_;
            _loc5_.push(_loc8_);
            _loc9_++;
         }
         return _loc5_;
      }
      
      public static function charsToHex(param1:Array) : String
      {
         var _loc2_:String = new String("");
         var _loc3_:Array = new Array("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f");
         var _loc4_:* = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_ += _loc3_[param1[_loc4_] >> 4] + _loc3_[param1[_loc4_] & 15];
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function hexToChars(param1:String) : Array
      {
         var _loc2_:Array = new Array();
         var _loc3_:Number = param1.substr(0,2) == "0x" ? 2 : Number(0);
         while(_loc3_ < param1.length)
         {
            _loc2_.push(parseInt(param1.substr(_loc3_,2),16));
            _loc3_ += 2;
         }
         return _loc2_;
      }
      
      public static function charsToStr(param1:Array) : String
      {
         var _loc2_:String = new String("");
         var _loc3_:* = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ += String.fromCharCode(param1[_loc3_]);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function strToChars(param1:String) : Array
      {
         var _loc2_:Array = new Array();
         var _loc3_:* = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(param1.charCodeAt(_loc3_));
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function baToChars(param1:ByteArray) : Array
      {
         var _loc2_:* = [];
         param1.position = 0;
         var _loc3_:int = param1.bytesAvailable;
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_[_loc4_] = param1.readUnsignedByte();
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function charsToBa(param1:Array) : ByteArray
      {
         var _loc2_:ByteArray = new ByteArray();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.writeByte(param1[_loc3_]);
            _loc3_++;
         }
         _loc2_.position = 0;
         return _loc2_;
      }
   }
}
