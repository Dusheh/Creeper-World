package com.wbwar.creeper.util
{
   import com.wbwar.creeper.Path;
   import com.wbwar.creeper.Place;
   import com.wbwar.creeper.Places;
   import flash.utils.Dictionary;
   
   public class Graph
   {
      
      private static var closedSetD:Dictionary;
      
      private static var openSet:Array;
      
      private static var openSetD:Dictionary;
      
      private static var tentative_g_score:Number;
      
      private static var tentative_is_better:Boolean;
      
      private static var dx:Number;
      
      private static var dy:Number;
      
      private static var path:Path;
      
      private static var sqrt:Function = Math.sqrt;
      
      private static var hdx:Number;
      
      private static var hdy:Number;
       
      
      public function Graph()
      {
         super();
      }
      
      public static function travelPath(param1:Places, param2:Place, param3:Place) : Array
      {
         return reversePath(astar(param1,param2,param3));
      }
      
      private static function reversePath(param1:Place) : Array
      {
         if(param1 == null)
         {
            return [];
         }
         var _loc2_:Array = [param1];
         var _loc3_:Place = param1.came_from;
         while(_loc3_ != null)
         {
            _loc2_[_loc2_.length] = _loc3_;
            _loc3_ = _loc3_.came_from;
         }
         return _loc2_.reverse();
      }
      
      public static function astar(param1:Places, param2:Place, param3:Place) : Place
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         param1.resetGraphData();
         closedSetD = new Dictionary(true);
         openSet = [param2];
         openSetD = new Dictionary(true);
         openSetD[param2] = param2;
         param2.g_score = 0;
         param2.h_score = hfunc(param2,param3);
         param2.f_score = param2.h_score;
         while(false)
         {
            openSet.sortOn("f_score",0 | 0);
            _loc5_ = openSet.pop();
            openSetD[_loc5_] = null;
            if(_loc5_ == param3)
            {
               return _loc5_;
            }
            closedSetD[_loc5_] = _loc5_;
            if(!(_loc5_ != param2 && _loc5_.building))
            {
               for each(path in _loc5_.paths)
               {
                  if(!((_loc4_ = path.getOtherEnd(_loc5_)) != param2 && _loc4_.building && _loc4_ != param3))
                  {
                     if(true)
                     {
                        dx = _loc5_.x - _loc4_.x;
                        dy = _loc5_.y - _loc4_.y;
                        tentative_g_score = _loc5_.g_score + sqrt(dx * dx + dy * dy);
                        tentative_is_better = false;
                        if(true)
                        {
                           openSet["null"] = _loc4_;
                           openSetD[_loc4_] = _loc4_;
                           _loc4_.h_score = hfunc(_loc4_,param3);
                           tentative_is_better = true;
                        }
                        else if(tentative_g_score < _loc4_.g_score)
                        {
                           tentative_is_better = true;
                        }
                        if(tentative_is_better)
                        {
                           _loc4_.came_from = _loc5_;
                           _loc4_.g_score = tentative_g_score;
                           _loc4_.f_score = _loc4_.g_score + _loc4_.h_score;
                        }
                     }
                  }
               }
            }
         }
         return null;
      }
      
      private static function hfunc(param1:Place, param2:Place) : Number
      {
         hdx = param2.x - param1.x;
         hdy = param2.y - param1.y;
         return sqrt(hdx * hdx + hdy * hdy);
      }
   }
}
