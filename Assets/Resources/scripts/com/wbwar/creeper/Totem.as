package com.wbwar.creeper
{
   import com.wbwar.creeper.util.Bar;
   import com.wbwar.creeper.util.ColorUtil;
   import com.wbwar.creeper.util.Graph;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.GradientType;
   import flash.display.InterpolationMethod;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.SpreadMethod;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   
   public final class Totem extends Place
   {
      
      private static var bodyImage:Class = Totem_bodyImage;
      
      private static var bodyTopImage:Class = Totem_bodyTopImage;
      
      private static const MIN_RANGE_NODE2:int = 1;
       
      
      private var done:Boolean;
      
      private var activated:Boolean;
      
      private var energyBar:Bar;
      
      private var lastEnergyLevel:Number = 0;
      
      private var healthBar:Bar;
      
      private var lastHealth:Number = 0;
      
      private var playing:Boolean;
      
      private var bodyShape:DisplayObject;
      
      private var bodyTopShape:DisplayObject;
      
      public var infected:Boolean = false;
      
      public var infectedLaunchTime:int;
      
      public var infectedBlobStrength:Number = 0.5;
      
      public var infectedBlobDuration:int = 1;
      
      private var infectedLaunchCounter:int;
      
      private var _powered:Boolean;
      
      private var activatedShape:Shape;
      
      private var bodyRotate:Boolean;
      
      public function Totem(param1:int, param2:int)
      {
         this.infectedLaunchTime = 3000 + Math.random() * 500;
         this.infectedLaunchCounter = this.infectedLaunchTime;
         super(param1,param2);
         this.energyBar = new Bar(20,3,65280,0);
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
         this.healthBar.visible = false;
         this.bodyShape = getBodyShape();
         this.bodyTopShape = getBodyTopShape();
         addChild(this.bodyShape);
         addChild(this.bodyTopShape);
         this.filters = [new DropShadowFilter(2)];
         this.activatedShape = ColorUtil.star(5,10,16,65280);
         var _loc4_:Matrix;
         (_loc4_ = new Matrix()).createGradientBox(20,20,0,-10,-10);
         this.activatedShape.graphics.beginGradientFill(GradientType.RADIAL,[9502608,10526880],[1,0],[64,225],_loc4_,SpreadMethod.PAD,InterpolationMethod.RGB,0);
         this.activatedShape.graphics.drawCircle(0,0,10);
         this.activatedShape.graphics.endFill();
         this.activatedShape.filters = [new GlowFilter(5308160,1,8,8,2,1)];
         this.activatedShape.visible = false;
         addChild(this.activatedShape);
         if(false)
         {
            hookUp();
         }
         if(false)
         {
            GameSpace.instance.rift.addTotem(this);
         }
      }
      
      public static function getBodyShape() : DisplayObject
      {
         var _loc2_:* = null;
         var _loc1_:Sprite = new Sprite();
         _loc1_.mouseEnabled = false;
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(-10,-10,20,20);
         _loc1_.graphics.endFill();
         _loc2_ = new bodyImage() as Bitmap;
         _loc2_.smoothing = true;
         _loc2_.width = 16;
         _loc2_.height = 16;
         _loc2_.x = -8;
         _loc2_.y = -8;
         _loc1_.addChild(_loc2_);
         return _loc1_;
      }
      
      public static function getBodyTopShape() : DisplayObject
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.mouseEnabled = false;
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(-10,-10,20,20);
         _loc1_.graphics.endFill();
         var _loc2_:Bitmap = new bodyTopImage() as Bitmap;
         _loc2_.smoothing = true;
         _loc2_.width = 16;
         _loc2_.height = 16;
         _loc2_.x = -8;
         _loc2_.y = -8;
         _loc1_.addChild(_loc2_);
         return _loc1_;
      }
      
      private static function draw(param1:Sprite) : void
      {
         param1.graphics.beginFill(16777215);
         param1.graphics.lineStyle(1,0);
         param1.graphics.drawRect(-5,-5,10,10);
         param1.graphics.endFill();
      }
      
      public static function getPlacementSprite(param1:Boolean = true) : MovieClip
      {
         return new TotemBody();
      }
      
      public static function legalLocation(param1:int, param2:int, param3:Place = null) : Boolean
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(!legalTerrainLocation(param1,param2))
         {
            return false;
         }
         if(param1 < 0 || param2 < 0 || param1 >= GameSpace.WIDTH || param2 >= GameSpace.HEIGHT)
         {
            return false;
         }
         var _loc8_:int = GameSpace.instance.places.placesLayer.numChildren - 1;
         while(_loc8_ >= 0)
         {
            if(!((_loc4_ = GameSpace.instance.places.placesLayer.getChildAt(_loc8_) as Place) is MovingPlace && (_loc4_ as MovingPlace).state != MovingPlace.STATE_PLACED))
            {
               if(!(param3 != null && param3 == _loc4_))
               {
                  _loc5_ = _loc4_.gameSpaceX - param1;
                  _loc6_ = _loc4_.gameSpaceY - param2;
                  if((_loc7_ = _loc5_ * _loc5_ + _loc6_ * _loc6_) <= MIN_RANGE_NODE2)
                  {
                     return false;
                  }
               }
            }
            _loc8_--;
         }
         return true;
      }
      
      public function set powered(param1:Boolean) : void
      {
         this._powered = param1;
      }
      
      public function get powered() : Boolean
      {
         return this._powered;
      }
      
      override public function get operateEnergyType() : int
      {
         return EnergyPacket.TYPE_OPERATEENERGY;
      }
      
      override public function get maxHealth() : Number
      {
         return 0;
      }
      
      override public function get operateEnergy() : Number
      {
         return 50;
      }
      
      public function setActivated(param1:Boolean) : void
      {
         this.activated = param1;
         this.activatedShape.visible = param1;
         if(param1)
         {
            this.energyBar.visible = false;
         }
      }
      
      public function setDone() : void
      {
         this.done = true;
         ColorUtil.bwColor(this.bodyTopShape,1);
         this.bodyRotate = false;
      }
      
      override protected function buildComplete() : void
      {
         super.buildComplete();
         this.healthBar.visible = false;
      }
      
      override public function destroy(param1:Boolean = false) : void
      {
         super.destroy();
      }
      
      override public function update() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:* = null;
         if(this.done)
         {
            return;
         }
         super.update();
         if(this.infected)
         {
            if(this.infectedLaunchCounter > 0)
            {
               --this.infectedLaunchCounter;
            }
            else
            {
               _loc1_ = [];
               _loc3_ = GameSpace.instance.places.placesLayer.numChildren - 1;
               while(_loc3_ >= 0)
               {
                  _loc2_ = GameSpace.instance.places.placesLayer.getChildAt(_loc3_) as Place;
                  if(_loc2_ is Node || _loc2_ is Relay)
                  {
                     _loc1_.push(_loc2_);
                  }
                  _loc3_--;
               }
               if(_loc1_.length > 0)
               {
                  _loc4_ = int(Math.random() * _loc1_.length);
                  _loc5_ = _loc1_[_loc4_] as Place;
                  new GlopBlob(gameSpaceX,gameSpaceY,int(_loc5_.gameSpaceX + Math.random() * 4 - 2),int(_loc5_.gameSpaceY + Math.random() * 4 - 2),this.infectedBlobStrength,this.infectedBlobDuration);
                  this.infectedLaunchCounter = this.infectedLaunchTime;
               }
            }
         }
         if(energyLevel >= this.operateEnergy && !this.playing)
         {
            this.bodyRotate = true;
            this.infected = false;
            this.playing = true;
         }
         if(this.activated)
         {
            this.activatedShape.rotation -= 5;
         }
         if(building && health != this.lastHealth)
         {
            this.healthBar.setValue(health,this.maxHealth);
         }
         this.lastHealth = health;
         if(energyLevel != this.lastEnergyLevel)
         {
            this.energyBar.setValue(energyLevel,this.operateEnergy);
         }
         this.lastEnergyLevel = energyLevel;
         if(building)
         {
            return;
         }
         if(updateCount % 30 == 0 && !this.activated)
         {
            if((_loc6_ = Graph.astar(GameSpace.instance.places,this,GameSpace.instance.baseGun)) == null)
            {
               requestEnergy = false;
               this.powered = false;
               this.energyBar.visible = false;
               if(this.playing)
               {
                  this.bodyRotate = false;
                  this.playing = false;
               }
               energyLevel = 0;
            }
            else
            {
               requestEnergy = true;
               this.powered = true;
               this.energyBar.visible = true;
            }
         }
         if(this.bodyRotate)
         {
            this.bodyTopShape.rotation += 3;
         }
      }
      
      override protected function getXMLRoot() : XML
      {
         return <Totem/>;
      }
   }
}
