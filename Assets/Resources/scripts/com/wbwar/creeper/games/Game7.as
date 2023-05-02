package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.Ruin;
   import com.wbwar.creeper.util.MessageDialog;
   
   public class Game7 extends Game
   {
      
      public static var title:String = "Draco";
      
      public static var gameData:Class = Game7_gameData;
       
      
      private var md:MessageDialog;
      
      public function Game7()
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
         var _loc1_:Ruin = new Ruin(58,24);
         _loc1_.md.textField.text = "[OPS]\nThis Artifact is a bit of an enigma.  Our scientists will have to analyze it for some time before we can learn anything from it.";
         disableGame();
         Creeper.instance.gameScreen.playGameMusic(2,4);
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         enableGame();
         _loc2_ = new GlopProducer(35,22);
         _loc2_.productionBaseAmt = 4;
         _loc2_.productionInterval = 15;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(35,24);
         _loc2_.productionBaseAmt = 4;
         _loc2_.productionInterval = 15;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(34,23);
         _loc2_.productionBaseAmt = 4;
         _loc2_.productionInterval = 15;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(36,23);
         _loc2_.productionBaseAmt = 4;
         _loc2_.productionInterval = 15;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(5,0);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 30;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(65,0);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 30;
         _loc2_.startTime = 100;
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
         this.md.textField.text = "[OPS]\nDraco.... this world was barely inhabitable before the Creeper got here.  Now it\'s just a horror to behold.  Get us off this rock as quickly as you can Commander.\n\nScanners do show another Artifact, try to pick it up but don\'t let it delay our escape.  We\'re perched on the edge of a giant caldera.  The idea of being caught in a Creeper volcano sends shivers down my spine.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.createProducers,false,0,true);
      }
   }
}
