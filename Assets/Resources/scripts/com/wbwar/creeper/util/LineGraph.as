package com.wbwar.creeper.util
{
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   
   public class LineGraph extends Sprite
   {
       
      
      private var WIDTH:int;
      
      private var HEIGHT:int;
      
      private var GRAPH_WIDTH:int;
      
      private var GRAPH_HEIGHT:int;
      
      public var lineColor;
      
      private var backgroundColor:Number;
      
      public var yMax:Number;
      
      private var _data:Array;
      
      private var dataLength:int;
      
      private var yText:TextField;
      
      private var grid:Shape;
      
      private var graphArea:Shape;
      
      private var nameText:TextField;
      
      public function LineGraph(param1:int, param2:int, param3:*, param4:Number, param5:String)
      {
         super();
         this.WIDTH = param1;
         this.HEIGHT = param2;
         this.lineColor = param3;
         this.backgroundColor = param4;
         this.grid = new Shape();
         addChild(this.grid);
         this.graphArea = new Shape();
         addChild(this.graphArea);
         this.graphArea.filters = [new DropShadowFilter(2,45,16777215)];
         if(param5 != null)
         {
            this.nameText = Text.text(param5,10,16777215);
            this.nameText.x = this.WIDTH / 2 - this.nameText.width / 2;
            this.nameText.y = this.HEIGHT - 2 - this.nameText.height;
            addChild(this.nameText);
            this.GRAPH_HEIGHT = this.nameText.y - 2;
         }
         else
         {
            this.GRAPH_HEIGHT = this.HEIGHT;
         }
      }
      
      public function set data(param1:Array) : void
      {
         this._data = param1;
         if(this._data[0] is Array)
         {
            this.dataLength = this._data[0].length;
         }
         else
         {
            this.dataLength = this._data.length;
         }
         this.draw();
      }
      
      public function get data() : Array
      {
         return this._data;
      }
      
      private function drawGrid() : void
      {
         var _loc3_:int = 0;
         graphics.clear();
         if(this.dataLength == 0)
         {
            return;
         }
         var _loc1_:Number = this.GRAPH_WIDTH / (this.dataLength - 1);
         var _loc2_:Number = this.GRAPH_HEIGHT / this.yMax;
         this.grid.graphics.beginFill(this.backgroundColor);
         this.grid.graphics.drawRect(0,0,this.GRAPH_WIDTH + 2,this.GRAPH_HEIGHT + 2);
         this.grid.graphics.endFill();
         this.grid.graphics.lineStyle(1,5263440);
         _loc3_ = 0;
         while(_loc3_ < this.dataLength)
         {
            this.grid.graphics.moveTo(_loc3_ * _loc1_,0);
            this.grid.graphics.lineTo(_loc3_ * _loc1_,this.GRAPH_HEIGHT);
            _loc3_ += 3;
         }
         _loc3_ = 0;
         while(_loc3_ < int(this.yMax))
         {
            this.grid.graphics.moveTo(0,this.GRAPH_HEIGHT - _loc3_ * _loc2_);
            this.grid.graphics.lineTo(this.GRAPH_WIDTH,this.GRAPH_HEIGHT - _loc3_ * _loc2_);
            _loc3_++;
         }
         this.grid.graphics.lineStyle(1,16777215);
         this.grid.graphics.drawRect(0,0,this.GRAPH_WIDTH + 2,this.GRAPH_HEIGHT + 2);
      }
      
      private function drawLine(param1:Array, param2:Number) : void
      {
         var _loc3_:* = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = this.GRAPH_WIDTH / (param1.length - 1);
         var _loc6_:Number = this.GRAPH_HEIGHT / this.yMax;
         _loc3_ = 0;
         _loc4_ = this.GRAPH_HEIGHT - param1[0] * _loc6_;
         this.graphArea.graphics.lineStyle(2,param2);
         this.graphArea.graphics.moveTo(_loc3_,_loc4_);
         var _loc7_:int = 1;
         while(_loc7_ < param1.length)
         {
            _loc3_ = Number(_loc7_ * _loc5_);
            _loc4_ = this.GRAPH_HEIGHT - param1[_loc7_] * _loc6_;
            this.graphArea.graphics.lineTo(_loc3_,_loc4_);
            _loc7_++;
         }
      }
      
      private function draw() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         this.graphArea.graphics.clear();
         if(this.yMax < 1)
         {
            this.yMax = 1;
         }
         this.graphArea.x = 0;
         this.GRAPH_WIDTH = this.WIDTH;
         if(this.nameText != null)
         {
            this.nameText.x = this.graphArea.x + this.GRAPH_WIDTH / 2 - this.nameText.width / 2;
         }
         this.grid.x = this.graphArea.x - 1;
         this.grid.y = this.graphArea.y - 1;
         this.drawGrid();
         if(this.dataLength == 0)
         {
            return;
         }
         if(this.data[0] is Array)
         {
            _loc2_ = 0;
            while(_loc2_ < this.data.length)
            {
               this.drawLine(this.data[_loc2_],this.lineColor[_loc2_]);
               _loc2_++;
            }
         }
         else
         {
            this.drawLine(this.data,this.lineColor);
         }
      }
   }
}
