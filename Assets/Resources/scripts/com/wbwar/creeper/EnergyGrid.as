package com.wbwar.creeper
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public final class EnergyGrid
   {
      
      private static const ENERGY_AMT:Number = 1;
       
      
      private var updateCount:int;
      
      private var fullRect:Rectangle;
      
      private var energyRect:Rectangle;
      
      private var i:int;
      
      private var j:int;
      
      private var p:Point;
      
      public var energyBmd:BitmapData;
      
      public var energyGridData:Array;
      
      public function EnergyGrid()
      {
         this.energyGridData = new Array(0 * 0);
         super();
         var _loc1_:int = 0;
         while(_loc1_ < this.energyGridData.length)
         {
            this.energyGridData[_loc1_] = 0;
            _loc1_++;
         }
         this.createBitmap();
      }
      
      public function createBitmap(param1:Number = 2130743296) : void
      {
         this.energyBmd = new BitmapData(GameSpace.CELL_WIDTH_S,GameSpace.CELL_HEIGHT_S,true,param1);
      }
   }
}
