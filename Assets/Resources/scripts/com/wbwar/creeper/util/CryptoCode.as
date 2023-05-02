package com.wbwar.creeper.util
{
   import com.hurlant.crypto.Crypto;
   import com.hurlant.crypto.symmetric.ICipher;
   import com.hurlant.crypto.symmetric.IPad;
   import com.hurlant.crypto.symmetric.PKCS5;
   import com.hurlant.util.Base64;
   import com.hurlant.util.Hex;
   import flash.display.Sprite;
   import flash.utils.ByteArray;
   
   public class CryptoCode extends Sprite
   {
      
      private static var type:String = "simple-des-ecb";
       
      
      public function CryptoCode()
      {
         super();
      }
      
      public static function encryptByteArray(param1:String, param2:ByteArray) : ByteArray
      {
         var _loc3_:ByteArray = Hex.toArray(Hex.fromString(param1));
         var _loc4_:IPad = new PKCS5();
         var _loc5_:ICipher = Crypto.getCipher(type,_loc3_,_loc4_);
         _loc4_.setBlockSize(_loc5_.getBlockSize());
         _loc5_.encrypt(param2);
         return param2;
      }
      
      public static function decryptByteArray(param1:String, param2:ByteArray) : ByteArray
      {
         var _loc3_:ByteArray = Hex.toArray(Hex.fromString(param1));
         var _loc4_:IPad = new PKCS5();
         var _loc5_:ICipher = Crypto.getCipher(type,_loc3_,_loc4_);
         _loc4_.setBlockSize(_loc5_.getBlockSize());
         _loc5_.decrypt(param2);
         param2.position = 0;
         return param2;
      }
      
      public static function encrypt(param1:String, param2:String = "") : String
      {
         var _loc3_:ByteArray = Hex.toArray(Hex.fromString(param1));
         var _loc4_:ByteArray = Hex.toArray(Hex.fromString(param2));
         var _loc5_:IPad = new PKCS5();
         var _loc6_:ICipher = Crypto.getCipher(type,_loc3_,_loc5_);
         _loc5_.setBlockSize(_loc6_.getBlockSize());
         _loc6_.encrypt(_loc4_);
         return Base64.encodeByteArray(_loc4_);
      }
      
      public static function decrypt(param1:String, param2:String = "") : String
      {
         var _loc3_:ByteArray = Hex.toArray(Hex.fromString(param1));
         var _loc4_:ByteArray = Base64.decodeToByteArray(param2);
         var _loc5_:IPad = new PKCS5();
         var _loc6_:ICipher = Crypto.getCipher(type,_loc3_,_loc5_);
         _loc5_.setBlockSize(_loc6_.getBlockSize());
         _loc6_.decrypt(_loc4_);
         return Hex.toString(Hex.fromArray(_loc4_));
      }
   }
}
