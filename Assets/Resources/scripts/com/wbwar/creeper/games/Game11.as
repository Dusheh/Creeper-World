package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.Tech;
   import com.wbwar.creeper.util.MessageDialog;
   
   public class Game11 extends Game
   {
      
      public static var title:String = "Vela";
      
      public static var gameData:Class = Game11_gameData;
       
      
      private var md:MessageDialog;
      
      public function Game11()
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
         new Tech(64,44,Tech.TECH_ENERGYAMP);
         disableGame();
         Creeper.instance.gameScreen.playGameMusic(2,4);
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         enableGame();
         _loc2_ = new GlopProducer(4,0);
         _loc2_.productionBaseAmt = 2;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 50;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(24,0);
         _loc2_.productionBaseAmt = 2;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 50;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(43,0);
         _loc2_.productionBaseAmt = 2;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 50;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(64,0);
         _loc2_.productionBaseAmt = 2;
         _loc2_.productionInterval = 50;
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
         this.md.textField.text = "[OPS]\nCommander, this world seems as ordinary as the last.  Ordinary in that it is dead, it creeps, and I don\'t see how it could have any impact on our journey or offer us any refuge.\n\n[Commander]\nOPS, you almost sound like you believe there is supposed to be some purpose to the worlds we visit.  Have you ever considered that there is no purpose and we will live out the rest of our lives constantly fleeing from the Creeper?\n\n[OPS]\nI don\'t know what to believe.  You are probably right.  In any case everyone in this city depends on us in the here and now.  Commander I\'ve identified another nano schematic on this world.  Interesting... the Velans appear to have protected the schematics in a walled off area.  They must have desperately tried to keep this from the Creeper.  This nano schematic appears as if it will allow us to construct power generation reactors that rival the output of the fractal energy collectors that we use to build our network.  Commander, we can use these to produce power for our base whenever we can\'t spread out into a large collector network initially.\n\n[Commander]\nI\'ll put these new reactors to good use OPS.  Oh and OPS, for the record I never said I didn\'t believe in our purpose.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.createProducers,false,0,true);
      }
   }
}
