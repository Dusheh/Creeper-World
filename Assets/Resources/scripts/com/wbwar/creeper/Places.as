package com.wbwar.creeper
{
   import com.wbwar.creeper.util.ClassUtil;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.media.Sound;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public final class Places extends Sprite
   {
       
      
      public var gameSpace:GameSpace;
      
      public var onlyLegalX:int = -1;
      
      public var onlyLegalY:int = -1;
      
      private var _placeToAdd:String;
      
      private var _placeToMove:Place;
      
      private var addPlaceSprite:AddPlaceSprite;
      
      private var movePlaceSprite:MovePlaceSprite;
      
      public var placesLayer:Sprite;
      
      public var distLayer:Sprite;
      
      private var clickLayer:Sprite;
      
      private var clickSound:Sound;
      
      private var lastMouseMoveX:int = -1;
      
      private var lastMouseMoveY:int = -1;
      
      public function Places(param1:GameSpace)
      {
         super();
         this.gameSpace = param1;
         graphics.beginFill(0,0);
         graphics.drawRect(0,0,0 * 0,0 * 0);
         graphics.endFill();
         this.distLayer = new Sprite();
         this.distLayer.mouseEnabled = false;
         this.distLayer.mouseChildren = false;
         addChild(this.distLayer);
         this.placesLayer = new Sprite();
         this.placesLayer.mouseEnabled = false;
         addChild(this.placesLayer);
         this.clickLayer = GameSpace.instance.placesClickLayer;
         this.addPlaceSprite = new AddPlaceSprite();
         this.addPlaceSprite.visible = false;
         addChild(this.addPlaceSprite);
         this.movePlaceSprite = new MovePlaceSprite();
         this.movePlaceSprite.visible = false;
         addChild(this.movePlaceSprite);
         this.clickLayer.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this.clickLayer.addEventListener(MouseEvent.CLICK,this.onMouseClick);
         this.clickSound = new ClickSound();
      }
      
      public function set placeToAdd(param1:String) : void
      {
         var _loc2_:* = null;
         this._placeToAdd = param1;
         if(param1 != null)
         {
            this.addPlaceSprite.x = 1000;
            this.addPlaceSprite.visible = true;
            _loc2_ = getDefinitionByName(this._placeToAdd);
            this.addPlaceSprite.placementSprite = _loc2_["getPlacementSprite"]();
            this.showRanges(null,false,null);
            this.showRanges(ClassUtil.getClass(_loc2_),true,null);
            this.clickLayer.visible = true;
            this.lastMouseMoveX = -1;
            this.lastMouseMoveY = -1;
            this.onMouseMove(null);
         }
         else
         {
            this.showRanges(null,false,null);
            this.addPlaceSprite.visible = false;
            if(this._placeToMove == null)
            {
               this.clickLayer.visible = false;
            }
         }
      }
      
      public function get placeToAdd() : String
      {
         return this._placeToAdd;
      }
      
      public function set placeToMove(param1:Place) : void
      {
         this._placeToMove = param1;
         if(param1 != null)
         {
            this.movePlaceSprite.visible = true;
            this.clickLayer.visible = true;
            this.showRanges(null,false,null);
            this.showRanges(ClassUtil.getClass(param1),true,param1);
            this.lastMouseMoveX = -1;
            this.lastMouseMoveY = -1;
            this.onMouseMove(null);
         }
         else
         {
            this.movePlaceSprite.visible = false;
            this.showRanges(null,false,null);
            if(this._placeToAdd == null)
            {
               this.clickLayer.visible = false;
            }
         }
      }
      
      public function get placeToMove() : Place
      {
         return this._placeToMove;
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         _loc2_ = this.placesLayer.mouseX / 0;
         _loc3_ = this.placesLayer.mouseY / 0;
         if(_loc2_ != this.lastMouseMoveX || _loc3_ != this.lastMouseMoveY)
         {
            this.lastMouseMoveX = _loc2_;
            this.lastMouseMoveY = _loc3_;
            if(this._placeToAdd != null)
            {
               this.addPlaceSprite.x = _loc2_ * 0 + 0;
               this.addPlaceSprite.y = _loc3_ * 0 + 0;
               _loc4_ = getDefinitionByName(this._placeToAdd);
               this.addPlaceSprite.refresh(this.legalLocation(_loc2_,_loc3_,_loc4_,null),this._placeToAdd,_loc4_["START_RANGE"],_loc2_,_loc3_);
            }
            else if(this._placeToMove != null)
            {
               this.movePlaceSprite.x = _loc2_ * 0 + 0;
               this.movePlaceSprite.y = _loc3_ * 0 + 0;
               this.movePlaceSprite.refresh(this.legalLocation(_loc2_,_loc3_,ClassUtil.getClass(this._placeToMove),this._placeToMove),this._placeToMove.RANGE,_loc2_,_loc3_,this.placeToMove);
            }
         }
      }
      
      private function getUnitCost(param1:String) : int
      {
         var _loc2_:Object = getDefinitionByName(this._placeToAdd);
         return _loc2_["unitCost"];
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         this.lastMouseMoveX = -1;
         this.lastMouseMoveY = -1;
         if(this._placeToAdd)
         {
            this.clickSound.play();
            this.removeAllSelections();
            _loc2_ = this.addPlaceSprite.x / 0;
            _loc3_ = this.addPlaceSprite.y / 0;
            _loc4_ = getDefinitionByName(this._placeToAdd);
            if(this.legalLocation(_loc2_,_loc3_,_loc4_,null))
            {
               if(this._placeToAdd == "com.wbwar.creeper::Gun")
               {
                  _loc5_ = new Gun(_loc2_,_loc3_);
               }
               else if(this._placeToAdd == "com.wbwar.creeper::AreaGun")
               {
                  _loc5_ = new AreaGun(_loc2_,_loc3_);
               }
               else if(this._placeToAdd == "com.wbwar.creeper::ABM")
               {
                  _loc5_ = new ABM(_loc2_,_loc3_);
               }
               else if(this._placeToAdd == "com.wbwar.creeper::DroneBase")
               {
                  _loc5_ = new DroneBase(_loc2_,_loc3_);
               }
               else if(this._placeToAdd == "com.wbwar.creeper::ThorsHammer")
               {
                  _loc5_ = new ThorsHammer(_loc2_,_loc3_);
                  GameSpace.instance.controlPanel.onCancelButtonClick();
               }
               else if(this._placeToAdd == "com.wbwar.creeper::Node")
               {
                  _loc5_ = new Node(_loc2_,_loc3_);
               }
               else if(this._placeToAdd == "com.wbwar.creeper::Relay")
               {
                  _loc5_ = new Relay(_loc2_,_loc3_);
               }
               else if(this._placeToAdd == "com.wbwar.creeper::EnergyStorage")
               {
                  _loc5_ = new EnergyStorage(_loc2_,_loc3_);
               }
               else if(this._placeToAdd == "com.wbwar.creeper::Logistics")
               {
                  _loc5_ = new Logistics(_loc2_,_loc3_);
               }
               else if(this._placeToAdd == "com.wbwar.creeper::EnergyAmp")
               {
                  _loc5_ = new EnergyAmp(_loc2_,_loc3_);
               }
               else if(this._placeToAdd == "com.wbwar.creeper::Units")
               {
                  _loc5_ = new Units(_loc2_,_loc3_);
               }
               this.addPlace(_loc5_);
               if(_loc5_ != null && _loc5_ is MovingPlace)
               {
                  (_loc5_ as MovingPlace).showRangeIndicator(true);
               }
            }
            param1.stopImmediatePropagation();
         }
         else if(this._placeToMove)
         {
            this.clickSound.play();
            _loc2_ = this.movePlaceSprite.x / 0;
            _loc3_ = this.movePlaceSprite.y / 0;
            if(_loc2_ == this._placeToMove.gameSpaceX && _loc3_ == this._placeToMove.gameSpaceY && this._placeToMove is MovingPlace && (this._placeToMove as MovingPlace).state == MovingPlace.STATE_PLACED)
            {
               GameSpace.instance.controlPanel.onCancelButtonClick();
            }
            else if(this.legalLocation(_loc2_,_loc3_,ClassUtil.getClass(this._placeToMove),this._placeToMove))
            {
               dispatchEvent(new Event("PLACES_MOVE"));
               this.placeToMove.move(_loc2_,_loc3_);
               this.placeToMove.selected = false;
               this.placeToMove = null;
               GameSpace.instance.controlPanel.place = null;
            }
            param1.stopImmediatePropagation();
         }
      }
      
      public function legalLocation(param1:int, param2:int, param3:Object, param4:Place) : Boolean
      {
         var _loc5_:* = null;
         var _loc6_:* = NaN;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Number = NaN;
         var _loc12_:* = null;
         if(param1 < 0 || param2 < 0 || param1 >= GameSpace.WIDTH || param2 >= GameSpace.HEIGHT)
         {
            return false;
         }
         if(this.onlyLegalX > -1)
         {
            if(this.onlyLegalX != param1 || this.onlyLegalY != param2)
            {
               return false;
            }
         }
         if(param4 is DroneBase)
         {
            return true;
         }
         if(param4 is ThorsHammer)
         {
            return true;
         }
         if(param4 is BaseGun && (GameSpace.instance.rift != null && GameSpace.instance.rift.state == Rift.STATE_ACTIVATED))
         {
            _loc8_ = GameSpace.instance.rift.gameSpaceX - param1;
            _loc9_ = GameSpace.instance.rift.gameSpaceY - param2;
            if((_loc10_ = _loc8_ * _loc8_ + _loc9_ * _loc9_) <= 36)
            {
               return true;
            }
         }
         if(!Place.legalTerrainLocation(param1,param2,param3))
         {
            return false;
         }
         _loc7_ = GameSpace.instance.places.placesLayer.numChildren - 1;
         while(_loc7_ >= 0)
         {
            _loc5_ = GameSpace.instance.places.placesLayer.getChildAt(_loc7_) as Place;
            if(!(param4 != null && param4 == _loc5_))
            {
               if(!(_loc5_ is MovingPlace && (_loc5_ as MovingPlace).state != MovingPlace.STATE_PLACED))
               {
                  if(_loc5_ is BaseGun || getQualifiedClassName(param3) == "com.wbwar.creeper::BaseGun")
                  {
                     _loc6_ = 4;
                  }
                  else if(_loc5_ is DroneBase || getQualifiedClassName(param3) == "com.wbwar.creeper::DroneBase")
                  {
                     _loc6_ = 2;
                  }
                  else if(_loc5_ is ThorsHammer || getQualifiedClassName(param3) == "com.wbwar.creeper::ThorsHammer")
                  {
                     _loc6_ = 3;
                  }
                  else if(_loc5_ is EnergyStorage || getQualifiedClassName(param3) == "com.wbwar.creeper::EnergyStorage")
                  {
                     _loc6_ = 2;
                  }
                  else if(_loc5_ is Logistics || getQualifiedClassName(param3) == "com.wbwar.creeper::Logistics")
                  {
                     _loc6_ = 2;
                  }
                  else if(_loc5_ is EnergyAmp || getQualifiedClassName(param3) == "com.wbwar.creeper::EnergyAmp")
                  {
                     _loc6_ = 2;
                  }
                  else if(_loc5_ is Units || getQualifiedClassName(param3) == "com.wbwar.creeper::Units")
                  {
                     _loc6_ = 2;
                  }
                  else
                  {
                     _loc6_ = 2;
                  }
                  if((_loc11_ = (_loc5_.gameSpaceX - param1) * (_loc5_.gameSpaceX - param1) + (_loc5_.gameSpaceY - param2) * (_loc5_.gameSpaceY - param2)) < _loc6_ * _loc6_)
                  {
                     return false;
                  }
               }
            }
            _loc7_--;
         }
         _loc7_ = GameSpace.instance.upperPlacesLayer.numChildren - 1;
         while(_loc7_ >= 0)
         {
            _loc5_ = GameSpace.instance.upperPlacesLayer.getChildAt(_loc7_) as Place;
            if(!(param4 != null && param4 == _loc5_))
            {
               if(_loc5_ is MovingPlace && (_loc5_ as MovingPlace).state != MovingPlace.STATE_PLACED)
               {
                  _loc12_ = _loc5_ as MovingPlace;
                  if(_loc5_ is BaseGun || getQualifiedClassName(param3) == "com.wbwar.creeper::BaseGun")
                  {
                     _loc6_ = 4;
                  }
                  else if(_loc5_ is DroneBase || getQualifiedClassName(param3) == "com.wbwar.creeper::ThorsHammer")
                  {
                     _loc6_ = 3;
                  }
                  else if(_loc5_ is DroneBase || getQualifiedClassName(param3) == "com.wbwar.creeper::DroneBase")
                  {
                     _loc6_ = 2;
                  }
                  else
                  {
                     _loc6_ = 2;
                  }
                  if(Math.abs(_loc12_.targetGameSpaceX - param1) < _loc6_ && Math.abs(_loc12_.targetGameSpaceY - param2) < _loc6_)
                  {
                     return false;
                  }
               }
            }
            _loc7_--;
         }
         return true;
      }
      
      public function addPlace(param1:Place) : void
      {
         this.placesLayer.addChild(param1);
      }
      
      public function removePlace(param1:Place) : void
      {
         if(this._placeToMove == param1)
         {
            GameSpace.instance.controlPanel.onCancelButtonClick();
         }
         if(this.placesLayer.contains(param1))
         {
            this.placesLayer.removeChild(param1);
         }
         if(GameSpace.instance.upperPlacesLayer.contains(param1))
         {
            GameSpace.instance.upperPlacesLayer.removeChild(param1);
         }
      }
      
      public function raisePlace(param1:Place) : void
      {
         if(this.placesLayer.contains(param1))
         {
            this.placesLayer.removeChild(param1);
            GameSpace.instance.upperPlacesLayer.addChild(param1);
         }
      }
      
      public function lowerPlace(param1:Place) : void
      {
         if(GameSpace.instance.upperPlacesLayer.contains(param1))
         {
            GameSpace.instance.upperPlacesLayer.removeChild(param1);
            this.placesLayer.addChild(param1);
         }
      }
      
      public function showRanges(param1:Class, param2:Boolean, param3:Place) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         _loc5_ = this.placesLayer.numChildren - 1;
         while(_loc5_ >= 0)
         {
            if((_loc4_ = this.placesLayer.getChildAt(_loc5_) as Place) is MovingPlace && _loc4_ != param3)
            {
               if(param1 == null || _loc4_ is param1)
               {
                  (_loc4_ as MovingPlace).showRangeIndicator(param2);
               }
            }
            _loc5_--;
         }
         _loc5_ = GameSpace.instance.upperPlacesLayer.numChildren - 1;
         while(_loc5_ >= 0)
         {
            if((_loc4_ = GameSpace.instance.upperPlacesLayer.getChildAt(_loc5_) as Place) is MovingPlace && _loc4_ != param3)
            {
               if(param1 == null || _loc4_ is param1)
               {
                  (_loc4_ as MovingPlace).showRangeIndicator(param2);
               }
            }
            _loc5_--;
         }
      }
      
      public function removeAllSelections() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         _loc2_ = this.placesLayer.numChildren - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = this.placesLayer.getChildAt(_loc2_) as Place;
            _loc1_.selected = false;
            _loc2_--;
         }
         _loc2_ = GameSpace.instance.upperPlacesLayer.numChildren - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = GameSpace.instance.upperPlacesLayer.getChildAt(_loc2_) as Place;
            _loc1_.selected = false;
            _loc2_--;
         }
      }
      
      public function update() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         _loc4_ = this.placesLayer.numChildren - 1;
         while(_loc4_ >= 0)
         {
            _loc1_ = this.placesLayer.getChildAt(_loc4_) as Place;
            _loc2_ += _loc1_.energyRequestQueue.length;
            _loc1_.update();
            if(_loc1_ is ThorsHammer)
            {
               if(_loc3_)
               {
                  _loc1_.destroy();
               }
               _loc3_ = true;
            }
            _loc4_--;
         }
         _loc4_ = GameSpace.instance.upperPlacesLayer.numChildren - 1;
         while(_loc4_ >= 0)
         {
            _loc1_ = GameSpace.instance.upperPlacesLayer.getChildAt(_loc4_) as Place;
            _loc2_ += _loc1_.energyRequestQueue.length;
            _loc1_.update();
            if(_loc1_ is ThorsHammer)
            {
               _loc3_ = true;
            }
            _loc4_--;
         }
         if(_loc3_)
         {
            GameSpace.instance.controlPanel.buildMenu.thorsHammerButton.enabled = false;
         }
         else
         {
            GameSpace.instance.controlPanel.buildMenu.thorsHammerButton.enabled = true;
         }
         GameSpace.instance.energyQueueLength = _loc2_;
      }
      
      public function resetGraphData() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         _loc2_ = this.placesLayer.numChildren - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = this.placesLayer.getChildAt(_loc2_) as Place;
            _loc1_.g_score = 0;
            _loc1_.h_score = 0;
            _loc1_.f_score = 99999999;
            _loc1_.came_from = null;
            _loc2_--;
         }
         _loc2_ = GameSpace.instance.upperPlacesLayer.numChildren - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = GameSpace.instance.upperPlacesLayer.getChildAt(_loc2_) as Place;
            _loc1_.g_score = 0;
            _loc1_.h_score = 0;
            _loc1_.f_score = 99999999;
            _loc1_.came_from = null;
            _loc2_--;
         }
      }
   }
}
