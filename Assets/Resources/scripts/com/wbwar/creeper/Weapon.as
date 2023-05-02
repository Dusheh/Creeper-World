package com.wbwar.creeper
{
   import com.wbwar.creeper.util.Graph;
   
   public class Weapon extends MovingPlace
   {
      
      private static const WIDTH:int = GameSpace.WIDTH;
      
      private static const HEIGHT:int = GameSpace.HEIGHT;
      
      private static const MIN_HEAT:Number = Glop.MIN_HEAT;
       
      
      protected var damageAmt:Number = 0.05;
      
      protected var damaged:Boolean = false;
      
      public function Weapon(param1:int, param2:int)
      {
         super(param1,param2);
         if(false)
         {
            this.places = GameSpace.instance.places;
         }
         if(false)
         {
            hookUp();
         }
      }
      
      public static function damageGlop(param1:int, param2:int, param3:int, param4:int, param5:Number, param6:Number) : void
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc15_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = param4 * param4;
         var _loc16_:Number = GameSpace.instance.terrain.terrainHeight[param1 + param2 * 0];
         var _loc17_:Array = GameSpace.instance.places.gameSpace.glop.data;
         _loc7_ = 0;
         while(_loc7_ < param4)
         {
            _loc8_ = param1 - _loc7_;
            while(_loc8_ <= param1 + _loc7_)
            {
               if(_loc8_ >= 0 && _loc8_ < WIDTH)
               {
                  _loc9_ = param2 - _loc7_;
                  if((_loc10_ = (_loc8_ - param1) * (_loc8_ - param1) + (_loc9_ - param2) * (_loc9_ - param2)) < _loc14_)
                  {
                     if(_loc9_ >= 0 && _loc9_ < HEIGHT)
                     {
                        if(GameSpace.instance.terrain.terrainHeight[_loc8_ + _loc9_ * 0] <= _loc16_)
                        {
                           if(_loc17_[_loc8_ + _loc9_ * WIDTH] >= MIN_HEAT)
                           {
                              GameSpace.instance.glop.addGlop(_loc8_,_loc9_,param5);
                              GameSpace.instance.mistLayer.addMistRandom(_loc8_,_loc9_,param6);
                              _loc15_++;
                              if(_loc15_ >= param3)
                              {
                                 return;
                              }
                           }
                        }
                     }
                     if((_loc9_ = param2 + _loc7_) >= 0 && _loc9_ < HEIGHT)
                     {
                        if(GameSpace.instance.terrain.terrainHeight[_loc8_ + _loc9_ * 0] <= _loc16_)
                        {
                           if(_loc17_[_loc8_ + _loc9_ * WIDTH] >= MIN_HEAT)
                           {
                              GameSpace.instance.glop.addGlop(_loc8_,_loc9_,param5);
                              GameSpace.instance.mistLayer.addMistRandom(_loc8_,_loc9_,param6);
                              _loc15_++;
                              if(_loc15_ >= param3)
                              {
                                 return;
                              }
                           }
                        }
                     }
                  }
               }
               _loc8_++;
            }
            _loc9_ = param2 - _loc7_ + 1;
            while(_loc9_ <= param2 + _loc7_ - 1)
            {
               if(_loc9_ >= 0 && _loc9_ < HEIGHT)
               {
                  if((_loc10_ = ((_loc8_ = param1 - _loc7_) - param1) * (_loc8_ - param1) + (_loc9_ - param2) * (_loc9_ - param2)) < _loc14_)
                  {
                     if(_loc8_ >= 0 && _loc8_ < WIDTH)
                     {
                        if(GameSpace.instance.terrain.terrainHeight[_loc8_ + _loc9_ * 0] <= _loc16_)
                        {
                           if(_loc17_[_loc8_ + _loc9_ * WIDTH] >= MIN_HEAT)
                           {
                              GameSpace.instance.glop.addGlop(_loc8_,_loc9_,param5);
                              GameSpace.instance.mistLayer.addMistRandom(_loc8_,_loc9_,param6);
                              _loc15_++;
                              if(_loc15_ >= param3)
                              {
                                 return;
                              }
                           }
                        }
                     }
                     if((_loc8_ = param1 + _loc7_) >= 0 && _loc8_ < WIDTH)
                     {
                        if(GameSpace.instance.terrain.terrainHeight[_loc8_ + _loc9_ * 0] <= _loc16_)
                        {
                           if(_loc17_[_loc8_ + _loc9_ * WIDTH] >= MIN_HEAT && _loc10_ < _loc13_)
                           {
                              GameSpace.instance.glop.addGlop(_loc8_,_loc9_,param5);
                              GameSpace.instance.mistLayer.addMistRandom(_loc8_,_loc9_,param6);
                              _loc15_++;
                              if(_loc15_ >= param3)
                              {
                                 return;
                              }
                           }
                        }
                     }
                  }
               }
               _loc9_++;
            }
            _loc7_++;
         }
      }
      
      override public function destroy(param1:Boolean = false) : void
      {
         super.destroy();
      }
      
      private function calculateDamage() : Boolean
      {
         var _loc1_:Number = NaN;
         var _loc4_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:int = -1;
         while(_loc3_ <= 1)
         {
            _loc4_ = -1;
            while(_loc4_ <= 1)
            {
               _loc1_ = GameSpace.instance.glop.data[gameSpaceX + _loc4_ + (gameSpaceY + _loc3_) * 0];
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
               _loc4_++;
            }
            _loc3_++;
         }
         if(!_loc2_ && !building)
         {
            health += 0.01;
            if(health > maxHealth)
            {
               health = maxHealth;
            }
         }
         return _loc2_;
      }
      
      override public function update() : void
      {
         var _loc1_:* = null;
         super.update();
         if(updateCount % 30 == 0)
         {
            if(turnedOn)
            {
               _loc1_ = Graph.astar(GameSpace.instance.places,this,GameSpace.instance.baseGun);
               if(_loc1_ == null)
               {
                  requestEnergy = false;
               }
               else
               {
                  requestEnergy = true;
               }
            }
         }
         if(state == STATE_PLACED)
         {
            this.damaged = this.calculateDamage();
         }
      }
      
      public function sell() : void
      {
         places.removePlace(this);
      }
   }
}
