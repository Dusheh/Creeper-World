package com.wbwar.creeper
{
   import com.wbwar.creeper.util.ColorUtil;
   import com.wbwar.creeper.util.Text;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.utils.getQualifiedClassName;
   
   public final class MovePlaceSprite extends Sprite
   {
       
      
      private var weaponDistIndicator:WeaponDistIndicator;
      
      private var pathIndicator:Shape;
      
      private var awss:Shape;
      
      private var droneText:TextField;
      
      private var legal:Boolean;
      
      private var sourcePlace:Place;
      
      public function MovePlaceSprite()
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
         this.droneText = Text.text("DRONE CHARGING",10,16711680);
         this.droneText.filters = [new GlowFilter(0,1,2,2,2)];
         this.droneText.visible = false;
         addChild(this.droneText);
         this.droneText.x = -this.droneText.width / 2;
         this.droneText.y = -this.droneText.height - 12;
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
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
      
      private function refreshPathIndicator(param1:Boolean, param2:Place) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         this.pathIndicator.graphics.clear();
         if(param1 && !(param2 is DroneBase) && !(param2 is ThorsHammer && !param2.building))
         {
            _loc3_ = Place.getPossiblePaths(getQualifiedClassName(param2),x,y);
            this.pathIndicator.graphics.lineStyle(1,65280);
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
      
      public function refresh(param1:Boolean, param2:int, param3:int, param4:int, param5:Place) : void
      {
         var _loc6_:int = 0;
         var _loc7_:* = null;
         this.legal = param1;
         this.sourcePlace = param5;
         if(param5 is BaseGun)
         {
            _loc6_ = 0;
            this.weaponDistIndicator.visible = false;
         }
         else
         {
            _loc6_ = 0;
         }
         if(param1)
         {
            this.awss.graphics.clear();
            if(param5 is DroneBase)
            {
               this.awss.graphics.lineStyle(2,16711680);
               ColorUtil.drawArrow(this.awss.graphics,-10,-10,-5,-5);
               ColorUtil.drawArrow(this.awss.graphics,10,-10,5,-5);
               ColorUtil.drawArrow(this.awss.graphics,-10,10,-5,5);
               ColorUtil.drawArrow(this.awss.graphics,10,10,5,5);
               if((_loc7_ = param5 as DroneBase).energyLevel < DroneBase.DRONE_ENERGY_COST)
               {
                  this.droneText.visible = true;
                  this.droneText.text = "DRONE ALREADY DEPLOYED";
                  if(_loc7_.drones.length > 0)
                  {
                     if((_loc7_.drones[0] as Drone).state == Drone.STATE_LANDED)
                     {
                        this.droneText.text = "DRONE CHARGING";
                     }
                  }
                  this.droneText.x = -this.droneText.width / 2;
               }
               else
               {
                  this.droneText.visible = false;
               }
            }
            else
            {
               this.droneText.visible = false;
               this.awss.graphics.beginFill(16777136,0.3);
               this.awss.graphics.lineStyle(2,0);
               this.awss.graphics.drawRect(-_loc6_,-_loc6_,_loc6_ * 2,_loc6_ * 2);
               this.awss.graphics.endFill();
               this.awss.graphics.lineStyle(2,0);
               this.awss.graphics.moveTo(-_loc6_,-_loc6_);
               this.awss.graphics.lineTo(-_loc6_ + 5,-_loc6_ + 5);
               this.awss.graphics.moveTo(_loc6_,-_loc6_);
               this.awss.graphics.lineTo(_loc6_ - 5,-_loc6_ + 5);
               this.awss.graphics.moveTo(_loc6_,_loc6_);
               this.awss.graphics.lineTo(_loc6_ - 5,_loc6_ - 5);
               this.awss.graphics.moveTo(-_loc6_,_loc6_);
               this.awss.graphics.lineTo(-_loc6_ + 5,_loc6_ - 5);
            }
            if(!(param5 is BaseGun))
            {
               this.weaponDistIndicator.refresh(getQualifiedClassName(param5),param2,param3,param4);
               this.weaponDistIndicator.visible = true;
            }
         }
         else if(this.weaponDistIndicator.visible || param5 is BaseGun)
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
