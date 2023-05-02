package com.wbwar.creeper
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public final class Walls extends Sprite
   {
      
      private static var wallImage:Class = Walls_wallImage;
      
      private static var wallBitmap:Bitmap = new wallImage() as Bitmap;
      
      public static var wallBmd:BitmapData = new BitmapData(GameSpace.CELL_WIDTH_S,GameSpace.CELL_HEIGHT_S,true,0);
      
      private static var superwallImage:Class = Walls_superwallImage;
      
      private static var superwallBitmap:Bitmap = new superwallImage() as Bitmap;
      
      public static var superwallBmd:BitmapData = new BitmapData(GameSpace.CELL_WIDTH_S,GameSpace.CELL_HEIGHT_S,true,0);
      
      private static var matrix:Matrix = new Matrix();
      
      {
         matrix.scale(0 / 0,0 / 0);
         wallBmd.draw(wallBitmap.bitmapData,matrix,null,null,null,true);
         superwallBmd.draw(superwallBitmap.bitmapData,matrix,null,null,null,true);
      }
      
      public var wallData:Array;
      
      public function Walls()
      {
         super();
      }
      
      public function setData(param1:Array) : void
      {
         this.wallData = param1;
      }
      
      public function update() : void
      {
      }
   }
}
