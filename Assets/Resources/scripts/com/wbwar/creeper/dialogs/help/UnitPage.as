package com.wbwar.creeper.dialogs.help
{
   import com.wbwar.creeper.BaseGun;
   import com.wbwar.creeper.util.Text;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   
   public class UnitPage extends Sprite
   {
       
      
      private var WIDTH:int;
      
      private var HEIGHT:int;
      
      private var titleTextField:TextField;
      
      private var textField:TextField;
      
      public function UnitPage(param1:String, param2:int, param3:int)
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         super();
         this.WIDTH = param2;
         this.HEIGHT = param3;
         if(param1 == "BaseGun")
         {
            _loc4_ = BaseGun.getHelpImage();
            addChild(_loc4_);
            _loc4_.x = this.WIDTH / 2;
            _loc4_.y = 50;
            _loc4_.scaleX = 2;
            _loc4_.scaleY = _loc4_.scaleX;
         }
         else if(param1 != "")
         {
            _loc4_ = getDefinitionByName("com.wbwar.creeper." + param1)["getPlacementSprite"](false);
            addChild(_loc4_);
            _loc4_.x = this.WIDTH / 2;
            _loc4_.y = 50;
            _loc4_.scaleX = 4;
            _loc4_.scaleY = _loc4_.scaleX;
         }
         else
         {
            _loc5_ = Text.text("?",48,16777215);
            addChild(_loc5_);
            _loc5_.x = this.WIDTH / 2 - _loc5_.width / 2;
            _loc5_.y = 50 - _loc5_.height / 2;
         }
         this.titleTextField = Text.text("",24,16777215);
         this.titleTextField.filters = [new GlowFilter(0,1,2,2,3,1)];
         addChild(this.titleTextField);
         this.titleTextField.x = 5;
         if(param1 == "BaseGun")
         {
            this.titleTextField.y = 100;
         }
         else
         {
            this.titleTextField.y = 80;
         }
         this.textField = Text.text("",14,16777215);
         this.textField.filters = [new GlowFilter(0,1,2,2,3,1)];
         addChild(this.textField);
         this.textField.x = 5;
         if(param1 == "BaseGun")
         {
            this.textField.y = 130;
         }
         else
         {
            this.textField.y = 110;
         }
         this.textField.wordWrap = true;
         this.textField.width = this.WIDTH - 10;
         if(param1 == "")
         {
            this.setUnknown();
         }
         else
         {
            this["setText" + param1]();
         }
      }
      
      private function setTextNode() : void
      {
         this.titleTextField.text = "Collector";
         this.titleTextField.x = this.WIDTH / 2 - this.titleTextField.width / 2;
         this.textField.text = "The Collector is your primary means of getting energy.  With energy you build and power everything.  Without energy, you wither and die.  Collectors operate by tapping into fractal space and extracting energy from infinite recursive space-time.  Sadly, Collectors only have a limited discernment resolution so they can\'t extract infinite energy from a single point.  In other words, they need area to operate.  Collectors should be spaced apart so that each has the maximum area from which to collect energy.  Overlapping Collectors is inefficient.  Also Collectors need to send their energy somewhere, so there must be some path from a Collector back to Odin City for the collector to operate.  If a Collector goes offline, nothing bad happens to the Collector, you just don\'t get any energy from it until it is reconnected to the network.";
      }
      
      private function setTextRelay() : void
      {
         this.titleTextField.text = "Relay";
         this.titleTextField.x = this.WIDTH / 2 - this.titleTextField.width / 2;
         this.textField.text = "Relays allow you to extend your network over great distances.  Sometimes irregular terrain can best be dealt with by just Relay\'ing over it.  Note that Relays will only form long range connections with other Relays.  So to build only one Relay never makes any sense.  Build at least two to gain its benefits.  Also note that Relays can also be useful for creating more direct routes in your network for packets.";
      }
      
      private function setTextEnergyStorage() : void
      {
         this.titleTextField.text = "Storage";
         this.titleTextField.x = this.WIDTH / 2 - this.titleTextField.width / 2;
         this.textField.text = "Energy Storage is useful for increasing Odin City\'s reserve of raw energy.  The energy from Collectors is sent to Odin City where it is held and used to create packets for construction, weapons and Totem charging.  But, Odin City can only store so much energy.  Build Storage to increase this capacity.  Increasing energy capacity can be a key advantage in certain energy intensive situations.";
      }
      
      private function setTextLogistics() : void
      {
         this.titleTextField.text = "Speed";
         this.titleTextField.x = this.WIDTH / 2 - this.titleTextField.width / 2;
         this.textField.text = "Packet Speed drivers inject Higgs particles directly onto your network.  The result is improved propagation speed for all packets.  Any large base with any sustained military campaign will require several Speed drivers to operate efficiently.  By building Speed drivers, weapons stay better armed and building new structures at a distance can go faster.";
      }
      
      private function setTextEnergyAmp() : void
      {
         this.titleTextField.text = "Reactor";
         this.titleTextField.x = this.WIDTH / 2 - this.titleTextField.width / 2;
         this.textField.text = "Singularity Reactors use a stream of temporary black holes to drastically improve on the discernment resolution of Collector technology.  As such, they can produce energy from single points in space time.  This technology is expensive, though, so it is always better to build collectors when possible.  But sometimes Odin City needs more energy than can be produced by the available land area.  When this is the case, build farms of Reactors to meet the energy needs.";
      }
      
      private function setTextGun() : void
      {
         this.titleTextField.text = "Blaster";
         this.titleTextField.x = this.WIDTH / 2 - this.titleTextField.width / 2;
         this.textField.text = "Blasters are the primary defense weapon in Odin City\'s arsenal.  Blasters utilize the absolute latest in heavy boson particle beam technology to produce a beam that will incinerate any Creeper at which it fires.  Additionally, Blasters employ tachyon enhanced rotational turrets for near instant turret rotation.  Blasters do have two weaknesses.  First, Blasters can only fire at their current elevation or lower.  Blasters can\'t fire at higher terrain!  Because of this, Blasters at the base of a hill will only be able to fire at Creeper as it flows off of the hill.  As such, wise Commanders will fight to get Blasters on high ground.  The second weakness is that Blasters can only damage Creeper down to a fixed depth.  So using Blasters on deep pools or large tidal fronts of Creeper will prove only marginally effective.  It is best to use Blasters on thinner Creeper where it is most effective.";
      }
      
      private function setTextAreaGun() : void
      {
         this.titleTextField.text = "Mortar";
         this.titleTextField.x = this.WIDTH / 2 - this.titleTextField.width / 2;
         this.textField.text = "Mortars fire confined fusion projectiles.  The projectiles overcome the limitations of Blasters by being able to target any terrain level.  Additionally, Mortars can fire over walls.  The confined fusion projectiles can also damage nearly any depth of Creeper.  This makes Mortars absolutely devastating to pools of Creeper.  Fire a Mortar at a giant lake of Creeper and watch the lake disappear.  Mortars do require large amounts of ammunition packets to operate and they do have a limited fire rate.  This makes it best to employ Mortars against pools of Creeper that have accumulated significant depth.  Letting Mortars fire at thin Creeper will definitely do damage, but it will be done inefficiently compared to a Blaster.  Lastly, because of this, Mortars will always auto-target the deepest Creeper in range.";
      }
      
      private function setTextABM() : void
      {
         this.titleTextField.text = "SAM";
         this.titleTextField.x = this.WIDTH / 2 - this.titleTextField.width / 2;
         this.textField.text = "SAMs, or Surface to Air Missiles, have one and only one purpose;  destroy any insidious Creeper Spores before they hit the ground and do terrible damage.  On worlds that have Creeper Spores, numerous SAMs will be required to provide total base protection.  SAMs may also need to be relocated as the network grows.";
      }
      
      private function setTextDroneBase() : void
      {
         this.titleTextField.text = "Drone";
         this.titleTextField.x = this.WIDTH / 2 - this.titleTextField.width / 2;
         this.textField.text = "Automated nano tech Drones are state of the art in anti-Creeper weaponry.  Each Drone bomber carries a full load-out of confined fusion bombs.  Like Mortars, Drones are best targeted at deep Creeper.  Unlike Mortars, Drones can target any location on the map.  Drones do require large numbers of packets to operate, but they can be worth it to hit the Creeper deep in its territory.  Drones require manual targeting.  Select the Drone base, then select where to launch the sortie.  The Drone will fly to the specified area and drop its ordinance until empty.  When empty it will return to the base and re-arm.  Once re-armed, it can be manually launched again.";
      }
      
      private function setUnknown() : void
      {
         this.titleTextField.text = "Unknown";
         this.titleTextField.x = this.WIDTH / 2 - this.titleTextField.width / 2;
         this.textField.text = "Always be prepared for the unexpected.";
      }
      
      private function setTextBaseGun() : void
      {
         this.titleTextField.text = "Odin City";
         this.titleTextField.x = this.WIDTH / 2 - this.titleTextField.width / 2;
         this.textField.text = "Odin City is everything we have left.  Every human that remains alive calls Odin City home.  Protect the city at ALL costs.  Odin City has powerful nano production engines that convert the raw energy it receives from Collectors and Reactors into useful construction, ammunition, and totem packets.  Odin City is always the heart of any network.  Build Collectors out from Odin City as you expand your defenses into an offense.  As necessary, you may need to relocate Odin City to safer or more productive ground.  Wise commanders will click the three colored orbs surrounding Odin City to manage the packets that Odin City emits.  This can prevent unwanted packets from being dispensed.  Caution must be exercised with this advanced feature and only seasoned Commanders should attempt to use this feature.";
      }
   }
}
