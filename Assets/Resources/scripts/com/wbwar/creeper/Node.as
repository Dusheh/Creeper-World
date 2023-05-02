package com.wbwar.creeper
{
   import com.wbwar.creeper.util.Bar;
   import com.wbwar.creeper.util.ColorUtil;
   import com.wbwar.creeper.util.Graph;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   
   public final class Node extends Place
   {
      
      public static const EVENT_PLACED:String = "com.wbwar.creeper.Node.EVENT_PLACED";
      
      public static const STATE_UNDEPLOYED:int = 0;
      
      public static const STATE_DEPLOYED:int = 1;
      
      public static const STATE_DEPLOYING:int = 2;
      
      private static const SHAPERADIUS:int = 6;
      
      public static const START_RANGE:int = 4;
      
      private static var offlineSound:Sound;
      
      private static var soundCount:int;
      
      public static const BASE_COST:int = 50;
      
      private static var bodyImage:Class = Node_bodyImage;
       
      
      private var bodyShape:DisplayObject;
      
      public var state:int;
      
      private var energyGridDeployer:EnergyGridDeployer;
      
      private var healthBar:Bar;
      
      private var lastHealth:Number = 0;
      
      private var onlineSound:Sound;
      
      private var onShape:Shape;
      
      private var rotDir:Number;
      
      public function Node(param1:int, param2:int)
      {
         this.rotDir = Math.random() < 0.5 ? -3 : Number(3);
         super(param1,param2);
         RANGE = START_RANGE;
         this.energyGridDeployer = new EnergyGridDeployer(RANGE,this);
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
         addChild(placeBody);
         addChild(turnedOffShape);
         if(false)
         {
            hookUp();
            this.onlineSound = new NodeOnSound();
            offlineSound = new NodeOffSound();
         }
         if(false)
         {
            GameSpace.instance.places.dispatchEvent(new Event(EVENT_PLACED,true));
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
         this.state = STATE_UNDEPLOYED;
         this.energyGridDeployer.undeployEnergyGrid();
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
            if(turnedOn)
            {
               _loc1_ = Graph.astar(GameSpace.instance.places,this,GameSpace.instance.baseGun);
               if(_loc1_ == null)
               {
                  if(this.state == STATE_DEPLOYED)
                  {
                     this.state = STATE_UNDEPLOYED;
                     this.playSound("offline");
                     this.energyGridDeployer.undeployEnergyGrid();
                  }
               }
               else if(this.state == STATE_UNDEPLOYED)
               {
                  this.state = STATE_DEPLOYED;
                  this.playSound("online");
                  this.energyGridDeployer.deployEnergyGrid();
               }
            }
            else if(this.state == STATE_DEPLOYED)
            {
               this.state = STATE_UNDEPLOYED;
               this.playSound("offline");
               this.energyGridDeployer.undeployEnergyGrid();
            }
         }
         this.calculateDamage();
      }
      
      private function playSound(param1:String) : void
      {
         var _loc2_:* = null;
         if(soundCount < 2)
         {
            if(param1 == "online")
            {
               _loc2_ = this.onlineSound.play();
            }
            else if(param1 == "offline")
            {
               _loc2_ = offlineSound.play();
            }
            if(_loc2_ != null)
            {
               ++soundCount;
               _loc2_.addEventListener(Event.SOUND_COMPLETE,this.soundComplete,false,0,true);
            }
         }
      }
      
      private function soundComplete(param1:Event) : void
      {
         --soundCount;
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
         return <Node/>;
      }
   }
}
