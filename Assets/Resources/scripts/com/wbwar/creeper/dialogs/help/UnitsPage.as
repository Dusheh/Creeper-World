package com.wbwar.creeper.dialogs.help
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class UnitsPage extends Sprite
   {
       
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      private var collectorButton:UnitButton;
      
      private var relayButton:UnitButton;
      
      private var storageButton:UnitButton;
      
      private var speedButton:UnitButton;
      
      private var reactorButton:UnitButton;
      
      private var blasterButton:UnitButton;
      
      private var mortarButton:UnitButton;
      
      private var samButton:UnitButton;
      
      private var droneButton:UnitButton;
      
      private var thorButton:UnitButton;
      
      private var odinCityButton:UnitButton;
      
      private var collectorPage:UnitPage;
      
      private var relayPage:UnitPage;
      
      private var storagePage:UnitPage;
      
      private var speedPage:UnitPage;
      
      private var reactorPage:UnitPage;
      
      private var blasterPage:UnitPage;
      
      private var mortarPage:UnitPage;
      
      private var samPage:UnitPage;
      
      private var dronePage:UnitPage;
      
      private var thorPage:UnitPage;
      
      private var odinCityPage:UnitPage;
      
      public function UnitsPage(param1:int, param2:int)
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         super();
         this.WIDTH = param1;
         this.HEIGHT = param2;
         _loc3_ = 5;
         _loc4_ = 50;
         this.collectorButton = new UnitButton("Node");
         addChild(this.collectorButton);
         this.collectorButton.x = 5;
         this.collectorButton.y = _loc3_;
         _loc3_ += _loc4_;
         this.relayButton = new UnitButton("Relay");
         addChild(this.relayButton);
         this.relayButton.x = 5;
         this.relayButton.y = _loc3_;
         _loc3_ += _loc4_;
         this.storageButton = new UnitButton("EnergyStorage");
         addChild(this.storageButton);
         this.storageButton.x = 5;
         this.storageButton.y = _loc3_;
         _loc3_ += _loc4_;
         this.speedButton = new UnitButton("Logistics");
         addChild(this.speedButton);
         this.speedButton.x = 5;
         this.speedButton.y = _loc3_;
         _loc3_ += _loc4_;
         this.reactorButton = new UnitButton("EnergyAmp");
         addChild(this.reactorButton);
         this.reactorButton.x = 5;
         this.reactorButton.y = _loc3_;
         _loc3_ += _loc4_;
         _loc3_ = 5;
         this.blasterButton = new UnitButton("Gun");
         addChild(this.blasterButton);
         this.blasterButton.x = 55;
         this.blasterButton.y = _loc3_;
         _loc3_ += _loc4_;
         this.mortarButton = new UnitButton("AreaGun");
         addChild(this.mortarButton);
         this.mortarButton.x = 55;
         this.mortarButton.y = _loc3_;
         _loc3_ += _loc4_;
         this.samButton = new UnitButton("ABM");
         addChild(this.samButton);
         this.samButton.x = 55;
         this.samButton.y = _loc3_;
         _loc3_ += _loc4_;
         this.droneButton = new UnitButton("DroneBase");
         addChild(this.droneButton);
         this.droneButton.x = 55;
         this.droneButton.y = _loc3_;
         _loc3_ += _loc4_;
         this.thorButton = new UnitButton("");
         addChild(this.thorButton);
         this.thorButton.x = 55;
         this.thorButton.y = _loc3_;
         _loc3_ += _loc4_;
         this.odinCityButton = new UnitButton("BaseGun");
         addChild(this.odinCityButton);
         this.odinCityButton.x = 5;
         this.odinCityButton.y = _loc3_;
         this.collectorButton.addEventListener(MouseEvent.CLICK,this.onCollector);
         this.relayButton.addEventListener(MouseEvent.CLICK,this.onRelay);
         this.storageButton.addEventListener(MouseEvent.CLICK,this.onStorage);
         this.speedButton.addEventListener(MouseEvent.CLICK,this.onSpeed);
         this.reactorButton.addEventListener(MouseEvent.CLICK,this.onReactor);
         this.blasterButton.addEventListener(MouseEvent.CLICK,this.onBlaster);
         this.mortarButton.addEventListener(MouseEvent.CLICK,this.onMortar);
         this.samButton.addEventListener(MouseEvent.CLICK,this.onSam);
         this.droneButton.addEventListener(MouseEvent.CLICK,this.onDrone);
         this.thorButton.addEventListener(MouseEvent.CLICK,this.onThor);
         this.odinCityButton.addEventListener(MouseEvent.CLICK,this.onOdinCity);
         this.collectorPage = new UnitPage("Node",this.WIDTH - 10 - 110,param2 - 10);
         this.collectorPage.x = 110;
         this.collectorPage.y = 5;
         addChild(this.collectorPage);
         this.relayPage = new UnitPage("Relay",this.WIDTH - 10 - 110,param2 - 10);
         this.relayPage.x = 110;
         this.relayPage.y = 5;
         addChild(this.relayPage);
         this.storagePage = new UnitPage("EnergyStorage",this.WIDTH - 10 - 110,param2 - 10);
         this.storagePage.x = 110;
         this.storagePage.y = 5;
         addChild(this.storagePage);
         this.speedPage = new UnitPage("Logistics",this.WIDTH - 10 - 110,param2 - 10);
         this.speedPage.x = 110;
         this.speedPage.y = 5;
         addChild(this.speedPage);
         this.reactorPage = new UnitPage("EnergyAmp",this.WIDTH - 10 - 110,param2 - 10);
         this.reactorPage.x = 110;
         this.reactorPage.y = 5;
         addChild(this.reactorPage);
         this.blasterPage = new UnitPage("Gun",this.WIDTH - 10 - 110,param2 - 10);
         this.blasterPage.x = 110;
         this.blasterPage.y = 5;
         addChild(this.blasterPage);
         this.mortarPage = new UnitPage("AreaGun",this.WIDTH - 10 - 110,param2 - 10);
         this.mortarPage.x = 110;
         this.mortarPage.y = 5;
         addChild(this.mortarPage);
         this.samPage = new UnitPage("ABM",this.WIDTH - 10 - 110,param2 - 10);
         this.samPage.x = 110;
         this.samPage.y = 5;
         addChild(this.samPage);
         this.dronePage = new UnitPage("DroneBase",this.WIDTH - 10 - 110,param2 - 10);
         this.dronePage.x = 110;
         this.dronePage.y = 5;
         addChild(this.dronePage);
         this.thorPage = new UnitPage("",this.WIDTH - 10 - 110,param2 - 10);
         this.thorPage.x = 110;
         this.thorPage.y = 5;
         addChild(this.thorPage);
         this.odinCityPage = new UnitPage("BaseGun",this.WIDTH - 10 - 110,param2 - 10);
         this.odinCityPage.x = 110;
         this.odinCityPage.y = 5;
         addChild(this.odinCityPage);
         this.showPage(0);
      }
      
      private function showPage(param1:int) : void
      {
         this.collectorButton.active = false;
         this.relayButton.active = false;
         this.storageButton.active = false;
         this.speedButton.active = false;
         this.reactorButton.active = false;
         this.blasterButton.active = false;
         this.mortarButton.active = false;
         this.samButton.active = false;
         this.droneButton.active = false;
         this.thorButton.active = false;
         this.odinCityButton.active = false;
         this.collectorPage.visible = false;
         this.relayPage.visible = false;
         this.storagePage.visible = false;
         this.speedPage.visible = false;
         this.reactorPage.visible = false;
         this.blasterPage.visible = false;
         this.mortarPage.visible = false;
         this.samPage.visible = false;
         this.dronePage.visible = false;
         this.thorPage.visible = false;
         this.odinCityPage.visible = false;
         if(param1 == 0)
         {
            this.collectorPage.visible = true;
            this.collectorButton.active = true;
         }
         else if(param1 == 1)
         {
            this.relayPage.visible = true;
            this.relayButton.active = true;
         }
         else if(param1 == 2)
         {
            this.storagePage.visible = true;
            this.storageButton.active = true;
         }
         else if(param1 == 3)
         {
            this.speedPage.visible = true;
            this.speedButton.active = true;
         }
         else if(param1 == 4)
         {
            this.reactorPage.visible = true;
            this.reactorButton.active = true;
         }
         else if(param1 == 5)
         {
            this.blasterPage.visible = true;
            this.blasterButton.active = true;
         }
         else if(param1 == 6)
         {
            this.mortarPage.visible = true;
            this.mortarButton.active = true;
         }
         else if(param1 == 7)
         {
            this.samPage.visible = true;
            this.samButton.active = true;
         }
         else if(param1 == 8)
         {
            this.dronePage.visible = true;
            this.droneButton.active = true;
         }
         else if(param1 == 9)
         {
            this.thorPage.visible = true;
            this.thorButton.active = true;
         }
         else if(param1 == 10)
         {
            this.odinCityPage.visible = true;
            this.odinCityButton.active = true;
         }
      }
      
      private function onCollector(param1:MouseEvent = null) : void
      {
         this.showPage(0);
      }
      
      private function onRelay(param1:MouseEvent = null) : void
      {
         this.showPage(1);
      }
      
      private function onStorage(param1:MouseEvent = null) : void
      {
         this.showPage(2);
      }
      
      private function onSpeed(param1:MouseEvent = null) : void
      {
         this.showPage(3);
      }
      
      private function onReactor(param1:MouseEvent = null) : void
      {
         this.showPage(4);
      }
      
      private function onBlaster(param1:MouseEvent = null) : void
      {
         this.showPage(5);
      }
      
      private function onMortar(param1:MouseEvent = null) : void
      {
         this.showPage(6);
      }
      
      private function onSam(param1:MouseEvent = null) : void
      {
         this.showPage(7);
      }
      
      private function onDrone(param1:MouseEvent = null) : void
      {
         this.showPage(8);
      }
      
      private function onThor(param1:MouseEvent = null) : void
      {
         this.showPage(9);
      }
      
      private function onOdinCity(param1:MouseEvent = null) : void
      {
         this.showPage(10);
      }
   }
}
