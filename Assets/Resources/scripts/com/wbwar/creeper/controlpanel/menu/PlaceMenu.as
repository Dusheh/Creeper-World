package com.wbwar.creeper.controlpanel.menu
{
   import com.wbwar.creeper.ABM;
   import com.wbwar.creeper.AreaGun;
   import com.wbwar.creeper.BaseGun;
   import com.wbwar.creeper.DroneBase;
   import com.wbwar.creeper.Gun;
   import com.wbwar.creeper.Place;
   import com.wbwar.creeper.ThorsHammer;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   
   public class PlaceMenu extends Sprite
   {
       
      
      public var placeControlMenu:PlaceControlMenu;
      
      public var civControlMenu:CivControlMenu;
      
      public var weaponControlMenu:WeaponControlMenu;
      
      private var _place:Place;
      
      public function PlaceMenu()
      {
         super();
         mouseEnabled = false;
         this.placeControlMenu = new PlaceControlMenu();
         addChild(this.placeControlMenu);
         this.civControlMenu = new CivControlMenu();
         this.civControlMenu.x = 75;
         addChild(this.civControlMenu);
         this.civControlMenu.visible = false;
         this.weaponControlMenu = new WeaponControlMenu();
         this.weaponControlMenu.x = 75;
         addChild(this.weaponControlMenu);
         this.weaponControlMenu.visible = false;
      }
      
      public function set place(param1:Place) : void
      {
         this._place = param1;
         if(param1 is BaseGun)
         {
            this.civControlMenu.place = param1;
            this.weaponControlMenu.visible = false;
            this.civControlMenu.visible = true;
         }
         else if(param1 is Gun || param1 is AreaGun || param1 is ABM || param1 is DroneBase || param1 is ThorsHammer)
         {
            this.weaponControlMenu.place = param1;
            this.weaponControlMenu.visible = true;
            this.civControlMenu.visible = false;
         }
         else
         {
            this.civControlMenu.place = param1;
            this.weaponControlMenu.visible = false;
            this.civControlMenu.visible = true;
         }
         this.placeControlMenu.place = param1;
      }
      
      public function get place() : Place
      {
         return this._place;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         if(param1)
         {
            Creeper.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false,0,true);
         }
         else
         {
            Creeper.instance.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         }
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(this.weaponControlMenu.visible)
         {
            if(param1.keyCode == 81)
            {
               if(this.placeControlMenu.turnOnOffButton.visible)
               {
                  this.placeControlMenu.onTurnOnOffButtonClick(null);
               }
            }
            else if(param1.keyCode == 65)
            {
               if(this.placeControlMenu.armDisarmButton.visible)
               {
                  this.placeControlMenu.onArmDisarmButtonClick(null);
               }
            }
         }
         if(param1.keyCode == 88)
         {
            if(this.placeControlMenu.destroyButton.visible)
            {
               this.placeControlMenu.onDestroyButtonClick(null);
            }
         }
      }
   }
}
