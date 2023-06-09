package com.hurlant.crypto.symmetric
{
   import flash.utils.ByteArray;
   
   public class OFBMode extends IVMode implements IMode
   {
       
      
      public function OFBMode(param1:ISymmetricKey, param2:IPad = null)
      {
         super(param1,null);
      }
      
      public function toString() : String
      {
         return key.toString() + "-ofb";
      }
      
      private function core(param1:ByteArray, param2:ByteArray) : void
      {
         var _loc3_:* = 0;
         var _loc4_:* = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         _loc3_ = uint(param1.length);
         _loc4_ = new ByteArray();
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            key.encrypt(param2);
            _loc4_.position = 0;
            _loc4_.writeBytes(param2);
            _loc6_ = uint(_loc5_ + blockSize < _loc3_ ? uint(blockSize) : uint(_loc3_ - _loc5_));
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               param1[_loc5_ + _loc7_] ^= param2[_loc7_];
               _loc7_++;
            }
            param2.position = 0;
            param2.writeBytes(_loc4_);
            _loc5_ += blockSize;
         }
      }
      
      public function decrypt(param1:ByteArray) : void
      {
         var _loc2_:* = null;
         _loc2_ = getIV4d();
         core(param1,_loc2_);
      }
      
      public function encrypt(param1:ByteArray) : void
      {
         var _loc2_:* = null;
         _loc2_ = getIV4e();
         core(param1,_loc2_);
      }
   }
}
