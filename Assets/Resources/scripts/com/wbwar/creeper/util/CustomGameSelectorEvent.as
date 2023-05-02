package com.wbwar.creeper.util
{
   import flash.events.Event;
   
   public class CustomGameSelectorEvent extends Event
   {
      
      public static const OVER:String = "com.wbwar.creeper.util.CustomGameSelector.OVER";
      
      public static const OUT:String = "com.wbwar.creeper.util.CustomGameSelector.OUT";
      
      public static const CLICKED:String = "com.wbwar.creeper.util.CustomGameSelector.CLICKED";
       
      
      public var cgs:CustomGameSelector;
      
      public var deleteGame:Boolean;
      
      public var resubmit:Boolean;
      
      public var score:Boolean;
      
      public function CustomGameSelectorEvent(param1:CustomGameSelector, param2:String = "com.wbwar.creeper.util.CustomGameSelector.CLICKED")
      {
         super(param2,true);
         this.cgs = param1;
      }
   }
}
