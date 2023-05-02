package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.util.MessageDialog;
   
   public class Game10 extends Game
   {
      
      public static var title:String = "Tucana";
      
      public static var gameData:Class = Game10_gameData;
       
      
      private var md:MessageDialog;
      
      public function Game10()
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
         GameSpace.instance.controlPanel.buildMenu.abmButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.droneBaseButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.thorsHammerButton.mystery = true;
         disableGame();
         Creeper.instance.gameScreen.playGameMusic(2,4);
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         enableGame();
         _loc2_ = new GlopProducer(0,0);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 30;
         _loc2_.startTime = 50;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(69,0);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 30;
         _loc2_.startTime = 50;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(69,47);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 30;
         _loc2_.startTime = 50;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(0,47);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 30;
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
         this.md.textField.text = "[OPS]\nUh oh Commander.  We\'ve rifted to the specified coordinates and ended up on Tucana.  The city is in a terrible position.  We are surrounded by Creeper and there is precious little high ground.  We normally might try to relocate the city to high ground, but there is no high ground large enough to support the city.\n\nYou will have to act quickly to save the city.  Mortars will be instrumental.  Build a Collector network rapidly and take advantage of the four craters around the city.  These craters will buffer the Creeper for a while as they fill up.  But once full, only the Gods can help us.   So Commander, don\'t let them get full.\n\nCommander, if you approach an emitter with Blasters and Mortars to provide cover, you might be able to get a single Blaster in range to effectively cap off the emitter.  Once capped, you can free up most of the resources it takes to hold back the Creeper from that emitter and focus on the next emitter.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.createProducers,false,0,true);
      }
   }
}
