package com.wbwar.creeper.util
{
   import flash.events.TimerEvent;
   
   public class Callback
   {
       
      
      public function Callback()
      {
         super();
      }
      
      public static function callback(param1:Function, param2:Number) : void
      {
         var _loc3_:DataTimer = new DataTimer(param2,1);
         _loc3_.data = param1;
         _loc3_.addEventListener(TimerEvent.TIMER_COMPLETE,onTimer);
         _loc3_.start();
      }
      
      private static function onTimer(param1:TimerEvent) : void
      {
         (param1.currentTarget as DataTimer).removeEventListener(TimerEvent.TIMER_COMPLETE,onTimer);
         var _loc2_:Object = (param1.currentTarget as DataTimer).data;
         if(_loc2_ != null)
         {
            _loc2_();
         }
      }
   }
}
