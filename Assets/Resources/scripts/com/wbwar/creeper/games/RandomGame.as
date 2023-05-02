package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopBlobProducer;
   import com.wbwar.creeper.GlopBlobProducerWave;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.UpgradeBox;
   import com.wbwar.creeper.screens.FreeplayMissionSelection;
   import com.wbwar.creeper.util.MapMaker;
   import com.wbwar.creeper.util.Rndm;
   import flash.geom.Point;
   
   public class RandomGame extends Game
   {
      
      private static const x0:int = 0;
      
      private static const x1:int = 17;
      
      private static const x2:int = 35;
      
      private static const x3:int = 53;
      
      private static const x4:int = 69;
      
      private static const y0:int = 0;
      
      private static const y1:int = 12;
      
      private static const y2:int = 24;
      
      private static const y3:int = 36;
      
      private static const y4:int = 47;
       
      
      private var random:Rndm;
      
      private var bg:int;
      
      private var th:Array;
      
      public var gproducers:Array;
      
      public var upgradeBoxes:Array;
      
      private var baseGunLocation:Point;
      
      private var gbActivateTime:int;
      
      private var gbVolleyAmt:int;
      
      private var gbDirection:int;
      
      private var gameNumber:int;
      
      public function RandomGame(param1:int)
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         super();
         if(false)
         {
            return;
         }
         this.gameNumber = param1;
         var _loc2_:int = int((this.gameNumber - 1) / 5);
         if(param1 < 100000000)
         {
            gameTitle = FreeplayMissionSelection.systemNames[_loc2_] + " " + ((this.gameNumber - 1) % 5 + 1);
         }
         this.random = new Rndm(param1);
         this.random.random();
         this.bg = int(this.random.random() * 6);
         if(param1 >= 100000000)
         {
            this.th = MapMaker.generateMap(this.random.seed,param1 > 100000000 && param1 % 28 == 0);
         }
         else
         {
            this.th = MapMaker.generateMap(this.random.seed,param1 % 10 == 0);
         }
         var _loc3_:int = int(this.random.random() * 8);
         this.baseGunLocation = this.getBaseGunLocation(_loc3_);
         this.createPad(this.baseGunLocation,3);
         this.gproducers = this.getGlopProducers(_loc3_);
         if(this.random.random() < 0.5)
         {
            _loc8_ = 2 + int(this.random.random() * 7);
            this.gbActivateTime = int(8000 + 1080 * _loc8_);
            this.gbVolleyAmt = _loc8_;
            if(_loc3_ == 0 || _loc3_ == 6 || _loc3_ == 7)
            {
               this.gbDirection = GlopBlobProducerWave.SIDE_RIGHT;
            }
            else if(_loc3_ == 2 || _loc3_ == 3 || _loc3_ == 4)
            {
               this.gbDirection = GlopBlobProducerWave.SIDE_LEFT;
            }
            else if(_loc3_ == 1)
            {
               this.gbDirection = GlopBlobProducerWave.SIDE_BOTTOM;
            }
            else
            {
               this.gbDirection = GlopBlobProducerWave.SIDE_TOP;
            }
         }
         var _loc4_:Array = this.getTotemLocations(_loc3_);
         for each(_loc5_ in _loc4_)
         {
            this.createPad(_loc5_,1);
         }
         _loc6_ = this.getRiftLocation(_loc3_);
         _loc7_ = int(this.random.random() * 7);
         this.upgradeBoxes = this.getUpgradeBoxes(_loc3_,_loc7_);
         xml = <game>
					<places>
					<Totem>
					  <gameSpaceX>{_loc4_[0].x}</gameSpaceX>
					  <gameSpaceY>{_loc4_[0].y}</gameSpaceY>
					  <health>0</health>
					  <energyLevel>0</energyLevel>
					</Totem>
					<Totem>
					  <gameSpaceX>{_loc4_[1].x}</gameSpaceX>
					  <gameSpaceY>{_loc4_[1].y}</gameSpaceY>
					  <health>0</health>
					  <energyLevel>0</energyLevel>
					</Totem>
					<Totem>
					  <gameSpaceX>{_loc4_[2].x}</gameSpaceX>
					  <gameSpaceY>{_loc4_[2].y}</gameSpaceY>
					  <health>0</health>
					  <energyLevel>0</energyLevel>
					</Totem>
					</places>
					<specialplaces>
					<BaseGun>
					  <gameSpaceX>{this.baseGunLocation.x}</gameSpaceX>
					  <gameSpaceY>{this.baseGunLocation.y}</gameSpaceY>
					  <health>0</health>
					  <energyLevel>0</energyLevel>
					</BaseGun>
					<Rift>
					  <gameSpaceX>{_loc6_.x}</gameSpaceX>
					  <gameSpaceY>{_loc6_.y}</gameSpaceY>
					  <health>0</health>
					  <energyLevel>0</energyLevel>
					</Rift>
					</specialplaces>
					</game>;
      }
      
      private function createPad(param1:Point, param2:int) : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = this.th[param1.x + param1.y * 0];
         var _loc4_:int = param1.y - param2;
         while(_loc4_ <= param1.y + param2)
         {
            _loc5_ = param1.x - param2;
            while(_loc5_ <= param1.x + param2)
            {
               if(_loc5_ >= 0 && _loc4_ >= 0 && _loc5_ < GameSpace.WIDTH && _loc4_ < GameSpace.HEIGHT)
               {
                  this.th[_loc5_ + _loc4_ * 0] = _loc3_;
               }
               _loc5_++;
            }
            _loc4_++;
         }
      }
      
      private function isLegitUpgradeBoxLocation(param1:Array, param2:Point) : Boolean
      {
         var _loc6_:* = null;
         var _loc3_:int = this.baseGunLocation.x - param2.x;
         var _loc4_:int = this.baseGunLocation.y - param2.y;
         var _loc5_:int;
         if((_loc5_ = _loc3_ * _loc3_ + _loc4_ * _loc4_) < 400)
         {
            return false;
         }
         if(_loc5_ > 2000)
         {
            return false;
         }
         for each(_loc6_ in param1)
         {
            _loc3_ = _loc6_.x - param2.x;
            _loc4_ = _loc6_.y - param2.y;
            if((_loc5_ = _loc3_ * _loc3_ + _loc4_ * _loc4_) < 225)
            {
               return false;
            }
         }
         return true;
      }
      
      private function getUpgradeBoxes(param1:int, param2:int) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = null;
         var _loc11_:int = 0;
         var _loc3_:* = [];
         _loc4_ = 2;
         _loc5_ = 67;
         _loc6_ = 2;
         _loc7_ = 45;
         var _loc12_:int = 0;
         while(_loc12_ < param2)
         {
            _loc11_ = 0;
            do
            {
               _loc8_ = _loc4_ + int(this.random.random() * (_loc5_ - _loc4_));
               _loc9_ = _loc6_ + int(this.random.random() * (_loc7_ - _loc6_));
               _loc10_ = new Point(_loc8_,_loc9_);
               _loc11_++;
            }
            while(!this.isLegitUpgradeBoxLocation(_loc3_,_loc10_) && _loc11_ < 1000);
            
            _loc3_.push(_loc10_);
            _loc12_++;
         }
         return _loc3_;
      }
      
      private function getGlopProducers(param1:int) : Array
      {
         var _loc2_:* = [];
         if(param1 == 0)
         {
            _loc2_.push(new Point(x4,y2));
            _loc2_.push(new Point(x4,y3));
            _loc2_.push(new Point(x4,y4));
            _loc2_.push(new Point(x3,y4));
            _loc2_.push(new Point(x2,y4));
         }
         else if(param1 == 1)
         {
            _loc2_.push(new Point(x0,y4));
            _loc2_.push(new Point(x1,y4));
            _loc2_.push(new Point(x2,y4));
            _loc2_.push(new Point(x3,y4));
            _loc2_.push(new Point(x4,y4));
         }
         else if(param1 == 2)
         {
            _loc2_.push(new Point(x0,y2));
            _loc2_.push(new Point(x0,y3));
            _loc2_.push(new Point(x0,y4));
            _loc2_.push(new Point(x1,y4));
            _loc2_.push(new Point(x2,y4));
         }
         else if(param1 == 3)
         {
            _loc2_.push(new Point(x0,y0));
            _loc2_.push(new Point(x0,y1));
            _loc2_.push(new Point(x0,y2));
            _loc2_.push(new Point(x0,y3));
            _loc2_.push(new Point(x0,y4));
         }
         else if(param1 == 4)
         {
            _loc2_.push(new Point(x0,y0));
            _loc2_.push(new Point(x0,y1));
            _loc2_.push(new Point(x0,y2));
            _loc2_.push(new Point(x1,y0));
            _loc2_.push(new Point(x2,y0));
         }
         else if(param1 == 5)
         {
            _loc2_.push(new Point(x0,y0));
            _loc2_.push(new Point(x1,y0));
            _loc2_.push(new Point(x2,y0));
            _loc2_.push(new Point(x3,y0));
            _loc2_.push(new Point(x4,y0));
         }
         else if(param1 == 6)
         {
            _loc2_.push(new Point(x2,y0));
            _loc2_.push(new Point(x3,y0));
            _loc2_.push(new Point(x4,y0));
            _loc2_.push(new Point(x4,y1));
            _loc2_.push(new Point(x4,y2));
         }
         else if(param1 == 7)
         {
            _loc2_.push(new Point(x4,y0));
            _loc2_.push(new Point(x4,y1));
            _loc2_.push(new Point(x4,y2));
            _loc2_.push(new Point(x4,y3));
            _loc2_.push(new Point(x4,y4));
         }
         return _loc2_;
      }
      
      private function getBaseGunLocation(param1:int) : Point
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1 == 0)
         {
            _loc2_ = 5;
            _loc3_ = 5;
         }
         else if(param1 == 1)
         {
            _loc2_ = 35;
            _loc3_ = 5;
         }
         else if(param1 == 2)
         {
            _loc2_ = 65;
            _loc3_ = 5;
         }
         else if(param1 == 3)
         {
            _loc2_ = 65;
            _loc3_ = 24;
         }
         else if(param1 == 4)
         {
            _loc2_ = 65;
            _loc3_ = 43;
         }
         else if(param1 == 5)
         {
            _loc2_ = 35;
            _loc3_ = 43;
         }
         else if(param1 == 6)
         {
            _loc2_ = 5;
            _loc3_ = 43;
         }
         else if(param1 == 7)
         {
            _loc2_ = 5;
            _loc3_ = 24;
         }
         return new Point(_loc2_,_loc3_);
      }
      
      private function isLegitTotemLocation(param1:Array, param2:Point) : Boolean
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         for each(_loc3_ in param1)
         {
            _loc4_ = _loc3_.x - param2.x;
            _loc5_ = _loc3_.y - param2.y;
            if((_loc6_ = _loc4_ * _loc4_ + _loc5_ * _loc5_) < 400)
            {
               return false;
            }
         }
         return true;
      }
      
      private function getRiftLocation(param1:int) : Point
      {
         if(param1 == 0 || param1 == 6 || param1 == 7)
         {
            return new Point(47,24);
         }
         if(param1 == 2 || param1 == 3 || param1 == 4)
         {
            return new Point(17,24);
         }
         if(param1 == 1)
         {
            return new Point(35,35);
         }
         return new Point(35,12);
      }
      
      private function getTotemLocations(param1:int) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = null;
         var _loc10_:int = 0;
         var _loc2_:* = [];
         if(param1 == 0 || param1 == 6 || param1 == 7)
         {
            _loc3_ = 35;
            _loc4_ = 67;
            _loc5_ = 2;
            _loc6_ = 45;
         }
         else if(param1 == 2 || param1 == 3 || param1 == 4)
         {
            _loc3_ = 2;
            _loc4_ = 35;
            _loc5_ = 2;
            _loc6_ = 45;
         }
         else if(param1 == 1)
         {
            _loc3_ = 2;
            _loc4_ = 67;
            _loc5_ = 24;
            _loc6_ = 45;
         }
         else
         {
            _loc3_ = 2;
            _loc4_ = 67;
            _loc5_ = 2;
            _loc6_ = 24;
         }
         var _loc11_:int = 0;
         while(_loc11_ < 3)
         {
            _loc10_ = 0;
            do
            {
               _loc7_ = _loc3_ + int(this.random.random() * (_loc4_ - _loc3_));
               _loc8_ = _loc5_ + int(this.random.random() * (_loc6_ - _loc5_));
               _loc9_ = new Point(_loc7_,_loc8_);
               _loc10_++;
            }
            while(!this.isLegitTotemLocation(_loc2_,_loc9_) && _loc10_ < 1000);
            
            _loc2_.push(_loc9_);
            _loc11_++;
         }
         return _loc2_;
      }
      
      override public function getTerrainHeight() : Array
      {
         return this.th;
      }
      
      override public function getWallData() : Array
      {
         return [];
      }
      
      override public function getBackground() : int
      {
         return this.bg;
      }
      
      override public function gameStart() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = NaN;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         super.gameStart();
         GameSpace.instance.controlPanel.buildMenu.nodeButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.relayButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.energyStoreButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.logisticsButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.energyAmpButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.gunButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.areaGunButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.abmButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.droneBaseButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.thorsHammerButton.mystery = true;
         if(this.gameNumber <= 5)
         {
            _loc2_ = 3;
            _loc3_ = 100;
         }
         else if(this.gameNumber <= 10)
         {
            _loc2_ = 3;
            _loc3_ = 100;
         }
         else if(this.gameNumber <= 15)
         {
            _loc2_ = 3;
            _loc3_ = 75;
         }
         else if(this.gameNumber <= 20)
         {
            _loc2_ = 3;
            _loc3_ = 75;
         }
         else
         {
            _loc2_ = 3;
            _loc3_ = 50;
         }
         for each(_loc4_ in this.gproducers)
         {
            _loc1_ = new GlopProducer(_loc4_.x,_loc4_.y);
            _loc1_.productionBaseAmt = _loc2_;
            _loc1_.productionInterval = _loc3_;
            _loc1_.startTime = 100;
            GameSpace.instance.addGlopProducer(_loc1_);
         }
         for each(_loc5_ in this.upgradeBoxes)
         {
            new UpgradeBox(_loc5_.x,_loc5_.y);
         }
         if(this.gbActivateTime > 0)
         {
            _loc6_ = new GlopBlobProducer();
            _loc7_ = new GlopBlobProducerWave(this.gbActivateTime,this.gbVolleyAmt,1,36,0.3,this.gbDirection);
            _loc6_.waves.push(_loc7_);
            GameSpace.instance.glopBlobProducer = _loc6_;
         }
         Creeper.instance.gameScreen.playGameMusic(2,4);
         GameSpace.instance.baseGun.canMove = true;
      }
   }
}
