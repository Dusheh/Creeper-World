package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.Tech;
   import com.wbwar.creeper.util.MessageDialog;
   
   public class Game5 extends Game
   {
      
      public static var title:String = "Ara";
      
      public static var gameData:Class = Game5_gameData;
       
      
      private var md:MessageDialog;
      
      public function Game5()
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
         GameSpace.instance.controlPanel.buildMenu.areaGunButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.abmButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.droneBaseButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.thorsHammerButton.mystery = true;
         new Tech(57,31,Tech.TECH_LOGISTICS);
         disableGame();
         Creeper.instance.gameScreen.playGameMusic(2,4);
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         enableGame();
         _loc2_ = new GlopProducer(17,14);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 100;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(34,14);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 100;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(50,14);
         _loc2_.productionBaseAmt = 1;
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
         this.md.textField.text = "[OPS]\nFascinating.....  The coordinates we got from the Artifact on Cetus have taken us to the step-pyramid ruins on a world called Ara.  This world was one of the first worlds destroyed by the Creeper.  How some numbers written on a tablet in the year 2010 could come to represent this exact location must be some sort of crazy cosmic coincidence.\n\n[Commander]\nPerhaps.....   OPS is there anything of tangible value on this world?\n\n[OPS]\nScanners calibrating.... yes... there appears to be a nano schematic for improving the efficiency of our network.  Commander, this tech will allow the construction of nodes that provide a global speed-up to all packets.  This could be very useful for supporting larger networks and keeping Blasters and Mortars well supplied over long distances.\n\nCommander, remember that Blasters can\'t fire at elevations higher than themselves.  Since you will have to fight up the steps of a great pyramid, you will have to be aggressive with your Blasters and move them into the Creeper.  The Blasters can take some moderate exposure to the Creeper.  Just make sure you have the Blasters supplied with a nearby network node when you make a move to take higher ground.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.createProducers,false,0,true);
      }
   }
}
