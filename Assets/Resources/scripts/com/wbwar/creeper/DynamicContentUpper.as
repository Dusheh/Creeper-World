package com.wbwar.creeper
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public final class DynamicContentUpper extends Bitmap
   {
       
      
      private var updateCount:int;
      
      private var bm:Bitmap;
      
      private var bmd:BitmapData;
      
      private var fullRect:Rectangle;
      
      public function DynamicContentUpper()
      {
         super();
         this.bmd = new BitmapData(0 * 0,0 * 0,true,0);
         this.bitmapData = this.bmd;
         this.fullRect = new Rectangle(0,0,0 * 0,0 * 0);
         this.width = 700;
         this.height = 480;
      }
      
      public function update() : void
      {
         ++this.updateCount;
         if((this.updateCount + 3) % 12 == 0)
         {
            this.bmd.lock();
            this.bmd.fillRect(this.fullRect,0);
            GameSpace.instance.mistLayer.update(this.bmd);
            GameSpace.instance.exhaustLayer.update(this.bmd);
            this.bmd.unlock();
         }
      }
   }
}
