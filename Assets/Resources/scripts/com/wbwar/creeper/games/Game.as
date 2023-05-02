package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.Place;
   import com.wbwar.creeper.util.GameArrayUtil;
   import flash.display.Bitmap;
   
   public class Game
   {
      
      public static const TERRAIN_HEIGHT_MULTIPLE:Number = 1;
       
      
      public var xml:XML;
      
      public var gameTitle:String;
      
      protected var updateCount:int;
      
      protected var done:Boolean;
      
      private var first:Boolean = true;
      
      private var callbackTime:int;
      
      private var callbackFunction:Function;
      
      public var hasCustomBackground:Boolean;
      
      public var customBackground:Bitmap;
      
      public function Game()
      {
         super();
      }
      
      public function getBackground() : int
      {
         return int(this.xml.background.backgroundMap);
      }
      
      public function getEdgeSize() : int
      {
         var _loc1_:int = 5;
         if(this.xml.terrain.edgeSize != null && this.xml.terrain.edgeSize.length() > 0)
         {
            _loc1_ = this.xml.terrain.edgeSize;
         }
         return _loc1_;
      }
      
      public function getTint1() : Number
      {
         var _loc1_:* = 0.4722222222222222;
         if(this.xml.terrain.tint1 != null && this.xml.terrain.tint1.length() > 0)
         {
            _loc1_ = Number(this.xml.terrain.tint1);
         }
         return _loc1_;
      }
      
      public function getTint2() : Number
      {
         var _loc1_:* = 0.6944444444444444;
         if(this.xml.terrain.tint2 != null && this.xml.terrain.tint2.length() > 0)
         {
            _loc1_ = Number(this.xml.terrain.tint2);
         }
         return _loc1_;
      }
      
      public function getTint3() : Number
      {
         var _loc1_:* = 0.9166666666666666;
         if(this.xml.terrain.tint3 != null && this.xml.terrain.tint3.length() > 0)
         {
            _loc1_ = Number(this.xml.terrain.tint3);
         }
         return _loc1_;
      }
      
      public function getTint4() : Number
      {
         var _loc1_:* = 1.1388888888888888;
         if(this.xml.terrain.tint4 != null && this.xml.terrain.tint4.length() > 0)
         {
            _loc1_ = Number(this.xml.terrain.tint4);
         }
         return _loc1_;
      }
      
      public function getTint5() : Number
      {
         var _loc1_:* = 1.3611111111111112;
         if(this.xml.terrain.tint5 != null && this.xml.terrain.tint5.length() > 0)
         {
            _loc1_ = Number(this.xml.terrain.tint5);
         }
         return _loc1_;
      }
      
      public function getTerrainHeight() : Array
      {
         var _loc1_:Array = GameArrayUtil.csvAsIntArray(this.xml.terrain.terrainHeight);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc1_[_loc2_] *= TERRAIN_HEIGHT_MULTIPLE;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getWallData() : Array
      {
         return GameArrayUtil.csvAsIntArray(this.xml.walls.wallData);
      }
      
      public function disableGame() : void
      {
         GameSpace.instance.controlPanel.buildMenu.enableAll(false);
         GameSpace.instance.baseGun.canMove = false;
         GameSpace.instance.controlPanel.missionTimeViewer.visible = false;
      }
      
      public function enableGame() : void
      {
         GameSpace.instance.controlPanel.buildMenu.enableAll(true);
         GameSpace.instance.baseGun.canMove = true;
         GameSpace.instance.controlPanel.missionTimeViewer.visible = true;
         GameSpace.instance.updateCount = 0;
         GameSpace.instance.elapsedTime = 0;
         GameSpace.instance.controlPanel.missionTimeViewer.update();
      }
      
      public function update() : void
      {
         if(this.done)
         {
            return;
         }
         if(this.first)
         {
            this.gameStart();
            this.first = false;
         }
         if(this.updateCount == this.callbackTime && this.callbackFunction != null)
         {
            this.callbackTime = -1;
            this.callbackFunction();
         }
         ++this.updateCount;
      }
      
      public function gameSpaceStarted() : void
      {
      }
      
      public function gameStart() : void
      {
      }
      
      protected function delayedCallback(param1:int, param2:Function) : void
      {
         this.callbackTime = this.updateCount + param1;
         this.callbackFunction = param2;
      }
      
      protected function placesCharged(param1:Class) : Boolean
      {
         var _loc2_:* = null;
         var _loc3_:int = GameSpace.instance.places.placesLayer.numChildren - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = GameSpace.instance.places.placesLayer.getChildAt(_loc3_) as Place;
            if(_loc2_ is param1)
            {
               if(_loc2_.energyLevel < _loc2_.operateEnergy)
               {
                  return false;
               }
            }
            _loc3_--;
         }
         return true;
      }
      
      protected function placeInRange(param1:Class, param2:int, param3:int, param4:int) : Boolean
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = GameSpace.instance.places.placesLayer.numChildren - 1;
         while(_loc9_ >= 0)
         {
            if((_loc5_ = GameSpace.instance.places.placesLayer.getChildAt(_loc9_) as Place) is param1)
            {
               _loc6_ = _loc5_.gameSpaceX - param2;
               _loc7_ = _loc5_.gameSpaceY - param3;
               if(_loc6_ * _loc6_ + _loc7_ * _loc7_ <= param4 * param4)
               {
                  return true;
               }
            }
            _loc9_--;
         }
         return false;
      }
   }
}
