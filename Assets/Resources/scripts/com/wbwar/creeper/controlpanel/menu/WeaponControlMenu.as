package com.wbwar.creeper.controlpanel.menu
{
   import com.wbwar.creeper.ABM;
   import com.wbwar.creeper.AreaGun;
   import com.wbwar.creeper.DroneBase;
   import com.wbwar.creeper.Gun;
   import com.wbwar.creeper.Place;
   import com.wbwar.creeper.ThorsHammer;
   import com.wbwar.creeper.util.Text;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   
   public class WeaponControlMenu extends Sprite
   {
       
      
      private var checkForDone:Boolean;
      
      private var _place:Place;
      
      private var titleText:TextField;
      
      private var descText:TextField;
      
      private var currentLevelText:TextField;
      
      public function WeaponControlMenu()
      {
         super();
         this.titleText = Text.text("",12,16777215);
         this.titleText.filters = [new DropShadowFilter(2,45,16711680)];
         this.titleText.y = 0;
         addChild(this.titleText);
         this.currentLevelText = Text.text("",10,13684944);
         this.currentLevelText.filters = [new DropShadowFilter(2,45,65280)];
         this.currentLevelText.y = 1;
         addChild(this.currentLevelText);
         this.descText = Text.text("",9,16777215);
         this.descText.y = 17;
         addChild(this.descText);
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame,false,0,true);
      }
      
      public function set place(param1:Place) : void
      {
         this._place = param1;
         if(param1 is Gun)
         {
            this.titleText.text = "Blaster";
            this.descText.text = "Primary defense weapon.\nCannot fire at elevations higher than itself!";
         }
         else if(param1 is AreaGun)
         {
            this.titleText.text = "Mortar";
            this.descText.text = "Area effect weapon.  Can fire over walls.\nBest when used against dense creeper.";
         }
         else if(param1 is ABM)
         {
            this.titleText.text = "SAM";
            this.descText.text = "Surface to air missile launcher.\nDestroys incoming creeper spores.";
         }
         else if(param1 is DroneBase)
         {
            this.titleText.text = "Drone Base";
            this.descText.text = "Powerful drone bomber. Good for air to ground support.\nMust be manually targeted.";
         }
         else if(param1 is ThorsHammer)
         {
            this.titleText.text = "Thor";
            this.descText.text = "The ultimate weapon.";
         }
         if(this._place.building && !this._place.upgrading)
         {
            this.currentLevelText.text = "[Constructing...]";
            this.currentLevelText.x = this.titleText.x + this.titleText.width + 3;
            this.checkForDone = true;
         }
         else if(this._place.upgrading)
         {
            this.currentLevelText.text = "[Upgrading...]";
            this.currentLevelText.x = this.titleText.x + this.titleText.width + 3;
            this.checkForDone = true;
         }
         else
         {
            this.currentLevelText.text = "";
         }
      }
      
      public function get place() : Place
      {
         return this._place;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this._place != null)
         {
            if(!this._place.upgrading && !this._place.building && this.checkForDone)
            {
               this.place = this.place;
            }
         }
      }
   }
}
