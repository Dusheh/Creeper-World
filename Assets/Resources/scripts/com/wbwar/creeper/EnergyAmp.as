package com.wbwar.creeper
{
   import com.wbwar.creeper.util.Bar;
   import com.wbwar.creeper.util.ColorUtil;
   import com.wbwar.creeper.util.Graph;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   
   public final class EnergyAmp extends Place
   {
      
      public static const BASE_COST:int = 200;
      
      private static var bodyImage:Class = EnergyAmp_bodyImage;
       
      
      public var state:int;
      
      private var bodyShape:DisplayObject;
      
      private var healthBar:Bar;
      
      private var lastHealth:Number = 0;
      
      private var _powered:Boolean;
      
      public function EnergyAmp(param1:int, param2:int)
      {
         super(param1,param2);
         cacheAsBitmap = true;
         this.healthBar = new Bar(20,3,65280,0);
         addChild(this.healthBar);
         this.healthBar.x = -10;
         this.healthBar.y = 7;
         this.healthBar.setValue(0,20);
         this.healthBar.filters = [new DropShadowFilter(1)];
         this.bodyShape = getBodyShape();
         placeBody.addChild(this.bodyShape);
         placeBody.filters = [new GlowFilter(2097152,1,2,2,3,1),new DropShadowFilter(2)];
         if(false)
         {
            hookUp();
         }
      }
      
      public static function getBodyShape() : DisplayObject
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         _loc1_ = new Sprite();
         _loc1_.mouseEnabled = false;
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(-10,-10,20,20);
         _loc1_.graphics.endFill();
         _loc2_ = new bodyImage() as Bitmap;
         _loc2_.smoothing = true;
         _loc2_.width = 18;
         _loc2_.height = 18;
         _loc2_.x = -9;
         _loc2_.y = -9;
         _loc1_.addChild(_loc2_);
         return _loc1_;
      }
      
      private static function createBodyShape(param1:Sprite) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         param1.graphics.beginFill(16723968);
         param1.graphics.drawCircle(0,0,3);
         param1.graphics.endFill();
         _loc2_ = getEllpise();
         _loc2_.rotation = -45;
         _loc3_ = getEllpise();
         _loc3_.rotation = 45;
         param1.addChild(_loc2_);
         param1.addChild(_loc3_);
      }
      
      private static function getEllpise() : Shape
      {
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.lineStyle(2,7980733);
         _loc3_.graphics.drawEllipse(-8,-3,16,6);
         return _loc3_;
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
      
      public function set powered(param1:Boolean) : void
      {
         this._powered = param1;
      }
      
      public function get powered() : Boolean
      {
         return this._powered;
      }
      
      override public function get maxHealth() : Number
      {
         return BASE_COST;
      }
      
      override public function get operateEnergy() : Number
      {
         return 0;
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
         super.update();
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
         if(updateCount % 30 == 0)
         {
            _loc1_ = Graph.astar(GameSpace.instance.places,this,GameSpace.instance.baseGun);
            if(_loc1_ == null)
            {
               this.powered = false;
            }
            else
            {
               this.powered = true;
            }
         }
         this.calculateDamage();
      }
      
      private function calculateDamage() : void
      {
         var _loc1_:Number = GameSpace.instance.glop.data[gameSpaceX + gameSpaceY * 0];
         if(_loc1_ >= Glop.MIN_HEAT)
         {
            this.destroy();
         }
      }
      
      override protected function getXMLRoot() : XML
      {
         return <EnergyAmp/>;
      }
   }
}
