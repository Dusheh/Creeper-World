package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.UpgradeBox;
   import com.wbwar.creeper.util.MessageDialog;
   
   public class Game16 extends Game
   {
      
      public static var title:String = "Scluptor";
      
      public static var gameData:Class = Game16_gameData;
       
      
      private var md:MessageDialog;
      
      public function Game16()
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
         new UpgradeBox(26,22);
         new UpgradeBox(52,24);
         disableGame();
         Creeper.instance.gameScreen.playGameMusic(2,4);
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         enableGame();
         _loc2_ = new GlopProducer(7,47);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 100;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(14,0);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 100;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(46,15);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 100;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(61,32);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 100;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(46,47);
         _loc2_.productionBaseAmt = 1.3;
         _loc2_.productionInterval = 100;
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
         this.md.textField.text = "[OPS]\nExcellent job on that last world Commander.  That Drone tech really came in handy.  But even with that tech, all would have been lost had it not been for your quick and decisive actions.\n\nWe are in a pretty bad position on this world.  It seems that on each world we visit, the Creeper gets worse and worse.  I fear if this trend continues we eventually will not be able to survive a world.\n\n[Commander]\nHang in there OPS....  just hang in there.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.createProducers,false,0,true);
      }
   }
}
