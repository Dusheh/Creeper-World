package com.wbwar.creeper
{
   import com.wbwar.creeper.util.Bar;
   import com.wbwar.creeper.util.ColorUtil;
   import com.wbwar.creeper.util.Graph;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   
   public final class Units extends Place
   {
       
      
      public var state:int;
      
      private var healthBar:Bar;
      
      private var lastHealth:Number = 0;
      
      private var _powered:Boolean;
      
      public function Units(param1:int, param2:int)
      {
         super(param1,param2);
         cacheAsBitmap = true;
         this.healthBar = new Bar(20,3,65280,0);
         addChild(this.healthBar);
         this.healthBar.x = -10;
         this.healthBar.y = 7;
         this.healthBar.setValue(0,20);
         this.healthBar.filters = [new DropShadowFilter(1)];
         draw(this);
         this.filters = [new DropShadowFilter(2)];
         if(false)
         {
            hookUp();
         }
         ColorUtil.bwColor(this,0);
         addTurnedOffShape();
         addSelectedShape();
      }
      
      private static function draw(param1:Sprite) : void
      {
         param1.graphics.beginFill(11579536,0.5);
         param1.graphics.lineStyle(1,3158064);
         param1.graphics.drawCircle(0,0,14);
         param1.graphics.endFill();
         param1.graphics.beginFill(16732240);
         param1.graphics.lineStyle(1,0);
         param1.graphics.drawRect(-5,-5,10,10);
         param1.graphics.endFill();
      }
      
      public static function getPlacementSprite(param1:Boolean = true) : Sprite
      {
         var _loc2_:* = null;
         _loc2_ = new Sprite();
         draw(_loc2_);
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
         return 200;
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
         return <Units/>;
      }
   }
}
