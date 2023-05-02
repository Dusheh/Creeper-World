package com.wbwar.creeper.controlpanel.menu
{
   import com.wbwar.creeper.BaseGun;
   import com.wbwar.creeper.EnergyAmp;
   import com.wbwar.creeper.EnergyStorage;
   import com.wbwar.creeper.Logistics;
   import com.wbwar.creeper.Mine;
   import com.wbwar.creeper.Node;
   import com.wbwar.creeper.Place;
   import com.wbwar.creeper.Relay;
   import com.wbwar.creeper.Ruin;
   import com.wbwar.creeper.SurvivalPod;
   import com.wbwar.creeper.Tech;
   import com.wbwar.creeper.Totem;
   import com.wbwar.creeper.UpgradeBox;
   import com.wbwar.creeper.util.Text;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   
   public class CivControlMenu extends Sprite
   {
       
      
      private var _place:Place;
      
      private var titleText:TextField;
      
      private var descText:TextField;
      
      public function CivControlMenu()
      {
         super();
         this.titleText = Text.text("",12,16777215);
         this.titleText.filters = [new DropShadowFilter(2,45,65280)];
         this.titleText.y = 0;
         addChild(this.titleText);
         this.descText = Text.text("",9,16777215);
         this.descText.y = 17;
         addChild(this.descText);
      }
      
      public function set place(param1:Place) : void
      {
         this._place = param1;
         if(param1 is Node)
         {
            this.titleText.text = "Collector";
            this.descText.text = "Collects fractal space energy from surroundings.\nCollectors are the backbone of any successful network.";
         }
         else if(param1 is Relay)
         {
            this.titleText.text = "Relay";
            this.descText.text = "Form long range network connections to other relays.\nUseful for spanning valleys or creating shorter paths.";
         }
         else if(param1 is EnergyStorage)
         {
            this.titleText.text = "Energy Storage";
            this.descText.text = "Increases maximum energy reserves.\nProvides additional buffer for rapid building.";
         }
         else if(param1 is Logistics)
         {
            this.titleText.text = "Packet Speed";
            this.descText.text = "Increases speed of all packets on the network.\nUseful for rapid supply of packets over long distance.";
         }
         else if(param1 is EnergyAmp)
         {
            this.titleText.text = "Singularity Reactor";
            this.descText.text = "Utilizes fractal space singularities to produce energy.\nUseful for producing additional energy.";
         }
         else if(param1 is BaseGun)
         {
            this.titleText.text = "Odin City";
            this.descText.text = "Humanity\'s last hope for survival.\nProtect the city at ALL costs.";
         }
         else if(param1 is Totem)
         {
            this.titleText.text = "Rift Totem";
            this.descText.text = "Power all of these on a map to activate the Rift.\nMade of fractal alloy, totems are immune to Creeper.";
         }
         else if(param1 is UpgradeBox)
         {
            this.titleText.text = "Nanobot Deposit";
            this.descText.text = "Collect these to earn upgrades.\nCollect as many of these as possible.";
         }
         else if(param1 is Tech)
         {
            this.titleText.text = "Nano Schematics";
            this.descText.text = "Schematics for new technology.\nCollect these to rebuild our technology database.";
         }
         else if(param1 is Ruin)
         {
            this.titleText.text = "Ruin";
            this.descText.text = "Unknown artifact.";
         }
         else if(param1 is Mine)
         {
            this.titleText.text = "Mortar Mine";
            this.descText.text = "Stationary defense.  Explodes when creeper touches it.";
         }
         else if(param1 is SurvivalPod)
         {
            this.titleText.text = "Survival Pod";
            this.descText.text = "Escape pod from orbiting ship.\nMay contain living human survivors.";
         }
      }
      
      public function get place() : Place
      {
         return this._place;
      }
   }
}
