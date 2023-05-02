package com.wbwar.creeper
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public final class DynamicContent extends Bitmap
   {
       
      
      private var updateCount:int;
      
      private var updateStash:Boolean;
      
      private var bmd:BitmapData;
      
      private var bm:Bitmap;
      
      private var cellRect:Rectangle;
      
      private var fullRect:Rectangle;
      
      private var i:int;
      
      private var j:int;
      
      private var loc:int;
      
      private var p:Point;
      
      private var glopData:Array;
      
      private var wallData:Array;
      
      private var energyGridData:Array;
      
      private var cTransform:ColorTransform;
      
      private var WIDTH:int;
      
      private var HEIGHT:int;
      
      private var CELL_WIDTH:int;
      
      private var CELL_HEIGHT:int;
      
      private var updateGraphics:Boolean;
      
      private var glop:Glop;
      
      private var glopBmd:Array;
      
      public var energyAccumulationRate:Number = 0;
      
      private var wallRect:Rectangle;
      
      private var cc:int;
      
      public var energyMod:Number;
      
      public var energyStores:int;
      
      public var energyReactorProduction:Number;
      
      public var trect:Rectangle;
      
      public var tpoint:Point;
      
      private var wdl:Number;
      
      private var mh:Number = 0.001;
      
      private var level:int;
      
      private var da:Number;
      
      private var li:int;
      
      public function DynamicContent()
      {
         this.p = new Point();
         this.cTransform = new ColorTransform();
         this.trect = new Rectangle(0,0,0 * 0,0 * 0);
         this.tpoint = new Point(0,0);
         super();
         this.WIDTH = GameSpace.WIDTH;
         this.HEIGHT = GameSpace.HEIGHT;
         this.CELL_WIDTH = GameSpace.CELL_WIDTH_S;
         this.CELL_HEIGHT = GameSpace.CELL_HEIGHT_S;
         this.bmd = new BitmapData(this.CELL_WIDTH * this.WIDTH,this.CELL_HEIGHT * this.HEIGHT,false,0);
         this.bitmapData = this.bmd;
         this.cellRect = new Rectangle(0,0,this.CELL_WIDTH,this.CELL_HEIGHT);
         this.fullRect = new Rectangle(0,0,this.WIDTH * this.CELL_WIDTH,this.HEIGHT * this.CELL_HEIGHT);
         this.wallRect = new Rectangle(0,0,this.CELL_WIDTH,this.CELL_HEIGHT);
         this.width = 700;
         this.height = 480;
      }
      
      public function update() : void
      {
         var _loc1_:* = NaN;
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:Number = NaN;
         ++this.updateCount;
         if(GameSpace.instance.upgradeEconomic0)
         {
            this.energyMod = 1.1;
         }
         else
         {
            this.energyMod = 1;
         }
         if((this.updateCount + 1) % 32 == 0)
         {
            GameSpace.instance.controlPanel.stashViewer.update();
            this.updateStash = true;
            this.energyAccumulationRate = 0;
            if(GameSpace.instance.baseGun != null && GameSpace.instance.baseGun.state == MovingPlace.STATE_PLACED)
            {
               this.energyAccumulationRate += 3 * this.energyMod;
               GameSpace.instance.stash += 3 * this.energyMod;
               GameSpace.instance.totalEnergyCollected += 3 * this.energyMod;
            }
            _loc1_ = 0;
            _loc2_ = 0;
            _loc3_ = 0;
            _loc4_ = 0;
            _loc5_ = GameSpace.instance.places.placesLayer.numChildren - 1;
            while(_loc5_ >= 0)
            {
               if((_loc6_ = GameSpace.instance.places.placesLayer.getChildAt(_loc5_)) is EnergyStorage)
               {
                  if((_loc6_ as EnergyStorage).powered && (_loc6_ as Place).turnedOn)
                  {
                     _loc1_++;
                  }
               }
               else if(_loc6_ is Logistics)
               {
                  if((_loc6_ as Logistics).powered && (_loc6_ as Place).turnedOn)
                  {
                     _loc2_++;
                  }
               }
               else if(_loc6_ is EnergyAmp)
               {
                  if((_loc6_ as EnergyAmp).powered && (_loc6_ as Place).turnedOn)
                  {
                     _loc3_++;
                  }
               }
               else if(_loc6_ is Gun)
               {
                  _loc4_++;
               }
               else if(_loc6_ is AreaGun)
               {
                  _loc4_++;
               }
               else if(_loc6_ is DroneBase)
               {
                  _loc4_ += 4;
               }
               _loc5_--;
            }
            GameSpace.instance.stashMax = 100 + 100 * _loc1_;
            this.energyStores = _loc1_;
            GameSpace.instance.energyPacketSpeed = 2 + _loc2_ * 0.5;
            _loc3_ *= 1.5;
            _loc3_ *= this.energyMod;
            this.energyReactorProduction = _loc3_;
            this.energyAccumulationRate += _loc3_;
            GameSpace.instance.stash += _loc3_;
            GameSpace.instance.totalEnergyCollected += _loc3_;
         }
         else
         {
            this.updateStash = false;
         }
         if(GameSpace.instance.speedUp)
         {
            this.updateGraphics = (this.updateCount + 1) % 16 == 0;
         }
         else
         {
            this.updateGraphics = true;
         }
         if((this.updateCount + 1) % 8 == 0)
         {
            if(this.updateGraphics)
            {
               this.bmd.lock();
               this.bmd.copyPixels(GameSpace.instance.terrain.terrainBMD,this.trect,this.tpoint);
            }
            this.glop = GameSpace.instance.glop;
            this.glopBmd = GameSpace.instance.glop.glopBmd;
            this.glopData = GameSpace.instance.glop.data;
            this.wallData = GameSpace.instance.walls.wallData;
            this.energyGridData = GameSpace.instance.energyGrid.energyGridData;
            this.j = 0;
            while(this.j < this.HEIGHT)
            {
               _loc5_ = 0;
               while(_loc5_ < this.WIDTH)
               {
                  this.loc = int(_loc5_ + this.j * this.WIDTH);
                  this.p.x = _loc5_ * this.CELL_WIDTH;
                  this.p.y = this.j * this.CELL_HEIGHT;
                  if(this.energyGridData[this.loc] > 0)
                  {
                     if(this.updateStash)
                     {
                        _loc7_ = 0.02 * this.energyMod;
                        this.energyAccumulationRate += _loc7_;
                        GameSpace.instance.stash += _loc7_;
                        GameSpace.instance.totalEnergyCollected += _loc7_;
                     }
                     if(this.updateGraphics)
                     {
                        this.bmd.copyPixels(GameSpace.instance.energyGrid.energyBmd,this.cellRect,this.p);
                     }
                  }
                  if(this.updateGraphics)
                  {
                     this.da = this.glopData[this.loc];
                     if(this.da >= this.mh)
                     {
                        if(this.da >= 2)
                        {
                           this.level = 15;
                        }
                        else
                        {
                           this.level = this.da * 7.5;
                        }
                        this.li = this.glop.getEdgeInt(this.level,_loc5_,this.j);
                        this.bmd.copyPixels(this.glopBmd[this.level][this.li],this.cellRect,this.p,null,null,true);
                     }
                  }
                  if(this.updateGraphics)
                  {
                     this.wdl = this.wallData[this.loc];
                     if(this.wdl > 0)
                     {
                        if(this.wdl > 100000)
                        {
                           this.bmd.copyPixels(Walls.superwallBmd,this.cellRect,this.p);
                        }
                        else
                        {
                           this.bmd.copyPixels(Walls.wallBmd,this.cellRect,this.p);
                        }
                        if(this.wdl < 1)
                        {
                           this.cTransform.redMultiplier = this.wdl;
                           this.cTransform.greenMultiplier = this.cTransform.redMultiplier;
                           this.cTransform.blueMultiplier = this.cTransform.redMultiplier;
                           this.wallRect.x = _loc5_ * this.CELL_WIDTH;
                           this.wallRect.y = this.j * this.CELL_HEIGHT;
                           this.bmd.colorTransform(this.wallRect,this.cTransform);
                        }
                     }
                  }
                  _loc5_++;
               }
               ++this.j;
            }
            if(this.updateGraphics)
            {
               this.bmd.unlock();
            }
         }
      }
   }
}
