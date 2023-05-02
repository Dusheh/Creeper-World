package com.wbwar.creeper
{
   public final class GlopBlobProducerWave
   {
      
      public static const SIDE_TOP:int = 0;
      
      public static const SIDE_LEFT:int = 1;
      
      public static const SIDE_BOTTOM:int = 2;
      
      public static const SIDE_RIGHT:int = 3;
       
      
      public var activateTime:int;
      
      public var volleyAmt:int;
      
      public var volleyGroupSize:int;
      
      public var volleyDelay:int;
      
      public var volleyStrength:Number;
      
      public var volleySide:int;
      
      public function GlopBlobProducerWave(param1:int, param2:int, param3:int, param4:int, param5:Number, param6:int)
      {
         super();
         this.activateTime = param1;
         this.volleyAmt = param2;
         this.volleyGroupSize = param3;
         this.volleyDelay = param4;
         this.volleyStrength = param5;
         this.volleySide = param6;
      }
   }
}
