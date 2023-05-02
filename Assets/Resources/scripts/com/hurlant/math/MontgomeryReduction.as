package com.hurlant.math
{
   use namespace bi_internal;
   
   class MontgomeryReduction implements IReduction
   {
       
      
      private var um:int;
      
      private var mp:int;
      
      private var mph:int;
      
      private var mpl:int;
      
      private var mt2:int;
      
      private var m:BigInteger;
      
      function MontgomeryReduction(param1:BigInteger)
      {
         super();
         this.m = param1;
         mp = param1.invDigit();
         mpl = mp & 32767;
         mph = mp >> 15;
         um = 131071;
         mt2 = 2 * param1.t;
      }
      
      public function mulTo(param1:BigInteger, param2:BigInteger, param3:BigInteger) : void
      {
         param1.multiplyTo(param2,param3);
         reduce(param3);
      }
      
      public function revert(param1:BigInteger) : BigInteger
      {
         var _loc2_:* = null;
         _loc2_ = new BigInteger();
         param1.copyTo(_loc2_);
         reduce(_loc2_);
         return _loc2_;
      }
      
      public function convert(param1:BigInteger) : BigInteger
      {
         var _loc2_:* = null;
         _loc2_ = new BigInteger();
         param1.abs().dlShiftTo(m.t,_loc2_);
         _loc2_.divRemTo(m,null,_loc2_);
         if(param1.s < 0 && _loc2_.compareTo(BigInteger.ZERO) > 0)
         {
            m.subTo(_loc2_,_loc2_);
         }
         return _loc2_;
      }
      
      public function reduce(param1:BigInteger) : void
      {
         /*
          * 反编译出错
          * 代码可能被加密
          * 已激活反混淆功能，但反编译仍然失败。如果未混淆文件，请禁用"自动反混淆"以获得更好的结果。
          * 错误类型: NullPointerException (null)
          */
         throw new flash.errors.IllegalOperationError("由于错误未反编译");
      }
      
      public function sqrTo(param1:BigInteger, param2:BigInteger) : void
      {
         param1.squareTo(param2);
         reduce(param2);
      }
   }
}
