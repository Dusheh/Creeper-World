package com.wbwar.creeper
{
   public final class EnergyRequest
   {
       
      
      public var target:Place;
      
      public var type:int;
      
      public function EnergyRequest(param1:Place, param2:int)
      {
         super();
         this.target = param1;
         this.type = param2;
      }
   }
}
