package com.wbwar.creeper
{
   import com.wbwar.creeper.util.Bar;
   import com.wbwar.creeper.util.ColorUtil;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   
   public final class Relay extends Place
   {
      
      public static const EVENT_PLACED:String = "com.wbwar.creeper.Relay.EVENT_PLACED";
      
      private static const ENERGY_CONSUMPTION_RATE:int = 30;
      
      public static const START_RANGE:int = 0;
      
      private static const SHAPERADIUS:int = 7;
      
      public static const EFFECT_RANGE:int = 4;
      
      public static const BASE_COST:int = 100;
      
      private static var bodyImage:Class = Relay_bodyImage;
      
      private static const MIN_RANGE_NODE2:int = 1;
       
      
      public var state:int;
      
      private var bodyShape:DisplayObject;
      
      private var healthBar:Bar;
      
      private var lastHealth:Number = 0;
      
      public function Relay(param1:int, param2:int)
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
         placeBody.filters = [new DropShadowFilter(2)];
         if(false)
         {
            hookUp();
         }
         if(false)
         {
            GameSpace.instance.places.dispatchEvent(new Event(EVENT_PLACED,true));
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
         return <Relay/>;
      }
   }
}
