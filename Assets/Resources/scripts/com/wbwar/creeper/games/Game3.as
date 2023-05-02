package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.Tech;
   import com.wbwar.creeper.util.MessageDialog;
   
   public class Game3 extends Game
   {
      
      public static var title:String = "Orion";
      
      public static var gameData:Class = Game3_gameData;
       
      
      private var md:MessageDialog;
      
      public function Game3()
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
         GameSpace.instance.controlPanel.buildMenu.logisticsButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.energyAmpButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.gunButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.areaGunButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.abmButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.droneBaseButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.thorsHammerButton.mystery = true;
         new Tech(65,40,Tech.TECH_AREAGUN);
         disableGame();
         Creeper.instance.gameScreen.playGameMusic(2,4);
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         enableGame();
         _loc2_ = new GlopProducer(0,16);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 150;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(0,20);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 150;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(0,24);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 150;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(0,28);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 150;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(0,32);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 150;
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
         this.md.textField.text = "[OPS]\nExcellent job on that last world Commander.  You outperformed any of the simulator\'s predictions.  You seem to have a natural talent for command.  We might just have a chance with you at the helm.\n\nScanners show a high priority target in the lower right of the map.  There is a nano schematic for a major weapon system there.  The Orions onboard say that their military had been working on an anti-Creeper Mortar system.  This weapon can fire over walls and at higher terrain elevations.  As you may have noticed, Blasters require a line of sight to their target so they can\'t fire at elevations higher than themselves or through walls.  But with this Mortar tech, we can overcome this limitation!\n\nThe Orions indicate that the Mortar is mostly useful against deep pools of Creeper.  The shells it fires will destroy any depth of Creeper down to the terrain.  In fact, the Mortar always auto targets the thickest Creeper in range.  Our military analysts recommend  that Blasters  be used against the thin Creeper that spreads everywhere and that Mortars should be positioned to fire at deep pools of Creeper.\n\nCommander, if you find that a Mortar is drawing too much energy and is only firing at thin Creeper, you can select the Mortar and click the Deactivate button in the lower left of the command bar.  This will turn off the Mortar until you need it again.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.createProducers,false,0,true);
      }
   }
}
