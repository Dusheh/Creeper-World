package com.hurlant.crypto.hash
{
   public class SHA1 extends SHABase implements IHash
   {
      
      public static const HASH_SIZE:int = 20;
       
      
      public function SHA1()
      {
         super();
      }
      
      private function ft(param1:uint, param2:uint, param3:uint, param4:uint) : uint
      {
         if(param1 < 20)
         {
            return param2 & param3 | ~param2 & param4;
         }
         if(param1 < 40)
         {
            return param2 ^ param3 ^ param4;
         }
         if(param1 < 60)
         {
            return param2 & param3 | param2 & param4 | param3 & param4;
         }
         return param2 ^ param3 ^ param4;
      }
      
      private function kt(param1:uint) : uint
      {
         return param1 < 20 ? 1518500249 : (param1 < 40 ? 1859775393 : (param1 < 60 ? 2400959708 : uint(3395469782)));
      }
      
      override public function toString() : String
      {
         return "sha1";
      }
      
      override public function getHashSize() : uint
      {
         return HASH_SIZE;
      }
      
      private function rol(param1:uint, param2:uint) : uint
      {
         return param1 << param2 | param1 >>> 32 - param2;
      }
      
      override protected function core(param1:Array, param2:uint) : Array
      {
         var _loc3_:* = null;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:* = 0;
         var _loc16_:* = 0;
         param1[param2 >> 5] |= 128 << 24 - param2 % 32;
         param1[(param2 + 64 >> 9 << 4) + 15] = param2;
         _loc3_ = [];
         _loc4_ = 1732584193;
         _loc5_ = 4023233417;
         _loc6_ = 2562383102;
         _loc7_ = 271733878;
         _loc8_ = 3285377520;
         _loc9_ = 0;
         while(_loc9_ < param1.length)
         {
            _loc10_ = uint(_loc4_);
            _loc11_ = uint(_loc5_);
            _loc12_ = uint(_loc6_);
            _loc13_ = uint(_loc7_);
            _loc14_ = uint(_loc8_);
            _loc15_ = 0;
            while(_loc15_ < 80)
            {
               if(_loc15_ < 16)
               {
                  _loc3_[_loc15_] = param1[_loc9_ + _loc15_] || false;
               }
               else
               {
                  _loc3_[_loc15_] = rol(_loc3_[_loc15_ - 3] ^ _loc3_[_loc15_ - 8] ^ _loc3_[_loc15_ - 14] ^ _loc3_[_loc15_ - 16],1);
               }
               _loc16_ = uint(rol(_loc4_,5) + ft(_loc15_,_loc5_,_loc6_,_loc7_) + _loc8_ + _loc3_[_loc15_] + kt(_loc15_));
               _loc8_ = uint(_loc7_);
               _loc7_ = uint(_loc6_);
               _loc6_ = uint(rol(_loc5_,30));
               _loc5_ = uint(_loc4_);
               _loc4_ = uint(_loc16_);
               _loc15_++;
            }
            _loc4_ += _loc10_;
            _loc5_ += _loc11_;
            _loc6_ += _loc12_;
            _loc7_ += _loc13_;
            _loc8_ += _loc14_;
            _loc9_ += 16;
         }
         return [_loc4_,_loc5_,_loc6_,_loc7_,_loc8_];
      }
   }
}
