package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopBlobProducer;
   import com.wbwar.creeper.GlopBlobProducerWave;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.Tech;
   import com.wbwar.creeper.util.MessageDialog;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class Game9 extends Game
   {
      
      public static var title:String = "Octan";
      
      public static var gameData:Class = Game9_gameData;
       
      
      private var md:MessageDialog;
      
      private var tamd:MessageDialog;
      
      public function Game9()
      {
         super();
         gameTitle = title;
         xml = new XML(new gameData());
      }
      
      override public function gameStart() : void
      {
         super.gameStart();
         GameSpace.instance.controlPanel.buildMenu.nodeButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.relayButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.energyStoreButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.logisticsButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.energyAmpButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.gunButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.areaGunButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.abmButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.droneBaseButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.thorsHammerButton.mystery = true;
         var _loc1_:Tech = new Tech(3,44,Tech.TECH_ABM);
         _loc1_.addEventListener(Tech.EVENT_TECH_APPLIED,this.onTechApplied);
         disableGame();
         Creeper.instance.gameScreen.playGameMusic(2,4);
      }
      
      private function onTechApplied(param1:Event = null) : void
      {
         this.tamd = new MessageDialog(MessageDialog.SIDE_TOP,-1,650,-1,true);
         this.tamd.textField.text = "[OPS]\nExcellent news Commander.  The missile tech can be utilized to create a Surface to Air Missile system.  This SAM unit should be able to shoot down incoming Creeper Spores.  Build several of these units and spread them around your base.  You may also need to move them around as you expand your base.\n\nAlso Commander,  the schematics listed five worlds where the Octans planned to ship the technology.\n\n[Commander]\nProgram the coordinates for the first of those worlds into the Totems.  That\'s where we will head next.";
         this.tamd.show();
         GameSpace.instance.paused = true;
         this.tamd.okButton.addEventListener(MouseEvent.CLICK,this.dismissSamDialog,false,100,true);
      }
      
      private function dismissSamDialog(param1:Event = null) : void
      {
         GameSpace.instance.paused = false;
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         enableGame();
         _loc2_ = new GlopProducer(0,0);
         _loc2_.productionBaseAmt = 2;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(17,0);
         _loc2_.productionBaseAmt = 2;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(57,0);
         _loc2_.productionBaseAmt = 2;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(69,0);
         _loc2_.productionBaseAmt = 2;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(11,29);
         _loc2_.productionBaseAmt = 1.5;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(53,26);
         _loc2_.productionBaseAmt = 1.5;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         var _loc3_:GlopBlobProducer = new GlopBlobProducer();
         var _loc4_:GlopBlobProducerWave = new GlopBlobProducerWave(8640,2,1,72,0.2,GlopBlobProducerWave.SIDE_TOP);
         _loc3_.waves.push(_loc4_);
         _loc4_ = new GlopBlobProducerWave(6480,3,1,72,0.2,GlopBlobProducerWave.SIDE_TOP);
         _loc3_.waves.push(_loc4_);
         _loc4_ = new GlopBlobProducerWave(6480,3,1,72,0.2,GlopBlobProducerWave.SIDE_TOP);
         _loc3_.waves.push(_loc4_);
         _loc4_ = new GlopBlobProducerWave(6480,3,1,72,0.2,GlopBlobProducerWave.SIDE_TOP);
         _loc3_.waves.push(_loc4_);
         _loc4_ = new GlopBlobProducerWave(6480,4,1,72,0.2,GlopBlobProducerWave.SIDE_TOP);
         _loc3_.waves.push(_loc4_);
         GameSpace.instance.glopBlobProducer = _loc3_;
      }
      
      override public function update() : void
      {
         super.update();
         if(updateCount == 20)
         {
            this.showDialog1();
         }
      }
      
      private function showDialog1() : void
      {
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,650,-1,true);
         this.md.textField.text = "[Commander]\nOPS, sound the city alarm.  We have trouble coming.  One of the scientists we rescued a couple worlds back had some critical information for us.  He and his crew spent some time in orbit around this world and they observed something unexpected.  Apparently, the Creeper here has started producing Aerial Spores.  These Spores are launched from great distances and target human made structures.  When they land they release patches of Creeper that immediately destroy anything in the vicinity.  We have no defense against this....\n\n[OPS]\nCommander I might have something we can adapt as a defense.  There is a nearby nano schematic for some missile technology that the Octans were working on.  Octan is constantly bombarded by meteor debris so they must have developed some advanced missile tracking technology to deal with it.  Pick up the nano schematic and we can use those missiles to defend against these Spores.\n\nOur sensors can detect incoming Spore attacks at great distances so I\'ve augmented your command console to show a countdown timer.  Keep an eye on this timer as it indicates when the next Spore attack is due.  Also Commander, you might want to build redundancy into your network.  If Spores make it through, you don\'t want to have a whole section of the network lose power.\n\nOne more thing Commander...  Our scientists have identified a potential weakness in the Creeper.  Apparently, if you get a Blaster in range of a Creeper emitter and eliminate any surrounding Creeper, a single Blaster will be able to cap-off the emitter.  This tactic could be very useful.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.createProducers,false,0,true);
      }
   }
}
