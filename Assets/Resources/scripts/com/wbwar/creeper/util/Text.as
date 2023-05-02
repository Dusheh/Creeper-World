package com.wbwar.creeper.util
{
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class Text
   {
       
      
      public function Text()
      {
         super();
      }
      
      public static function text(param1:String, param2:uint, param3:uint, param4:String = "left") : TextField
      {
         var _loc6_:* = null;
         var _loc5_:TextField;
         (_loc5_ = new TextField()).mouseEnabled = false;
         _loc6_ = new TextFormat();
         if(param2 <= 8)
         {
            _loc6_.font = "befontsmall";
         }
         else
         {
            _loc6_.font = "befont";
         }
         _loc6_.color = param3;
         _loc6_.size = param2;
         _loc5_.embedFonts = true;
         if(param2 <= 8)
         {
            _loc5_.antiAliasType = AntiAliasType.NORMAL;
         }
         else
         {
            _loc5_.antiAliasType = AntiAliasType.ADVANCED;
         }
         if(param2 <= 8)
         {
            _loc5_.sharpness = 400;
         }
         else if(param2 <= 14)
         {
            _loc5_.sharpness = 200;
         }
         _loc5_.defaultTextFormat = _loc6_;
         _loc5_.autoSize = param4;
         _loc5_.selectable = false;
         _loc5_.mouseEnabled = false;
         if(param1 != null)
         {
            _loc5_.text = param1;
         }
         return _loc5_;
      }
   }
}
