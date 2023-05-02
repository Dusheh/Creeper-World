package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.SurvivalPod;
   import com.wbwar.creeper.UpgradeBox;
   import com.wbwar.creeper.util.MessageDialog;
   
   public class Game17 extends Game
   {
      
      public static var title:String = "Volan";
      
      public static var gameData:Class = Game17_gameData;
       
      
      private var md:MessageDialog;
      
      public function Game17()
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
         GameSpace.instance.controlPanel.buildMenu.droneBaseButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.thorsHammerButton.mystery = true;
         new UpgradeBox(30,9);
         new UpgradeBox(7,19);
         var _loc1_:SurvivalPod = new SurvivalPod(32,20,500);
         _loc1_.md.textField.text = "[OPS]\nCommander, the survival pod is empty....  How did it get here?";
         disableGame();
         Creeper.instance.gameScreen.playGameMusic(2,4);
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         enableGame();
         _loc2_ = new GlopProducer(69,29);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 100;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(69,47);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 100;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(69,0);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 100;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(0,47);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 100;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(37,22);
         _loc2_.productionBaseAmt = 2;
         _loc2_.productionInterval = 200;
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
         this.md.textField.text = "[OPS]\nScanners show.... a single survival pod!  The pod appears to have landed within the hour.  Commander, if there is a survival pod then there must be other humans in ships nearby.\n\n[Commander]\nThis is possible OPS, or the pod could have been on an automated course to its home world...  Either way, we\'re going to collect it. The Creeper is very intense and has deployed strategically OPS.  Put the city on general alert, this is going to be a rough ride.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.createProducers,false,0,true);
      }
   }
}
