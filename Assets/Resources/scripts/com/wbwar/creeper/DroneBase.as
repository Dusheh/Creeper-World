package com.wbwar.creeper
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.util.Bar;
   import com.wbwar.creeper.util.ColorUtil;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.media.Sound;
   
   public final class DroneBase extends Place
   {
      
      public static const DRONE_ENERGY_COST:int = 0;
      
      public static const BASE_COST:int = 250;
      
      public static var unitCost:int = 4;
      
      private static var bodyImage:Class = DroneBase_bodyImage;
       
      
      public var state:int;
      
      private var landedDrones:int;
      
      private var bodyShape:DisplayObject;
      
      private var energyBar:Bar;
      
      private var healthBar:Bar;
      
      private var lastEnergyLevel:Number = 0;
      
      private var lastHealth:Number = 0;
      
      public var drones:Array;
      
      private var damageAmt:Number = 0.5;
      
      public function DroneBase(param1:int, param2:int)
      {
         this.drones = [];
         super(param1,param2);
         cacheAsBitmap = true;
         this.energyBar = new Bar(20,3,16711680,0);
         addChild(this.energyBar);
         this.energyBar.x = -10;
         this.energyBar.y = -10;
         this.energyBar.setValue(0,20);
         this.energyBar.filters = [new DropShadowFilter(1)];
         this.healthBar = new Bar(20,3,65280,0);
         addChild(this.healthBar);
         this.healthBar.x = -10;
         this.healthBar.y = 7;
         this.healthBar.setValue(0,20);
         this.healthBar.filters = [new DropShadowFilter(1)];
         this.bodyShape = getBodyShape();
         placeBody.addChild(this.bodyShape);
         this.bodyShape.filters = [new DropShadowFilter(2)];
         if(false)
         {
            addEventListener(MouseEvent.CLICK,this.onMouseClick);
            hookUp();
         }
         this.drones[0] = new Drone(this,0);
         this.drones[0].visible = false;
      }
      
      private static function draw(param1:Sprite) : void
      {
         param1.graphics.beginFill(12619856);
         param1.graphics.drawRect(-20,-10,40,20);
         param1.graphics.endFill();
      }
      
      public static function getBodyShape() : DisplayObject
      {
         var _loc1_:* = null;
         _loc1_ = new Sprite();
         _loc1_.mouseEnabled = false;
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(-10,-10,20,20);
         _loc1_.graphics.endFill();
         var _loc2_:Bitmap = new bodyImage() as Bitmap;
         _loc2_.smoothing = true;
         _loc2_.width = 18;
         _loc2_.height = 18;
         _loc2_.x = -9;
         _loc2_.y = -9;
         _loc1_.addChild(_loc2_);
         return _loc1_;
      }
      
      public static function getPlacementSprite(param1:Boolean = true) : Sprite
      {
         var _loc2_:Sprite = new Sprite();
         _loc2_.addChild(getBodyShape());
         if(param1)
         {
            ColorUtil.bwColor(_loc2_,0);
         }
         _loc2_.mouseEnabled = false;
         return _loc2_;
      }
      
      override public function get maxHealth() : Number
      {
         return BASE_COST;
      }
      
      override public function get operateEnergy() : Number
      {
         return this.landedDrones * DRONE_ENERGY_COST;
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         if(_locked)
         {
            param1.stopImmediatePropagation();
            return;
         }
         if(GameSpace.instance.places.placeToMove == this)
         {
            return;
         }
         var _loc2_:Boolean = selected;
         GameSpace.instance.places.removeAllSelections();
         selected = !_loc2_;
         param1.stopImmediatePropagation();
         if(!building)
         {
            GameSpace.instance.places.placeToMove = this;
         }
      }
      
      override public function move(param1:int, param2:int) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(energyLevel >= DRONE_ENERGY_COST)
         {
            for each(_loc3_ in this.drones)
            {
               if(_loc3_.state == Drone.STATE_LANDED)
               {
                  _loc3_.attack(param1,param2);
                  energyLevel -= DRONE_ENERGY_COST;
                  --this.landedDrones;
                  (_loc4_ = new DroneSound()).play();
                  break;
               }
            }
         }
      }
      
      public function getParkingSpot(param1:int) : Point
      {
         if(param1 == 0)
         {
            return new Point(0,0);
         }
         if(param1 == 1)
         {
            return new Point(-10,-10);
         }
         return new Point(10,10);
      }
      
      override public function fallIntoHole() : void
      {
         var _loc1_:Number = Math.random() * 2;
         Tweener.addTween(this,{
            "time":6,
            "delay":_loc1_,
            "transition":"easeInExpo",
            "x":GameSpace.instance.rift.x,
            "y":GameSpace.instance.rift.y,
            "onComplete":holeComplete
         });
         Tweener.addTween(this.drones[0],{
            "time":6,
            "delay":_loc1_,
            "transition":"easeInExpo",
            "x":GameSpace.instance.rift.x,
            "y":GameSpace.instance.rift.y,
            "onComplete":this.droneInHole
         });
      }
      
      private function droneInHole() : void
      {
         this.drones[0].visible = false;
      }
      
      override protected function buildComplete() : void
      {
         super.buildComplete();
         this.healthBar.visible = false;
      }
      
      override public function destroy(param1:Boolean = false) : void
      {
         var _loc2_:* = null;
         if(destroyed)
         {
            return;
         }
         super.destroy();
         for each(_loc2_ in this.drones)
         {
            _loc2_.destroy();
         }
      }
      
      override public function update() : void
      {
         var _loc1_:* = null;
         super.update();
         if(destroyed)
         {
            return;
         }
         if(energyLevel != this.lastEnergyLevel)
         {
            this.energyBar.setValue(energyLevel,this.operateEnergy);
         }
         this.lastEnergyLevel = energyLevel;
         if(energyLevel >= this.operateEnergy)
         {
            this.energyBar.visible = false;
         }
         else
         {
            this.energyBar.visible = true;
         }
         if(building && health != this.lastHealth)
         {
            this.healthBar.setValue(health,this.maxHealth);
         }
         this.lastHealth = health;
         if(building)
         {
            this.calculateDamage();
            return;
         }
         this.landedDrones = 0;
         for each(_loc1_ in this.drones)
         {
            if(_loc1_.state == Drone.STATE_LANDED)
            {
               ++this.landedDrones;
               if(energyLevel < DRONE_ENERGY_COST)
               {
                  _loc1_.visible = false;
               }
               else
               {
                  _loc1_.visible = true;
               }
            }
         }
         this.calculateDamage();
      }
      
      private function calculateDamage() : Boolean
      {
         var _loc1_:Number = NaN;
         var _loc4_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:int = -1;
         while(_loc3_ <= 1)
         {
            _loc4_ = -1;
            while(_loc4_ <= 1)
            {
               _loc1_ = GameSpace.instance.glop.data[gameSpaceX + _loc4_ + (gameSpaceY + _loc3_) * 0];
               if(_loc1_ >= Glop.MIN_HEAT)
               {
                  _loc2_ = true;
                  health -= this.damageAmt;
                  if(health < 0)
                  {
                     health = 0;
                     this.destroy();
                     return true;
                  }
               }
               _loc4_++;
            }
            _loc3_++;
         }
         if(!_loc2_ && !building)
         {
            health += 0.01;
            if(health > this.maxHealth)
            {
               health = this.maxHealth;
            }
         }
         return _loc2_;
      }
      
      override protected function getXMLRoot() : XML
      {
         return <DroneBase/>;
      }
   }
}
