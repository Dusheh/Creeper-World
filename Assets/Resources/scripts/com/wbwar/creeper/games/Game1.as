package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.Tech;
   import com.wbwar.creeper.util.MessageDialog;
   
   public class Game1 extends Game
   {
      
      public static var gameData:Class = Game1_gameData;
      
      public static var title:String = "Taurus";
       
      
      private var md:MessageDialog;
      
      public function Game1()
      {
         super();
         gameTitle = title;
         xml = new XML(new gameData());
      }
      
      override public function gameStart() : void
      {
         super.gameStart();
         GameSpace.instance.controlPanel.buildMenu.nodeButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.relayButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.energyStoreButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.logisticsButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.energyAmpButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.gunButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.areaGunButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.abmButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.droneBaseButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.thorsHammerButton.mystery = true;
         new Tech(28,43,Tech.TECH_RELAY);
         GameSpace.instance.controlPanel.buildMenu.enableAll(false);
         GameSpace.instance.baseGun.canMove = false;
         Creeper.instance.gameScreen.playGameMusic(1,4);
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         GameSpace.instance.controlPanel.buildMenu.enableAll(true);
         GameSpace.instance.baseGun.canMove = true;
         _loc2_ = new GlopProducer(69,24);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 75;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(25,47);
         _loc2_.productionBaseAmt = 0.75;
         _loc2_.productionInterval = 200;
         _loc2_.startTime = 200;
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
         this.md.textField.text = "[OPS]\nRift Complete!\nWe have Rifted to the next world.  Now that our journey has begun our goal is to leave each world as quickly as possible.\n\nOn each world we visit, the Creeper will be hunting us.  It has destroyed thousands of worlds and won\'t hesitate to destroy the few of us that remain.\n\nCommander I have some bad news. Our first Rift jump has erased our data banks! We\'ve lost valuable nano schematics.  As we visit new worlds we will have to collect whatever technology we find to rebuild our data banks.\n\nScanners indicate that there is some small good news to report.  There is a nano schematic for building Relays at the bottom of your console.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showDialog5,false,0,true);
      }
      
      private function showDialog5(param1:Object = null) : void
      {
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,650,-1,true);
         this.md.textField.text = "[OPS]\nWe need to collect this tech and then activate the Rift Totems.  I recommend building one or two blasters and using them to push back the Creeper that is headed this way from the south.\n\nMove your blasters forward slowly a small jump at a time.  Each time you jump, build collectors behind the Blasters to extend your network. Once you get the nano schematic connected to our network, we will be able to build Relays again.  And once we can build Relays, you can quickly build a network to connect and charge the Totems.\n\nNow get busy Commander, our lives depend on you!";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.createProducers,false,0,true);
      }
   }
}
