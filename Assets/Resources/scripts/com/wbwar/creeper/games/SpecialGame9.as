package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.Ruin;
   import com.wbwar.creeper.SurvivalPod;
   import com.wbwar.creeper.util.MessageDialog;
   
   public class SpecialGame9 extends Game
   {
      
      public static var title:String = "KC";
      
      public static var gameData:Class = SpecialGame9_gameData;
       
      
      private var md:MessageDialog;
      
      private var gps:Array;
      
      private var level:int = 0;
      
      public function SpecialGame9()
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
         var _loc2_:Ruin = new Ruin(8,42);
         _loc2_.md.textField.text = "[Platius]\nWell well well.... you think your journey is at its end don\'t you?\n\nWin this map and unlock Double-Down mode young one!  On any mission selection screen click the \"Double Down\" button to double the amount of Creeper on all missions!\n\nYou can turn it off if it gets too tough... but I doubt that will be the case my young friend.  You have proven yourself to be most worthy.\n\nI told you I wouldn\'t be far....  Good bye again young one.  I can\'t wait for you to see what the future has in store for you next....";
         disableGame();
         Creeper.instance.gameScreen.playGameMusic(2,4);
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         enableGame();
         _loc2_ = new GlopProducer(42,22);
         _loc2_.productionBaseAmt = 4;
         _loc2_.productionInterval = 25;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         this.gps.push(_loc2_);
         _loc2_ = new GlopProducer(59,34);
         _loc2_.productionBaseAmt = 4;
         _loc2_.productionInterval = 25;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         this.gps.push(_loc2_);
         _loc2_ = new GlopProducer(55,4);
         _loc2_.productionBaseAmt = 4;
         _loc2_.productionInterval = 25;
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
