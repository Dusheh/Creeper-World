package com.wbwar.creeper.controlpanel.menu
{
   import com.wbwar.creeper.ABM;
   import com.wbwar.creeper.AreaGun;
   import com.wbwar.creeper.BaseGun;
   import com.wbwar.creeper.DroneBase;
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.Gun;
   import com.wbwar.creeper.Place;
   import com.wbwar.creeper.Ruin;
   import com.wbwar.creeper.SurvivalPod;
   import com.wbwar.creeper.Tech;
   import com.wbwar.creeper.Totem;
   import com.wbwar.creeper.UpgradeBox;
   import com.wbwar.creeper.util.Button;
   import com.wbwar.creeper.util.Checkbox;
   import com.wbwar.creeper.util.Text;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   
   public class PlaceControlMenu extends Sprite
   {
       
      
      private var _place:Place;
      
      private var packetControlPanel:Sprite;
      
      private var constructionPacketsCB:Checkbox;
      
      private var energyPacketsCB:Checkbox;
      
      private var operationPacketsCB:Checkbox;
      
      public var destroyButton:Button;
      
      public var armDisarmButton:Button;
      
      public var turnOnOffButton:Button;
      
      public var noActionMode:Boolean;
      
      public function PlaceControlMenu()
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         super();
         this.packetControlPanel = new Sprite();
         addChild(this.packetControlPanel);
         this.packetControlPanel.y = 0;
         this.constructionPacketsCB = new Checkbox(16777215,16777215);
         this.constructionPacketsCB.scaleX = 0.55;
         this.constructionPacketsCB.scaleY = this.constructionPacketsCB.scaleX;
         this.energyPacketsCB = new Checkbox(16777215,16711680);
         this.energyPacketsCB.scaleX = 0.55;
         this.energyPacketsCB.scaleY = this.energyPacketsCB.scaleX;
         this.operationPacketsCB = new Checkbox(16777215,65280);
         this.operationPacketsCB.scaleX = 0.55;
         this.operationPacketsCB.scaleY = this.operationPacketsCB.scaleX;
         this.packetControlPanel.addChild(this.constructionPacketsCB);
         this.packetControlPanel.addChild(this.energyPacketsCB);
         this.packetControlPanel.addChild(this.operationPacketsCB);
         this.constructionPacketsCB.x = 7;
         this.constructionPacketsCB.y = 15;
         this.energyPacketsCB.x = 7;
         this.energyPacketsCB.y = 26;
         this.operationPacketsCB.x = 7;
         this.operationPacketsCB.y = 37;
         this.packetControlPanel.graphics.lineStyle(1,12632256);
         this.packetControlPanel.graphics.drawRect(0,8,72,35);
         _loc1_ = Text.text("Packet Control",8,15790320);
         this.packetControlPanel.addChild(_loc1_);
         _loc1_.x = 3;
         _loc1_.y = -4;
         _loc2_ = Text.text("Build",8,16777215);
         this.packetControlPanel.addChild(_loc2_);
         _loc2_.x = 13;
         _loc2_.y = 7;
         _loc3_ = Text.text("Ammo",8,16711680);
         this.packetControlPanel.addChild(_loc3_);
         _loc3_.x = _loc2_.x;
         _loc3_.y = _loc2_.y + 11;
         var _loc4_:TextField = Text.text("Totem",8,65280);
         this.packetControlPanel.addChild(_loc4_);
         _loc4_.x = _loc2_.x;
         _loc4_.y = _loc3_.y + 11;
         this.packetControlPanel.filters = [new DropShadowFilter()];
         this.constructionPacketsCB.addEventListener(Checkbox.CHECK_CHANGE,this.onConstructionCheck);
         this.energyPacketsCB.addEventListener(Checkbox.CHECK_CHANGE,this.onEnergyCheck);
         this.operationPacketsCB.addEventListener(Checkbox.CHECK_CHANGE,this.onOperationCheck);
         this.turnOnOffButton = new Button("Deactivate",10,66,15,0,-1,false,1077264,-1);
         addChild(this.turnOnOffButton);
         this.turnOnOffButton.setSubtitle("Q",59,3,true);
         this.turnOnOffButton.x = 5;
         this.turnOnOffButton.y = 1;
         this.armDisarmButton = new Button("Disarm",10,66,15,0,-1,false,1077360,-1);
         addChild(this.armDisarmButton);
         this.armDisarmButton.setSubtitle("A",59,3,true);
         this.armDisarmButton.x = 5;
         this.armDisarmButton.y = 17;
         this.destroyButton = new Button("Destroy",8,46,10,0,-3,true,7344144,-1);
         addChild(this.destroyButton);
         this.destroyButton.setSubtitle("x",39,-1,true);
         this.destroyButton.x = 5;
         this.destroyButton.y = 35;
         this.destroyButton.addEventListener(MouseEvent.CLICK,this.onDestroyButtonClick,false,0,true);
         this.turnOnOffButton.addEventListener(MouseEvent.CLICK,this.onTurnOnOffButtonClick,false,0,true);
         this.armDisarmButton.addEventListener(MouseEvent.CLICK,this.onArmDisarmButtonClick,false,0,true);
      }
      
      public function set place(param1:Place) : void
      {
         this._place = param1;
         if(param1 != null)
         {
            if(this.noActionMode)
            {
               this.destroyButton.visible = false;
               this.turnOnOffButton.visible = false;
               this.armDisarmButton.visible = false;
               this.packetControlPanel.visible = false;
            }
            else if(param1 is BaseGun || param1 is UpgradeBox || param1 is Totem || param1 is Tech || param1 is Ruin || param1 is SurvivalPod)
            {
               if(param1 is BaseGun)
               {
                  this.packetControlPanel.visible = true;
                  this.constructionPacketsCB.checked = (param1 as BaseGun).allowConstructionPackets;
                  this.energyPacketsCB.checked = (param1 as BaseGun).allowWeaponEnergyPackets;
                  this.operationPacketsCB.checked = (param1 as BaseGun).allowOperateEnergyPackets;
               }
               else
               {
                  this.packetControlPanel.visible = false;
               }
               this.destroyButton.visible = false;
               this.armDisarmButton.visible = false;
               this.turnOnOffButton.visible = false;
            }
            else
            {
               this.packetControlPanel.visible = false;
               this.destroyButton.visible = true;
               if(param1.turnedOn)
               {
                  this.turnOnOffButton.text.text = "Deactivate";
               }
               else
               {
                  this.turnOnOffButton.text.text = "Activate";
               }
               if(param1.armed)
               {
                  this.armDisarmButton.text.text = "Disarm";
               }
               else
               {
                  this.armDisarmButton.text.text = "Arm";
               }
               if(param1 is Gun || param1 is AreaGun || param1 is ABM || param1 is DroneBase)
               {
                  this.turnOnOffButton.visible = true;
               }
               else
               {
                  this.turnOnOffButton.visible = false;
               }
               if(param1 is Gun || param1 is AreaGun || param1 is ABM)
               {
                  this.armDisarmButton.visible = true;
               }
               else
               {
                  this.armDisarmButton.visible = false;
               }
            }
         }
      }
      
      public function get place() : Place
      {
         return this._place;
      }
      
      private function onConstructionCheck(param1:Event) : void
      {
         if(this._place is BaseGun)
         {
            (this._place as BaseGun).allowConstructionPackets = this.constructionPacketsCB.checked;
         }
      }
      
      private function onEnergyCheck(param1:Event) : void
      {
         if(this._place is BaseGun)
         {
            (this._place as BaseGun).allowWeaponEnergyPackets = this.energyPacketsCB.checked;
         }
      }
      
      private function onOperationCheck(param1:Event) : void
      {
         if(this._place is BaseGun)
         {
            (this._place as BaseGun).allowOperateEnergyPackets = this.operationPacketsCB.checked;
         }
      }
      
      public function onDestroyButtonClick(param1:MouseEvent) : void
      {
         if(param1 != null)
         {
            param1.stopImmediatePropagation();
         }
         if(this._place != null)
         {
            this._place.destroy();
         }
         GameSpace.instance.controlPanel.onCancelButtonClick();
      }
      
      public function onArmDisarmButtonClick(param1:MouseEvent) : void
      {
         if(param1 != null)
         {
            param1.stopImmediatePropagation();
         }
         if(this._place != null)
         {
            this._place.armed = !this._place.armed;
            if(this._place.armed)
            {
               this.armDisarmButton.text.text = "Disarm";
            }
            else
            {
               this.armDisarmButton.text.text = "Arm";
            }
         }
      }
      
      public function onTurnOnOffButtonClick(param1:MouseEvent) : void
      {
         if(param1 != null)
         {
            param1.stopImmediatePropagation();
         }
         if(this._place != null)
         {
            this._place.turnedOn = !this._place.turnedOn;
            if(this._place.turnedOn)
            {
               this.turnOnOffButton.text.text = "Deactivate";
            }
            else
            {
               this.turnOnOffButton.text.text = "Activate";
            }
         }
      }
   }
}
