package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.Ruin;
   import com.wbwar.creeper.SurvivalPod;
   import com.wbwar.creeper.util.MessageDialog;
   
   public class SpecialGame4 extends Game
   {
      
      public static var title:String = "Chess";
      
      public static var gameData:Class = SpecialGame4_gameData;
       
      
      private var md:MessageDialog;
      
      private var gps:Array;
      
      private var level:int = 0;
      
      public function SpecialGame4()
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
         var _loc2_:Ruin = new Ruin(35,14);
         _loc2_.md.textField.text = "Have you played Whiteboardwar: ChopRaider?  Visit whiteboardwar.com and check it out!";
         var _loc3_:Ruin = new Ruin(35,34);
         _loc3_.md.textField.text = "If you see this message, you must really like this game and be pretty good at it as well!  Thanks for buying, playing, and enjoying it.  Your support of independent game development is most appreciated.";
         disableGame();
         Creeper.instance.gameScreen.playGameMusic(2,4);
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         enableGame();
         _loc2_ = new GlopProducer(5,14);
         _loc2_.productionBaseAmt = 2;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         this.gps.push(_loc2_);
         _loc2_ = new GlopProducer(5,34);
         _loc2_.productionBaseAmt = 2;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         this.gps.push(_loc2_);
         _loc2_ = new GlopProducer(25,14);
         _loc2_.productionBaseAmt = 2;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         this.gps.push(_loc2_);
         _loc2_ = new GlopProducer(25,34);
         _loc2_.productionBaseAmt = 2;
         _loc2_.productionInterval = 50;
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
