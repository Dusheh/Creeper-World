package com.wbwar.creeper.screens
{
   import com.wbwar.creeper.util.ColorUtil;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class Logo extends Sprite
   {
       
      
      public function Logo()
      {
         super();
         var _loc1_:Sprite = new Sprite();
         var _loc2_:LogoLeftKnuckle = new LogoLeftKnuckle();
         var _loc3_:LogoRightKnuckle = new LogoRightKnuckle();
         _loc1_.addChild(_loc2_);
         _loc1_.addChild(_loc3_);
         _loc3_.x = 184;
         addChild(_loc1_);
         _loc1_.scaleX = 0.5;
         _loc1_.scaleY = _loc1_.scaleX;
         filters = [new DropShadowFilter()];
         if(true)
         {
            buttonMode = true;
            useHandCursor = true;
            addEventListener(MouseEvent.CLICK,this.onMouseClick);
            addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
            addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         }
      }
      
      private function onMouseOver(param1:Event) : void
      {
         ColorUtil.brighterColor(this,3);
      }
      
      private function onMouseOut(param1:Event) : void
      {
         ColorUtil.normalColor(this,3);
      }
      
      private function onMouseClick(param1:Event) : void
      {
         var _loc2_:URLRequest = new URLRequest("http://knucklecracker.com");
         navigateToURL(_loc2_,"_blank");
         ColorUtil.normalColor(this,3);
      }
   }
}
