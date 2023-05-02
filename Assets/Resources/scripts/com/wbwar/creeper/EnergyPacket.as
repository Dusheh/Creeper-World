package com.wbwar.creeper
{
   import com.wbwar.creeper.util.Graph;
   import flash.display.GradientType;
   import flash.display.Shape;
   import flash.geom.Matrix;
   
   public final class EnergyPacket extends Shape
   {
      
      public static const TYPE_CONSTRUCTION:int = 0;
      
      public static const TYPE_WEAPONENERGY:int = 1;
      
      public static const TYPE_OPERATEENERGY:int = 2;
      
      public static const WORTH:Number = 5;
      
      private static var matr:Matrix = new Matrix();
      
      {
         matr.createGradientBox(10.4,10.4,0,-7.2,-7.2);
      }
      
      private var type:int;
      
      private var currentSource:Place;
      
      private var currentPath:Path;
      
      private var goal:Place;
      
      private var currentDistance:Number = 0;
      
      public var destroyed:Boolean;
      
      private var oe:Place;
      
      private var d:Number;
      
      private var sx:Number;
      
      private var sy:Number;
      
      private var tx:Number;
      
      private var ty:Number;
      
      private var dx:Number;
      
      private var dy:Number;
      
      private var frac:Number;
      
      private var sqrt:Function;
      
      public function EnergyPacket(param1:Place, param2:Place, param3:int)
      {
         this.sqrt = Math.sqrt;
         super();
         this.currentSource = param1;
         this.goal = param2;
         this.type = param3;
         this.init();
      }
      
      private function init() : void
      {
         var _loc1_:* = 7368816;
         if(this.type == TYPE_OPERATEENERGY)
         {
            _loc1_ = 3211056;
         }
         else if(this.type == TYPE_WEAPONENERGY)
         {
            _loc1_ = 16732208;
         }
         graphics.beginGradientFill(GradientType.RADIAL,[16777215,_loc1_],[1,1],[0,255],matr);
         graphics.lineStyle(1,3158016);
         graphics.drawCircle(0,0,4);
         graphics.endFill();
         GameSpace.instance.energyPackets.addEnergyPacket(this);
         this.nextTarget();
         if(!this.destroyed)
         {
            this.oe = this.currentPath.getOtherEnd(this.currentSource);
            this.render();
         }
      }
      
      private function nextTarget() : void
      {
         var _loc1_:Array = Graph.travelPath(GameSpace.instance.places,this.currentSource,this.goal);
         if(_loc1_.length <= 1)
         {
            this.destroy();
         }
         else
         {
            this.currentPath = this.currentSource.getPathTo(_loc1_[1]);
         }
      }
      
      private function reachGoal() : void
      {
         this.goal.applyEnergyPacket(this);
         this.destroy();
      }
      
      public function destroy() : void
      {
         this.destroyed = true;
         --this.goal.assignedEnergyPacketCount;
         if(this.goal.assignedEnergyPacketCount < 0)
         {
            this.goal.assignedEnergyPacketCount = 0;
         }
         GameSpace.instance.energyPackets.removeEnergyPacket(this);
      }
      
      public function update() : void
      {
         if(this.currentPath != null && this.currentPath.destroyed)
         {
            this.destroy();
         }
         else
         {
            this.oe = this.currentPath.getOtherEnd(this.currentSource);
            this.d = this.currentPath.getDistance();
            if(this.currentDistance >= this.d)
            {
               if(this.oe == this.goal)
               {
                  this.reachGoal();
                  return;
               }
               this.currentSource = this.oe;
               this.currentDistance -= this.d;
               this.nextTarget();
               this.oe = this.currentPath.getOtherEnd(this.currentSource);
            }
            else
            {
               this.currentDistance += GameSpace.instance.energyPacketSpeed;
            }
            this.render();
         }
      }
      
      private function render() : void
      {
         if(this.currentPath == null)
         {
            return;
         }
         this.sx = this.currentSource.x;
         this.sy = this.currentSource.y;
         this.tx = this.oe.x;
         this.ty = this.oe.y;
         this.dx = this.tx - this.sx;
         this.dy = this.ty - this.sy;
         this.d = this.sqrt(this.dx * this.dx + this.dy * this.dy);
         if(this.d == 0)
         {
            this.frac = 1;
         }
         else
         {
            this.frac = this.currentDistance / this.d;
            if(this.frac > 1)
            {
               this.frac = 1;
            }
         }
         x = this.currentSource.x + this.dx * this.frac;
         y = this.currentSource.y + this.dy * this.frac;
      }
   }
}
