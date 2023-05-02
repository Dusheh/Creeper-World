package com.wbwar.creeper.util
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.geom.Matrix;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class BackgroundImageLoader
   {
       
      
      private var imageLoader:Loader;
      
      private var callback:Function;
      
      public function BackgroundImageLoader()
      {
         super();
         this.imageLoader = new Loader();
         this.imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadImageComplete);
         this.imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.loadImageError);
      }
      
      public function loadByteArray(param1:ByteArray, param2:Function) : void
      {
         this.callback = param2;
         this.imageLoader.loadBytes(param1);
      }
      
      public function load(param1:URLRequest, param2:Function) : void
      {
         this.callback = param2;
         this.imageLoader.load(param1);
      }
      
      private function loadImageComplete(param1:Event) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc2_:Bitmap = Bitmap(this.imageLoader.content);
         var _loc3_:int = _loc2_.width;
         var _loc4_:int = _loc2_.height;
         if(_loc3_ == 700 && _loc4_ == 480)
         {
            this.callback(_loc2_);
         }
         else
         {
            _loc5_ = new BitmapData(700,480,false,0);
            (_loc6_ = new Matrix()).scale(700 / _loc3_,480 / _loc4_);
            _loc5_.draw(_loc2_.bitmapData,_loc6_);
            this.callback(new Bitmap(_loc5_));
         }
      }
      
      private function loadImageError(param1:IOErrorEvent) : void
      {
         this.callback(null);
      }
   }
}
