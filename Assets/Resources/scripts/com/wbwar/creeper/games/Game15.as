package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.Tech;
   import com.wbwar.creeper.UpgradeBox;
   import com.wbwar.creeper.util.MessageDialog;
   
   public class Game15 extends Game
   {
      
      public static var title:String = "Ix";
      
      public static var gameData:Class = Game15_gameData;
       
      
      private var md:MessageDialog;
      
      public function Game15()
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
         new Tech(40,40,Tech.TECH_DRONEBASE);
         new UpgradeBox(52,35);
         new UpgradeBox(25,44);
         new UpgradeBox(62,28);
         disableGame();
         Creeper.instance.gameScreen.playGameMusic(2,4);
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         enableGame();
         _loc2_ = new GlopProducer(9,10);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 20;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(32,9);
         _loc2_.productionBaseAmt = 3;
         _loc2_.productionInterval = 20;
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
         this.md.textField.text = "[OPS]\nWe have arrived on Ix.  I was afraid of this Commander.  I spent some time on this world in my youth.  Ix has striking geographic features, and we have rifted right at the base of a double caldera.  The Creeper has emitters in each crater and we are on the low land.  Commander, I\'m not sure we will be able to mount a defense in time.  Once the Creeper spills over the edge of the craters, it will flood down onto the plain we are on in a nearly unstoppable force.\n\n[Commander]\nCheck the scanners again... there has to be some way.  We wouldn\'t have been led to this world otherwi....\n\n[OPS]\nSorry to interrupt Commander, but you are right.  Scanners show a nano schematic for a new technology on this world.  Ix was a peaceful world, so I\'m surprised to see this technology here.  In any case, this tech looks amazing.  These schematics will allow us to build drone bombers.\n\nCommander, you should collect these schematics immediately.  These drones must be manually targeted once they are built and charged.  But Commander, they can be targeted anywhere on the map!  The drone will fly to the target area and deliver its bombs.\n\nIf you can get the drones built in time you should target them onto the center of the craters.  This will destroy the creeper at its source and prevent the Creeper from spilling over the crater walls.\n\nHurry Commander!";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.createProducers,false,0,true);
      }
   }
}
