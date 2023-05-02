package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopBlobProducer;
   import com.wbwar.creeper.GlopBlobProducerWave;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.Ruin;
   import com.wbwar.creeper.UpgradeBox;
   import com.wbwar.creeper.util.MessageDialog;
   
   public class Game14 extends Game
   {
      
      public static var title:String = "Canis";
      
      public static var gameData:Class = Game14_gameData;
       
      
      private var md:MessageDialog;
      
      public function Game14()
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
         GameSpace.instance.controlPanel.buildMenu.energyAmpButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.gunButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.areaGunButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.abmButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.droneBaseButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.thorsHammerButton.mystery = true;
         var _loc1_:Ruin = new Ruin(28,5);
         _loc1_.md.textField.text = "[OPS]\nCommander, this Artifact is different than all of the others.  It isn\'t ancient.  In fact it appears as if it may only be days old.  It may have been made moments before we arrived for all we know.  What is unbelievable about this is that this world has been dead for over 5 years.\n\nAnd Commander, there is little mystery as to what this artifact means.  The coordinates of five worlds are clearly indicated.  The Artifact is also signed with the name \"Platius\".  Does this name mean anything to you Commander?\n\n[Commander]\n...  yes ...\n\nEnter the first set of coordinates OPS.  We\'re leaving.\n\n[OPS]\nYes..... yes sir...";
         new UpgradeBox(27,32);
         new UpgradeBox(47,35);
         new UpgradeBox(46,44);
         new UpgradeBox(3,34);
         new UpgradeBox(4,15);
         disableGame();
         Creeper.instance.gameScreen.playGameMusic(2,4);
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         enableGame();
         _loc2_ = new GlopProducer(0,0);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(69,47);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(69,0);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 25;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         var _loc3_:GlopBlobProducer = new GlopBlobProducer();
         var _loc4_:GlopBlobProducerWave = new GlopBlobProducerWave(8640,2,1,72,0.2,GlopBlobProducerWave.SIDE_TOP);
         _loc3_.waves.push(_loc4_);
         _loc4_ = new GlopBlobProducerWave(6480,3,1,72,0.2,GlopBlobProducerWave.SIDE_TOP);
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
         this.md.textField.text = "[OPS]\nScanners show an Artifact on this world.  If recent history is any indicator, we should retrieve this Artifact.\n\nCommander, we\'ve rifted onto low ground.  You may want to relocate the city as a first order of business.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.createProducers,false,0,true);
      }
   }
}
