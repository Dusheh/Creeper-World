package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopBlobProducer;
   import com.wbwar.creeper.GlopBlobProducerWave;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.UpgradeBox;
   import com.wbwar.creeper.util.MessageDialog;
   
   public class Game13 extends Game
   {
      
      public static var title:String = "Ursa";
      
      public static var gameData:Class = Game13_gameData;
       
      
      private var md:MessageDialog;
      
      public function Game13()
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
         new UpgradeBox(67,10);
         new UpgradeBox(60,20);
         new UpgradeBox(66,33);
         new UpgradeBox(6,43);
         disableGame();
         Creeper.instance.gameScreen.playGameMusic(2,4);
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         enableGame();
         _loc2_ = new GlopProducer(31,30);
         _loc2_.productionBaseAmt = 2;
         _loc2_.productionInterval = 100;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(42,30);
         _loc2_.productionBaseAmt = 2;
         _loc2_.productionInterval = 100;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         var _loc3_:GlopBlobProducer = new GlopBlobProducer();
         var _loc4_:GlopBlobProducerWave = new GlopBlobProducerWave(8640,2,1,72,0.2,GlopBlobProducerWave.SIDE_BOTTOM);
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
         this.md.textField.text = "[OPS]\nEMERGENCY!!!! COMMANDER!!!!\n\nCommander, you must immediately move the city.  We rifted in right on top of some Creeper emitters.  Get the city to higher ground away from the emitters!\n\nSensors also report incoming aerial Creeper spores.  Move the city and ready your defenses!";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.createProducers,false,0,true);
      }
   }
}
