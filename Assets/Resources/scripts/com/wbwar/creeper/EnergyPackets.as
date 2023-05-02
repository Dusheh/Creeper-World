package com.wbwar.creeper
{
   import flash.display.Sprite;
   
   public final class EnergyPackets extends Sprite
   {
       
      
      private var energyPacketLayer:Sprite;
      
      public function EnergyPackets()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         this.energyPacketLayer = new Sprite();
         this.energyPacketLayer.mouseEnabled = false;
         addChild(this.energyPacketLayer);
      }
      
      public function addEnergyPacket(param1:EnergyPacket) : void
      {
         this.energyPacketLayer.addChild(param1);
      }
      
      public function removeEnergyPacket(param1:EnergyPacket) : void
      {
         this.energyPacketLayer.removeChild(param1);
      }
      
      public function update() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = this.energyPacketLayer.numChildren - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = this.energyPacketLayer.getChildAt(_loc2_) as EnergyPacket;
            _loc1_.update();
            _loc2_--;
         }
      }
   }
}
