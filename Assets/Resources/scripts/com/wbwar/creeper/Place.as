package com.wbwar.creeper
{
   import caurina.transitions.Tweener;
   import com.adobe.utils.ArrayUtil;
   import com.wbwar.creeper.util.ClassUtil;
   import com.wbwar.creeper.util.ColorUtil;
   import com.wbwar.creeper.util.Graph;
   import com.wbwar.creeper.util.LOS;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.media.Sound;
   import flash.utils.getQualifiedClassName;
   
   public class Place extends Sprite
   {
      
      public static const CHEAPER_RATE:Number = 0.9;
      
      private static const CONNECT_RANGE:int = 6;
      
      private static var clickSound:Sound;
      
      private static var turnedOnSound:Sound;
      
      private static var placeExplosionSound:Sound;
      
      private static const WIDTH:int = GameSpace.WIDTH;
      
      private static const HEIGHT:int = GameSpace.HEIGHT;
      
      private static const MIN_HEAT:Number = Glop.MIN_HEAT;
       
      
      protected var ENERGYPACKET_REQUESTRATE:int = 30;
      
      public var g_score:Number;
      
      public var h_score:Number;
      
      public var f_score:Number;
      
      public var came_from:Place;
      
      public var energyRequestQueue:Array;
      
      public var energyLevel:Number = 0;
      
      public var health:Number;
      
      public var level:int;
      
      public var assignedEnergyPacketCount:int;
      
      public var building:Boolean = true;
      
      public var upgrading:Boolean;
      
      protected var updateCount:int;
      
      public var gameSpaceX:int;
      
      public var gameSpaceY:int;
      
      protected var lockedShape:Shape;
      
      protected var armedShape:Shape;
      
      protected var turnedOffShape:Shape;
      
      protected var selectedShape:Shape;
      
      protected var requestEnergy:Boolean = true;
      
      protected var placeBody:Sprite;
      
      public var paths:Array;
      
      protected var _turnedOn:Boolean = true;
      
      protected var _armed:Boolean = true;
      
      protected var _locked:Boolean = false;
      
      protected var _selected:Boolean;
      
      public var RANGE:int;
      
      private var energyPacketRequestCounter:int;
      
      public var destroyed:Boolean;
      
      public var hookedUp:Boolean;
      
      protected var places:Places;
      
      private var mh:Number;
      
      public function Place(param1:Number, param2:Number)
      {
         this.energyRequestQueue = [];
         this.paths = [];
         super();
         this.gameSpaceX = param1;
         this.gameSpaceY = param2;
         this.setScreenCoords();
         this.health = 0;
         this.placeBody = new Sprite();
         addChild(this.placeBody);
         ColorUtil.bwColor(this.placeBody,0.1);
         if(false)
         {
            this.places = GameSpace.instance.places;
            addEventListener(MouseEvent.CLICK,this.onMouseClick);
            if(clickSound == null)
            {
               clickSound = new ClickSound();
            }
            if(turnedOnSound == null)
            {
               turnedOnSound = new LandSound();
            }
            if(placeExplosionSound == null)
            {
               placeExplosionSound = new PlaceExplosionSound();
            }
            GameSpace.instance.currentUnitCount += this.getUnitCost();
         }
         this.addTurnedOffShape();
         this.addSelectedShape();
      }
      
      private static function checkPath(param1:Place, param2:String, param3:Number, param4:Number) : Boolean
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         if(param1.destroyed)
         {
            return false;
         }
         if(param2 == "com.wbwar.creeper::Mine" || param1 is Mine)
         {
            return false;
         }
         if(param2 == "com.wbwar.creeper::Rift" || param1 is Rift)
         {
            return false;
         }
         if(param2 == "com.wbwar.creeper::BaseGun" && param1 is Tech || param2 == "com.wbwar.creeper::Tech" && param1 is BaseGun)
         {
            return false;
         }
         if(param1 is ThorsHammer && !param1.building)
         {
            return false;
         }
         if(param2 == "com.wbwar.creeper::Node" || param1 is Node || param2 == "com.wbwar.creeper::Relay" || param1 is Relay || param1 is BaseGun || param2 == "com.wbwar.creeper::BaseGun" && param1 is Tech || param2 == "com.wbwar.creeper::BaseGun" && param1 is Totem || param2 == "com.wbwar.creeper::BaseGun" && param1 is EnergyStorage || param2 == "com.wbwar.creeper::BaseGun" && param1 is Logistics || param2 == "com.wbwar.creeper::BaseGun" && param1 is EnergyAmp || param2 == "com.wbwar.creeper::BaseGun" && param1 is Units || param2 == "com.wbwar.creeper::BaseGun" && param1 is AreaGun || param2 == "com.wbwar.creeper::BaseGun" && param1 is ABM || param2 == "com.wbwar.creeper::BaseGun" && param1 is DroneBase || param2 == "com.wbwar.creeper::BaseGun" && param1 is ThorsHammer || param2 == "com.wbwar.creeper::BaseGun" && param1 is Gun)
         {
            _loc7_ = param1.x - param3;
            _loc8_ = param1.y - param4;
            _loc5_ = Math.sqrt(_loc7_ * _loc7_ + _loc8_ * _loc8_);
            _loc9_ = param3 / 0;
            _loc10_ = param4 / 0;
            if(param2 == "com.wbwar.creeper::Relay" && param1 is Relay)
            {
               _loc6_ = CONNECT_RANGE * 2;
            }
            else
            {
               _loc6_ = CONNECT_RANGE;
            }
            if(_loc5_ < _loc6_ * 0)
            {
               return LOS.hasLOS(_loc9_,_loc10_,param1.gameSpaceX,param1.gameSpaceY,true,false,true) || LOS.hasLOS(param1.gameSpaceX,param1.gameSpaceY,_loc9_,_loc10_,true,false,true);
            }
            return false;
         }
         return false;
      }
      
      public static function getPossiblePaths(param1:String, param2:Number, param3:Number) : Array
      {
         var _loc6_:* = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         var _loc4_:Places = GameSpace.instance.places;
         var _loc5_:* = [];
         _loc9_ = _loc4_.placesLayer.numChildren - 1;
         while(_loc9_ >= 0)
         {
            _loc6_ = _loc4_.placesLayer.getChildAt(_loc9_) as Place;
            if(checkPath(_loc6_,param1,param2,param3))
            {
               _loc5_.push(_loc6_);
            }
            _loc9_--;
         }
         _loc9_ = GameSpace.instance.upperPlacesLayer.numChildren - 1;
         while(_loc9_ >= 0)
         {
            _loc6_ = GameSpace.instance.upperPlacesLayer.getChildAt(_loc9_) as Place;
            if(checkPath(_loc6_,param1,param2,param3))
            {
               _loc5_.push(_loc6_);
            }
            _loc9_--;
         }
         return _loc5_;
      }
      
      public static function legalTerrainLocation(param1:int, param2:int, param3:Object = null) : Boolean
      {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         if(param1 < 0 || param2 < 0 || param1 >= GameSpace.WIDTH || param2 >= GameSpace.HEIGHT)
         {
            return false;
         }
         var _loc4_:int = GameSpace.instance.terrain.terrainHeight[param1 + param2 * 0];
         if(getQualifiedClassName(param3) == "com.wbwar.creeper::BaseGun")
         {
            _loc5_ = 3;
         }
         else if(getQualifiedClassName(param3) == "com.wbwar.creeper::ThorsHammer")
         {
            _loc5_ = 2;
         }
         else
         {
            _loc5_ = 1;
         }
         var _loc6_:int = param2 - _loc5_;
         while(_loc6_ <= param2 + _loc5_)
         {
            _loc7_ = param1 - _loc5_;
            while(_loc7_ <= param1 + _loc5_)
            {
               if(_loc7_ < 0 || _loc6_ < 0 || _loc7_ >= GameSpace.WIDTH || _loc6_ >= GameSpace.HEIGHT)
               {
                  return false;
               }
               if(GameSpace.instance.terrain.terrainHeight[_loc7_ + _loc6_ * 0] != _loc4_)
               {
                  return false;
               }
               if(GameSpace.instance.walls.wallData[_loc7_ + _loc6_ * 0] > 0)
               {
                  return false;
               }
               _loc7_++;
            }
            _loc6_++;
         }
         return true;
      }
      
      public static function create(param1:XML) : Place
      {
         var _loc2_:* = null;
         var _loc3_:String = param1.name();
         switch(_loc3_)
         {
            case "Node":
               _loc2_ = new Node(param1.gameSpaceX,param1.gameSpaceY);
               _loc2_.load(param1);
               break;
            case "Relay":
               _loc2_ = new Relay(param1.gameSpaceX,param1.gameSpaceY);
               _loc2_.load(param1);
               break;
            case "EnergyStorage":
               _loc2_ = new EnergyStorage(param1.gameSpaceX,param1.gameSpaceY);
               _loc2_.load(param1);
               break;
            case "Gun":
               _loc2_ = new Gun(param1.gameSpaceX,param1.gameSpaceY);
               _loc2_.load(param1);
               break;
            case "AreaGun":
               _loc2_ = new AreaGun(param1.gameSpaceX,param1.gameSpaceY);
               _loc2_.load(param1);
               break;
            case "DroneBase":
               _loc2_ = new DroneBase(param1.gameSpaceX,param1.gameSpaceY);
               _loc2_.load(param1);
               break;
            case "ThorsHammer":
               _loc2_ = new ThorsHammer(param1.gameSpaceX,param1.gameSpaceY);
               _loc2_.load(param1);
               break;
            case "Totem":
               _loc2_ = new Totem(param1.gameSpaceX,param1.gameSpaceY);
               _loc2_.load(param1);
               break;
            case "Rift":
               _loc2_ = new Rift(param1.gameSpaceX,param1.gameSpaceY);
               _loc2_.load(param1);
               break;
            case "BaseGun":
               _loc2_ = new BaseGun(param1.gameSpaceX,param1.gameSpaceY);
               _loc2_.load(param1);
         }
         return _loc2_;
      }
      
      public function get maxHealth() : Number
      {
         return 0;
      }
      
      public function get operateEnergy() : Number
      {
         return 0;
      }
      
      public function get operateEnergyType() : int
      {
         return EnergyPacket.TYPE_WEAPONENERGY;
      }
      
      public function set turnedOn(param1:Boolean) : void
      {
         this._turnedOn = param1;
         if(this.turnedOffShape != null)
         {
            this.turnedOffShape.visible = !param1;
         }
         if(!param1)
         {
            this.energyRequestQueue = [];
            this.assignedEnergyPacketCount = 0;
         }
         else
         {
            turnedOnSound.play();
         }
      }
      
      public function get turnedOn() : Boolean
      {
         return this._turnedOn;
      }
      
      public function set armed(param1:Boolean) : void
      {
         this._armed = param1;
         if(this.armedShape != null)
         {
            this.armedShape.visible = !param1;
         }
         if(param1)
         {
            turnedOnSound.play();
         }
      }
      
      public function get armed() : Boolean
      {
         return this._armed;
      }
      
      public function set locked(param1:Boolean) : void
      {
         this._locked = param1;
         if(this.lockedShape != null)
         {
            this.lockedShape.visible = param1;
         }
      }
      
      public function get locked() : Boolean
      {
         return this._locked;
      }
      
      public function set selected(param1:Boolean) : void
      {
         this._selected = param1;
         if(this.selectedShape != null)
         {
            this.selectedShape.visible = param1;
         }
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function zeroEnergyQueue() : void
      {
         this.energyRequestQueue = [];
         this.assignedEnergyPacketCount = 0;
      }
      
      public function fallIntoHole() : void
      {
         var _loc1_:Number = Math.random() * 2;
         Tweener.addTween(this,{
            "time":6,
            "delay":_loc1_,
            "transition":"easeInExpo",
            "x":GameSpace.instance.rift.x,
            "y":GameSpace.instance.rift.y,
            "onComplete":this.holeComplete
         });
      }
      
      protected function holeComplete() : void
      {
         this.destroy();
      }
      
      protected function getModMaxHealth(param1:int) : int
      {
         if(GameSpace.instance.upgradeEconomic1)
         {
            return int(param1 * 0.9);
         }
         return param1;
      }
      
      public function getUnitCost() : int
      {
         return ClassUtil.getClass(this)["unitCost"];
      }
      
      protected function addLockedShape() : void
      {
         this.lockedShape = new Shape();
         addChild(this.lockedShape);
         this.lockedShape.graphics.beginFill(8425680,0.6);
         this.lockedShape.graphics.drawRect(-10,-10,20,20);
         this.lockedShape.graphics.endFill();
         this.lockedShape.visible = false;
      }
      
      protected function addArmedShape() : void
      {
         this.armedShape = new Shape();
         addChild(this.armedShape);
         this.armedShape.graphics.beginFill(16711680,0.3);
         this.armedShape.graphics.drawRect(-10,-10,20,20);
         this.armedShape.graphics.endFill();
         this.armedShape.visible = false;
      }
      
      protected function addTurnedOffShape() : void
      {
         this.addArmedShape();
         this.addLockedShape();
         this.turnedOffShape = new Shape();
         addChild(this.turnedOffShape);
         this.turnedOffShape.graphics.lineStyle(2,16711680,0.5);
         this.turnedOffShape.graphics.drawCircle(0,0,10);
         this.turnedOffShape.graphics.moveTo(7,-7);
         this.turnedOffShape.graphics.lineTo(-7,7);
         this.turnedOffShape.x = 0;
         this.turnedOffShape.y = 0;
         this.turnedOffShape.visible = false;
         this.turnedOffShape.filters = [new DropShadowFilter(2)];
      }
      
      protected function addSelectedShape() : void
      {
         this.selectedShape = new Shape();
         addChild(this.selectedShape);
         this.selectedShape.graphics.lineStyle(2,65280);
         this.selectedShape.graphics.moveTo(2,-15);
         this.selectedShape.graphics.curveTo(13,-13,15,-2);
         this.selectedShape.graphics.moveTo(15,2);
         this.selectedShape.graphics.curveTo(13,13,2,15);
         this.selectedShape.graphics.moveTo(-2,-15);
         this.selectedShape.graphics.curveTo(-13,-13,-15,-2);
         this.selectedShape.graphics.moveTo(-15,2);
         this.selectedShape.graphics.curveTo(-13,13,-2,15);
         this.selectedShape.x = 0;
         this.selectedShape.y = 0;
         this.selectedShape.visible = false;
         this.selectedShape.filters = [new DropShadowFilter(2)];
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         if(!this._locked)
         {
            clickSound.play();
            GameSpace.instance.controlPanel.place = this;
            GameSpace.instance.places.removeAllSelections();
            this.selected = true;
         }
         param1.stopPropagation();
      }
      
      public function snapTo() : void
      {
         var _loc1_:int = x / 0;
         var _loc2_:int = y / 0;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         if(_loc1_ > -1)
         {
            _loc1_ = -1;
         }
         if(_loc2_ > -1)
         {
            _loc2_ = -1;
         }
         this.gameSpaceX = _loc1_;
         this.gameSpaceY = _loc2_;
         this.setScreenCoords();
      }
      
      public function setScreenCoords() : void
      {
         x = this.gameSpaceX * 0 + 0;
         y = this.gameSpaceY * 0 + 0;
      }
      
      public function getEffectiveEnergy() : Number
      {
         return this.energyLevel + this.assignedEnergyPacketCount * 0;
      }
      
      public function applyEnergyPacket(param1:EnergyPacket) : void
      {
         if(this.building)
         {
            this.health += EnergyPacket.WORTH;
            if(this.health > this.maxHealth)
            {
               this.health = this.maxHealth;
            }
         }
         else
         {
            this.energyLevel += EnergyPacket.WORTH;
            if(this.energyLevel > this.operateEnergy)
            {
               this.energyLevel = this.operateEnergy;
            }
         }
      }
      
      protected function upgrade() : void
      {
         if(!this.upgrading && !this.building)
         {
            this.energyRequestQueue = [];
            this.assignedEnergyPacketCount = 0;
            this.building = true;
            this.upgrading = true;
            this.ENERGYPACKET_REQUESTRATE = 30;
            this.health = 0;
            ++this.level;
            ColorUtil.bwColor(this.placeBody,0.5);
            if(GameSpace.instance.places.placeToMove == this)
            {
               GameSpace.instance.places.placeToMove = null;
            }
         }
      }
      
      public function update() : void
      {
         var _loc1_:* = null;
         ++this.updateCount;
         if(this.selectedShape != null && this.selectedShape.visible)
         {
            this.selectedShape.rotation += 2;
         }
         if(this.energyPacketRequestCounter > 0)
         {
            --this.energyPacketRequestCounter;
         }
         if(GameSpace.instance.upgradeEconomic1)
         {
            this.mh = this.maxHealth * CHEAPER_RATE;
         }
         else
         {
            this.mh = this.maxHealth;
         }
         if(GameSpace.instance.upgradeEconomic2)
         {
            if(this.ENERGYPACKET_REQUESTRATE > 15)
            {
               this.ENERGYPACKET_REQUESTRATE = 24;
            }
         }
         if(this._locked && this.updateCount % 4 == 0)
         {
            if(Graph.astar(GameSpace.instance.places,this,GameSpace.instance.baseGun) != null)
            {
               if(this._locked)
               {
                  if(GameSpace.instance.baseGun.state == MovingPlace.STATE_PLACED)
                  {
                     this.locked = false;
                  }
               }
            }
         }
         if(this.requestEnergy && this.energyPacketRequestCounter == 0 && this._turnedOn)
         {
            if(!(this is MovingPlace) || this is MovingPlace && (this as MovingPlace).state == MovingPlace.STATE_PLACED)
            {
               if(!this.building && this.operateEnergy - (this.energyLevel + this.assignedEnergyPacketCount * 0) >= EnergyPacket.WORTH || this.building && this.mh - (this.health + this.assignedEnergyPacketCount * 0) > 0)
               {
                  if(Graph.astar(GameSpace.instance.places,this,GameSpace.instance.baseGun) != null)
                  {
                     if(this.building)
                     {
                        this.requestEnergyPacket(EnergyPacket.TYPE_CONSTRUCTION);
                     }
                     else
                     {
                        this.requestEnergyPacket(this.operateEnergyType);
                     }
                  }
                  this.energyPacketRequestCounter = this.ENERGYPACKET_REQUESTRATE;
               }
            }
         }
         if(this.building)
         {
            if(this.health >= this.mh)
            {
               this.health = this.maxHealth;
               this.buildComplete();
            }
         }
         if(this.energyRequestQueue.length > 0)
         {
            _loc1_ = this.energyRequestQueue[0];
            if(_loc1_.type == EnergyPacket.TYPE_CONSTRUCTION && !GameSpace.instance.baseGun.allowConstructionPackets || _loc1_.type == EnergyPacket.TYPE_OPERATEENERGY && !GameSpace.instance.baseGun.allowOperateEnergyPackets || _loc1_.type == EnergyPacket.TYPE_WEAPONENERGY && !GameSpace.instance.baseGun.allowWeaponEnergyPackets)
            {
               this.zeroEnergyQueue();
            }
         }
      }
      
      private function requestEnergyPacket(param1:int) : void
      {
         ++this.assignedEnergyPacketCount;
         this.energyRequestQueue.push(new EnergyRequest(this,param1));
      }
      
      protected function buildComplete() : void
      {
         this.building = false;
         this.upgrading = false;
         this.ENERGYPACKET_REQUESTRATE = 15;
         if(this.selected && this is MovingPlace)
         {
            (this as MovingPlace).onMPMouseClick(null);
         }
         ColorUtil.normalColor(this.placeBody,0.5);
      }
      
      public function move(param1:int, param2:int) : void
      {
      }
      
      public function destroyAllPaths() : void
      {
         var _loc2_:* = null;
         var _loc1_:Array = this.paths.concat();
         for each(_loc2_ in _loc1_)
         {
            _loc2_.destroy();
         }
      }
      
      public function destroy(param1:Boolean = false) : void
      {
         this.selected = false;
         this.destroyAllPaths();
         GameSpace.instance.places.removePlace(this);
         this.destroyed = true;
         if(!param1)
         {
            placeExplosionSound.play();
            new Explosion(x,y,65280,36864,0.5,15);
         }
         GameSpace.instance.currentUnitCount -= this.getUnitCost();
      }
      
      protected function hookUp() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc1_:* = [];
         if(!this.destroyed)
         {
            _loc1_ = getPossiblePaths(getQualifiedClassName(this),x,y);
            for each(_loc2_ in this.paths)
            {
               if(_loc1_.indexOf(_loc2_.getOtherEnd(this)) == -1)
               {
                  _loc2_.destroy();
               }
            }
            for each(_loc3_ in _loc1_)
            {
               if(this.getPathTo(_loc3_) == null && _loc3_ != this)
               {
                  this.connectToPlace(_loc3_);
               }
            }
         }
         this.hookedUp = true;
      }
      
      public function getPathTo(param1:Place) : Path
      {
         var _loc2_:* = null;
         for each(_loc2_ in this.paths)
         {
            if(_loc2_.getOtherEnd(this) == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function distToOtherPlace(param1:Place) : Number
      {
         var _loc2_:int = param1.x - x;
         var _loc3_:int = param1.y - y;
         return Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_);
      }
      
      private function connectToPlace(param1:Place) : void
      {
         var _loc2_:Path = new Path(this,param1);
         this.paths.push(_loc2_);
         param1.paths.push(_loc2_);
      }
      
      public function removePath(param1:Path) : void
      {
         ArrayUtil.removeValueFromArray(this.paths,param1);
      }
      
      protected function findDeepestGlop(param1:Boolean = false) : Point
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc11_:Number = NaN;
         var _loc5_:int = -1;
         var _loc6_:int = -1;
         var _loc7_:int = 0;
         var _loc8_:* = 0;
         var _loc9_:int = this.RANGE * this.RANGE;
         var _loc10_:Array = this.places.gameSpace.glop.data;
         _loc3_ = this.gameSpaceY - this.RANGE;
         while(_loc3_ <= this.gameSpaceY + this.RANGE)
         {
            if(!(_loc3_ < 0 || _loc3_ >= HEIGHT))
            {
               _loc2_ = this.gameSpaceX - this.RANGE;
               while(_loc2_ <= this.gameSpaceX + this.RANGE)
               {
                  if(!(_loc2_ < 0 || _loc2_ >= WIDTH))
                  {
                     if((_loc4_ = (_loc2_ - this.gameSpaceX) * (_loc2_ - this.gameSpaceX) + (_loc3_ - this.gameSpaceY) * (_loc3_ - this.gameSpaceY)) <= _loc9_)
                     {
                        if((_loc11_ = _loc10_[_loc2_ + _loc3_ * WIDTH]) >= Glop.MIN_HEAT && _loc11_ >= _loc8_)
                        {
                           if(!(_loc11_ == _loc8_ && _loc4_ > _loc7_))
                           {
                              _loc8_ = Number(_loc11_);
                              _loc7_ = _loc4_;
                              _loc5_ = _loc2_;
                              _loc6_ = _loc3_;
                           }
                        }
                     }
                  }
                  _loc2_++;
               }
            }
            _loc3_++;
         }
         if(_loc5_ > -1)
         {
            return new Point(_loc5_,_loc6_);
         }
         return null;
      }
      
      protected function findNearestGlop(param1:Boolean = false) : Point
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = -1;
         var _loc7_:int = -1;
         var _loc8_:int = 0;
         var _loc9_:int = this.RANGE * this.RANGE;
         var _loc10_:Array = this.places.gameSpace.glop.data;
         _loc2_ = 1;
         while(_loc2_ < this.RANGE)
         {
            _loc3_ = this.gameSpaceX - _loc2_;
            while(_loc3_ <= this.gameSpaceX + _loc2_)
            {
               if(_loc3_ >= 0 && _loc3_ < WIDTH)
               {
                  _loc4_ = this.gameSpaceY - _loc2_;
                  if((_loc5_ = (_loc3_ - this.gameSpaceX) * (_loc3_ - this.gameSpaceX) + (_loc4_ - this.gameSpaceY) * (_loc4_ - this.gameSpaceY)) <= _loc9_)
                  {
                     if(_loc4_ >= 0 && _loc4_ < HEIGHT)
                     {
                        if(_loc10_[_loc3_ + _loc4_ * WIDTH] >= MIN_HEAT && _loc5_ <= _loc8_)
                        {
                           if(_loc5_ < _loc8_ || this.updateCount % 4 == 0)
                           {
                              if(LOS.hasLOS(this.gameSpaceX,this.gameSpaceY,_loc3_,_loc4_,param1,false))
                              {
                                 _loc8_ = _loc5_;
                                 _loc6_ = _loc3_;
                                 _loc7_ = _loc4_;
                              }
                           }
                        }
                     }
                     if((_loc4_ = this.gameSpaceY + _loc2_) >= 0 && _loc4_ < HEIGHT)
                     {
                        if(_loc10_[_loc3_ + _loc4_ * WIDTH] >= MIN_HEAT && _loc5_ <= _loc8_)
                        {
                           if(_loc5_ < _loc8_ || this.updateCount % 4 == 1)
                           {
                              if(LOS.hasLOS(this.gameSpaceX,this.gameSpaceY,_loc3_,_loc4_,param1,false))
                              {
                                 _loc8_ = _loc5_;
                                 _loc6_ = _loc3_;
                                 _loc7_ = _loc4_;
                              }
                           }
                        }
                     }
                  }
               }
               _loc3_++;
            }
            _loc4_ = this.gameSpaceY - _loc2_ + 1;
            while(_loc4_ <= this.gameSpaceY + _loc2_ - 1)
            {
               if(_loc4_ >= 0 && _loc4_ < HEIGHT)
               {
                  _loc3_ = this.gameSpaceX - _loc2_;
                  if((_loc5_ = (_loc3_ - this.gameSpaceX) * (_loc3_ - this.gameSpaceX) + (_loc4_ - this.gameSpaceY) * (_loc4_ - this.gameSpaceY)) <= _loc9_)
                  {
                     if(_loc3_ >= 0 && _loc3_ < WIDTH)
                     {
                        if(_loc10_[_loc3_ + _loc4_ * WIDTH] >= MIN_HEAT && _loc5_ <= _loc8_)
                        {
                           if(_loc5_ < _loc8_ || this.updateCount % 4 == 2)
                           {
                              if(LOS.hasLOS(this.gameSpaceX,this.gameSpaceY,_loc3_,_loc4_,param1,false))
                              {
                                 _loc8_ = _loc5_;
                                 _loc6_ = _loc3_;
                                 _loc7_ = _loc4_;
                              }
                           }
                        }
                     }
                     _loc3_ = this.gameSpaceX + _loc2_;
                     if(_loc3_ >= 0 && _loc3_ < WIDTH)
                     {
                        if(_loc10_[_loc3_ + _loc4_ * WIDTH] >= MIN_HEAT && _loc5_ <= _loc8_)
                        {
                           if(_loc5_ < _loc8_ || this.updateCount % 4 == 3)
                           {
                              if(LOS.hasLOS(this.gameSpaceX,this.gameSpaceY,_loc3_,_loc4_,param1,false))
                              {
                                 _loc8_ = _loc5_;
                                 _loc6_ = _loc3_;
                                 _loc7_ = _loc4_;
                              }
                           }
                        }
                     }
                  }
               }
               _loc4_++;
            }
            if(_loc6_ > -1)
            {
               break;
            }
            _loc2_++;
         }
         if(_loc6_ > -1)
         {
            return new Point(_loc6_,_loc7_);
         }
         return null;
      }
      
      public function load(param1:XML) : void
      {
         this.gameSpaceX = param1.gameSpaceX;
         this.gameSpaceY = param1.gameSpaceY;
         this.health = param1.health;
         this.energyLevel = param1.energyLevel;
      }
      
      public function getXML() : XML
      {
         var _loc1_:XML = this.getXMLRoot();
         _loc1_.gameSpaceX = this.gameSpaceX;
         _loc1_.gameSpaceY = this.gameSpaceY;
         _loc1_.health = this.health;
         _loc1_.energyLevel = this.energyLevel;
         return _loc1_;
      }
      
      protected function getXMLRoot() : XML
      {
         return <Place/>;
      }
   }
}
