package com.wbwar.creeper
{
   import flash.display.GradientType;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   
   public class PacketControl extends Sprite
   {
       
      
      private var color:Number;
      
      private var ptype:int;
      
      private var _selected:Boolean = true;
      
      public function PacketControl(param1:Number, param2:int, param3:Boolean = false)
      {
         super();
         this.color = param1;
         this.ptype = param2;
         if(!param3)
         {
            addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            addEventListener(MouseEvent.CLICK,this.onMouseClick);
         }
         this.drawPacket();
      }
      
      public function set selected(param1:Boolean) : void
      {
         this._selected = param1;
         this.drawPacket();
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         this.selected = !this.selected;
         if(this.ptype == EnergyPacket.TYPE_CONSTRUCTION)
         {
            GameSpace.instance.baseGun.allowConstructionPackets = this.selected;
         }
         else if(this.ptype == EnergyPacket.TYPE_WEAPONENERGY)
         {
            GameSpace.instance.baseGun.allowWeaponEnergyPackets = this.selected;
         }
         else if(this.ptype == EnergyPacket.TYPE_OPERATEENERGY)
         {
            GameSpace.instance.baseGun.allowOperateEnergyPackets = this.selected;
         }
      }
      
      private function drawPacket() : void
      {
         var _loc1_:Matrix = new Matrix();
         graphics.clear();
         if(this.selected)
         {
            _loc1_.createGradientBox(10.4,10.4,0,-7.2,-7.2);
            graphics.beginGradientFill(GradientType.RADIAL,[15724527,this.color],[1,1],[0,255],_loc1_);
            graphics.lineStyle(1,3158016);
            graphics.drawCircle(0,0,6);
            graphics.endFill();
         }
         else
         {
            graphics.beginFill(16777215,0.3);
            graphics.lineStyle(2,3158016);
            graphics.drawCircle(0,0,6);
            graphics.endFill();
         }
      }
   }
}
