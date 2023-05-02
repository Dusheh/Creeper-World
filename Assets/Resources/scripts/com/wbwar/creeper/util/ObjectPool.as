package com.wbwar.creeper.util
{
   public class ObjectPool
   {
       
      
      private var _minSize:int;
      
      private var _maxSize:int;
      
      public var size:int = 0;
      
      public var create:Function;
      
      public var clean:Function;
      
      public var length:int = 0;
      
      private var list:Array;
      
      private var disposed:Boolean = false;
      
      public function ObjectPool(param1:Function, param2:Function = null, param3:int = 50, param4:int = 200)
      {
         this.list = [];
         super();
         this.create = param1;
         this.clean = param2;
         this.minSize = param3;
         this.maxSize = param4;
         var _loc5_:int = 0;
         while(_loc5_ < param3)
         {
            this.add();
            _loc5_++;
         }
      }
      
      private function add() : void
      {
         var _loc1_:* = this.length++;
         this.list[_loc1_] = this.create();
         ++this.size;
      }
      
      public function set minSize(param1:int) : void
      {
         this._minSize = param1;
         if(this._minSize > this._maxSize)
         {
            this._maxSize = this._minSize;
         }
         if(this._maxSize < this.list.length)
         {
            this.list.splice(this._maxSize);
         }
         this.size = this.list.length;
      }
      
      public function get minSize() : int
      {
         return this._minSize;
      }
      
      public function set maxSize(param1:int) : void
      {
         this._maxSize = param1;
         if(this._maxSize < this.list.length)
         {
            this.list.splice(this._maxSize);
         }
         this.size = this.list.length;
         if(this._maxSize < this._minSize)
         {
            this._minSize = this._maxSize;
         }
      }
      
      public function get maxSize() : int
      {
         return this._maxSize;
      }
      
      public function checkOut() : *
      {
         if(this.length == 0)
         {
            if(this.size < this.maxSize)
            {
               ++this.size;
               return this.create();
            }
            return null;
         }
         return this.list[--this.length];
      }
      
      public function checkIn(param1:*) : void
      {
         if(this.clean != null)
         {
            this.clean(param1);
         }
         var _loc2_:* = this.length++;
         this.list[_loc2_] = param1;
      }
      
      public function dispose() : void
      {
         if(this.disposed)
         {
            return;
         }
         this.disposed = true;
         this.create = null;
         this.clean = null;
         this.list = null;
      }
   }
}
