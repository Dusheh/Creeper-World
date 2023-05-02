package com.wbwar.creeper.games
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.Place;
   import com.wbwar.creeper.SurvivalPod;
   import com.wbwar.creeper.util.MessageDialog;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class Game6 extends Game
   {
      
      public static var title:String = "Corvus";
      
      public static var gameData:Class = Game6_gameData;
       
      
      private var md:MessageDialog;
      
      private var gamd:MessageDialog;
      
      private var gotAllSurvivalPods:Boolean;
      
      public function Game6()
      {
         super();
         gameTitle = title;
         xml = new XML(new gameData());
      }
      
      override public function gameStart() : void
      {
         var _loc1_:* = null;
         super.gameStart();
         GameSpace.instance.controlPanel.buildMenu.nodeButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.relayButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.energyStoreButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.logisticsButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.energyAmpButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.gunButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.areaGunButton.mystery = false;
         GameSpace.instance.controlPanel.buildMenu.abmButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.droneBaseButton.mystery = true;
         GameSpace.instance.controlPanel.buildMenu.thorsHammerButton.mystery = true;
         _loc1_ = new SurvivalPod(52,18);
         _loc1_.md.textField.text = "Survivors rescued!";
         _loc1_ = new SurvivalPod(65,42);
         _loc1_.md.textField.text = "Survivors rescued!";
         _loc1_ = new SurvivalPod(37,18);
         _loc1_.md.textField.text = "Survivors rescued!";
         _loc1_ = new SurvivalPod(38,1);
         _loc1_.md.textField.text = "Survivors rescued!";
         _loc1_ = new SurvivalPod(37,36);
         _loc1_.md.textField.text = "Survivors rescued!";
         _loc1_ = new SurvivalPod(21,35);
         _loc1_.md.textField.text = "Survivors rescued!";
         _loc1_ = new SurvivalPod(27,13);
         _loc1_.md.textField.text = "Survivors rescued!";
         disableGame();
         Creeper.instance.gameScreen.playGameMusic(2,4);
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         enableGame();
         _loc2_ = new GlopProducer(0,4);
         _loc2_.productionBaseAmt = 4;
         _loc2_.productionInterval = 30;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(0,34);
         _loc2_.productionBaseAmt = 4;
         _loc2_.productionInterval = 30;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
      }
      
      override public function update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         super.update();
         if(updateCount == 20)
         {
            this.showDialog1();
         }
         if(updateCount % 36 == 0)
         {
            if(!this.gotAllSurvivalPods)
            {
               _loc1_ = 0;
               _loc3_ = GameSpace.instance.places.placesLayer.numChildren - 1;
               while(_loc3_ >= 0)
               {
                  _loc2_ = GameSpace.instance.places.placesLayer.getChildAt(_loc3_) as Place;
                  if(_loc2_ is SurvivalPod)
                  {
                     _loc1_++;
                  }
                  _loc3_--;
               }
               if(_loc1_ == 0)
               {
                  this.gotAllSurvivalPods = true;
                  this.gamd = new MessageDialog(MessageDialog.SIDE_TOP,-1,650,-1,true);
                  this.gamd.textField.text = "[OPS]\nAll survival pods have been secured Commander. Twenty seven people have been saved.  Great job!  One of the survivors has told us that they are the crew of a science mission that has been in extra-galactic deep space for the last 20 years.  They had just recently returned to our galaxy to find every world they visited covered in Creeper.  Eventually, they ran out of fuel and settled into orbit around this world.  There they stayed until they could no longer maintain orbit.  They had just entered their escape pods and crashed on the surface moments before Odin City rifted through.\n\nAnd Commander, one of the survivors claims he was approached by an Old Man over twenty years ago.  He was given a stone by the Old Man before he and his crew set out on their deep space mission.  The Old Man told him it would keep him and his crew safe on their journey.  He also was told that one day, in his moment of greatest need, others on a great journey would find him and save him... and that on that day the stone would find a new home with the leader of those others.\n\n[Commander]\nLet me see this man and his good luck charm in my Ready Room.  Have him wait there until I get a moment to speak with him.\n\n[OPS]\nYes sir.";
                  this.gamd.show();
                  GameSpace.instance.paused = true;
                  this.gamd.okButton.addEventListener(MouseEvent.CLICK,this.survivorDialogDismissed,false,100,true);
               }
            }
         }
      }
      
      private function survivorDialogDismissed(param1:Event = null) : *
      {
         GameSpace.instance.paused = false;
      }
      
      private function showDialog1() : void
      {
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,650,-1,true);
         this.md.textField.text = "[OPS]\nThe once lush ocean world of Corvus....  I always dreamed of visiting this beautiful world.  Now it is a dry, barren rock.  The Creeper knows no end to its destructive power.\n\nCommander, I show something on scanners.... MY GODS!  There are survival pods on this world!  They must have recently landed after staying in orbit as long as possible.\n\n[Commander]\nNotify the medical centers to expect casualties.  We\'re going to save those people.... too many have been taken by the Creeper already.\n\n[OPS]\nThe whole city is on alert status and Medical are mobilizing.  Build out a network to connect to the pods so we can rescue the survivors.  Sensors show that the Creeper has massed and is rushing this way in a wave like we have never encountered.  It must sense the survivors somehow.  You will need to act quickly and aggressively to save the survivors...\nGo save them Commander!";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.createProducers,false,0,true);
      }
   }
}
