package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.Ruin;
   import com.wbwar.creeper.util.MessageDialog;
   
   public class Game4 extends Game
   {
      
      public static var title:String = "Cetus";
      
      public static var gameData:Class = Game4_gameData;
       
      
      private var md:MessageDialog;
      
      public function Game4()
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
         var _loc1_:Ruin = new Ruin(27,25);
         _loc1_.md.textField.text = "[OPS]\nOur scientists have analyzed the Artifact... the results were at first puzzling.  This Artifact should definitely not be on this world...  it contains writing not used by Cetusians.  The analysis computers have concluded that the Artifact encodes the coordinates of five known worlds.  What is special about these worlds, the Artifact doesn\'t say.\n\n[Commander]\nPick the first of the coordinates and program them into the Totems.  Since we don\'t have any other place to go, we might as well find out what is special about these worlds.\n\n[OPS]\nOne more thing Commander... the dating computer has determined that the Artifact is 11,261 years old.  Whatever it is, the coordinates were carved into it in the year 2010....";
         disableGame();
         Creeper.instance.gameScreen.playGameMusic(2,4);
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         enableGame();
         _loc2_ = new GlopProducer(4,0);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 200;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(8,0);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 200;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(0,4);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 200;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(0,8);
         _loc2_.productionBaseAmt = 1;
         _loc2_.productionInterval = 200;
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
         this.md.textField.text = "[OPS]\nCommander, there is information I have been withholding since we left Hope.... When the data banks were lost we also lost the coordinates for most of the worlds the Old Man left us.  We can go anywhere, yet we have no knowledge of where to go.\n\nAll worlds are lost and covered in Creeper... but the path given to us by the Old Man must have had some reason and meaning.  But now we may never know.  I know I should not have withheld this information, but I just didn\'t know how to tell you.  And Commander, this world is the last world we have coordinates for.  Even if you activate the Rift Totems, I don\'t know what coordinates to enter.  At best I will be able to pick a random world.\n\nCommander, there appears to be some sort of Artifact in the middle of the map.  We aren\'t sure... scanners can\'t determine what it is.  It is probably nothing but you might want to check it out...";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.createProducers,false,0,true);
      }
   }
}
