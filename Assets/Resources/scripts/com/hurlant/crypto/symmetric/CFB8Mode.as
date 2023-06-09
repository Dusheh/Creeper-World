package com.hurlant.crypto.symmetric
{
   import flash.utils.ByteArray;
   
   public class CFB8Mode extends IVMode implements IMode
   {
       
      
      public function CFB8Mode(param1:ISymmetricKey, param2:IPad = null)
      {
         super(param1,null);
      }
      
      public function toString() : String
      {
         return key.toString() + "-cfb8";
      }
      
      public function decrypt(param1:ByteArray) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         _loc2_ = getIV4d();
         _loc3_ = new ByteArray();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = uint(param1[_loc4_]);
            _loc3_.position = 0;
            _loc3_.writeBytes(_loc2_);
            key.encrypt(_loc2_);
            param1[_loc4_] ^= _loc2_[0];
            _loc6_ = 0;
            while(_loc6_ < blockSize - 1)
            {
               _loc2_[_loc6_] = _loc3_[_loc6_ + 1];
               _loc6_++;
            }
            _loc2_[blockSize - 1] = _loc5_;
            _loc4_++;
         }
      }
      
      public function encrypt(param1:ByteArray) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         _loc2_ = getIV4e();
         _loc3_ = new ByteArray();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_.position = 0;
            _loc3_.writeBytes(_loc2_);
            key.encrypt(_loc2_);
            param1[_loc4_] ^= _loc2_[0];
            _loc5_ = 0;
            while(_loc5_ < blockSize - 1)
            {
               _loc2_[_loc5_] = _loc3_[_loc5_ + 1];
               _loc5_++;
            }
            _loc2_[blockSize - 1] = param1[_loc4_];
            _loc4_++;
         }
      }
   }
}
