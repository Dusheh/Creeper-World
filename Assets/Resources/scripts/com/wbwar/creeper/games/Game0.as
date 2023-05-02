package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.Gun;
   import com.wbwar.creeper.Node;
   import com.wbwar.creeper.Place;
   import com.wbwar.creeper.Relay;
   import com.wbwar.creeper.Totem;
   import com.wbwar.creeper.util.MessageDialog;
   import com.wbwar.creeper.util.PulsingArrow;
   import com.wbwar.creeper.util.PulsingArrowGameSpace;
   import flash.events.MouseEvent;
   
   public class Game0 extends Game
   {
      
      public static var title:String = "Hope";
      
      public static var gameData:Class = Game0_gameData;
       
      
      private var md:MessageDialog;
      
      private var arrow:PulsingArrow;
      
      private var arrowGS:PulsingArrowGameSpace;
      
      private var gunsBuilt:Boolean;
      
      private var totemsCharged:Boolean;
      
      private var removedFinalArrow:Boolean;
      
      private var gameStarted:Boolean;
      
      private var gunToMove:Gun;
      
      public var prelude:Prelude;
      
      public function Game0()
      {
         super();
         gameTitle = title;
         xml = new XML(new gameData());
      }
      
      override public function gameSpaceStarted() : void
      {
         super.gameSpaceStarted();
         this.prelude = new Prelude(this);
         GameSpace.instance.addChild(this.prelude);
         GameSpace.instance.paused = true;
      }
      
      override public function gameStart() : void
      {
         super.gameStart();
      }
      
      public function actualGameStart() : void
      {
         var _loc1_:* = null;
         this.gameStarted = true;
         updateCount = 0;
         GameSpace.instance.updateCount = 0;
         GameSpace.instance.elapsedTime = 0;
         GameSpace.instance.paused = false;
         GameSpace.instance.baseGun.canMove = false;
         GameSpace.instance.controlPanel.buildMenu.enableAll(false);
         GameSpace.instance.controlPanel.placeMenu.placeControlMenu.noActionMode = true;
         GameSpace.instance.controlPanel.buildMenu.nodeButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.relayButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.energyStoreButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.logisticsButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.energyAmpButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.gunButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.areaGunButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.abmButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.droneBaseButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.thorsHammerButton.mystery = true;
         Creeper.instance.gameScreen.playGameMusic(0,0);
         this.gunToMove = new Gun(42,19);
         this.gunToMove.health = this.gunToMove.maxHealth;
         this.gunToMove.energyLevel = this.gunToMove.operateEnergy;
         GameSpace.instance.places.addPlace(this.gunToMove);
         var _loc2_:int = GameSpace.instance.places.placesLayer.numChildren - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = GameSpace.instance.places.placesLayer.getChildAt(_loc2_) as Place;
            if(_loc1_ is Gun)
            {
               (_loc1_ as Gun).canMove = false;
            }
            _loc2_--;
         }
      }
      
      override public function update() : void
      {
         super.update();
         if(!this.gameStarted)
         {
            return;
         }
         if(updateCount % 30 == 0)
         {
            if(!this.gunsBuilt && placesCharged(Gun))
            {
               this.gunsBuilt = true;
               this.showMessage12();
            }
            if(!this.totemsCharged && placesCharged(Totem))
            {
               this.totemsCharged = true;
               this.showMessage18();
            }
         }
         if(updateCount == 20)
         {
            this.showMessage1();
         }
      }
      
      private function showMessage1(param1:Object = null) : void
      {
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,500,-1,true);
         this.md.textField.text = "[OPS]\nCommander, follow my instructions precisely.  Time is critical....";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showMessage2,false,0,true);
      }
      
      private function showMessage2(param1:Object = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showMessage2);
         this.md.hide(true);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,500,-1,false);
         this.md.textField.text = "[OPS]\nOdin City is in the center of your console. She is almost ready to launch.\n\nClick the COLLECTOR button in the command bar. There is an arrow showing you the button.";
         this.md.show();
         GameSpace.instance.controlPanel.buildMenu.nodeButton.enabled = true;
         this.arrow = new PulsingArrow();
         this.arrow.rotation = 135;
         this.arrow.scaleX = 1.5;
         this.arrow.scaleY = this.arrow.scaleX;
         this.arrow.x = 45;
         this.arrow.y = 480;
         GameSpace.instance.controlPanel.buildMenu.nodeButton.addEventListener(MouseEvent.CLICK,this.showMessage3,false,1,true);
      }
      
      private function showMessage3(param1:Object = null) : void
      {
         GameSpace.instance.controlPanel.buildMenu.nodeButton.removeEventListener(MouseEvent.CLICK,this.showMessage3);
         this.md.hide(true);
         this.arrow.remove();
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,500,-1,false);
         this.md.textField.text = "[OPS]\nNow build the Collector where I have indicated...";
         this.md.show();
         this.arrowGS = new PulsingArrowGameSpace();
         this.arrowGS.x = 325;
         this.arrowGS.y = 325;
         GameSpace.instance.places.onlyLegalX = 32;
         GameSpace.instance.places.onlyLegalY = 32;
         GameSpace.instance.places.addEventListener(Node.EVENT_PLACED,this.showMessage4,false,0,true);
      }
      
      private function showMessage4(param1:Object = null) : void
      {
         GameSpace.instance.places.removeEventListener(Node.EVENT_PLACED,this.showMessage4);
         GameSpace.instance.controlPanel.buildMenu.enableAll(false);
         this.md.hide(true);
         this.arrowGS.remove();
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,500,-1,false);
         this.md.textField.text = "[OPS]\nClick the cancel button to exit build mode.";
         this.md.show();
         GameSpace.instance.controlPanel.addEventListener("ControlPanel_Cancel",this.showMessage5,false,1,true);
      }
      
      private function showMessage5(param1:Object = null) : void
      {
         GameSpace.instance.controlPanel.removeEventListener("ControlPanel_Cancel",this.showMessage5);
         this.md.hide(true);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,500,-1,true);
         this.md.textField.text = "[OPS]\nCollectors produce energy.  Each collector produces energy proportional to the green area around it.  Always try to position Collectors so that they create the greatest total green area with the fewest Collectors.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showMessage6,false,0,true);
      }
      
      private function showMessage6(param1:Object = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showMessage6);
         this.md.hide(true);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,500,-1,true);
         this.md.textField.text = "[OPS]\nStructures must be connected to Odin City to be operational.  The Collector you just built not only produces energy it also connects a group of existing Collectors to Odin City.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showMessage7,false,0,true);
      }
      
      private function showMessage7(param1:Object = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showMessage7);
         this.md.hide(true);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,500,-1,true);
         this.md.textField.text = "[OPS]\nThere are also some unfinished Collectors to the east of Odin City.  Since they are now connected to the City, they can be finished.  Odin City will produce and deliver construction packets to these Collectors.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showMessage8,false,0,true);
      }
      
      private function showMessage8(param1:Object = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showMessage7);
         this.md.hide(true);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,500,-1,false);
         this.md.textField.text = "[OPS]\nReports indicate we have only minutes before the first wave of Creeper arrives.  We must act fast.  Build a RELAY where I have indicated.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showMessage8,false,0,true);
         GameSpace.instance.controlPanel.buildMenu.relayButton.enabled = true;
         this.arrowGS = new PulsingArrowGameSpace();
         this.arrowGS.x = 225;
         this.arrowGS.y = 225;
         GameSpace.instance.places.onlyLegalX = 22;
         GameSpace.instance.places.onlyLegalY = 22;
         GameSpace.instance.places.addEventListener(Relay.EVENT_PLACED,this.showMessage9,false,0,true);
      }
      
      private function showMessage9(param1:Object = null) : void
      {
         GameSpace.instance.controlPanel.buildMenu.enableAll(false);
         GameSpace.instance.places.removeEventListener(Node.EVENT_PLACED,this.showMessage4);
         GameSpace.instance.controlPanel.buildMenu.enableAll(false);
         this.md.hide(true);
         this.arrowGS.remove();
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,500,-1,false);
         this.md.textField.text = "[OPS]\nClick the cancel button to exit build mode.";
         this.md.show();
         GameSpace.instance.controlPanel.addEventListener("ControlPanel_Cancel",this.showMessage10,false,1,true);
      }
      
      private function showMessage10(param1:Object = null) : void
      {
         GameSpace.instance.controlPanel.removeEventListener("ControlPanel_Cancel",this.showMessage10);
         this.md.hide(true);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,500,-1,true);
         this.md.textField.text = "[OPS]\nRelays create long range connections, but only with other Relays.  They can be useful for spanning valleys, or creating more direct paths in your base.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showMessage11,false,0,true);
      }
      
      private function showMessage11(param1:Object = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showMessage10);
         this.md.hide(true);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,500,-1,false);
         this.md.textField.text = "[OPS]\nOnce the Relays are complete, the three newly connected Blasters will start to charge.  These Blasters were built earlier, but have not yet fully armed.  Let\'s wait for the Blasters to charge...";
         this.md.show();
      }
      
      private function showMessage12(param1:Object = null) : void
      {
         this.md.hide(true);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,500,-1,false);
         this.gunToMove.canMove = true;
         this.md.textField.text = "[OPS]\nThere is one additional Blaster just to the north east of Odin City.  Click it now.";
         this.md.show();
         this.gunToMove.addEventListener(MouseEvent.CLICK,this.showMessage13,false,99,true);
      }
      
      private function showMessage13(param1:Object = null) : void
      {
         this.gunToMove.removeEventListener(MouseEvent.CLICK,this.showMessage13);
         this.md.hide(true);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,500,-1,false);
         this.md.textField.text = "[OPS]\nNow click where I have indicated to move the Blaster.  A key strategy for defending against the Creeper is to move and position your weapons wisely.";
         this.md.show();
         this.arrowGS = new PulsingArrowGameSpace();
         this.arrowGS.x = 115;
         this.arrowGS.y = 295;
         GameSpace.instance.places.onlyLegalX = 11;
         GameSpace.instance.places.onlyLegalY = 29;
         GameSpace.instance.places.addEventListener("PLACES_MOVE",this.showMessage14,false,0,true);
      }
      
      private function showMessage14(param1:Object = null) : void
      {
         GameSpace.instance.places.removeEventListener("PLACES_MOVE",this.showMessage14);
         this.md.hide(true);
         this.arrowGS.remove();
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,500,-1,true);
         this.md.textField.text = "[OPS]\nThe Creeper has arrived....  this is it Commander!\n\nOur Blasters should hold off the Creeper just long enough for us to open the Rift and get Odin City out of danger.";
         this.md.show();
         this.createProducers();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showMessage15,false,0,true);
      }
      
      private function showMessage15(param1:Object = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showMessage15);
         this.md.hide(true);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,300,-1,true);
         this.gunToMove.canMove = false;
         this.md.textField.text = "[OPS]\nWe need to power three Rift Totems in order to activate the Rift.  These three Totems are in the upper right hand corner of the map.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showMessage16,false,0,true);
      }
      
      private function showMessage16(param1:Object = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showMessage16);
         this.md.hide(true);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,500,-1,false);
         this.md.textField.text = "[OPS]\nClick Odin City and fly her to the location I\'ll indicate.  Once there, Odin City will supply rift packets to the Totems.  Once all three Totems are charged, the Totems will activate the Rift!";
         this.md.show();
         GameSpace.instance.baseGun.canMove = true;
         GameSpace.instance.baseGun.addEventListener(MouseEvent.CLICK,this.showMessage17,false,99,true);
      }
      
      private function showMessage17(param1:Object = null) : void
      {
         var _loc2_:* = null;
         GameSpace.instance.baseGun.removeEventListener(MouseEvent.CLICK,this.showMessage17);
         this.md.hide(true);
         this.arrowGS = new PulsingArrowGameSpace(true);
         this.arrowGS.x = 405;
         this.arrowGS.y = 95;
         GameSpace.instance.places.onlyLegalX = 40;
         GameSpace.instance.places.onlyLegalY = 9;
         _loc2_ = new GlopProducer(0,12);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 5;
         _loc2_.startTime = 0;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(0,24);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 5;
         _loc2_.startTime = 0;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(0,36);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 5;
         _loc2_.startTime = 0;
         GameSpace.instance.addGlopProducer(_loc2_);
      }
      
      private function showMessage18(param1:Object = null) : void
      {
         if(this.md != null)
         {
            this.md.hide(true);
         }
         if(this.arrowGS != null)
         {
            this.arrowGS.remove();
         }
         GameSpace.instance.places.onlyLegalX = -1;
         GameSpace.instance.places.onlyLegalY = -1;
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,200,50,false,true);
         this.md.textField.text = "---RIFT ACTIVE!---\n";
         this.md.show();
      }
      
      private function createProducers() : void
      {
         var _loc1_:* = null;
         _loc1_ = new GlopProducer(0,12);
         _loc1_.productionBaseAmt = 0.1;
         _loc1_.productionInterval = 50;
         _loc1_.startTime = 0;
         _loc1_.productionModifierTime = 0.001;
         _loc1_.productionModifierTimeMax = 1;
         GameSpace.instance.addGlopProducer(_loc1_);
         _loc1_ = new GlopProducer(0,24);
         _loc1_.productionBaseAmt = 0.1;
         _loc1_.productionInterval = 50;
         _loc1_.startTime = 0;
         _loc1_.productionModifierTime = 0.001;
         _loc1_.productionModifierTimeMax = 1;
         GameSpace.instance.addGlopProducer(_loc1_);
         _loc1_ = new GlopProducer(0,36);
         _loc1_.productionBaseAmt = 0.1;
         _loc1_.productionInterval = 50;
         _loc1_.startTime = 0;
         _loc1_.productionModifierTime = 0.001;
         _loc1_.productionModifierTimeMax = 1;
         GameSpace.instance.addGlopProducer(_loc1_);
      }
   }
}
