package com.wbwar.creeper.controlpanel.menu
{
   import com.wbwar.creeper.ABM;
   import com.wbwar.creeper.AreaGun;
   import com.wbwar.creeper.DroneBase;
   import com.wbwar.creeper.EnergyAmp;
   import com.wbwar.creeper.EnergyStorage;
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.Gun;
   import com.wbwar.creeper.Logistics;
   import com.wbwar.creeper.Node;
   import com.wbwar.creeper.Place;
   import com.wbwar.creeper.Relay;
   import com.wbwar.creeper.ThorsHammer;
   import com.wbwar.creeper.util.Button;
   import com.wbwar.creeper.util.ButtonHighlight;
   import com.wbwar.creeper.util.Text;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   
   public class BuildMenu extends Sprite
   {
       
      
      public var gunButton:Button;
      
      public var areaGunButton:Button;
      
      public var abmButton:Button;
      
      public var droneBaseButton:Button;
      
      public var thorsHammerButton:Button;
      
      public var nodeButton:Button;
      
      public var relayButton:Button;
      
      public var energyStoreButton:Button;
      
      public var logisticsButton:Button;
      
      public var energyAmpButton:Button;
      
      private var highlightLayer:Sprite;
      
      public var buttonHighlight:ButtonHighlight;
      
      public var statusName:TextField;
      
      public var statusDesc:TextField;
      
      public var statusCost:TextField;
      
      public function BuildMenu()
      {
         var _loc1_:* = null;
         super();
         mouseEnabled = false;
         this.gunButton = new Button("Blaster",10,66,17,0,0,false,7344144,-1);
         addChild(this.gunButton);
         this.gunButton.setSubtitle("6",-2,6);
         _loc1_ = Gun.getPlacementSprite(false);
         this.gunButton.addChild(_loc1_);
         _loc1_.x = 57;
         _loc1_.y = 9;
         _loc1_.scaleX = 0.8;
         _loc1_.scaleY = _loc1_.scaleX;
         this.gunButton.x = 1;
         this.gunButton.y = 19;
         this.gunButton.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverGun,false,0,true);
         this.gunButton.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.gunButton.mystery = true;
         this.areaGunButton = new Button("Mortar",10,66,17,0,0,false,7344144,-1);
         addChild(this.areaGunButton);
         this.areaGunButton.setSubtitle("7",-2,6);
         _loc1_ = AreaGun.getPlacementSprite(false);
         this.areaGunButton.addChild(_loc1_);
         _loc1_.x = 57;
         _loc1_.y = 9;
         _loc1_.scaleX = 0.8;
         _loc1_.scaleY = _loc1_.scaleX;
         this.areaGunButton.x = this.gunButton.x + 67;
         this.areaGunButton.y = 19;
         this.areaGunButton.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverAreaGun,false,0,true);
         this.areaGunButton.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.areaGunButton.mystery = true;
         this.abmButton = new Button("SAM",10,66,17,0,0,false,7344144,-1);
         addChild(this.abmButton);
         this.abmButton.setSubtitle("8",-2,6);
         _loc1_ = ABM.getPlacementSprite(false);
         this.abmButton.addChild(_loc1_);
         _loc1_.x = 57;
         _loc1_.y = 9;
         _loc1_.scaleX = 0.8;
         _loc1_.scaleY = _loc1_.scaleX;
         this.abmButton.x = this.areaGunButton.x + 67;
         this.abmButton.y = 19;
         this.abmButton.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverAbm,false,0,true);
         this.abmButton.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.abmButton.mystery = true;
         this.droneBaseButton = new Button("Drone",10,66,17,0,0,false,7344144,-1);
         addChild(this.droneBaseButton);
         this.droneBaseButton.setSubtitle("9",-2,6);
         _loc1_ = DroneBase.getPlacementSprite(false);
         this.droneBaseButton.addChild(_loc1_);
         _loc1_.x = 57;
         _loc1_.y = 9;
         _loc1_.scaleX = 0.7;
         _loc1_.scaleY = _loc1_.scaleX;
         this.droneBaseButton.x = this.abmButton.x + 67;
         this.droneBaseButton.y = 19;
         this.droneBaseButton.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverDroneBase,false,0,true);
         this.droneBaseButton.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.droneBaseButton.mystery = true;
         this.thorsHammerButton = new Button("Thor",10,66,17,0,0,false,7344144,-1);
         addChild(this.thorsHammerButton);
         this.thorsHammerButton.setSubtitle("0",-2,6);
         _loc1_ = ThorsHammer.getPlacementSprite(false);
         this.thorsHammerButton.addChild(_loc1_);
         _loc1_.rotation = -90;
         _loc1_.x = 57;
         _loc1_.y = 9;
         _loc1_.scaleX = 0.4;
         _loc1_.scaleY = _loc1_.scaleX;
         this.thorsHammerButton.x = this.droneBaseButton.x + 67;
         this.thorsHammerButton.y = 19;
         this.thorsHammerButton.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverThorsHammer,false,0,true);
         this.thorsHammerButton.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.thorsHammerButton.mystery = true;
         this.nodeButton = new Button("Collector",10,66,17,0,0,false,1077264,-1);
         addChild(this.nodeButton);
         this.nodeButton.setSubtitle("1",-2,6);
         _loc1_ = Node.getPlacementSprite(false);
         this.nodeButton.addChild(_loc1_);
         _loc1_.x = 57;
         _loc1_.y = 9;
         _loc1_.scaleX = 0.8;
         _loc1_.scaleY = _loc1_.scaleX;
         this.nodeButton.x = 1;
         this.nodeButton.y = 1;
         this.nodeButton.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverNode,false,0,true);
         this.nodeButton.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.nodeButton.mystery = true;
         this.relayButton = new Button("Relay",10,66,17,0,0,false,1077264,-1);
         addChild(this.relayButton);
         this.relayButton.setSubtitle("2",-2,6);
         _loc1_ = Relay.getPlacementSprite(false);
         this.relayButton.addChild(_loc1_);
         _loc1_.x = 57;
         _loc1_.y = 9;
         _loc1_.scaleX = 0.8;
         _loc1_.scaleY = _loc1_.scaleX;
         this.relayButton.x = this.nodeButton.x + 67;
         this.relayButton.y = 1;
         this.relayButton.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverRelay,false,0,true);
         this.relayButton.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.relayButton.mystery = true;
         this.energyStoreButton = new Button("Storage",10,66,17,0,0,false,1077264,-1);
         addChild(this.energyStoreButton);
         this.energyStoreButton.setSubtitle("3",-2,6);
         _loc1_ = EnergyStorage.getPlacementSprite(false);
         this.energyStoreButton.addChild(_loc1_);
         _loc1_.x = 57;
         _loc1_.y = 9;
         _loc1_.scaleX = 0.8;
         _loc1_.scaleY = _loc1_.scaleX;
         this.energyStoreButton.x = this.relayButton.x + 67;
         this.energyStoreButton.y = 1;
         this.energyStoreButton.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverEnergyStorage,false,0,true);
         this.energyStoreButton.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.energyStoreButton.mystery = true;
         this.logisticsButton = new Button("Speed",10,66,17,0,0,false,1077264,-1);
         addChild(this.logisticsButton);
         this.logisticsButton.setSubtitle("4",-2,6);
         _loc1_ = Logistics.getPlacementSprite(false);
         this.logisticsButton.addChild(_loc1_);
         _loc1_.x = 57;
         _loc1_.y = 9;
         _loc1_.scaleX = 0.8;
         _loc1_.scaleY = _loc1_.scaleX;
         this.logisticsButton.x = this.energyStoreButton.x + 67;
         this.logisticsButton.y = 1;
         this.logisticsButton.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverLogistics,false,0,true);
         this.logisticsButton.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.logisticsButton.mystery = true;
         this.energyAmpButton = new Button("Reactor",10,66,17,0,0,false,1077264,-1);
         addChild(this.energyAmpButton);
         this.energyAmpButton.setSubtitle("5",-2,6);
         _loc1_ = EnergyAmp.getPlacementSprite(false);
         this.energyAmpButton.addChild(_loc1_);
         _loc1_.x = 57;
         _loc1_.y = 9;
         _loc1_.scaleX = 0.8;
         _loc1_.scaleY = _loc1_.scaleX;
         this.energyAmpButton.x = this.logisticsButton.x + 67;
         this.energyAmpButton.y = 1;
         this.energyAmpButton.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverEnergyAmp,false,0,true);
         this.energyAmpButton.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.energyAmpButton.mystery = true;
         this.highlightLayer = new Sprite();
         this.highlightLayer.mouseEnabled = false;
         this.highlightLayer.mouseChildren = false;
         addChild(this.highlightLayer);
         this.buttonHighlight = new ButtonHighlight(this.gunButton.width,this.gunButton.height);
         this.highlightLayer.addChild(this.buttonHighlight);
         this.buttonHighlight.visible = false;
         this.gunButton.addEventListener(MouseEvent.CLICK,this.onGunButtonClick,false,0,true);
         this.areaGunButton.addEventListener(MouseEvent.CLICK,this.onAreaGunButtonClick,false,0,true);
         this.abmButton.addEventListener(MouseEvent.CLICK,this.onAbmButtonClick,false,0,true);
         this.droneBaseButton.addEventListener(MouseEvent.CLICK,this.onDroneBaseButtonClick,false,0,true);
         this.thorsHammerButton.addEventListener(MouseEvent.CLICK,this.onThorsHammerButtonClick,false,0,true);
         this.nodeButton.addEventListener(MouseEvent.CLICK,this.onNodeButtonClick,false,0,true);
         this.relayButton.addEventListener(MouseEvent.CLICK,this.onRelayButtonClick,false,0,true);
         this.energyStoreButton.addEventListener(MouseEvent.CLICK,this.onEnergyStoreButtonClick,false,0,true);
         this.logisticsButton.addEventListener(MouseEvent.CLICK,this.onLogisticsButtonClick,false,0,true);
         this.energyAmpButton.addEventListener(MouseEvent.CLICK,this.onEnergyAmpButtonClick,false,0,true);
         this.statusName = Text.text("",8,16777215);
         this.statusName.filters = [new DropShadowFilter(1,45,4210752)];
         this.statusName.y = 33;
         addChild(this.statusName);
         this.statusDesc = Text.text("",8,10526880);
         this.statusDesc.filters = [new DropShadowFilter(1,45,4210752)];
         this.statusDesc.y = 33;
         addChild(this.statusDesc);
         this.statusCost = Text.text("",8,65280);
         this.statusCost.filters = [new DropShadowFilter(1,45,4210752)];
         this.statusCost.y = 33;
         addChild(this.statusCost);
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         if(param1)
         {
            Creeper.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false,0,true);
         }
         else
         {
            Creeper.instance.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         }
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 49)
         {
            if(this.nodeButton.enabled && !this.nodeButton.mystery)
            {
               this.onNodeButtonClick(null);
            }
         }
         else if(param1.keyCode == 50)
         {
            if(this.relayButton.enabled && !this.relayButton.mystery)
            {
               this.onRelayButtonClick(null);
            }
         }
         else if(param1.keyCode == 51)
         {
            if(this.energyStoreButton.enabled && !this.energyStoreButton.mystery)
            {
               this.onEnergyStoreButtonClick(null);
            }
         }
         else if(param1.keyCode == 52)
         {
            if(this.logisticsButton.enabled && !this.logisticsButton.mystery)
            {
               this.onLogisticsButtonClick(null);
            }
         }
         else if(param1.keyCode == 53)
         {
            if(this.energyAmpButton.enabled && !this.energyAmpButton.mystery)
            {
               this.onEnergyAmpButtonClick(null);
            }
         }
         else if(param1.keyCode == 54)
         {
            if(this.gunButton.enabled && !this.gunButton.mystery)
            {
               this.onGunButtonClick(null);
            }
         }
         else if(param1.keyCode == 55)
         {
            if(this.areaGunButton.enabled && !this.areaGunButton.mystery)
            {
               this.onAreaGunButtonClick(null);
            }
         }
         else if(param1.keyCode == 56)
         {
            if(this.abmButton.enabled && !this.abmButton.mystery)
            {
               this.onAbmButtonClick(null);
            }
         }
         else if(param1.keyCode == 57)
         {
            if(this.droneBaseButton.enabled && !this.droneBaseButton.mystery)
            {
               this.onDroneBaseButtonClick(null);
            }
         }
         else if(param1.keyCode == 48)
         {
            if(this.thorsHammerButton.enabled && !this.thorsHammerButton.mystery)
            {
               this.onThorsHammerButtonClick(null);
            }
         }
      }
      
      private function alignStatus() : void
      {
         this.statusName.visible = true;
         this.statusDesc.visible = true;
         this.statusCost.visible = true;
         this.statusName.x = 5;
         this.statusCost.x = this.statusName.x + this.statusName.width + 5;
         this.statusDesc.x = this.statusCost.x + this.statusCost.width + 10;
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         this.statusName.visible = false;
         this.statusDesc.visible = false;
         this.statusCost.visible = false;
      }
      
      private function onMouseOverGun(param1:MouseEvent) : void
      {
         if(this.gunButton.mystery)
         {
            return;
         }
         var _loc2_:Number = !!GameSpace.instance.upgradeEconomic1 ? 0 : Number(1);
         this.statusName.text = "[BLASTER]";
         this.statusDesc.text = "Fractal beam blaster.";
         this.statusCost.text = "COST: " + String(int(0 * _loc2_));
         this.alignStatus();
      }
      
      private function onMouseOverAreaGun(param1:MouseEvent) : void
      {
         if(this.areaGunButton.mystery)
         {
            return;
         }
         var _loc2_:Number = !!GameSpace.instance.upgradeEconomic1 ? 0 : Number(1);
         this.statusName.text = "[Mortar]";
         this.statusDesc.text = "Confined fractal charge launcher.";
         this.statusCost.text = "COST: " + String(int(0 * _loc2_));
         this.alignStatus();
      }
      
      private function onMouseOverAbm(param1:MouseEvent) : void
      {
         if(this.abmButton.mystery)
         {
            return;
         }
         var _loc2_:Number = !!GameSpace.instance.upgradeEconomic1 ? 0 : Number(1);
         this.statusName.text = "[SAM]";
         this.statusDesc.text = "Surface to air missile.";
         this.statusCost.text = "COST: " + String(int(0 * _loc2_));
         this.alignStatus();
      }
      
      private function onMouseOverDroneBase(param1:MouseEvent) : void
      {
         if(this.droneBaseButton.mystery)
         {
            return;
         }
         var _loc2_:Number = !!GameSpace.instance.upgradeEconomic1 ? 0 : Number(1);
         this.statusName.text = "[DRONE]";
         this.statusDesc.text = "AI Drone bomber base.";
         this.statusCost.text = "COST: " + String(int(0 * _loc2_));
         this.alignStatus();
      }
      
      private function onMouseOverThorsHammer(param1:MouseEvent) : void
      {
         if(this.thorsHammerButton.mystery)
         {
            return;
         }
         var _loc2_:Number = !!GameSpace.instance.upgradeEconomic1 ? 0 : Number(1);
         this.statusName.text = "[THOR\'S HAMMER]";
         this.statusDesc.text = "Ultimate Weapon";
         this.statusCost.text = "COST: " + String(int(0 * _loc2_));
         this.alignStatus();
      }
      
      private function onMouseOverNode(param1:MouseEvent) : void
      {
         if(this.nodeButton.mystery)
         {
            return;
         }
         var _loc2_:Number = !!GameSpace.instance.upgradeEconomic1 ? 0 : Number(1);
         this.statusName.text = "[COLLECTOR]";
         this.statusDesc.text = "Fractal energy collector.";
         this.statusCost.text = "COST: " + String(int(0 * _loc2_));
         this.alignStatus();
      }
      
      private function onMouseOverRelay(param1:MouseEvent) : void
      {
         if(this.relayButton.mystery)
         {
            return;
         }
         var _loc2_:Number = !!GameSpace.instance.upgradeEconomic1 ? 0 : Number(1);
         this.statusName.text = "[RELAY]";
         this.statusDesc.text = "Long range network relay.";
         this.statusCost.text = "COST: " + String(int(0 * _loc2_));
         this.alignStatus();
      }
      
      private function onMouseOverEnergyStorage(param1:MouseEvent) : void
      {
         if(this.energyStoreButton.mystery)
         {
            return;
         }
         var _loc2_:Number = !!GameSpace.instance.upgradeEconomic1 ? 0 : Number(1);
         this.statusName.text = "[ENERGY STORAGE]";
         this.statusDesc.text = "Fractal energy storage center.";
         this.statusCost.text = "COST: " + String(int(0 * _loc2_));
         this.alignStatus();
      }
      
      private function onMouseOverLogistics(param1:MouseEvent) : void
      {
         if(this.logisticsButton.mystery)
         {
            return;
         }
         var _loc2_:Number = !!GameSpace.instance.upgradeEconomic1 ? 0 : Number(1);
         this.statusName.text = "[PACKET SPEED]";
         this.statusDesc.text = "Packet speed enhancement driver.";
         this.statusCost.text = "COST: " + String(int(0 * _loc2_));
         this.alignStatus();
      }
      
      private function onMouseOverEnergyAmp(param1:MouseEvent) : void
      {
         if(this.energyAmpButton.mystery)
         {
            return;
         }
         var _loc2_:Number = !!GameSpace.instance.upgradeEconomic1 ? 0 : Number(1);
         this.statusName.text = "[SINGULARITY REACTOR]";
         this.statusDesc.text = "Fractal energy producer.";
         this.statusCost.text = "COST: " + String(int(0 * _loc2_));
         this.alignStatus();
      }
      
      public function enableAll(param1:Boolean) : void
      {
         this.nodeButton.enabled = param1;
         this.relayButton.enabled = param1;
         this.energyStoreButton.enabled = param1;
         this.logisticsButton.enabled = param1;
         this.energyAmpButton.enabled = param1;
         this.gunButton.enabled = param1;
         this.areaGunButton.enabled = param1;
         this.abmButton.enabled = param1;
         this.droneBaseButton.enabled = param1;
      }
      
      private function setBuildMode(param1:Button) : void
      {
         GameSpace.instance.controlPanel.cancelButton.visible = true;
         this.buttonHighlight.visible = true;
         this.buttonHighlight.x = param1.x;
         this.buttonHighlight.y = param1.y;
      }
      
      private function onGunButtonClick(param1:MouseEvent) : void
      {
         if(param1 != null)
         {
            param1.stopImmediatePropagation();
         }
         GameSpace.instance.places.removeAllSelections();
         GameSpace.instance.places.placeToMove = null;
         GameSpace.instance.places.placeToAdd = "com.wbwar.creeper::Gun";
         this.setBuildMode(this.gunButton);
      }
      
      private function onAreaGunButtonClick(param1:MouseEvent) : void
      {
         if(param1 != null)
         {
            param1.stopImmediatePropagation();
         }
         GameSpace.instance.places.removeAllSelections();
         GameSpace.instance.places.placeToMove = null;
         GameSpace.instance.places.placeToAdd = "com.wbwar.creeper::AreaGun";
         this.setBuildMode(this.areaGunButton);
      }
      
      private function onAbmButtonClick(param1:MouseEvent) : void
      {
         if(param1 != null)
         {
            param1.stopImmediatePropagation();
         }
         GameSpace.instance.places.removeAllSelections();
         GameSpace.instance.places.placeToMove = null;
         GameSpace.instance.places.placeToAdd = "com.wbwar.creeper::ABM";
         this.setBuildMode(this.abmButton);
      }
      
      private function onDroneBaseButtonClick(param1:MouseEvent) : void
      {
         if(param1 != null)
         {
            param1.stopImmediatePropagation();
         }
         GameSpace.instance.places.removeAllSelections();
         GameSpace.instance.places.placeToMove = null;
         GameSpace.instance.places.placeToAdd = "com.wbwar.creeper::DroneBase";
         this.setBuildMode(this.droneBaseButton);
      }
      
      private function onThorsHammerButtonClick(param1:MouseEvent) : void
      {
         if(param1 != null)
         {
            param1.stopImmediatePropagation();
         }
         GameSpace.instance.places.removeAllSelections();
         GameSpace.instance.places.placeToMove = null;
         GameSpace.instance.places.placeToAdd = "com.wbwar.creeper::ThorsHammer";
         this.setBuildMode(this.thorsHammerButton);
      }
      
      private function onNodeButtonClick(param1:MouseEvent) : void
      {
         if(param1 != null)
         {
            param1.stopImmediatePropagation();
         }
         GameSpace.instance.places.removeAllSelections();
         GameSpace.instance.places.placeToMove = null;
         GameSpace.instance.places.placeToAdd = "com.wbwar.creeper::Node";
         this.setBuildMode(this.nodeButton);
      }
      
      private function onRelayButtonClick(param1:MouseEvent) : void
      {
         if(param1 != null)
         {
            param1.stopImmediatePropagation();
         }
         GameSpace.instance.places.removeAllSelections();
         GameSpace.instance.places.placeToMove = null;
         GameSpace.instance.places.placeToAdd = "com.wbwar.creeper::Relay";
         this.setBuildMode(this.relayButton);
      }
      
      private function onEnergyStoreButtonClick(param1:MouseEvent) : void
      {
         if(param1 != null)
         {
            param1.stopImmediatePropagation();
         }
         GameSpace.instance.places.removeAllSelections();
         GameSpace.instance.places.placeToMove = null;
         GameSpace.instance.places.placeToAdd = "com.wbwar.creeper::EnergyStorage";
         this.setBuildMode(this.energyStoreButton);
      }
      
      private function onLogisticsButtonClick(param1:MouseEvent) : void
      {
         if(param1 != null)
         {
            param1.stopImmediatePropagation();
         }
         GameSpace.instance.places.removeAllSelections();
         GameSpace.instance.places.placeToMove = null;
         GameSpace.instance.places.placeToAdd = "com.wbwar.creeper::Logistics";
         this.setBuildMode(this.logisticsButton);
      }
      
      private function onEnergyAmpButtonClick(param1:MouseEvent) : void
      {
         if(param1 != null)
         {
            param1.stopImmediatePropagation();
         }
         GameSpace.instance.places.removeAllSelections();
         GameSpace.instance.places.placeToMove = null;
         GameSpace.instance.places.placeToAdd = "com.wbwar.creeper::EnergyAmp";
         this.setBuildMode(this.energyAmpButton);
      }
   }
}
