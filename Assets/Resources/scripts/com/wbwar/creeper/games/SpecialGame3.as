package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopBlobProducer;
   import com.wbwar.creeper.GlopBlobProducerWave;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.Ruin;
   import com.wbwar.creeper.SurvivalPod;
   import com.wbwar.creeper.util.MessageDialog;
   
   public class SpecialGame3 extends Game
   {
      
      public static var title:String = "Mouse Shadow";
      
      public static var gameData:Class = SpecialGame3_gameData;
       
      
      private var md:MessageDialog;
      
      private var gps:Array;
      
      private var level:int = 0;
      
      public function SpecialGame3()
      {
         this.gps = [];
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
         var _loc2_:Ruin = new Ruin(63,3);
         _loc2_.md.textField.text = "In early stages of the game, the Creeper was RED.  Check out the early game screen shots in the credits...";
         var _loc3_:Ruin = new Ruin(6,27);
         _loc3_.md.textField.text = "Creeper World combines physics with computer science.  The Creeper is modeled as thermal flow through a medium and packets find their way through your network utilizing the A* algorithm.\n\nThere can be more to physics based games than kinematic simulations!";
         disableGame();
         Creeper.instance.gameScreen.playGameMusic(2,4);
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         enableGame();
         _loc2_ = new GlopProducer(39,21);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         this.gps.push(_loc2_);
         _loc2_ = new GlopProducer(19,7);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         this.gps.push(_loc2_);
         var _loc3_:GlopBlobProducer = new GlopBlobProducer();
         var _loc4_:GlopBlobProducerWave = new GlopBlobProducerWave(8640,2,1,72,0.2,GlopBlobProducerWave.SIDE_LEFT);
         _loc3_.waves.push(_loc4_);
         _loc4_ = new GlopBlobProducerWave(6480,3,1,72,0.2,GlopBlobProducerWave.SIDE_LEFT);
         _loc3_.waves.push(_loc4_);
         GameSpace.instance.glopBlobProducer = _loc3_;
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
