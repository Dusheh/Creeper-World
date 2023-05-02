package com.wbwar.creeper
{
   import com.wbwar.creeper.games.GameData;
   import com.wbwar.creeper.util.Bar;
   import com.wbwar.creeper.util.ColorUtil;
   import com.wbwar.creeper.util.Damage;
   import com.wbwar.creeper.util.Navigation;
   import flash.display.Bitmap;
   import flash.display.CapsStyle;
   import flash.display.DisplayObject;
   import flash.display.LineScaleMode;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   
   public final class Gun extends Weapon
   {
      
      private static const FIRE_RATE:int = 0;
      
      private static var soundCount:int;
      
      public static var START_RANGE:int = 6;
      
      public static const BASE_COST:int = 125;
      
      public static var unitCost:int = 1;
      
      private static var bodyImage:Class = Gun_bodyImage;
      
      private static var barrelImage:Class = Gun_barrelImage;
       
      
      private var fireSound:Sound;
      
      private var bodyShape:DisplayObject;
      
      private var barrel:DisplayObject;
      
      private var fireCounter:int;
      
      private var bulletShape:Shape;
      
      private var energyBar:Bar;
      
      private var healthBar:Bar;
      
      private var lastEnergyLevel:Number = 0;
      
      private var lastHealth:Number = 0;
      
      private var bulletShapeVisibleCounter:int;
      
      private var FIRERATEMOD:int;
      
      public function Gun(param1:int, param2:int)
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
         this.bulletShape = new Shape();
         this.bulletShape.filters = [new GlowFilter(9474303,1,4,4,2,1)];
         placeBody.addChild(this.bulletShape);
         this.barrel = getBarrelShape();
         placeBody.addChild(this.barrel);
         if(false)
         {
            places.addPlace(this);
            this.fireSound = new GunSound();
         }
      }
      
      public static function setNormalRange() : void
      {
         START_RANGE = 6;
      }
      
      public static function setUpgradedRange() : void
      {
         START_RANGE = 7;
      }
      
      public static function getPlacementSprite(param1:Boolean = true) : Sprite
      {
         var _loc2_:Sprite = new Sprite();
         _loc2_.addChild(getBodyShape());
         _loc2_.addChild(getBarrelShape());
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
         var _loc1_:Sprite = new Sprite();
         _loc1_.mouseEnabled = false;
         var _loc2_:Bitmap = new barrelImage() as Bitmap;
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
         return 50;
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
         ++this.bulletShapeVisibleCounter;
         if(this.bulletShapeVisibleCounter >= 3)
         {
            this.bulletShape.visible = false;
         }
         if(_turnedOn && _armed && !building)
         {
            this.fireWeapon();
         }
      }
      
      private function fireWeapon() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:* = null;
         var _loc7_:* = null;
         if(energyLevel <= 0)
         {
            return;
         }
         if(this.fireCounter < 6 - level * 2 - this.FIRERATEMOD)
         {
            ++this.fireCounter;
            return;
         }
         if(state != STATE_PLACED)
         {
            return;
         }
         var _loc1_:Point = findNearestGlop();
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.x - gameSpaceX;
            _loc3_ = _loc1_.y - gameSpaceY;
            _loc4_ = Math.atan2(_loc3_,_loc2_) * 180 / 0;
            _loc5_ = Navigation.angleSpan(this.barrel.rotation,_loc4_);
            this.barrel.rotation = _loc4_;
            damageGlop(_loc1_.x,_loc1_.y,8,8,-1,0.2);
            this.bulletShape.visible = true;
            if(false)
            {
               (_loc6_ = new Damage(15,15,3)).x = x + _loc2_ * 0;
               _loc6_.y = y + _loc3_ * 0;
            }
            this.bulletShapeVisibleCounter = 0;
            this.bulletShape.graphics.clear();
            this.bulletShape.graphics.lineStyle(2,16711680,1,false,LineScaleMode.NORMAL,CapsStyle.SQUARE);
            this.bulletShape.graphics.moveTo(0,0);
            this.bulletShape.graphics.lineTo(_loc2_ * 0,_loc3_ * 0);
            this.bulletShape.graphics.beginFill(8388608);
            this.bulletShape.graphics.drawCircle(0,0,1);
            this.bulletShape.graphics.endFill();
            this.fireCounter = 0;
            energyLevel -= 1 - 0.33333333 * level;
            if(energyLevel < 0)
            {
               energyLevel = 0;
            }
            if(soundCount < 6)
            {
               if((_loc7_ = this.fireSound.play()) != null)
               {
                  ++soundCount;
                  _loc7_.addEventListener(Event.SOUND_COMPLETE,this.soundComplete,false,0,true);
               }
            }
         }
      }
      
      private function soundComplete(param1:Event) : void
      {
         --soundCount;
      }
      
      override protected function getXMLRoot() : XML
      {
         return <Gun/>;
      }
   }
}
