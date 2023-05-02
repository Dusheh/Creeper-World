package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.Tech;
   import com.wbwar.creeper.util.MessageDialog;
   
   public class Game2 extends Game
   {
      
      public static var title:String = "Fitch";
      
      public static var gameData:Class = Game2_gameData;
       
      
      private var md:MessageDialog;
      
      public function Game2()
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
         GameSpace.instance.controlPanel.buildMenu.energyStoreButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.logisticsButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.energyAmpButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.gunButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.areaGunButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.abmButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.droneBaseButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.thorsHammerButton.mystery = true;
         new Tech(55,41,Tech.TECH_ENERGYSTORAGE);
         disableGame();
         Creeper.instance.gameScreen.playGameMusic(2,4);
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         enableGame();
         _loc2_ = new GlopProducer(0,0);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 150;
         _loc2_.startTime = 50;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(17,0);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 150;
         _loc2_.startTime = 50;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(35,0);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 150;
         _loc2_.startTime = 50;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(53,0);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 150;
         _loc2_.startTime = 50;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(69,0);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 150;
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
         this.md.textField.text = "[OPS]\nThe Old Man gave us the coordinates for each of these worlds...  The Gods only know where he got them.  But he is the only reason we\'ve survived long enough to build Odin City in the first place, so we owe him the benefit of the doubt.  Plus, what other choice do we really have anyway?\n\nCommander, there is a nano schematic for energy storage on this world.  Build out a base and collect this as a first order of business.  Energy storage will allow you to construct storage pods that will buffer the energy our collectors produce.  This can be useful when you need to build or arm lots of things all at the same time.\n\nAlso Commander, be mindful of your energy consumption at all times.  Watch the red starvation indicator in the lower right of your command bar.  If this is very large, you are building too many things or powering too many things at once.  Either fall back, or build more energy collectors.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.createProducers,false,0,true);
      }
   }
}
