package com.wbwar.creeper.util
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   
   public class CustomGameSelectorSortBar extends Sprite
   {
      
      public static const EVENT_SORTCHANGED:String = "SortChanged";
       
      
      public var numberTriangle:SortTriangle;
      
      public var titleTriangle:SortTriangle;
      
      public var playCountTriangle:SortTriangle;
      
      public var scoreTriangle:SortTriangle;
      
      public function CustomGameSelectorSortBar()
      {
         var _loc2_:* = null;
         super();
         graphics.lineStyle(1,16777215);
         graphics.beginFill(5263440);
         graphics.drawRect(0,0,CustomGameSelector.WIDTH,CustomGameSelector.HEIGHT);
         graphics.endFill();
         var _loc1_:TextField = Text.text("#",18,10535167);
         addChild(_loc1_);
         _loc1_.x = 2;
         _loc1_.y = int(0 - _loc1_.height / 2);
         this.numberTriangle = new SortTriangle(this,50,25);
         addChild(this.numberTriangle);
         this.numberTriangle.x = 0;
         this.numberTriangle.y = _loc1_.y;
         _loc2_ = Text.text("TITLE",18,14671839);
         addChild(_loc2_);
         _loc2_.x = 50;
         _loc2_.y = int(0 - _loc2_.height / 2);
         this.titleTriangle = new SortTriangle(this,-230,60);
         addChild(this.titleTriangle);
         this.titleTriangle.x = 50;
         this.titleTriangle.y = _loc2_.y;
         var _loc3_:TextField = Text.text("PLAYS",18,14671839);
         addChild(_loc3_);
         _loc3_.x = -160 - _loc3_.width;
         _loc3_.y = int(0 - _loc3_.height / 2);
         this.playCountTriangle = new SortTriangle(this,80,65);
         addChild(this.playCountTriangle);
         this.playCountTriangle.x = _loc3_.x;
         this.playCountTriangle.y = _loc3_.y;
         var _loc4_:TextField = Text.text("SCORE",18,14671839);
         addChild(_loc4_);
         _loc4_.x = -70 - _loc4_.width;
         _loc4_.y = int(0 - _loc4_.height / 2);
         this.scoreTriangle = new SortTriangle(this,0 - _loc4_.x,70);
         addChild(this.scoreTriangle);
         this.scoreTriangle.x = _loc4_.x;
         this.scoreTriangle.y = _loc4_.y;
         useHandCursor = true;
         buttonMode = true;
      }
      
      public function clearAllSorts(param1:SortTriangle) : void
      {
         if(param1 != this.numberTriangle)
         {
            this.numberTriangle.state = SortTriangle.STATE_NONE;
         }
         if(param1 != this.titleTriangle)
         {
            this.titleTriangle.state = SortTriangle.STATE_NONE;
         }
         if(param1 != this.playCountTriangle)
         {
            this.playCountTriangle.state = SortTriangle.STATE_NONE;
         }
         if(param1 != this.scoreTriangle)
         {
            this.scoreTriangle.state = SortTriangle.STATE_NONE;
         }
      }
      
      public function sortChanged() : void
      {
         dispatchEvent(new Event(EVENT_SORTCHANGED));
      }
   }
}
