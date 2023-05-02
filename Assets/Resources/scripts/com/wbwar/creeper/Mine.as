package com.wbwar.creeper
{
   import com.wbwar.creeper.util.Bar;
   import com.wbwar.creeper.util.ColorUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import flash.media.Sound;
   
   public final class Mine extends Place
   {
      
      public static const EVENT_PLACED:String = "com.wbwar.creeper.Mine.EVENT_PLACED";
      
      public static const BASE_COST:int = 10;
       
      
      protected var damageAmt:Number = 0.5;
      
      public var state:int;
      
      private var healthBar:Bar;
      
      private var lastHealth:Number = 0;
      
      private var bodyShape:DisplayObject;
      
      private var explosionSound:Sound;
      
      public function Mine(param1:int, param2:int)
      {
         super(param1,param2);
         this.healthBar = new Bar(6,1,65280,0);
         addChild(this.healthBar);
         this.healthBar.x = -3;
         this.healthBar.y = 5;
         this.healthBar.setValue(0,20);
         this.healthBar.filters = [new DropShadowFilter(1)];
         this.bodyShape = getBodyShape();
         placeBody.addChild(this.bodyShape);
         this.bodyShape.filters = [new DropShadowFilter(2)];
         if(false)
         {
            hookUp();
         }
         if(false)
         {
            GameSpace.instance.places.dispatchEvent(new Event(EVENT_PLACED,true));
         }
         this.explosionSound = new AreaGunExplosionSound();
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
      
      public static function getBodyShape() : DisplayObject
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         _loc1_ = new Sprite();
         _loc1_.mouseEnabled = false;
         _loc2_ = new MineBody();
         _loc2_.mouseEnabled = false;
         _loc1_.addChild(_loc2_);
         return _loc1_;
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
      }
      
      override public function destroy(param1:Boolean = false) : void
      {
         if(selected)
         {
            GameSpace.instance.controlPanel.onCancelButtonClick();
         }
         super.destroy();
         Weapon.damageGlop(gameSpaceX,gameSpaceY,48,15,-4,1);
         this.explosionSound.play();
         this.fireMortar(false);
         this.fireMortar(true);
         this.fireMortar(true);
         this.fireMortar(true);
         this.fireMortar(true);
      }
      
      private function fireMortar(param1:Boolean) : void
      {
         var _loc2_:int = -1;
         var _loc3_:int = -1;
         while(_loc2_ < 0 || _loc2_ >= GameSpace.WIDTH || _loc2_ == gameSpaceX)
         {
            _loc2_ = gameSpaceX + Math.random() * 20 - 10;
         }
         while(_loc3_ < 0 || _loc3_ >= GameSpace.HEIGHT || _loc3_ == gameSpaceY)
         {
            _loc3_ = gameSpaceY + Math.random() * 20 - 10;
         }
         new Mortar(gameSpaceX,gameSpaceY,_loc2_,_loc3_,0,param1);
      }
      
      override public function update() : void
      {
         super.update();
         if(health != this.lastHealth)
         {
            this.healthBar.setValue(health,this.maxHealth);
         }
         this.lastHealth = health;
         this.calculateDamage();
      }
      
      private function calculateDamage() : Boolean
      {
         var _loc1_:Number = NaN;
         var _loc2_:Boolean = false;
         _loc1_ = GameSpace.instance.glop.data[gameSpaceX + gameSpaceY * 0];
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
         return <Mine/>;
      }
   }
}
