package com.hurlant.crypto.symmetric
{
   import flash.utils.ByteArray;
   
   public class CBCMode extends IVMode implements IMode
   {
       
      
      public function CBCMode(param1:ISymmetricKey, param2:IPad = null)
      {
         super(param1,param2);
      }
      
      public function toString() : String
      {
         return key.toString() + "-cbc";
      }
      
      public function decrypt(param1:ByteArray) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         _loc2_ = getIV4d();
         _loc3_ = new ByteArray();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_.position = 0;
            _loc3_.writeBytes(param1,_loc4_,blockSize);
            key.decrypt(param1,_loc4_);
            _loc5_ = 0;
            while(_loc5_ < blockSize)
            {
               param1[_loc4_ + _loc5_] ^= _loc2_[_loc5_];
               _loc5_++;
            }
            _loc2_.position = 0;
            _loc2_.writeBytes(_loc3_,0,blockSize);
            _loc4_ += blockSize;
         }
         padding.unpad(param1);
      }
      
      public function encrypt(param1:ByteArray) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         padding.pad(param1);
         _loc2_ = getIV4e();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = 0;
            while(_loc4_ < blockSize)
            {
               param1[_loc3_ + _loc4_] ^= _loc2_[_loc4_];
               _loc4_++;
            }
            key.encrypt(param1,_loc3_);
            _loc2_.position = 0;
            _loc2_.writeBytes(param1,_loc3_,blockSize);
            _loc3_ += blockSize;
         }
      }
   }
}
