package com.wbwar.creeper.screens
{
   public class UnchartedGameRow
   {
      
      private static const months:Array = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
       
      
      public var played:Boolean;
      
      public var mapNumber:int;
      
      public var mapName:String;
      
      public var score:int;
      
      public var playCount:int;
      
      public var playTime:Number;
      
      public function UnchartedGameRow(param1:Boolean, param2:int, param3:int, param4:int, param5:Number)
      {
         super();
         this.played = param1;
         this.mapNumber = param2;
         this.score = param3;
         this.playCount = param4;
         this.playTime = param5;
         var _loc6_:Object = UnchartedMapSelector.getDateFromDays(param2);
         this.mapName = "undefined " + _loc6_.day + ", " + UnchartedMapSelector.zeroPad(_loc6_.year,4);
      }
   }
}
