package com.wbwar.creeper.util
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class FlowContainer extends Sprite
   {
       
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      private var contentContainer:Sprite;
      
      private var content:Sprite;
      
      private var scrollBar:SliderBar;
      
      private var containerRect:Rectangle;
      
      private var currentY:int;
      
      public function FlowContainer(param1:int, param2:int)
      {
         super();
         this.WIDTH = param1;
         this.HEIGHT = param2;
         this.contentContainer = new Sprite();
         this.containerRect = new Rectangle(0,0,this.WIDTH - 16,this.HEIGHT);
         this.contentContainer.scrollRect = this.containerRect;
         addChild(this.contentContainer);
         this.content = new Sprite();
         this.contentContainer.addChild(this.content);
         this.scrollBar = new SliderBar(16777215,65280,this.HEIGHT - 9,0);
         this.scrollBar.rotation = 90;
         this.scrollBar.x = this.WIDTH - 2;
         this.scrollBar.y = 3;
         this.scrollBar.scaleY = 1.5;
         addChild(this.scrollBar);
         this.scrollBar.visible = false;
         this.scrollBar.addEventListener(SliderBar.SLIDER_CHANGING,this.onScrollbarChange);
         this.scrollBar.addEventListener(SliderBar.SLIDER_CHANGED,this.onScrollbarChange);
      }
      
      public function refresh() : void
      {
         this.onScrollbarChange(null);
      }
      
      public function addContent(param1:DisplayObject, param2:int = -1) : void
      {
         var _loc3_:int = 0;
         this.content.addChild(param1);
         param1.x = this.containerRect.width / 2 - param1.width / 2;
         param1.y = this.currentY;
         if(param2 < 0)
         {
            this.currentY += param1.height;
         }
         else
         {
            this.currentY += param2;
         }
         _loc3_ = this.content.height;
         if(_loc3_ - this.containerRect.height < 0)
         {
            _loc3_ = 0;
            this.scrollBar.visible = false;
         }
         else
         {
            this.scrollBar.visible = true;
            this.scrollBar.maxValue = _loc3_;
         }
      }
      
      public function removeAllContent() : void
      {
         var _loc1_:int = this.content.numChildren - 1;
         while(_loc1_ >= 0)
         {
            this.content.removeChildAt(_loc1_);
            _loc1_--;
         }
         this.currentY = 0;
      }
      
      private function onScrollbarChange(param1:Event) : void
      {
         this.content.y = -this.scrollBar.value;
      }
   }
}
