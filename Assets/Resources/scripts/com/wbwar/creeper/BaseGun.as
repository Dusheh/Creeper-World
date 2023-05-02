package com.wbwar.creeper
{
   import com.wbwar.creeper.util.ArcBar;
   import com.wbwar.creeper.util.ColorUtil;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.GradientType;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.geom.Matrix;
   import flash.media.Sound;
   
   public final class BaseGun extends MovingPlace
   {
      
      public static const PLACE_RANGE:int = 7;
      
      public static const ENERGYPACKET_RECHARGE:int = 0;
      
      private static var bodyImage:Class = BaseGun_bodyImage;
       
      
      private var energyPacketCounter:int = 0;
      
      private var bodyShape:DisplayObject;
      
      private var energyGridDeployer:EnergyGridDeployer;
      
      private var healthBar:ArcBar;
      
      private var _allowConstructionPackets:Boolean = true;
      
      private var _allowWeaponEnergyPackets:Boolean = true;
      
      private var _allowOperateEnergyPackets:Boolean = true;
      
      private var packetControlConstructionPacket:PacketControl;
      
      private var packetControlWeaponEnergyPacket:PacketControl;
      
      private var packetControlOperateEnergyPacket:PacketControl;
      
      private var placeQueueLoc:int;
      
      private var soundCounter:int;
      
      private var endCounter:int;
      
      public function BaseGun(param1:int, param2:int)
      {
         super(param1,param2);
         canMove = false;
         RANGE = PLACE_RANGE;
         this.bodyShape = getBodyShape();
         this.bodyShape.filters = [new DropShadowFilter(2)];
         placeBody.addChild(this.bodyShape);
         ColorUtil.normalColor(placeBody,0.2);
         if(false)
         {
            GameSpace.instance.places.addPlace(this);
            hookUp();
         }
         building = false;
         if(movePlaceIndicator != null)
         {
            movePlaceIndicator.graphics.clear();
            movePlaceIndicator.graphics.lineStyle(2,32768);
            movePlaceIndicator.graphics.drawRect(-30,-30,60,60);
         }
         this.healthBar = new ArcBar(8,-360,-90,3,2134048,11534336);
         addChild(this.healthBar);
         this.healthBar.y = -8;
         this.healthBar.setValue(this.maxHealth,this.maxHealth);
         this.energyGridDeployer = new EnergyGridDeployer(5,this);
         this.packetControlConstructionPacket = new PacketControl(4210752,0);
         this.packetControlWeaponEnergyPacket = new PacketControl(15671296,1);
         this.packetControlOperateEnergyPacket = new PacketControl(61184,2);
         addChild(this.packetControlConstructionPacket);
         addChild(this.packetControlWeaponEnergyPacket);
         addChild(this.packetControlOperateEnergyPacket);
         this.packetControlOperateEnergyPacket.x = 0;
         this.packetControlOperateEnergyPacket.y = -24;
         this.packetControlConstructionPacket.x = 22.5;
         this.packetControlConstructionPacket.y = 12.5;
         this.packetControlWeaponEnergyPacket.x = -22.5;
         this.packetControlWeaponEnergyPacket.y = 12.5;
      }
      
      public static function getBodyShape() : Sprite
      {
         var _loc1_:* = null;
         _loc1_ = new Sprite();
         _loc1_.mouseEnabled = false;
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(-36,-36,72,72);
         _loc1_.graphics.endFill();
         var _loc3_:Bitmap = new bodyImage() as Bitmap;
         _loc3_.smoothing = true;
         _loc3_.width = 64.8;
         _loc3_.height = 64.8;
         _loc3_.x = -32.4;
         _loc3_.y = -32.4;
         _loc1_.addChild(_loc3_);
         return _loc1_;
      }
      
      public static function getHelpImage() : Sprite
      {
         var _loc1_:Sprite = getBodyShape();
         var _loc2_:PacketControl = new PacketControl(4210752,0,true);
         var _loc3_:PacketControl = new PacketControl(15671296,1,true);
         var _loc4_:PacketControl = new PacketControl(61184,2,true);
         _loc1_.addChild(_loc2_);
         _loc1_.addChild(_loc3_);
         _loc1_.addChild(_loc4_);
         _loc4_.x = 0;
         _loc4_.y = -24;
         _loc2_.x = 23.5;
         _loc2_.y = 13.5;
         _loc3_.x = -23.5;
         _loc3_.y = 13.5;
         return _loc1_;
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
      
      override public function get maxHealth() : Number
      {
         return 100;
      }
      
      override public function get operateEnergy() : Number
      {
         return 0;
      }
      
      public function set allowConstructionPackets(param1:Boolean) : void
      {
         this._allowConstructionPackets = param1;
         this.packetControlConstructionPacket.selected = param1;
      }
      
      public function get allowConstructionPackets() : Boolean
      {
         return this._allowConstructionPackets;
      }
      
      public function set allowWeaponEnergyPackets(param1:Boolean) : void
      {
         this._allowWeaponEnergyPackets = param1;
         this.packetControlWeaponEnergyPacket.selected = param1;
      }
      
      public function get allowWeaponEnergyPackets() : Boolean
      {
         return this._allowWeaponEnergyPackets;
      }
      
      public function set allowOperateEnergyPackets(param1:Boolean) : void
      {
         this._allowOperateEnergyPackets = param1;
         this.packetControlOperateEnergyPacket.selected = param1;
      }
      
      public function get allowOperateEnergyPackets() : Boolean
      {
         return this._allowOperateEnergyPackets;
      }
      
      private function getPacketShape(param1:Number) : Shape
      {
         var _loc2_:Matrix = new Matrix();
         _loc2_.createGradientBox(10.4,10.4,0,-7.2,-7.2);
         var _loc3_:Shape = new Shape();
         _loc3_ = new Shape();
         _loc3_.graphics.beginGradientFill(GradientType.RADIAL,[15724527,param1],[1,1],[0,255],_loc2_);
         _loc3_.graphics.lineStyle(1,3158016);
         _loc3_.graphics.drawCircle(0,0,6);
         _loc3_.graphics.endFill();
         return _loc3_;
      }
      
      private function setPacketControlDisplay() : void
      {
         this.packetControlConstructionPacket.visible = this._allowConstructionPackets;
         this.packetControlWeaponEnergyPacket.visible = this._allowWeaponEnergyPackets;
         this.packetControlOperateEnergyPacket.visible = this._allowOperateEnergyPackets;
      }
      
      override public function load(param1:XML) : void
      {
         super.load(param1);
         health = this.maxHealth;
      }
      
      private function processEnergyQueue() : void
      {
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc1_:Boolean = true;
         var _loc3_:int = 0;
         var _loc4_:int = GameSpace.instance.places.placesLayer.numChildren;
         if(destroyed)
         {
            return;
         }
         if(state == STATE_RIFT3)
         {
            return;
         }
         while(_loc1_ && GameSpace.instance.stash >= EnergyPacket.WORTH && _loc3_ < _loc4_)
         {
            if(this.placeQueueLoc >= _loc4_)
            {
               this.placeQueueLoc = 0;
            }
            _loc2_ = GameSpace.instance.places.placesLayer.getChildAt(this.placeQueueLoc) as Place;
            if(_loc2_.energyRequestQueue.length > 0)
            {
               _loc1_ = false;
               _loc5_ = _loc2_.energyRequestQueue[0];
               _loc2_.energyRequestQueue.shift();
               if(!(_loc6_ = new EnergyPacket(this,_loc2_,_loc5_.type)).destroyed)
               {
                  GameSpace.instance.stash -= 0;
                  GameSpace.instance.energyConsumed += EnergyPacket.WORTH;
               }
               else
               {
                  _loc1_ = true;
               }
            }
            ++this.placeQueueLoc;
            _loc3_++;
         }
      }
      
      override public function update() : void
      {
         var _loc1_:* = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         super.update();
         --this.soundCounter;
         if(this.soundCounter < 0)
         {
            this.soundCounter = 0;
         }
         if(state == STATE_PLACED && !rifted && !destroyed)
         {
            if(this.calculateDamage())
            {
               if(this.soundCounter == 0)
               {
                  this.soundCounter = 200;
                  _loc1_ = new CityDamageSound();
                  _loc1_.play();
               }
            }
         }
         if(destroyed)
         {
            ++this.endCounter;
            if(this.endCounter >= 180)
            {
               GameSpace.instance.destroyedReason = GameSpace.DESTROYED_REASON_SHIP_DESTROYED;
               Creeper.instance.gameScreen.showResultsScreen();
            }
         }
         if(GameSpace.instance.rift != null && !GameSpace.instance.suppressCityExit)
         {
            if(GameSpace.instance.rift.state == Rift.STATE_ACTIVATED && state == STATE_PLACED)
            {
               canMove = true;
               move(gameSpaceX,gameSpaceY);
            }
            if(GameSpace.instance.rift.state == Rift.STATE_ACTIVATED && state == STATE_MOVING)
            {
               _loc2_ = GameSpace.instance.rift.x - x;
               _loc3_ = GameSpace.instance.rift.y - y;
               _loc4_ = _loc2_ * _loc2_ + _loc3_ * _loc3_;
               state = STATE_RIFT1;
            }
         }
         this.processEnergyQueue();
         if(updateCount % 30 == 0)
         {
            if(state == STATE_PLACED)
            {
               this.energyGridDeployer.deployEnergyGrid();
            }
            else
            {
               this.energyGridDeployer.undeployEnergyGrid();
            }
         }
         if(this.energyPacketCounter > 0)
         {
            --this.energyPacketCounter;
         }
      }
      
      override public function destroy(param1:Boolean = false) : void
      {
         destroyAllPaths();
         this.energyGridDeployer.undeployEnergyGrid();
         new Explosion(x,y,16711680,9437184,0.3,36);
         new Explosion(x + Math.random() * 100 - 50,y + Math.random() * 100 - 50,16711680,9437184,0.5,36);
         new Explosion(x + Math.random() * 100 - 50,y + Math.random() * 100 - 50,16711680,9437184,0.2,72);
         new Explosion(x + Math.random() * 100 - 50,y + Math.random() * 100 - 50,16711680,9437184,0.4,50);
         new Explosion(x + Math.random() * 100 - 50,y + Math.random() * 100 - 50,16711680,9437184,0.6,36);
         new Explosion(x + Math.random() * 100 - 50,y + Math.random() * 100 - 50,16711680,9437184,0.5,36);
         new Explosion(x + Math.random() * 100 - 50,y + Math.random() * 100 - 50,16711680,9437184,0.2,72);
         new Explosion(x + Math.random() * 100 - 50,y + Math.random() * 100 - 50,16711680,9437184,0.4,50);
         new Explosion(x + Math.random() * 100 - 50,y + Math.random() * 100 - 50,16711680,9437184,0.6,36);
         visible = false;
         destroyed = true;
         var _loc2_:Sound = new CityExplosionSound();
         _loc2_.play();
      }
      
      private function calculateDamage() : Boolean
      {
         var _loc1_:Number = NaN;
         var _loc3_:Boolean = false;
         var _loc5_:int = 0;
         var _loc2_:Boolean = false;
         var _loc4_:int = -2;
         while(_loc4_ <= 2)
         {
            _loc5_ = -2;
            while(_loc5_ <= 2)
            {
               _loc1_ = GameSpace.instance.glop.data[gameSpaceX + _loc5_ + (gameSpaceY + _loc4_) * 0];
               if(_loc1_ >= Glop.MIN_HEAT)
               {
                  _loc2_ = true;
                  health -= 0.01;
                  if(health < 0)
                  {
                     health = 0;
                     this.destroy();
                     return true;
                  }
                  _loc3_ = true;
               }
               _loc5_++;
            }
            _loc4_++;
         }
         if(!_loc2_ && !building)
         {
            health += 0.01;
            if(health > this.maxHealth)
            {
               health = this.maxHealth;
            }
            else
            {
               _loc3_ = true;
            }
         }
         if(_loc3_)
         {
            this.healthBar.setValue(health,this.maxHealth);
         }
         return _loc2_;
      }
      
      override protected function getXMLRoot() : XML
      {
         return <BaseGun/>;
      }
   }
}
