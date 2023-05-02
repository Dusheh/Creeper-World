package com.wbwar.creeper
{
   import com.wbwar.creeper.games.CustomGame;
   import com.wbwar.creeper.games.Game;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public final class Glop extends Sprite
   {
      
      public static const MIN_HEAT:Number = 0.001;
      
      private static const WALL_DECAY:Number = 0.0004761904761904762;
      
      private static const WALL_DECAY_OLD:Number = 0.0007142857142857143;
      
      private static const HEIGHT:int = GameSpace.HEIGHT;
      
      private static const WIDTH:int = GameSpace.WIDTH;
      
      private static const CELL_WIDTH:int = GameSpace.CELL_WIDTH_S;
      
      private static const CELL_HEIGHT:int = GameSpace.CELL_HEIGHT_S;
      
      private static const TERRAIN_HEIGHT_MULTIPLE:Number = Game.TERRAIN_HEIGHT_MULTIPLE;
      
      private static const NUM_LEVELS:int = 16;
      
      private static const transferRate:Number = 0.25;
       
      
      private var glopBitmap:Bitmap;
      
      private var walls:Array;
      
      private var terrain:Array;
      
      public var data:Array;
      
      private var updateCount:int;
      
      public var glopBmd:Array;
      
      public var glopIBmd:Array;
      
      private var glopNoise:Array;
      
      private var glopBmdRect:Rectangle;
      
      private var oldMode:Boolean = true;
      
      private var c:int;
      
      private var shadow:Array;
      
      private var sourceX:int;
      
      private var sourceY:int;
      
      private var targetX:int;
      
      private var targetY:int;
      
      private var sAmt:Number;
      
      private var tAmt0:Number;
      
      private var tAmt1:Number;
      
      private var tAmt2:Number;
      
      private var tAmt3:Number;
      
      private var deltaAmt0a:Number;
      
      private var deltaAmt0b:Number;
      
      private var deltaAmt1a:Number;
      
      private var deltaAmt1b:Number;
      
      private var deltaAmt2a:Number;
      
      private var deltaAmt2b:Number;
      
      private var deltaAmt3a:Number;
      
      private var deltaAmt3b:Number;
      
      private var c0a:Boolean;
      
      private var c0b:Boolean;
      
      private var c1a:Boolean;
      
      private var c1b:Boolean;
      
      private var c2a:Boolean;
      
      private var c2b:Boolean;
      
      private var c3a:Boolean;
      
      private var c3b:Boolean;
      
      private var sloc:int;
      
      private var tloc:int;
      
      private var tsla:Number;
      
      private var wsl:Number;
      
      private var wtl:Number;
      
      private var ttlt:Number;
      
      private var de:Number;
      
      private var wallData:Number;
      
      private var b0:int;
      
      private var b1:int;
      
      private var b2:int;
      
      private var b3:int;
      
      private var da:Number;
      
      private var olevel:int;
      
      public function Glop()
      {
         var _loc11_:int = 0;
         this.data = [];
         this.glopBmd = [];
         this.glopIBmd = [];
         this.glopNoise = [];
         super();
         var _loc1_:int = int(GameSpace.instance.game.xml.version);
         if(_loc1_ >= 345)
         {
            this.oldMode = false;
         }
         var _loc2_:BitmapData = new BitmapData(0 * 0,0 * 0,true,0);
         this.glopBitmap = new Bitmap(_loc2_);
         addChild(this.glopBitmap);
         var _loc3_:int = 0;
         while(_loc3_ < WIDTH * HEIGHT)
         {
            this.data[_loc3_] = 0;
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < NUM_LEVELS)
         {
            this.glopBmd[_loc4_] = [];
            this.glopIBmd[_loc4_] = [];
            _loc11_ = 0;
            while(_loc11_ < 16)
            {
               this.glopBmd[_loc4_][_loc11_] = new BitmapData(CELL_WIDTH,CELL_HEIGHT,true,0);
               _loc11_++;
            }
            _loc4_++;
         }
         var _loc5_:* = [];
         _loc4_ = 0;
         while(_loc4_ < NUM_LEVELS)
         {
            _loc5_[_loc4_] = [];
            _loc11_ = 0;
            while(_loc11_ <= 5)
            {
               _loc5_[_loc4_][_loc11_] = this.generateEdgeShape(_loc4_,_loc11_);
               _loc11_++;
            }
            _loc4_++;
         }
         var _loc6_:Matrix;
         (_loc6_ = new Matrix()).translate(-CELL_WIDTH / 2,-CELL_HEIGHT / 2);
         _loc6_.rotate(0);
         _loc6_.translate(CELL_WIDTH / 2,CELL_HEIGHT / 2);
         var _loc7_:Matrix;
         (_loc7_ = new Matrix()).translate(-CELL_WIDTH / 2,-CELL_HEIGHT / 2);
         _loc7_.rotate(0);
         _loc7_.translate(CELL_WIDTH / 2,CELL_HEIGHT / 2);
         var _loc8_:Matrix;
         (_loc8_ = new Matrix()).translate(-CELL_WIDTH / 2,-CELL_HEIGHT / 2);
         _loc8_.rotate(Math.PI);
         _loc8_.translate(CELL_WIDTH / 2,CELL_HEIGHT / 2);
         var _loc9_:Rectangle = new Rectangle(0,0,CELL_WIDTH,CELL_HEIGHT);
         var _loc10_:Point = new Point(0,0);
         _loc11_ = 0;
         while(_loc11_ < NUM_LEVELS)
         {
            if(_loc11_ == 0)
            {
               (this.glopBmd[_loc11_][0] as BitmapData).draw(_loc5_[_loc11_][0]);
               (this.glopBmd[_loc11_][1] as BitmapData).draw(_loc5_[_loc11_][1]);
               (this.glopBmd[_loc11_][2] as BitmapData).draw(_loc5_[_loc11_][1],_loc6_);
               (this.glopBmd[_loc11_][3] as BitmapData).draw(_loc5_[_loc11_][2]);
               (this.glopBmd[_loc11_][4] as BitmapData).draw(_loc5_[_loc11_][1],_loc8_);
               (this.glopBmd[_loc11_][5] as BitmapData).draw(_loc5_[_loc11_][5]);
               (this.glopBmd[_loc11_][6] as BitmapData).draw(_loc5_[_loc11_][2],_loc6_);
               (this.glopBmd[_loc11_][7] as BitmapData).draw(_loc5_[_loc11_][3]);
               (this.glopBmd[_loc11_][8] as BitmapData).draw(_loc5_[_loc11_][1],_loc7_);
               (this.glopBmd[_loc11_][9] as BitmapData).draw(_loc5_[_loc11_][2],_loc7_);
               (this.glopBmd[_loc11_][10] as BitmapData).draw(_loc5_[_loc11_][5],_loc7_);
               (this.glopBmd[_loc11_][11] as BitmapData).draw(_loc5_[_loc11_][3],_loc7_);
               (this.glopBmd[_loc11_][12] as BitmapData).draw(_loc5_[_loc11_][2],_loc8_);
               (this.glopBmd[_loc11_][13] as BitmapData).draw(_loc5_[_loc11_][3],_loc8_);
               (this.glopBmd[_loc11_][14] as BitmapData).draw(_loc5_[_loc11_][3],_loc6_);
               (this.glopBmd[_loc11_][15] as BitmapData).draw(_loc5_[_loc11_][4]);
            }
            else
            {
               (this.glopBmd[_loc11_][0] as BitmapData).copyPixels(this.glopBmd[_loc11_ - 1][15] as BitmapData,_loc9_,_loc10_);
               (this.glopBmd[_loc11_][0] as BitmapData).draw(_loc5_[_loc11_][0]);
               (this.glopBmd[_loc11_][1] as BitmapData).copyPixels(this.glopBmd[_loc11_ - 1][15] as BitmapData,_loc9_,_loc10_);
               (this.glopBmd[_loc11_][1] as BitmapData).draw(_loc5_[_loc11_][1]);
               (this.glopBmd[_loc11_][2] as BitmapData).copyPixels(this.glopBmd[_loc11_ - 1][15] as BitmapData,_loc9_,_loc10_);
               (this.glopBmd[_loc11_][2] as BitmapData).draw(_loc5_[_loc11_][1],_loc6_);
               (this.glopBmd[_loc11_][3] as BitmapData).copyPixels(this.glopBmd[_loc11_ - 1][15] as BitmapData,_loc9_,_loc10_);
               (this.glopBmd[_loc11_][3] as BitmapData).draw(_loc5_[_loc11_][2]);
               (this.glopBmd[_loc11_][4] as BitmapData).copyPixels(this.glopBmd[_loc11_ - 1][15] as BitmapData,_loc9_,_loc10_);
               (this.glopBmd[_loc11_][4] as BitmapData).draw(_loc5_[_loc11_][1],_loc8_);
               (this.glopBmd[_loc11_][5] as BitmapData).copyPixels(this.glopBmd[_loc11_ - 1][15] as BitmapData,_loc9_,_loc10_);
               (this.glopBmd[_loc11_][5] as BitmapData).draw(_loc5_[_loc11_][5]);
               (this.glopBmd[_loc11_][6] as BitmapData).copyPixels(this.glopBmd[_loc11_ - 1][15] as BitmapData,_loc9_,_loc10_);
               (this.glopBmd[_loc11_][6] as BitmapData).draw(_loc5_[_loc11_][2],_loc6_);
               (this.glopBmd[_loc11_][7] as BitmapData).copyPixels(this.glopBmd[_loc11_ - 1][15] as BitmapData,_loc9_,_loc10_);
               (this.glopBmd[_loc11_][7] as BitmapData).draw(_loc5_[_loc11_][3]);
               (this.glopBmd[_loc11_][8] as BitmapData).copyPixels(this.glopBmd[_loc11_ - 1][15] as BitmapData,_loc9_,_loc10_);
               (this.glopBmd[_loc11_][8] as BitmapData).draw(_loc5_[_loc11_][1],_loc7_);
               (this.glopBmd[_loc11_][9] as BitmapData).copyPixels(this.glopBmd[_loc11_ - 1][15] as BitmapData,_loc9_,_loc10_);
               (this.glopBmd[_loc11_][9] as BitmapData).draw(_loc5_[_loc11_][2],_loc7_);
               (this.glopBmd[_loc11_][10] as BitmapData).copyPixels(this.glopBmd[_loc11_ - 1][15] as BitmapData,_loc9_,_loc10_);
               (this.glopBmd[_loc11_][10] as BitmapData).draw(_loc5_[_loc11_][5],_loc7_);
               (this.glopBmd[_loc11_][11] as BitmapData).copyPixels(this.glopBmd[_loc11_ - 1][15] as BitmapData,_loc9_,_loc10_);
               (this.glopBmd[_loc11_][11] as BitmapData).draw(_loc5_[_loc11_][3],_loc7_);
               (this.glopBmd[_loc11_][12] as BitmapData).copyPixels(this.glopBmd[_loc11_ - 1][15] as BitmapData,_loc9_,_loc10_);
               (this.glopBmd[_loc11_][12] as BitmapData).draw(_loc5_[_loc11_][2],_loc8_);
               (this.glopBmd[_loc11_][13] as BitmapData).copyPixels(this.glopBmd[_loc11_ - 1][15] as BitmapData,_loc9_,_loc10_);
               (this.glopBmd[_loc11_][13] as BitmapData).draw(_loc5_[_loc11_][3],_loc8_);
               (this.glopBmd[_loc11_][14] as BitmapData).copyPixels(this.glopBmd[_loc11_ - 1][15] as BitmapData,_loc9_,_loc10_);
               (this.glopBmd[_loc11_][14] as BitmapData).draw(_loc5_[_loc11_][3],_loc6_);
               (this.glopBmd[_loc11_][15] as BitmapData).copyPixels(this.glopBmd[_loc11_ - 1][15] as BitmapData,_loc9_,_loc10_);
               (this.glopBmd[_loc11_][15] as BitmapData).draw(_loc5_[_loc11_][4]);
            }
            _loc11_++;
         }
         this.glopNoise[0] = new BitmapData(CELL_WIDTH,CELL_HEIGHT,true,0);
         (this.glopNoise[0] as BitmapData).draw(this.generateNoise(0));
         this.glopBmdRect = new Rectangle(0,0,CELL_WIDTH,CELL_HEIGHT);
      }
      
      private function generateNoise(param1:int) : Shape
      {
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.lineStyle(0,16777215);
         _loc2_.graphics.drawCircle(CELL_WIDTH / 2,CELL_HEIGHT / 2,3);
         return _loc2_;
      }
      
      private function getLevelARGB(param1:int) : Number
      {
         return this.getLevelAlpha(param1) << 24 | this.getLevelColor(param1);
      }
      
      private function getLevelColor(param1:int) : Number
      {
         if(GameSpace.instance.game is CustomGame)
         {
            return (GameSpace.instance.game as CustomGame).creeperColor;
         }
         return 3355545;
      }
      
      private function getLevelAlpha(param1:int) : Number
      {
         if(param1 == 0)
         {
            return 0.38;
         }
         return 0.2;
      }
      
      private function generateEdgeShape(param1:int, param2:int) : Shape
      {
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc3_:* = [];
         var _loc4_:* = [];
         var _loc7_:int = 0;
         while(_loc7_ < NUM_LEVELS)
         {
            _loc3_[_loc7_] = this.getLevelColor(_loc7_);
            _loc4_[_loc7_] = this.getLevelAlpha(_loc7_);
            _loc7_++;
         }
         if(param2 == 0)
         {
            (_loc8_ = new Shape()).graphics.beginFill(_loc3_[param1],_loc4_[param1]);
            _loc8_.graphics.lineStyle(0,48,0.5);
            _loc8_.graphics.drawRect(0,0,CELL_WIDTH - 0.5,CELL_HEIGHT - 0.5);
            _loc8_.graphics.endFill();
            return _loc8_;
         }
         if(param2 == 1)
         {
            (_loc9_ = new Shape()).graphics.beginFill(_loc3_[param1],_loc4_[param1]);
            _loc9_.graphics.lineStyle(0,48,0.5);
            _loc9_.graphics.drawCircle(CELL_WIDTH,CELL_HEIGHT / 2,CELL_WIDTH / 2);
            _loc9_.graphics.endFill();
            return _loc9_;
         }
         if(param2 == 2)
         {
            (_loc10_ = new Shape()).graphics.beginFill(_loc3_[param1],_loc4_[param1]);
            _loc10_.graphics.moveTo(0,0);
            _loc10_.graphics.lineTo(CELL_WIDTH,0);
            _loc10_.graphics.lineTo(CELL_WIDTH,CELL_HEIGHT);
            _loc10_.graphics.lineTo(0,0);
            _loc10_.graphics.endFill();
            _loc10_.graphics.lineStyle(0,48,0.5);
            _loc10_.graphics.moveTo(0,0);
            _loc10_.graphics.lineTo(CELL_WIDTH,CELL_HEIGHT);
            return _loc10_;
         }
         if(param2 == 3)
         {
            (_loc11_ = new Shape()).graphics.beginFill(_loc3_[param1],_loc4_[param1]);
            _loc11_.graphics.drawRect(0,0,CELL_WIDTH,CELL_HEIGHT);
            _loc11_.graphics.endFill();
            _loc11_.graphics.lineStyle(0,48,0.5);
            _loc11_.graphics.moveTo(0,CELL_HEIGHT - 0.5);
            _loc11_.graphics.lineTo(CELL_WIDTH,CELL_HEIGHT - 0.5);
            return _loc11_;
         }
         if(param2 == 4)
         {
            (_loc12_ = new Shape()).graphics.beginFill(_loc3_[param1],_loc4_[param1]);
            _loc12_.graphics.drawRect(0,0,CELL_WIDTH,CELL_HEIGHT);
            _loc12_.graphics.endFill();
            return _loc12_;
         }
         if(param2 == 5)
         {
            (_loc13_ = new Shape()).graphics.beginFill(_loc3_[param1],_loc4_[param1]);
            _loc13_.graphics.drawRect(0,0,CELL_WIDTH,CELL_HEIGHT);
            _loc13_.graphics.endFill();
            _loc13_.graphics.lineStyle(0,48,0.5);
            _loc13_.graphics.moveTo(0,CELL_HEIGHT - 0.5);
            _loc13_.graphics.lineTo(CELL_WIDTH,CELL_HEIGHT - 0.5);
            _loc13_.graphics.moveTo(0,0.5);
            _loc13_.graphics.lineTo(CELL_WIDTH,0.5);
            return _loc13_;
         }
         return new Shape();
      }
      
      public function setData(param1:Array, param2:Array) : void
      {
         this.terrain = param1;
         this.walls = param2;
      }
      
      public function update() : void
      {
         ++this.updateCount;
         if(this.updateCount % 7 != 0)
         {
            return;
         }
         if(this.oldMode)
         {
            this.updateGlopOld();
         }
         else
         {
            this.updateGlop();
         }
      }
      
      public function applyGlop(param1:int, param2:int, param3:Number) : void
      {
         if(param1 >= 0 && param1 < WIDTH && param2 >= 0 && param2 < HEIGHT)
         {
            this.data[param1 + param2 * WIDTH] = param3;
         }
      }
      
      public function addGlop(param1:int, param2:int, param3:Number) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:* = NaN;
         if(param1 >= 0 && param1 < WIDTH && param2 >= 0 && param2 < HEIGHT)
         {
            if((_loc5_ = Number((_loc4_ = this.data[param1 + param2 * WIDTH]) + param3)) < 0)
            {
               _loc5_ = 0;
            }
            if(param3 < 0)
            {
               GameSpace.instance.creeperKilled += _loc4_ - _loc5_;
            }
            this.data[param1 + param2 * WIDTH] = _loc5_;
         }
      }
      
      public function addAllGlop(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:* = NaN;
         _loc3_ = 0;
         while(_loc3_ < HEIGHT)
         {
            _loc2_ = 0;
            while(_loc2_ < WIDTH)
            {
               _loc4_ = _loc2_ + _loc3_ * WIDTH;
               if((_loc6_ = Number((_loc5_ = this.data[_loc4_]) + param1)) < 0)
               {
                  _loc6_ = 0;
               }
               this.data[_loc4_] = _loc6_;
               _loc2_++;
            }
            _loc3_++;
         }
      }
      
      private function updateGlop() : void
      {
         this.shadow = this.data.concat();
         var _loc1_:* = 0;
         this.sourceY = 0;
         while(this.sourceY < HEIGHT)
         {
            this.sourceX = 0;
            while(this.sourceX < WIDTH)
            {
               this.c0a = false;
               this.c0b = false;
               this.c1a = false;
               this.c1b = false;
               this.c2a = false;
               this.c2b = false;
               this.c3a = false;
               this.c3b = false;
               this.sloc = this.sourceX + this.sourceY * WIDTH;
               this.targetX = this.sourceX + 1;
               this.targetY = this.sourceY;
               this.tloc = this.targetX + this.targetY * WIDTH;
               this.wtl = this.walls[this.tloc];
               this.sAmt = this.shadow[this.sloc];
               this.tsla = this.terrain[this.sloc] + this.sAmt;
               this.wsl = this.walls[this.sloc];
               _loc1_ += this.sAmt;
               if(this.targetX < WIDTH)
               {
                  this.tAmt0 = this.shadow[this.tloc];
                  if(this.sAmt > 0 || this.tAmt0 > 0)
                  {
                     this.ttlt = this.terrain[this.tloc] + this.tAmt0;
                     if(this.wsl > 0)
                     {
                        if(this.tAmt0 >= MIN_HEAT && this.ttlt - this.tsla > 0)
                        {
                           this.wallData = this.wsl - WALL_DECAY;
                           if(this.wallData <= 0)
                           {
                              this.wallData = 0;
                           }
                           this.walls[this.sloc] = this.wallData;
                        }
                     }
                     else if(this.wtl > 0)
                     {
                        if(this.sAmt >= MIN_HEAT && this.tsla - this.ttlt > 0)
                        {
                           this.wallData = this.wtl - WALL_DECAY;
                           if(this.wallData <= 0)
                           {
                              this.wallData = 0;
                           }
                           this.walls[this.tloc] = this.wallData;
                        }
                     }
                     else if(this.tsla > this.ttlt)
                     {
                        this.c0a = true;
                        this.deltaAmt0a = this.tsla - this.ttlt;
                        if(this.deltaAmt0a > this.sAmt)
                        {
                           this.deltaAmt0a = this.sAmt;
                        }
                     }
                     else
                     {
                        this.c0b = true;
                        this.deltaAmt0b = this.ttlt - this.tsla;
                        if(this.deltaAmt0b > this.tAmt0)
                        {
                           this.deltaAmt0b = this.tAmt0;
                        }
                     }
                  }
               }
               this.targetX = this.sourceX + 1;
               this.targetY = this.sourceY + 1;
               this.tloc = this.targetX + this.targetY * WIDTH;
               this.wtl = this.walls[this.tloc];
               this.wsl = this.walls[this.sloc];
               if(this.targetX < WIDTH && this.targetY < HEIGHT)
               {
                  this.tAmt1 = this.shadow[this.tloc];
                  if(this.sAmt > 0 || this.tAmt1 > 0)
                  {
                     this.ttlt = this.terrain[this.tloc] + this.tAmt1;
                     if(this.wsl > 0)
                     {
                        if(this.tAmt1 >= MIN_HEAT && this.ttlt - this.tsla > 0)
                        {
                           this.wallData = this.wsl - WALL_DECAY;
                           if(this.wallData <= 0)
                           {
                              this.wallData = 0;
                           }
                           this.walls[this.sloc] = this.wallData;
                        }
                     }
                     else if(this.wtl > 0)
                     {
                        if(this.sAmt >= MIN_HEAT && this.tsla - this.ttlt > 0)
                        {
                           this.wallData = this.wtl - WALL_DECAY;
                           if(this.wallData <= 0)
                           {
                              this.wallData = 0;
                           }
                           this.walls[this.tloc] = this.wallData;
                        }
                     }
                     else if(this.tsla > this.ttlt)
                     {
                        this.c1a = true;
                        this.deltaAmt1a = this.tsla - this.ttlt;
                        if(this.deltaAmt1a > this.sAmt)
                        {
                           this.deltaAmt1a = this.sAmt;
                        }
                     }
                     else
                     {
                        this.c1b = true;
                        this.deltaAmt1b = this.ttlt - this.tsla;
                        if(this.deltaAmt1b > this.tAmt1)
                        {
                           this.deltaAmt1b = this.tAmt1;
                        }
                     }
                  }
               }
               this.targetX = this.sourceX;
               this.targetY = this.sourceY + 1;
               this.tloc = this.targetX + this.targetY * WIDTH;
               this.wtl = this.walls[this.tloc];
               this.wsl = this.walls[this.sloc];
               if(this.targetY < HEIGHT)
               {
                  this.tAmt2 = this.shadow[this.tloc];
                  if(this.sAmt > 0 || this.tAmt2 > 0)
                  {
                     this.ttlt = this.terrain[this.tloc] + this.tAmt2;
                     if(this.wsl > 0)
                     {
                        if(this.tAmt2 >= MIN_HEAT && this.ttlt - this.tsla > 0)
                        {
                           this.wallData = this.wsl - WALL_DECAY;
                           if(this.wallData <= 0)
                           {
                              this.wallData = 0;
                           }
                           this.walls[this.sloc] = this.wallData;
                        }
                     }
                     else if(this.wtl > 0)
                     {
                        if(this.sAmt >= MIN_HEAT && this.tsla - this.ttlt > 0)
                        {
                           this.wallData = this.wtl - WALL_DECAY;
                           if(this.wallData <= 0)
                           {
                              this.wallData = 0;
                           }
                           this.walls[this.tloc] = this.wallData;
                        }
                     }
                     else if(this.tsla > this.ttlt)
                     {
                        this.c2a = true;
                        this.deltaAmt2a = this.tsla - this.ttlt;
                        if(this.deltaAmt2a > this.sAmt)
                        {
                           this.deltaAmt2a = this.sAmt;
                        }
                     }
                     else
                     {
                        this.c2b = true;
                        this.deltaAmt2b = this.ttlt - this.tsla;
                        if(this.deltaAmt2b > this.tAmt2)
                        {
                           this.deltaAmt2b = this.tAmt2;
                        }
                     }
                  }
               }
               this.targetX = this.sourceX - 1;
               this.targetY = this.sourceY + 1;
               this.tloc = this.targetX + this.targetY * WIDTH;
               this.wtl = this.walls[this.tloc];
               this.wsl = this.walls[this.sloc];
               if(this.targetX >= 0 && this.targetY < HEIGHT)
               {
                  this.tAmt3 = this.shadow[this.tloc];
                  if(this.sAmt > 0 || this.tAmt3 > 0)
                  {
                     this.ttlt = this.terrain[this.tloc] + this.tAmt3;
                     if(this.wsl > 0)
                     {
                        if(this.tAmt3 >= MIN_HEAT && this.ttlt - this.tsla > 0)
                        {
                           this.wallData = this.wsl - WALL_DECAY;
                           if(this.wallData <= 0)
                           {
                              this.wallData = 0;
                           }
                           this.walls[this.sloc] = this.wallData;
                        }
                     }
                     else if(this.wtl > 0)
                     {
                        if(this.sAmt >= MIN_HEAT && this.tsla - this.ttlt > 0)
                        {
                           this.wallData = this.wtl - WALL_DECAY;
                           if(this.wallData <= 0)
                           {
                              this.wallData = 0;
                           }
                           this.walls[this.tloc] = this.wallData;
                        }
                     }
                     else if(this.tsla > this.ttlt)
                     {
                        this.c3a = true;
                        this.deltaAmt3a = this.tsla - this.ttlt;
                        if(this.deltaAmt3a > this.sAmt)
                        {
                           this.deltaAmt3a = this.sAmt;
                        }
                     }
                     else
                     {
                        this.c3b = true;
                        this.deltaAmt3b = this.ttlt - this.tsla;
                        if(this.deltaAmt3b > this.tAmt3)
                        {
                           this.deltaAmt3b = this.tAmt3;
                        }
                     }
                  }
               }
               this.targetX = this.sourceX + 1;
               this.targetY = this.sourceY;
               this.tloc = this.targetX + this.targetY * WIDTH;
               if(this.c0a)
               {
                  this.de = this.deltaAmt0a * 0.5 * transferRate;
                  this.data[this.sloc] -= this.de;
                  this.data[this.tloc] += this.de;
               }
               else if(this.c0b)
               {
                  this.de = this.deltaAmt0b * 0.5 * transferRate;
                  this.data[this.sloc] += this.de;
                  this.data[this.tloc] -= this.de;
               }
               this.targetX = this.sourceX + 1;
               this.targetY = this.sourceY + 1;
               this.tloc = this.targetX + this.targetY * WIDTH;
               if(this.c1a)
               {
                  this.de = this.deltaAmt1a * 0.5 * transferRate;
                  this.data[this.sloc] -= this.de;
                  this.data[this.tloc] += this.de;
               }
               else if(this.c1b)
               {
                  this.de = this.deltaAmt1b * 0.5 * transferRate;
                  this.data[this.sloc] += this.de;
                  this.data[this.tloc] -= this.de;
               }
               this.targetX = this.sourceX;
               this.targetY = this.sourceY + 1;
               this.tloc = this.targetX + this.targetY * WIDTH;
               if(this.c2a)
               {
                  this.de = this.deltaAmt2a * 0.5 * transferRate;
                  this.data[this.sloc] -= this.de;
                  this.data[this.tloc] += this.de;
               }
               else if(this.c2b)
               {
                  this.de = this.deltaAmt2b * 0.5 * transferRate;
                  this.data[this.sloc] += this.de;
                  this.data[this.tloc] -= this.de;
               }
               this.targetX = this.sourceX - 1;
               this.targetY = this.sourceY + 1;
               this.tloc = this.targetX + this.targetY * WIDTH;
               if(this.c3a)
               {
                  this.de = this.deltaAmt3a * 0.5 * transferRate;
                  this.data[this.sloc] -= this.de;
                  this.data[this.tloc] += this.de;
               }
               else if(this.c3b)
               {
                  this.de = this.deltaAmt3b * 0.5 * transferRate;
                  this.data[this.sloc] += this.de;
                  this.data[this.tloc] -= this.de;
               }
               this.sAmt = this.data[this.sloc];
               if(this.sAmt < MIN_HEAT && this.sAmt > 0)
               {
                  this.data[this.sloc] = 0;
               }
               ++this.sourceX;
            }
            ++this.sourceY;
         }
         GameSpace.instance.creeperCoverage = _loc1_;
      }
      
      private function updateGlopOld() : void
      {
         this.shadow = this.data.concat();
         var _loc1_:* = 0;
         this.sourceY = 0;
         while(this.sourceY < HEIGHT)
         {
            this.sourceX = 0;
            while(this.sourceX < WIDTH)
            {
               this.c0a = false;
               this.c0b = false;
               this.c1a = false;
               this.c1b = false;
               this.c2a = false;
               this.c2b = false;
               this.c3a = false;
               this.c3b = false;
               this.sloc = this.sourceX + this.sourceY * WIDTH;
               this.targetX = this.sourceX + 1;
               this.targetY = this.sourceY;
               this.tloc = this.targetX + this.targetY * WIDTH;
               this.wtl = this.walls[this.tloc];
               this.sAmt = this.shadow[this.sloc];
               this.tsla = this.terrain[this.sloc] + this.sAmt;
               this.wsl = this.walls[this.sloc];
               _loc1_ += this.sAmt;
               if(this.targetX < WIDTH)
               {
                  this.tAmt0 = this.shadow[this.tloc];
                  if(this.sAmt > 0 || this.tAmt0 > 0)
                  {
                     this.ttlt = this.terrain[this.tloc] + this.tAmt0;
                     if(this.wsl > 0)
                     {
                        if(this.tAmt0 >= MIN_HEAT && this.ttlt - this.tsla > 0)
                        {
                           this.wallData = this.wsl - WALL_DECAY_OLD;
                           if(this.wallData <= 0)
                           {
                              this.wallData = 0;
                           }
                           this.walls[this.sloc] = this.wallData;
                        }
                     }
                     else if(this.wtl > 0)
                     {
                        if(this.sAmt >= MIN_HEAT && this.tsla - this.ttlt > 0)
                        {
                           this.wallData = this.wtl - WALL_DECAY_OLD;
                           if(this.wallData <= 0)
                           {
                              this.wallData = 0;
                           }
                           this.walls[this.tloc] = this.wallData;
                        }
                     }
                     else if(this.tsla > this.ttlt)
                     {
                        this.c0a = true;
                        this.deltaAmt0a = this.tsla - this.ttlt;
                        if(this.deltaAmt0a > this.sAmt)
                        {
                           this.deltaAmt0a = this.sAmt;
                        }
                     }
                     else
                     {
                        this.c0b = true;
                        this.deltaAmt0b = this.ttlt - this.tsla;
                        if(this.deltaAmt0b > this.tAmt0)
                        {
                           this.deltaAmt0b = this.tAmt0;
                        }
                     }
                  }
               }
               this.targetX = this.sourceX + 1;
               this.targetY = this.sourceY + 1;
               this.tloc = this.targetX + this.targetY * WIDTH;
               this.wtl = this.walls[this.tloc];
               if(this.targetX < WIDTH && this.targetY < HEIGHT)
               {
                  this.tAmt1 = this.shadow[this.tloc];
                  if(this.sAmt > 0 || this.tAmt1 > 0)
                  {
                     this.ttlt = this.terrain[this.tloc] + this.tAmt1;
                     if(this.wsl > 0)
                     {
                        if(this.tAmt1 >= MIN_HEAT && this.ttlt - this.tsla > 0)
                        {
                           this.wallData = this.wsl - WALL_DECAY_OLD;
                           if(this.wallData <= 0)
                           {
                              this.wallData = 0;
                           }
                           this.walls[this.sloc] = this.wallData;
                        }
                     }
                     else if(this.wtl > 0)
                     {
                        if(this.sAmt >= MIN_HEAT && this.tsla - this.ttlt > 0)
                        {
                           this.wallData = this.wtl - WALL_DECAY_OLD;
                           if(this.wallData <= 0)
                           {
                              this.wallData = 0;
                           }
                           this.walls[this.tloc] = this.wallData;
                        }
                     }
                     else if(this.tsla > this.ttlt)
                     {
                        this.c1a = true;
                        this.deltaAmt1a = this.tsla - this.ttlt;
                        if(this.deltaAmt1a > this.sAmt)
                        {
                           this.deltaAmt1a = this.sAmt;
                        }
                     }
                     else
                     {
                        this.c1b = true;
                        this.deltaAmt1b = this.ttlt - this.tsla;
                        if(this.deltaAmt1b > this.tAmt1)
                        {
                           this.deltaAmt1b = this.tAmt1;
                        }
                     }
                  }
               }
               this.targetX = this.sourceX;
               this.targetY = this.sourceY + 1;
               this.tloc = this.targetX + this.targetY * WIDTH;
               this.wtl = this.walls[this.tloc];
               if(this.targetY < HEIGHT)
               {
                  this.tAmt2 = this.shadow[this.tloc];
                  if(this.sAmt > 0 || this.tAmt2 > 0)
                  {
                     this.ttlt = this.terrain[this.tloc] + this.tAmt2;
                     if(this.wsl > 0)
                     {
                        if(this.tAmt2 >= MIN_HEAT && this.ttlt - this.tsla > 0)
                        {
                           this.wallData = this.wsl - WALL_DECAY_OLD;
                           if(this.wallData <= 0)
                           {
                              this.wallData = 0;
                           }
                           this.walls[this.sloc] = this.wallData;
                        }
                     }
                     else if(this.wtl > 0)
                     {
                        if(this.sAmt >= MIN_HEAT && this.tsla - this.ttlt > 0)
                        {
                           this.wallData = this.wtl - WALL_DECAY_OLD;
                           if(this.wallData <= 0)
                           {
                              this.wallData = 0;
                           }
                           this.walls[this.tloc] = this.wallData;
                        }
                     }
                     else if(this.tsla > this.ttlt)
                     {
                        this.c2a = true;
                        this.deltaAmt2a = this.tsla - this.ttlt;
                        if(this.deltaAmt2a > this.sAmt)
                        {
                           this.deltaAmt2a = this.sAmt;
                        }
                     }
                     else
                     {
                        this.c2b = true;
                        this.deltaAmt2b = this.ttlt - this.tsla;
                        if(this.deltaAmt2b > this.tAmt2)
                        {
                           this.deltaAmt2b = this.tAmt2;
                        }
                     }
                  }
               }
               this.targetX = this.sourceX - 1;
               this.targetY = this.sourceY + 1;
               this.tloc = this.targetX + this.targetY * WIDTH;
               this.wtl = this.walls[this.tloc];
               if(this.targetX >= 0 && this.targetY < HEIGHT)
               {
                  this.tAmt3 = this.shadow[this.tloc];
                  if(this.sAmt > 0 || this.tAmt3 > 0)
                  {
                     this.ttlt = this.terrain[this.tloc] + this.tAmt3;
                     if(this.wsl > 0)
                     {
                        if(this.tAmt3 >= MIN_HEAT && this.ttlt - this.tsla > 0)
                        {
                           this.wallData = this.wsl - WALL_DECAY_OLD;
                           if(this.wallData <= 0)
                           {
                              this.wallData = 0;
                           }
                           this.walls[this.sloc] = this.wallData;
                        }
                     }
                     else if(this.wtl > 0)
                     {
                        if(this.sAmt >= MIN_HEAT && this.tsla - this.ttlt > 0)
                        {
                           this.wallData = this.wtl - WALL_DECAY_OLD;
                           if(this.wallData <= 0)
                           {
                              this.wallData = 0;
                           }
                           this.walls[this.tloc] = this.wallData;
                        }
                     }
                     else if(this.tsla > this.ttlt)
                     {
                        this.c3a = true;
                        this.deltaAmt3a = this.tsla - this.ttlt;
                        if(this.deltaAmt3a > this.sAmt)
                        {
                           this.deltaAmt3a = this.sAmt;
                        }
                     }
                     else
                     {
                        this.c3b = true;
                        this.deltaAmt3b = this.ttlt - this.tsla;
                        if(this.deltaAmt3b > this.tAmt3)
                        {
                           this.deltaAmt3b = this.tAmt3;
                        }
                     }
                  }
               }
               this.targetX = this.sourceX + 1;
               this.targetY = this.sourceY;
               this.tloc = this.targetX + this.targetY * WIDTH;
               if(this.c0a)
               {
                  this.de = this.deltaAmt0a * 0.5 * transferRate;
                  this.data[this.sloc] -= this.de;
                  this.data[this.tloc] += this.de;
               }
               else if(this.c0b)
               {
                  this.de = this.deltaAmt0b * 0.5 * transferRate;
                  this.data[this.sloc] += this.de;
                  this.data[this.tloc] -= this.de;
               }
               this.targetX = this.sourceX + 1;
               this.targetY = this.sourceY + 1;
               this.tloc = this.targetX + this.targetY * WIDTH;
               if(this.c1a)
               {
                  this.de = this.deltaAmt1a * 0.5 * transferRate;
                  this.data[this.sloc] -= this.de;
                  this.data[this.tloc] += this.de;
               }
               else if(this.c1b)
               {
                  this.de = this.deltaAmt1b * 0.5 * transferRate;
                  this.data[this.sloc] += this.de;
                  this.data[this.tloc] -= this.de;
               }
               this.targetX = this.sourceX;
               this.targetY = this.sourceY + 1;
               this.tloc = this.targetX + this.targetY * WIDTH;
               if(this.c2a)
               {
                  this.de = this.deltaAmt2a * 0.5 * transferRate;
                  this.data[this.sloc] -= this.de;
                  this.data[this.tloc] += this.de;
               }
               else if(this.c2b)
               {
                  this.de = this.deltaAmt2b * 0.5 * transferRate;
                  this.data[this.sloc] += this.de;
                  this.data[this.tloc] -= this.de;
               }
               this.targetX = this.sourceX - 1;
               this.targetY = this.sourceY + 1;
               this.tloc = this.targetX + this.targetY * WIDTH;
               if(this.c3a)
               {
                  this.de = this.deltaAmt3a * 0.5 * transferRate;
                  this.data[this.sloc] -= this.de;
                  this.data[this.tloc] += this.de;
               }
               else if(this.c3b)
               {
                  this.de = this.deltaAmt3b * 0.5 * transferRate;
                  this.data[this.sloc] += this.de;
                  this.data[this.tloc] -= this.de;
               }
               this.sAmt = this.data[this.sloc];
               if(this.sAmt < MIN_HEAT && this.sAmt > 0)
               {
                  this.data[this.sloc] = 0;
               }
               ++this.sourceX;
            }
            ++this.sourceY;
         }
         GameSpace.instance.creeperCoverage = _loc1_;
      }
      
      public final function getEdgeInt(param1:int, param2:int, param3:int) : int
      {
         this.b0 = 0;
         this.b1 = 0;
         this.b2 = 0;
         this.b3 = 0;
         if(param2 + 1 >= WIDTH || this.terrain[param2 + param3 * WIDTH] != this.terrain[param2 + 1 + param3 * WIDTH] || this.walls[param2 + 1 + param3 * WIDTH] > 0)
         {
            this.b0 = 1;
         }
         if(param3 - 1 < 0 || this.terrain[param2 + param3 * WIDTH] != this.terrain[param2 + (param3 - 1) * WIDTH] || this.walls[param2 + (param3 - 1) * WIDTH] > 0)
         {
            this.b1 = 1;
         }
         if(param2 - 1 < 0 || this.terrain[param2 + param3 * WIDTH] != this.terrain[param2 - 1 + param3 * WIDTH] || this.walls[param2 - 1 + param3 * WIDTH] > 0)
         {
            this.b2 = 1;
         }
         if(param3 + 1 >= HEIGHT || this.terrain[param2 + param3 * WIDTH] != this.terrain[param2 + (param3 + 1) * WIDTH] || this.walls[param2 + (param3 + 1) * WIDTH] > 0)
         {
            this.b3 = 1;
         }
         if(this.b0 == 0)
         {
            this.da = this.data[param2 + 1 + param3 * WIDTH];
            if(this.da >= 2)
            {
               this.olevel = NUM_LEVELS - 1;
            }
            else
            {
               this.olevel = this.da * (NUM_LEVELS - 1) / 2;
            }
            if(param1 == 0)
            {
               if(this.da >= MIN_HEAT)
               {
                  this.b0 = 1;
               }
            }
            else if(param1 <= this.olevel)
            {
               this.b0 = 1;
            }
         }
         if(this.b1 == 0)
         {
            this.da = this.data[param2 + (param3 - 1) * WIDTH];
            if(this.da >= 2)
            {
               this.olevel = NUM_LEVELS - 1;
            }
            else
            {
               this.olevel = this.da * (NUM_LEVELS - 1) / 2;
            }
            if(param1 == 0)
            {
               if(this.da >= MIN_HEAT)
               {
                  this.b1 = 1;
               }
            }
            else if(param1 <= this.olevel)
            {
               this.b1 = 1;
            }
         }
         if(this.b2 == 0)
         {
            this.da = this.data[param2 - 1 + param3 * WIDTH];
            if(this.da >= 2)
            {
               this.olevel = NUM_LEVELS - 1;
            }
            else
            {
               this.olevel = this.da * (NUM_LEVELS - 1) / 2;
            }
            if(param1 == 0)
            {
               if(this.da >= MIN_HEAT)
               {
                  this.b2 = 1;
               }
            }
            else if(param1 <= this.olevel)
            {
               this.b2 = 1;
            }
         }
         if(this.b3 == 0)
         {
            this.da = this.data[param2 + (param3 + 1) * WIDTH];
            if(this.da >= 2)
            {
               this.olevel = NUM_LEVELS - 1;
            }
            else
            {
               this.olevel = this.da * (NUM_LEVELS - 1) / 2;
            }
            if(param1 == 0)
            {
               if(this.da >= MIN_HEAT)
               {
                  this.b3 = 1;
               }
            }
            else if(param1 <= this.olevel)
            {
               this.b3 = 1;
            }
         }
         return this.b3 << 3 | this.b2 << 2 | this.b1 << 1 | this.b0;
      }
   }
}
