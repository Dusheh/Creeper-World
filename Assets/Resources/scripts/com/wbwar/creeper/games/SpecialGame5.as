package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.SurvivalPod;
   import com.wbwar.creeper.UpgradeBox;
   import com.wbwar.creeper.util.MessageDialog;
   
   public class SpecialGame5 extends Game
   {
      
      public static var title:String = "DTD";
      
      public static var gameData:Class = SpecialGame5_gameData;
       
      
      private var md:MessageDialog;
      
      private var gps:Array;
      
      private var level:int = 0;
      
      public function SpecialGame5()
      {
         this.gps = [];
         super();
         gameTitle = title;
         xml = new XML(new gameData());
      }
      
      override public function gameStart() : void
      {
         var _loc1_:* = null;
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
         _loc1_ = new SurvivalPod(28,27);
         _loc1_.md.textField.text = "Survivors rescued!";
         _loc1_ = new SurvivalPod(25,10);
         _loc1_.md.textField.text = "Survivors rescued!";
         _loc1_ = new SurvivalPod(40,35);
         _loc1_.md.textField.text = "Survivors rescued!";
         new UpgradeBox(54,14);
         new UpgradeBox(48,23);
         new UpgradeBox(54,31);
         new UpgradeBox(61,40);
         new UpgradeBox(61,7);
         new UpgradeBox(66,7);
         disableGame();
         Creeper.instance.gameScreen.playGameMusic(2,4);
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         enableGame();
         _loc2_ = new GlopProducer(0,22);
         _loc2_.productionBaseAmt = 2;
         _loc2_.productionInterval = 150;
         _loc2_.startTime = 125;
         GameSpace.instance.addGlopProducer(_loc2_);
         this.gps.push(_loc2_);
         _loc2_ = new GlopProducer(0,26);
         _loc2_.productionBaseAmt = 2;
         _loc2_.productionInterval = 150;
         _loc2_.startTime = 125;
         GameSpace.instance.addGlopProducer(_loc2_);
         this.gps.push(_loc2_);
         _loc2_ = new GlopProducer(33,0);
         _loc2_.productionBaseAmt = 2;
         _loc2_.productionInterval = 150;
         _loc2_.startTime = 125;
         GameSpace.instance.addGlopProducer(_loc2_);
         this.gps.push(_loc2_);
         _loc2_ = new GlopProducer(37,0);
         _loc2_.productionBaseAmt = 2;
         _loc2_.productionInterval = 100;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         this.gps.push(_loc2_);
      }
      
      override public function update() : void
      {
         super.update();
         if(updateCount == 20)
         {
            this.createProducers();
         }
      }
      
      private function updateProducers() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:* = null;
         for each(_loc2_ in this.gps)
         {
            _loc2_.productionBaseAmt *= 1.2;
            _loc1_ = _loc2_.productionBaseAmt;
         }
      }
   }
}
