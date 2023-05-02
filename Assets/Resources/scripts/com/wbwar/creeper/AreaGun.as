package com.wbwar.creeper
{
   import com.wbwar.creeper.util.Bar;
   import com.wbwar.creeper.util.ColorUtil;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   
   public final class AreaGun extends Weapon
   {
      
      private static const STATE_WAITING_TO_FIRE:int = 0;
      
      private static const STATE_FIRING:int = 1;
      
      private static const MORTAR_ENERGY_TAKE:int = 17;
      
      public static var START_RANGE:int = 9;
      
      public static const BASE_COST:int = 250;
      
      public static var unitCost:int = 1;
      
      private static var bodyImage:Class = AreaGun_bodyImage;
       
      
      private var barrel:DisplayObject;
      
      private var fireCounter:int;
      
      private var bodyShape:DisplayObject;
      
      private var energyBar:Bar;
      
      private var healthBar:Bar;
      
      private var lastEnergyLevel:Number = 0;
      
      private var lastHealth:Number = 0;
      
      private var areaGunState:int = 0;
      
      private var mortarFireCounter:int;
      
      private var mortarFirePoint:Point;
      
      private var firedMortars:int;
      
      private var FIRERATEMOD:int;
      
      public function AreaGun(param1:int, param2:int)
      {
         super(param1,param2);
         RANGE = START_RANGE;
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
         addChild(placeBody);
         addChild(armedShape);
         addChild(turnedOffShape);
         addChild(lockedShape);
         this.bodyShape = getBodyShape();
         placeBody.addChild(this.bodyShape);
         this.bodyShape.filters = [new DropShadowFilter(2)];
         if(false)
         {
            places.addPlace(this);
         }
      }
      
      public static function setNormalRange() : void
      {
         START_RANGE = 9;
      }
      
      public static function setUpgradedRange() : void
      {
         START_RANGE = 11;
      }
      
      public static function getPlacementSprite(param1:Boolean = true) : Sprite
      {
         var _loc2_:* = null;
         _loc2_ = new Sprite();
         _loc2_.addChild(getBodyShape());
         if(param1)
         {
            ColorUtil.bwColor(_loc2_,0);
         }
         _loc2_.mouseEnabled = false;
         return _loc2_;
      }
      
      public static function legalLocation(param1:int, param2:int, param3:Place = null) : Boolean
      {
         var _loc4_:* = null;
         if(!legalTerrainLocation(param1,param2))
         {
            return false;
         }
         if(param1 < 0 || param2 < 0 || param1 >= GameSpace.WIDTH || param2 >= GameSpace.HEIGHT)
         {
            return false;
         }
         var _loc5_:int = GameSpace.instance.places.placesLayer.numChildren - 1;
         while(_loc5_ >= 0)
         {
            if(!((_loc4_ = GameSpace.instance.places.placesLayer.getChildAt(_loc5_) as Place) is MovingPlace && (_loc4_ as MovingPlace).state != MovingPlace.STATE_PLACED))
            {
               if(!(param3 != null && param3 == _loc4_))
               {
                  if(Math.abs(_loc4_.gameSpaceX - param1) < 2 && Math.abs(_loc4_.gameSpaceY - param2) < 2)
                  {
                     return false;
                  }
               }
            }
            _loc5_--;
         }
         return true;
      }
      
      public static function getBodyShape() : DisplayObject
      {
         var _loc1_:Sprite = new Sprite();
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
      
      public static function getBarrelShape() : DisplayObject
      {
         return null;
      }
      
      override public function get maxHealth() : Number
      {
         return BASE_COST;
      }
      
      override public function get operateEnergy() : Number
      {
         return MORTAR_ENERGY_TAKE * 3 * 3;
      }
      
      override public function update() : void
      {
         super.update();
         if(RANGE != START_RANGE)
         {
            RANGE = START_RANGE;
         }
         if(GameSpace.instance.upgradeWeapon1)
         {
            this.FIRERATEMOD = 5;
         }
         else
         {
            this.FIRERATEMOD = 0;
         }
         if(state == STATE_PLACED)
         {
            this.healthBar.visible = true;
            this.energyBar.visible = true;
         }
         else
         {
            this.healthBar.visible = false;
            this.energyBar.visible = false;
         }
         if(energyLevel != this.lastEnergyLevel)
         {
            this.energyBar.setValue(energyLevel,this.operateEnergy);
         }
         this.lastEnergyLevel = energyLevel;
         if(health != this.lastHealth)
         {
            this.healthBar.setValue(health,this.maxHealth);
         }
         this.lastHealth = health;
         if(building)
         {
            return;
         }
         if(state == STATE_MOVING)
         {
            ++this.fireCounter;
         }
         if(_turnedOn && _armed && this.areaGunState == STATE_WAITING_TO_FIRE)
         {
            this.checkFireWeapon();
         }
         else if(this.areaGunState == STATE_FIRING)
         {
            this.fireMortar();
         }
      }
      
      private function checkFireWeapon() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(energyLevel < MORTAR_ENERGY_TAKE)
         {
            return;
         }
         if(state != STATE_PLACED)
         {
            return;
         }
         var _loc1_:Point = findDeepestGlop();
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.x - gameSpaceX;
            _loc3_ = _loc1_.y - gameSpaceY;
            _loc4_ = Math.atan2(_loc3_,_loc2_) * 180 / 0;
            if(this.fireCounter < 102 - 28 * level)
            {
               ++this.fireCounter;
               return;
            }
            this.mortarFirePoint = _loc1_;
            this.mortarFireCounter = 999;
            this.firedMortars = 0;
            this.areaGunState = STATE_FIRING;
            this.fireCounter = 0;
         }
      }
      
      private function fireMortar() : void
      {
         if(state != STATE_PLACED)
         {
            this.areaGunState = STATE_WAITING_TO_FIRE;
            return;
         }
         if(this.firedMortars >= 1)
         {
            this.fireCounter = 0;
            this.areaGunState = STATE_WAITING_TO_FIRE;
         }
         if(energyLevel < MORTAR_ENERGY_TAKE)
         {
            return;
         }
         if(this.mortarFireCounter < 35 - this.FIRERATEMOD)
         {
            ++this.mortarFireCounter;
            return;
         }
         var _loc1_:int = this.mortarFirePoint.x;
         var _loc2_:int = this.mortarFirePoint.y;
         if(this.firedMortars >= 1)
         {
            if(_loc1_ > gameSpaceX)
            {
               _loc1_ += int(Math.random() * 5);
            }
            else
            {
               _loc1_ -= int(Math.random() * 5);
            }
            if(_loc2_ > gameSpaceY)
            {
               _loc2_ += int(Math.random() * 5);
            }
            else
            {
               _loc2_ -= int(Math.random() * 5);
            }
         }
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         if(_loc1_ >= GameSpace.WIDTH)
         {
            _loc1_ = -1;
         }
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         if(_loc2_ >= GameSpace.HEIGHT)
         {
            _loc2_ = -1;
         }
         new Mortar(gameSpaceX,gameSpaceY,_loc1_,_loc2_,level);
         ++this.firedMortars;
         energyLevel -= MORTAR_ENERGY_TAKE - level * 5;
         if(energyLevel < 0)
         {
            energyLevel = 0;
         }
         this.mortarFireCounter = 0;
      }
      
      override protected function getXMLRoot() : XML
      {
         return <AreaGun/>;
      }
   }
}
