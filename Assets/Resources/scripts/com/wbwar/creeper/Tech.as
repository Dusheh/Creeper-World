package com.wbwar.creeper
{
   import com.wbwar.creeper.util.ColorUtil;
   import com.wbwar.creeper.util.Graph;
   import com.wbwar.creeper.util.MessageDialog;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   
   public final class Tech extends Place
   {
      
      public static const EVENT_TECH_APPLIED:String = "techApplied";
      
      public static const TECH_NODE:int = 0;
      
      public static const TECH_RELAY:int = 1;
      
      public static const TECH_ENERGYSTORAGE:int = 2;
      
      public static const TECH_LOGISTICS:int = 3;
      
      public static const TECH_ENERGYAMP:int = 4;
      
      public static const TECH_GUN:int = 5;
      
      public static const TECH_AREAGUN:int = 6;
      
      public static const TECH_ABM:int = 7;
      
      public static const TECH_DRONEBASE:int = 8;
      
      public static const TECH_THOR:int = 9;
      
      private static const STATE_WAITING:int = 0;
      
      private static const STATE_APPLYING:int = 1;
      
      private static const STATE_REMOVE:int = 2;
       
      
      private var ascaleRate:Number = 0.05;
      
      private var state:int;
      
      private var pulseTimer:int;
      
      private var techSprite:Sprite;
      
      private var techShape:Shape;
      
      public var techType:int;
      
      public var md:MessageDialog;
      
      public function Tech(param1:Number, param2:Number, param3:int)
      {
         var _loc4_:* = null;
         super(param1,param2);
         this.techType = param3;
         this.techSprite = new Sprite();
         addChild(this.techSprite);
         this.techShape = ColorUtil.star(8,12,12,9474192);
         this.techShape.filters = [new GlowFilter(65280,1,8,8,3),new DropShadowFilter(2)];
         this.techSprite.addChild(this.techShape);
         if(param3 == TECH_NODE)
         {
            (_loc4_ = Node.getPlacementSprite(false)).scaleX = 0.7;
            _loc4_.scaleY = _loc4_.scaleX;
         }
         if(param3 == TECH_RELAY)
         {
            (_loc4_ = Relay.getPlacementSprite(false)).scaleX = 0.7;
            _loc4_.scaleY = _loc4_.scaleX;
         }
         else if(param3 == TECH_ENERGYSTORAGE)
         {
            (_loc4_ = EnergyStorage.getPlacementSprite(false)).scaleX = 0.7;
            _loc4_.scaleY = _loc4_.scaleX;
         }
         else if(param3 == TECH_LOGISTICS)
         {
            (_loc4_ = Logistics.getPlacementSprite(false)).scaleX = 0.7;
            _loc4_.scaleY = _loc4_.scaleX;
         }
         else if(param3 == TECH_ENERGYAMP)
         {
            (_loc4_ = EnergyAmp.getPlacementSprite(false)).scaleX = 0.7;
            _loc4_.scaleY = _loc4_.scaleX;
         }
         else if(param3 == TECH_GUN)
         {
            (_loc4_ = Gun.getPlacementSprite(false)).scaleX = 0.7;
            _loc4_.scaleY = _loc4_.scaleX;
         }
         else if(param3 == TECH_AREAGUN)
         {
            (_loc4_ = AreaGun.getPlacementSprite(false)).scaleX = 0.7;
            _loc4_.scaleY = _loc4_.scaleX;
         }
         else if(param3 == TECH_ABM)
         {
            (_loc4_ = ABM.getPlacementSprite(false)).scaleX = 0.7;
            _loc4_.scaleY = _loc4_.scaleX;
         }
         else if(param3 == TECH_DRONEBASE)
         {
            (_loc4_ = DroneBase.getPlacementSprite(false)).scaleX = 0.7;
            _loc4_.scaleY = _loc4_.scaleX;
         }
         else if(param3 == TECH_THOR)
         {
            (_loc4_ = ThorsHammer.getPlacementSprite(false)).scaleX = 0.4;
            _loc4_.scaleY = _loc4_.scaleX;
         }
         if(_loc4_ != null)
         {
            _loc4_.filters = [new DropShadowFilter(2)];
            this.techSprite.addChild(_loc4_);
         }
         GameSpace.instance.places.addPlace(this);
      }
      
      override public function update() : void
      {
         var _loc1_:* = null;
         this.techShape.rotation -= 3;
         if(this.state == STATE_WAITING)
         {
            if(updateCount % 30 == 0)
            {
               _loc1_ = Graph.astar(GameSpace.instance.places,this,GameSpace.instance.baseGun);
               if(_loc1_ != null)
               {
                  this.applyTech();
               }
            }
         }
         else if(this.state == STATE_APPLYING)
         {
            ++this.pulseTimer;
            this.techSprite.scaleX += this.ascaleRate;
            this.techSprite.scaleY = this.techSprite.scaleX;
            if(this.techSprite.scaleX > 1.5 || this.techSprite.scaleX <= 1)
            {
               this.ascaleRate = -this.ascaleRate;
            }
            if(this.pulseTimer > 50)
            {
               this.state = STATE_REMOVE;
            }
         }
         else if(this.state == STATE_REMOVE)
         {
            destroy(true);
         }
      }
      
      private function applyTech() : void
      {
         this.state = STATE_APPLYING;
         if(this.techType == TECH_NODE)
         {
            GameSpace.instance.controlPanel.buildMenu.nodeButton.mystery = false;
            this.md = new MessageDialog(MessageDialog.SIDE_RIGHT,40,360,-1,true,true);
            this.md.textField.text = "---COLLECTOR TECH NOW AVAILABLE---";
            this.md.show();
            this.md.addEventListener(MessageDialog.OK_CLICK,function():void
            {
               md.remove();
            },false,0,true);
         }
         else if(this.techType == TECH_RELAY)
         {
            GameSpace.instance.controlPanel.buildMenu.relayButton.mystery = false;
            this.md = new MessageDialog(MessageDialog.SIDE_RIGHT,40,360,-1,true,true);
            this.md.textField.text = "---RELAY TECH NOW AVAILABLE---";
            this.md.show();
            this.md.addEventListener(MessageDialog.OK_CLICK,function():void
            {
               md.remove();
            },false,0,true);
         }
         else if(this.techType == TECH_ENERGYSTORAGE)
         {
            GameSpace.instance.controlPanel.buildMenu.energyStoreButton.mystery = false;
            this.md = new MessageDialog(MessageDialog.SIDE_RIGHT,40,360,-1,true,true);
            this.md.textField.text = "---ENERGY STORAGE TECH NOW AVAILABLE---";
            this.md.show();
            this.md.addEventListener(MessageDialog.OK_CLICK,function():void
            {
               md.remove();
            },false,0,true);
         }
         else if(this.techType == TECH_LOGISTICS)
         {
            GameSpace.instance.controlPanel.buildMenu.logisticsButton.mystery = false;
            this.md = new MessageDialog(MessageDialog.SIDE_RIGHT,40,360,-1,true,true);
            this.md.textField.text = "---PACKET SPEED TECH NOW AVAILABLE---";
            this.md.show();
            this.md.addEventListener(MessageDialog.OK_CLICK,function():void
            {
               md.remove();
            },false,0,true);
         }
         else if(this.techType == TECH_ENERGYAMP)
         {
            GameSpace.instance.controlPanel.buildMenu.energyAmpButton.mystery = false;
            this.md = new MessageDialog(MessageDialog.SIDE_RIGHT,40,360,-1,true,true);
            this.md.textField.text = "---REACTOR TECH NOW AVAILABLE---";
            this.md.show();
            this.md.addEventListener(MessageDialog.OK_CLICK,function():void
            {
               md.remove();
            },false,0,true);
         }
         else if(this.techType == TECH_GUN)
         {
            GameSpace.instance.controlPanel.buildMenu.gunButton.mystery = false;
            this.md = new MessageDialog(MessageDialog.SIDE_RIGHT,40,360,-1,true,true);
            this.md.textField.text = "---BLASTER TECH NOW AVAILABLE---";
            this.md.show();
            this.md.addEventListener(MessageDialog.OK_CLICK,function():void
            {
               md.remove();
            },false,0,true);
         }
         else if(this.techType == TECH_AREAGUN)
         {
            GameSpace.instance.controlPanel.buildMenu.areaGunButton.mystery = false;
            this.md = new MessageDialog(MessageDialog.SIDE_RIGHT,40,360,-1,true,true);
            this.md.textField.text = "---MORTAR TECH NOW AVAILABLE---";
            this.md.show();
            this.md.addEventListener(MessageDialog.OK_CLICK,function():void
            {
               md.remove();
            },false,0,true);
         }
         else if(this.techType == TECH_ABM)
         {
            GameSpace.instance.controlPanel.buildMenu.abmButton.mystery = false;
            this.md = new MessageDialog(MessageDialog.SIDE_RIGHT,40,360,-1,true,true);
            this.md.textField.text = "---SAM TECH NOW AVAILABLE---";
            this.md.show();
            this.md.addEventListener(MessageDialog.OK_CLICK,function():void
            {
               md.remove();
            },false,0,true);
         }
         else if(this.techType == TECH_DRONEBASE)
         {
            GameSpace.instance.controlPanel.buildMenu.droneBaseButton.mystery = false;
            this.md = new MessageDialog(MessageDialog.SIDE_RIGHT,40,360,-1,true,true);
            this.md.textField.text = "---DRONE TECH NOW AVAILABLE---";
            this.md.show();
            this.md.addEventListener(MessageDialog.OK_CLICK,function():void
            {
               md.remove();
            },false,0,true);
         }
         else if(this.techType == TECH_THOR)
         {
            GameSpace.instance.controlPanel.buildMenu.thorsHammerButton.mystery = false;
            if(GameSpace.instance.customGame)
            {
               this.md = new MessageDialog(MessageDialog.SIDE_RIGHT,40,360,-1,true,true);
               this.md.textField.text = "---THOR TECH NOW AVAILABLE---";
               this.md.show();
               this.md.addEventListener(MessageDialog.OK_CLICK,function():void
               {
                  md.remove();
               },false,0,true);
            }
            else
            {
               GameSpace.instance.paused = true;
               if(this.md != null)
               {
                  this.md.show();
               }
            }
         }
         dispatchEvent(new Event(EVENT_TECH_APPLIED));
      }
   }
}
