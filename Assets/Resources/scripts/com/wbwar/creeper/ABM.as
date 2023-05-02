package com.wbwar.creeper
{
   import com.wbwar.creeper.util.Bar;
   import com.wbwar.creeper.util.ColorUtil;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   
   public class ABM extends Weapon
   {
      
      private static const FIRE_TIME:int = 36;
      
      private static const MISSILE_ENERGY_TAKE:int = 20;
      
      public static var START_RANGE:int = 9;
      
      public static const BASE_COST:int = 100;
      
      public static var unitCost:int = 1;
      
      private static var bodyImage:Class = ABM_bodyImage;
      
      private static var barrelImage:Class = ABM_barrelImage;
      
      private static var barrelTopImage:Class = ABM_barrelTopImage;
       
      
      private var bodyShape:DisplayObject;
      
      private var barrelShape:DisplayObject;
      
      private var barrelTopShape:DisplayObject;
      
      private var fireCounter:int;
      
      private var energyBar:Bar;
      
      private var healthBar:Bar;
      
      private var lastEnergyLevel:Number = 0;
      
      private var lastHealth:Number = 0;
      
      private var FIRERATEMOD:int;
      
      public function ABM(param1:int, param2:int)
      {
         super(param1,param2);
         damageAmt = 0.5;
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
         this.barrelShape = getBarrelShape();
         placeBody.addChild(this.barrelShape);
         this.barrelTopShape = getBarrelTopShape();
         placeBody.addChild(this.barrelTopShape);
         this.barrelTopShape.visible = false;
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
         _loc2_.addChild(getBarrelShape());
         _loc2_.addChild(getBarrelTopShape());
         if(param1)
         {
            ColorUtil.bwColor(_loc2_,0);
         }
         _loc2_.mouseEnabled = false;
         return _loc2_;
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
         var _loc1_:Sprite = new Sprite();
         _loc1_.mouseEnabled = false;
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(-10,-10,20,20);
         _loc1_.graphics.endFill();
         var _loc2_:Bitmap = new barrelImage() as Bitmap;
         _loc2_.smoothing = true;
         _loc2_.width = 18;
         _loc2_.height = 18;
         _loc2_.x = -9;
         _loc2_.y = -9;
         _loc1_.addChild(_loc2_);
         return _loc1_;
      }
      
      public static function getBarrelTopShape() : DisplayObject
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         _loc1_ = new Sprite();
         _loc1_.mouseEnabled = false;
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(-10,-10,20,20);
         _loc1_.graphics.endFill();
         _loc2_ = new barrelTopImage() as Bitmap;
         _loc2_.smoothing = true;
         _loc2_.width = 18;
         _loc2_.height = 18;
         _loc2_.x = -9;
         _loc2_.y = -9;
         _loc1_.addChild(_loc2_);
         return _loc1_;
      }
      
      override public function get maxHealth() : Number
      {
         return BASE_COST;
      }
      
      override public function get operateEnergy() : Number
      {
         return MISSILE_ENERGY_TAKE * 2;
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
            this.FIRERATEMOD = 1;
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
         if(energyLevel >= MISSILE_ENERGY_TAKE)
         {
            this.barrelTopShape.visible = true;
         }
         else
         {
            this.barrelTopShape.visible = false;
         }
         if(_turnedOn && _armed && this.fireCounter == 0 && updateCount % 4 == 0 && energyLevel >= MISSILE_ENERGY_TAKE && state == STATE_PLACED)
         {
            this.fire();
         }
         else if(this.fireCounter > 0)
         {
            --this.fireCounter;
         }
      }
      
      private function fire() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:int = GameSpace.instance.projectiles.numChildren - 1;
         while(_loc5_ >= 0)
         {
            if((_loc4_ = GameSpace.instance.projectiles.getChildAt(_loc5_) as Projectile) is GlopBlob)
            {
               _loc2_ = _loc4_.x - x;
               _loc3_ = _loc4_.y - y;
               _loc1_ = _loc2_ * _loc2_ + _loc3_ * _loc3_;
               if(_loc1_ <= RANGE * 0 * RANGE * 0)
               {
                  this.fireCounter = FIRE_TIME - this.FIRERATEMOD;
                  energyLevel -= MISSILE_ENERGY_TAKE;
                  new Missile(x,y);
                  _loc2_ = _loc4_.x - x;
                  _loc3_ = _loc4_.y - y;
                  this.barrelShape.rotation = Math.atan2(_loc3_,_loc2_) * 180 / 0;
                  this.barrelTopShape.rotation = this.barrelShape.rotation;
                  break;
               }
            }
            _loc5_--;
         }
      }
      
      override protected function getXMLRoot() : XML
      {
         return <ABM/>;
      }
   }
}
