package
{
   import com.wbwar.creeper.util.CryptoCode;
   import com.wbwar.creeper.util.Encoder;
   import com.wbwar.creeper.util.RC4;
   import flash.utils.ByteArray;
   
   public class Gate
   {
       
      
      public function Gate()
      {
         super();
      }
      
      public static function check(param1:String) : Boolean
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         try
         {
            _loc2_ = Encoder.decode(param1);
            _loc3_ = CryptoCode.decryptByteArray(RC4.decrypt("48190ffea2a26dbae43ca77d","spaceestate12"),_loc2_);
            _loc4_ = uint(digest(_loc3_,5));
            _loc5_ = _loc3_.readInt();
            _loc6_ = uint(_loc3_.readByte() & 255);
            _loc7_ = uint(_loc3_.readByte() & 255);
            _loc8_ = uint(_loc3_.readByte() & 255);
            _loc9_ = uint(_loc7_ << 8 | _loc8_);
            if(_loc5_ % 97 == 0 && _loc4_ == _loc9_)
            {
               return true;
            }
            return false;
         }
         catch(e:Error)
         {
            return false;
         }
      }
      
      private static function guessQuad() : String
      {
         var _loc1_:String = "";
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            _loc1_ += Encoder.ALPHABET[int(Math.random() * 16)];
            _loc2_++;
         }
         return _loc1_;
      }
      
      public static function guess() : Boolean
      {
         var _loc1_:String = guessQuad() + "-" + guessQuad() + "-" + guessQuad() + "-" + guessQuad();
         return check(_loc1_);
      }
      
      private static function dump(param1:ByteArray) : void
      {
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ += param1[_loc3_] + " ";
            _loc3_++;
         }
      }
      
      private static function digest(param1:ByteArray, param2:int) : uint
      {
         var _loc4_:int = 0;
         var _loc3_:* = 0;
         while(_loc4_ < param2)
         {
            _loc3_ += uint(param1[_loc4_] & 255);
            _loc4_++;
         }
         return _loc3_;
      }
   }
}
