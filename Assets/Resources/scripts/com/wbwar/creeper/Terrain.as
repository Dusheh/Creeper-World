package com.wbwar.creeper
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public final class Terrain extends Sprite
   {
      
      private static var terrain0Image:Class = Terrain_terrain0Image;
      
      public static var terrain0Bitmap:Bitmap = new terrain0Image() as Bitmap;
      
      private static var terrain1Image:Class = Terrain_terrain1Image;
      
      public static var terrain1Bitmap:Bitmap = new terrain1Image() as Bitmap;
      
      private static var terrain2Image:Class = Terrain_terrain2Image;
      
      public static var terrain2Bitmap:Bitmap = new terrain2Image() as Bitmap;
      
      private static var terrain3Image:Class = Terrain_terrain3Image;
      
      public static var terrain3Bitmap:Bitmap = new terrain3Image() as Bitmap;
      
      private static var terrain4Image:Class = Terrain_terrain4Image;
      
      public static var terrain4Bitmap:Bitmap = new terrain4Image() as Bitmap;
      
      private static var terrain5Image:Class = Terrain_terrain5Image;
      
      public static var terrain5Bitmap:Bitmap = new terrain5Image() as Bitmap;
       
      
      public var background:int;
      
      public var customBackground:Bitmap;
      
      private var terrainBitmap:Bitmap;
      
      public var terrainBMD:BitmapData;
      
      public var terrainHeight:Array;
      
      private var levelBmd:Array;
      
      private var levelBmdRect:Rectangle;
      
      private var WIDTH:int;
      
      private var HEIGHT:int;
      
      private var CELL_WIDTH:int;
      
      private var CELL_HEIGHT:int;
      
      public var tints:Array;
      
      public var edgeSize:int = 5;
      
      private var cTransform:ColorTransform;
      
      public function Terrain()
      {
         this.terrainHeight = [];
         this.levelBmd = [];
         this.tints = [0.25,0.47222222222,0.69444444444,0.91666666666,1.13888888888,1.36111111111,1.58333333];
         this.cTransform = new ColorTransform();
         super();
         this.WIDTH = GameSpace.WIDTH;
         this.HEIGHT = GameSpace.HEIGHT;
         this.CELL_WIDTH = GameSpace.CELL_WIDTH_S;
         this.CELL_HEIGHT = GameSpace.CELL_HEIGHT_S;
         this.terrainBMD = new BitmapData(this.CELL_WIDTH * this.WIDTH,this.CELL_HEIGHT * this.HEIGHT,false);
         this.terrainBitmap = new Bitmap(this.terrainBMD);
         addChild(this.terrainBitmap);
      }
      
      private function drawHex(param1:int, param2:Number, param3:Number) : void
      {
         var _loc5_:Shape;
         (_loc5_ = new Shape()).graphics.beginFill(param2,param3);
         _loc5_.graphics.moveTo(6 + 6,6);
         var _loc6_:* = 0;
         while(_loc6_ < 0)
         {
            _loc5_.graphics.lineTo(6 + Math.cos(_loc6_) * 6,6 + Math.sin(_loc6_) * 6);
            _loc6_ += 0;
         }
         _loc5_.graphics.endFill();
         var _loc7_:BitmapData;
         (_loc7_ = new BitmapData(12,12,true,0)).draw(_loc5_);
         this.levelBmd[param1] = _loc7_;
         this.levelBmdRect = new Rectangle(0,0,12,12);
      }
      
      public function setData(param1:Array) : void
      {
         this.terrainHeight = param1;
      }
      
      public final function update() : void
      {
         this.renderTerrain();
      }
      
      private final function renderTerrain() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc10_:* = null;
         var _loc15_:Boolean = false;
         var _loc3_:BitmapData = this.terrainBitmap.bitmapData;
         if(this.customBackground != null)
         {
            _loc10_ = this.customBackground;
         }
         else if(this.background == 0)
         {
            _loc10_ = terrain0Bitmap;
         }
         else if(this.background == 1)
         {
            _loc10_ = terrain1Bitmap;
         }
         else if(this.background == 2)
         {
            _loc10_ = terrain2Bitmap;
         }
         else if(this.background == 3)
         {
            _loc10_ = terrain3Bitmap;
         }
         else if(this.background == 4)
         {
            _loc10_ = terrain4Bitmap;
         }
         else if(this.background == 5)
         {
            _loc10_ = terrain5Bitmap;
         }
         var _loc11_:Matrix = new Matrix();
         var _loc12_:Number = this.WIDTH * this.CELL_WIDTH / _loc10_.width;
         var _loc13_:Number = this.HEIGHT * this.CELL_HEIGHT / _loc10_.height;
         _loc11_.scale(_loc12_,_loc13_);
         var _loc14_:BitmapData;
         (_loc14_ = new BitmapData(this.WIDTH * this.CELL_WIDTH,this.HEIGHT * this.CELL_HEIGHT,true,0)).draw(_loc10_.bitmapData,_loc11_,null,null,null,true);
         _loc3_.copyPixels(_loc14_,new Rectangle(0,0,this.WIDTH * this.CELL_WIDTH,this.HEIGHT * this.CELL_HEIGHT),new Point(0,0));
         _loc1_ = 0;
         while(_loc1_ < this.HEIGHT)
         {
            _loc2_ = 0;
            while(_loc2_ < this.WIDTH)
            {
               this.cTransform.redMultiplier = this.tints[this.terrainHeight[_loc2_ + _loc1_ * this.WIDTH]];
               this.cTransform.greenMultiplier = this.cTransform.redMultiplier;
               this.cTransform.blueMultiplier = this.cTransform.redMultiplier;
               _loc3_.colorTransform(new Rectangle(_loc2_ * this.CELL_WIDTH,_loc1_ * this.CELL_HEIGHT,this.CELL_WIDTH,this.CELL_HEIGHT),this.cTransform);
               if(this.hasBottomEdge(_loc2_,_loc1_))
               {
                  this.cTransform.redMultiplier = 0.3;
                  this.cTransform.greenMultiplier = 0.3;
                  this.cTransform.blueMultiplier = 0.3;
                  if(this.edgeSize > 0)
                  {
                     _loc3_.colorTransform(new Rectangle(_loc2_ * this.CELL_WIDTH,(_loc1_ + 1) * this.CELL_HEIGHT,this.CELL_WIDTH,this.edgeSize * 0),this.cTransform);
                  }
               }
               if(this.hasTopEdge(_loc2_,_loc1_))
               {
                  this.cTransform.redMultiplier = 0.3;
                  this.cTransform.greenMultiplier = 0.3;
                  this.cTransform.blueMultiplier = 0.3;
                  if(this.edgeSize > 0)
                  {
                     _loc3_.colorTransform(new Rectangle(_loc2_ * this.CELL_WIDTH,_loc1_ * this.CELL_HEIGHT,this.CELL_WIDTH,0),this.cTransform);
                  }
               }
               if(this.hasLeftEdge(_loc2_,_loc1_))
               {
                  this.cTransform.redMultiplier = 0.3;
                  this.cTransform.greenMultiplier = 0.3;
                  this.cTransform.blueMultiplier = 0.3;
                  if(this.edgeSize > 0)
                  {
                     _loc3_.colorTransform(new Rectangle(_loc2_ * this.CELL_WIDTH,_loc1_ * this.CELL_HEIGHT,0,this.CELL_HEIGHT),this.cTransform);
                  }
               }
               if(this.hasRightEdge(_loc2_,_loc1_))
               {
                  this.cTransform.redMultiplier = 0.3;
                  this.cTransform.greenMultiplier = 0.3;
                  this.cTransform.blueMultiplier = 0.3;
                  _loc15_ = _loc2_ + 1 < this.WIDTH && _loc1_ + 1 < this.HEIGHT && this.terrainHeight[_loc2_ + _loc1_ * this.WIDTH] <= this.terrainHeight[_loc2_ + 1 + (_loc1_ + 1) * this.WIDTH];
                  if(this.hasBottomEdge(_loc2_ + 1,_loc1_ - 1))
                  {
                     _loc7_ = _loc1_ * this.CELL_HEIGHT + this.edgeSize * 0;
                     _loc8_ = this.CELL_HEIGHT - this.edgeSize * 0;
                  }
                  else
                  {
                     _loc7_ = _loc1_ * this.CELL_HEIGHT;
                     _loc8_ = this.CELL_HEIGHT;
                  }
                  if(this.hasBottomEdge(_loc2_,_loc1_) && !_loc15_)
                  {
                     _loc8_ += this.edgeSize * 0;
                  }
                  if(this.edgeSize > 0)
                  {
                     _loc3_.colorTransform(new Rectangle((_loc2_ + 1) * this.CELL_WIDTH,_loc7_,this.edgeSize * 0 - 2 <= 0 ? 0 : Number(this.edgeSize * 0 - 2),_loc8_),this.cTransform);
                  }
               }
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      private final function foo() : Boolean
      {
         return false;
      }
      
      private final function hasBottomEdge(param1:int, param2:int) : Boolean
      {
         return param2 + 1 < this.HEIGHT && this.terrainHeight[param1 + param2 * this.WIDTH] > this.terrainHeight[param1 + (param2 + 1) * this.WIDTH];
      }
      
      private final function hasTopEdge(param1:int, param2:int) : Boolean
      {
         return param2 - 1 >= 0 && this.terrainHeight[param1 + param2 * this.WIDTH] > this.terrainHeight[param1 + (param2 - 1) * this.WIDTH];
      }
      
      private final function hasLeftEdge(param1:int, param2:int) : Boolean
      {
         return param1 - 1 >= 0 && this.terrainHeight[param1 + param2 * this.WIDTH] > this.terrainHeight[param1 - 1 + param2 * this.WIDTH];
      }
      
      private final function hasRightEdge(param1:int, param2:int) : Boolean
      {
         return param1 + 1 < this.WIDTH && this.terrainHeight[param1 + param2 * this.WIDTH] > this.terrainHeight[param1 + 1 + param2 * this.WIDTH];
      }
   }
}
