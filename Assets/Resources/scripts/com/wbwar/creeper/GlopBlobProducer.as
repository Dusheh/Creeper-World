package com.wbwar.creeper
{
   import flash.media.Sound;
   
   public final class GlopBlobProducer
   {
      
      private static const STATE_WAITING:int = 0;
      
      private static const STATE_FIRING:int = 1;
      
      private static const STATE_VOLLEYWAITING:int = 2;
       
      
      private var updateCount:int;
      
      private var waveIndex:int;
      
      private var currentWaveUpdateCount:int;
      
      private var volleyUpdateCount:int;
      
      private var currentWave:GlopBlobProducerWave;
      
      private var state:int;
      
      private var volleyIndex:int;
      
      public var waves:Array;
      
      public function GlopBlobProducer()
      {
         this.waves = [];
         super();
      }
      
      public function get remainingTime() : int
      {
         var _loc1_:int = 0;
         if(this.currentWave != null)
         {
            _loc1_ = this.currentWave.activateTime - this.currentWaveUpdateCount;
            if(_loc1_ < 0)
            {
               _loc1_ = 0;
            }
            return _loc1_;
         }
         return 0;
      }
      
      public function update() : void
      {
         var _loc1_:* = null;
         if(this.currentWave == null && this.waves.length > 0)
         {
            this.currentWave = this.waves[this.waveIndex];
            ++this.waveIndex;
         }
         if(this.currentWave != null)
         {
            if(this.state == STATE_WAITING)
            {
               if(this.currentWaveUpdateCount >= this.currentWave.activateTime)
               {
                  this.state = STATE_FIRING;
                  _loc1_ = new AirAttackSound();
                  _loc1_.play();
                  this.volleyIndex = 0;
               }
            }
            else if(this.state == STATE_FIRING)
            {
               this.fireVolley(this.currentWave.volleyGroupSize);
               ++this.volleyIndex;
               if(this.volleyIndex >= this.currentWave.volleyAmt)
               {
                  this.state = STATE_WAITING;
                  this.currentWaveUpdateCount = 0;
                  this.nextWave();
               }
               else
               {
                  this.state = STATE_VOLLEYWAITING;
                  this.volleyUpdateCount = 0;
               }
            }
            else if(this.state == STATE_VOLLEYWAITING)
            {
               if(this.volleyUpdateCount >= this.currentWave.volleyDelay)
               {
                  this.state = STATE_FIRING;
               }
               ++this.volleyUpdateCount;
            }
            ++this.currentWaveUpdateCount;
         }
         ++this.updateCount;
      }
      
      private function nextWave() : void
      {
         if(this.waveIndex < this.waves.length)
         {
            this.currentWave = this.waves[this.waveIndex];
         }
         ++this.waveIndex;
      }
      
      private function fireVolley(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1)
         {
            this.produceBlob();
            _loc2_++;
         }
      }
      
      private function produceBlob() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc1_:* = [];
         var _loc3_:int = GameSpace.instance.places.placesLayer.numChildren - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = GameSpace.instance.places.placesLayer.getChildAt(_loc3_) as Place;
            if(!_loc2_.building && (_loc2_ is Node || _loc2_ is Relay))
            {
               _loc1_.push(_loc2_);
            }
            _loc3_--;
         }
         if(this.currentWave.volleySide == GlopBlobProducerWave.SIDE_LEFT)
         {
            _loc4_ = -20;
            _loc5_ = 20 + Math.random() * 0 * 0 - 40;
         }
         else if(this.currentWave.volleySide == GlopBlobProducerWave.SIDE_RIGHT)
         {
            _loc4_ = 0 * 0 + 20;
            _loc5_ = 20 + Math.random() * 0 * 0 - 40;
         }
         else if(this.currentWave.volleySide == GlopBlobProducerWave.SIDE_TOP)
         {
            _loc4_ = 20 + Math.random() * 0 * 0 - 40;
            _loc5_ = -20;
         }
         else if(this.currentWave.volleySide == GlopBlobProducerWave.SIDE_BOTTOM)
         {
            _loc4_ = 20 + Math.random() * 0 * 0 - 40;
            _loc5_ = 0 * 0 + 20;
         }
         if(_loc1_.length > 0)
         {
            _loc6_ = int(Math.random() * _loc1_.length);
            _loc7_ = _loc1_[_loc6_] as Place;
            new GlopBlob(_loc4_,_loc5_,_loc7_.x + Math.random() * 40 - 20,_loc7_.y + Math.random() * 40 - 20,this.currentWave.volleyStrength,1);
         }
         else
         {
            new GlopBlob(_loc4_,_loc5_,Math.random() * 700,Math.random() * 480,this.currentWave.volleyStrength,1);
         }
      }
   }
}
