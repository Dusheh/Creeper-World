package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.Ruin;
   import com.wbwar.creeper.UpgradeBox;
   import com.wbwar.creeper.util.MessageDialog;
   
   public class Game18 extends Game
   {
      
      public static var title:String = "Pyxis";
      
      public static var gameData:Class = Game18_gameData;
       
      
      private var md:MessageDialog;
      
      public function Game18()
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
         new UpgradeBox(3,44);
         new UpgradeBox(4,44);
         new UpgradeBox(5,44);
         new UpgradeBox(64,44);
         new UpgradeBox(65,44);
         new UpgradeBox(66,44);
         var _loc1_:Ruin = new Ruin(35,25);
         _loc1_.md.textField.text = "[OPS]\nCommander, this artifact contains a message addressed specifically to you.  This is unbelievable.... the message reads as follows: \n\n\"Greetings my young friend.  You have grown much.  It pleases me greatly that you and your people have made it this far.  Through all of your human history I always believed you would make it.  The others were not so sure....  You have one final task ahead young one, and you know what you must do.\n\nPlatius\"\n\n[OPS]\nCommander?!?!?  What must you do??\n\n[Commander]\nI.... Lay in a course for the next world OPS.  Our journey nears its end.\n\n[OPS]\nCommander....?\n\n[Commander]\nBelieve in me OPS.... Enter the coordinates.\n\n[OPS]\nSir....";
         disableGame();
         Creeper.instance.gameScreen.playGameMusic(2,4);
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         enableGame();
         _loc2_ = new GlopProducer(34,0);
         _loc2_.productionBaseAmt = 2;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(35,0);
         _loc2_.productionBaseAmt = 2;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(36,0);
         _loc2_.productionBaseAmt = 2;
         _loc2_.productionInterval = 50;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(5,0);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 100;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(64,0);
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
         this.md.textField.text = "[OPS]\nSir, I\'ve checked the scanners twice but they are correct.  The terrain here has been modified in ways we\'ve never seen.  The Pyxians never terraformed their planet this way.  The terrain has been layered into terraces.  There are Creeper resistance walls on the top terrace that are containing three Creeper emitters.  If it weren\'t for those walls we would be dead in minutes.  They won\'t hold forever, though, so you\'ll have to act quickly to build our defenses.\n\nCommander, I feel it is my duty to ask you what is going on and who \"Platius\" is?  His name was on the artifact we recovered on Canis.\n\n[Commander]\nPlatius is no one I have ever met.  I only know his name, yet I owe him my life.  My birth parents were killed in the Tucana raids when I was only an infant.  I would have perished too, but a man named Platius saved me somehow and took me to Aquila where I was adopted and raised.  My parents only know that on the night of Galactic Festival a man delivered me into their arms, smiled kindly and then walked away.  They asked his name as he left and he only said, \"Tell the young one that my name is Platius.\"  At that moment the fireworks of the Galactic festival apexed and everyone was awed by their light.  The sparkling lights reflected off my infant eyes and when my parents looked down, the man was gone.\n\nAnd OPS, as for what is going on.... all I can say is that we are surviving one world at a time.  I wish I knew more, I only know somehow that we must keep going.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.createProducers,false,0,true);
      }
   }
}
