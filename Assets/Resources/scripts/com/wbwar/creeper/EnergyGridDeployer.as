package com.wbwar.creeper
{
   import com.wbwar.creeper.util.LOS;
   
   public final class EnergyGridDeployer
   {
       
      
      private var energyGridCache:Array;
      
      private var RANGE:int;
      
      private var place:Place;
      
      private var deployed:Boolean;
      
      private var gameSpaceX:int;
      
      private var gameSpaceY:int;
      
      public function EnergyGridDeployer(param1:int, param2:Place)
      {
         super();
         this.RANGE = param1;
         this.place = param2;
         this.energyGridCache = [int(this.RANGE) * int(this.RANGE)];
         var _loc3_:int = 0;
         while(_loc3_ < this.energyGridCache.length)
         {
            this.energyGridCache[_loc3_] = false;
            _loc3_++;
         }
      }
      
      public function undeployEnergyGrid() : void
      {
         /*
          * 反编译出错
          * 代码可能被加密
          * 已激活反混淆功能，但反编译仍然失败。如果未混淆文件，请禁用"自动反混淆"以获得更好的结果。
          * 错误类型: NullPointerException (null)
          */
         throw new flash.errors.IllegalOperationError("由于错误未反编译");
      }
      
      public function deployEnergyGrid() : void
      {
         /*
          * 反编译出错
          * 代码可能被加密
          * 已激活反混淆功能，但反编译仍然失败。如果未混淆文件，请禁用"自动反混淆"以获得更好的结果。
          * 错误类型: NullPointerException (null)
          */
         throw new flash.errors.IllegalOperationError("由于错误未反编译");
      }
   }
}
