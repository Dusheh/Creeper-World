package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.UpgradeBox;
   import com.wbwar.creeper.util.MessageDialog;
   
   public class Game12 extends Game
   {
      
      public static var title:String = "Pavo";
      
      public static var gameData:Class = Game12_gameData;
       
      
      private var md:MessageDialog;
      
      public function Game12()
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
         new UpgradeBox(56,42);
         new UpgradeBox(4,29);
         new UpgradeBox(40,25);
         disableGame();
         Creeper.instance.gameScreen.playGameMusic(2,4);
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         enableGame();
         _loc2_ = new GlopProducer(15,0);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 50;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(15,7);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 50;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(12,3);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 50;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(18,3);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 50;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(58,7);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 50;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(58,14);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 50;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(54,10);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 50;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(63,10);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 50;
         GameSpace.instance.addGlopProducer(_loc2_);
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
         this.md.textField.text = "[OPS]\nCommander, the analysis of the \"enigma\" Artifact we picked up back on Draco has been completed.  The Artifact contained encrypted information describing improvements to nearly all of our technologies.  I don\'t know how this is even possible... half of our technology has only been developed over the last 5 years.  The information on the Artifact was recorded using ancient technology dating back many thousands of years.  In fact, the information that it contains would not even have made any sense to the people of the 21st century.\n\n[Commander]\nI understand OPS.\n\n[OPS]\nCommander, you don\'t seem surprised by this news.\n\n[Commander]\nJust tell me how the information can be applied to the mission at hand OPS.\n\n[OPS]\nYes sir... I see.  We can adapt the information to allow six different improvements to our tech.  In order to enable any upgrades we will need a substantial supply of raw nanobots.  If you collect these, then we can create an improvement.  On the map I have highlighted any available nanobot deposits.  Collect these and then click on the green Upgrades section of the command bar.  From there you can apply upgrade \"points\" as you see fit.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.createProducers,false,0,true);
      }
   }
}
