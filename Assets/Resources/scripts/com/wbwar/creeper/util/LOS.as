package com.wbwar.creeper.util
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.games.Game;
   
   public class LOS
   {
       
      
      public function LOS()
      {
         super();
      }
      
      public static function hasLOS(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:Boolean, param7:Boolean = false) : Boolean
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:Number;
         var _loc17_:Number = (_loc16_ = GameSpace.instance.terrain.terrainHeight[param1 + param2 * 0]) + 0;
         var _loc18_:Number;
         var _loc19_:Number = (_loc18_ = GameSpace.instance.terrain.terrainHeight[param3 + param4 * 0]) - _loc17_;
         var _loc20_:Number = _loc17_;
         _loc14_ = param1;
         _loc15_ = param2;
         _loc8_ = param3 - param1;
         _loc9_ = param4 - param2;
         _loc11_ = _loc8_ > 0 ? 1 : -1;
         _loc12_ = _loc9_ > 0 ? 1 : -1;
         _loc8_ = _loc8_ < 0 ? int(-_loc8_) : int(_loc8_);
         _loc9_ = _loc9_ < 0 ? int(-_loc9_) : int(_loc9_);
         if(_loc8_ > _loc9_)
         {
            _loc19_ /= _loc8_;
            _loc13_ = _loc8_ / 2;
            _loc10_ = 1;
            while(_loc10_ <= _loc8_)
            {
               _loc14_ += _loc11_;
               if((_loc13_ += _loc9_) >= _loc8_)
               {
                  _loc13_ -= _loc8_;
                  _loc15_ += _loc12_;
               }
               if(param7)
               {
                  if(GameSpace.instance.walls.wallData[_loc14_ + _loc15_ * 0] > 100000)
                  {
                     return false;
                  }
               }
               else if(GameSpace.instance.walls.wallData[_loc14_ + _loc15_ * 0] > 0)
               {
                  return false;
               }
               if(!param5)
               {
                  if(param6)
                  {
                     if(GameSpace.instance.terrain.terrainHeight[_loc14_ + _loc15_ * 0] != _loc16_)
                     {
                        return false;
                     }
                  }
                  else if(GameSpace.instance.terrain.terrainHeight[_loc14_ + _loc15_ * 0] > _loc16_)
                  {
                     return false;
                  }
               }
               _loc20_ += _loc19_;
               _loc10_++;
            }
         }
         else
         {
            _loc19_ /= _loc9_;
            _loc13_ = _loc9_ / 2;
            _loc10_ = 1;
            while(_loc10_ <= _loc9_)
            {
               _loc15_ += _loc12_;
               if((_loc13_ += _loc8_) >= _loc9_)
               {
                  _loc13_ -= _loc9_;
                  _loc14_ += _loc11_;
               }
               if(param7)
               {
                  if(GameSpace.instance.walls.wallData[_loc14_ + _loc15_ * 0] > 100000)
                  {
                     return false;
                  }
               }
               else if(GameSpace.instance.walls.wallData[_loc14_ + _loc15_ * 0] > 0)
               {
                  return false;
               }
               if(!param5)
               {
                  if(param6)
                  {
                     if(GameSpace.instance.terrain.terrainHeight[_loc14_ + _loc15_ * 0] != _loc16_)
                     {
                        return false;
                     }
                  }
                  else if(GameSpace.instance.terrain.terrainHeight[_loc14_ + _loc15_ * 0] > _loc16_)
                  {
                     return false;
                  }
               }
               _loc20_ += _loc19_;
               _loc10_++;
            }
         }
         return true;
      }
   }
}
