package com.wbwar.creeper
{
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   
   public class AddPlaceSprite extends Sprite
   {
       
      
      private var weaponDistIndicator:WeaponDistIndicator;
      
      private var pathIndicator:Shape;
      
      private var awss:Shape;
      
      private var legal:Boolean;
      
      private var sourcePlace:String;
      
      private var _placementSprite:Sprite;
      
      public function AddPlaceSprite()
      {
         super();
         mouseEnabled = false;
         this.pathIndicator = new Shape();
         addChild(this.pathIndicator);
         this.weaponDistIndicator = new WeaponDistIndicator();
         addChild(this.weaponDistIndicator);
         this.awss = new Shape();
         this.awss.filters = [new DropShadowFilter(2)];
         addChild(this.awss);
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function set placementSprite(param1:Sprite) : void
      {
         if(this._placementSprite != null)
         {
            removeChild(this._placementSprite);
         }
         this._placementSprite = param1;
         if(this._placementSprite != null)
         {
            addChild(param1);
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(visible)
         {
            if(this.sourcePlace != null)
            {
               this.refreshPathIndicator(this.legal,this.sourcePlace);
            }
         }
      }
      
      private function refreshPathIndicator(param1:Boolean, param2:String) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         this.pathIndicator.graphics.clear();
         if(param1)
         {
            _loc3_ = Place.getPossiblePaths(param2,x,y);
            for each(_loc4_ in _loc3_)
            {
               _loc5_ = _loc4_.x - x;
               _loc6_ = _loc4_.y - y;
               this.pathIndicator.graphics.lineStyle(3,0);
               this.pathIndicator.graphics.moveTo(0,0);
               this.pathIndicator.graphics.lineTo(_loc5_,_loc6_);
               this.pathIndicator.graphics.lineStyle(1,65280);
               this.pathIndicator.graphics.moveTo(0,0);
               this.pathIndicator.graphics.lineTo(_loc5_,_loc6_);
            }
         }
      }
      
      public function refresh(param1:Boolean, param2:String, param3:int, param4:int, param5:int) : void
      {
         var _loc6_:int = 0;
         this.legal = param1;
         this.sourcePlace = param2;
         if(param2 == "com.wbwar.creeper::ThorsHammer")
         {
            _loc6_ = 0;
         }
         else if(param2 == "com.wbwar.creeper::DroneBase")
         {
            _loc6_ = 0;
         }
         else
         {
            _loc6_ = 0;
         }
         if(param1)
         {
            this.weaponDistIndicator.refresh(param2,param3,param4,param5);
            this.awss.graphics.clear();
            this.awss.graphics.beginFill(16777136,0.3);
            this.awss.graphics.lineStyle(2,0);
            this.awss.graphics.drawRect(-_loc6_,-_loc6_,_loc6_ * 2,_loc6_ * 2);
            this.awss.graphics.endFill();
            this.weaponDistIndicator.visible = true;
         }
         else
         {
            this.awss.graphics.clear();
            this.awss.graphics.beginFill(16752800,0.3);
            this.awss.graphics.lineStyle(2,16711680);
            this.awss.graphics.drawRect(-_loc6_,-_loc6_,_loc6_ * 2,_loc6_ * 2);
            this.awss.graphics.endFill();
            this.weaponDistIndicator.visible = false;
         }
      }
   }
}
