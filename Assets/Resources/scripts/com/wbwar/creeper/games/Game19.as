package com.wbwar.creeper.games
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.Explosion;
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopBlobProducer;
   import com.wbwar.creeper.GlopBlobProducerWave;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.GlopProducerNexus;
   import com.wbwar.creeper.Place;
   import com.wbwar.creeper.Rift;
   import com.wbwar.creeper.Ruin;
   import com.wbwar.creeper.Tech;
   import com.wbwar.creeper.ThorsHammer;
   import com.wbwar.creeper.UpgradeBox;
   import com.wbwar.creeper.util.MessageDialog;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.media.Sound;
   
   public class Game19 extends Game
   {
      
      public static var title:String = "Loki";
      
      public static var gameData:Class = Game19_gameData;
       
      
      private var md:MessageDialog;
      
      private var creeperNexus:GlopProducerNexus;
      
      private var gotThorTime:int;
      
      private var thorBuilt:Boolean;
      
      private var thorBuiltTime:int;
      
      private var creeperLow:Boolean;
      
      private var nexusDestroyedTime:int;
      
      private var victory1:Boolean;
      
      private var thorDestroyedTime:int;
      
      private var victory2:Boolean;
      
      private var blackHoleOpen:Boolean;
      
      private var thorTech:Tech;
      
      public function Game19()
      {
         super();
         gameTitle = title;
         xml = new XML(new gameData());
      }
      
      override public function gameStart() : void
      {
         super.gameStart();
         GameSpace.instance.suppressCityExit = true;
         GameSpace.instance.hideGlopBlobWaveViewer = true;
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
         var _loc1_:Ruin = new Ruin(63,1);
         _loc1_.md.textField.text = "[OPS]\nCommander, this artifact simply says:\n\"In the end, no answer is ever as elegant as its question.\"\n\n[Commander]\nOPS.... I....\nI think I understand now.  All of human history and all its future are in our hands.  Our next actions may very well be the end of everything that ever was or could be.   The memory of every person that has ever lived sums to a singular question.... \"WHY?\"\n\nThe Creeper has no purpose other than to end that question by erasing everything we have ever been.  We are the very last embers of this question... this question that must never cease to be asked....\nOdin City must not fall...\n\nREADY EVERYTHING WE HAVE OPS.  WE WILL HOLD BACK THE CREEPER WITH EVERYTHING WE HAVE!";
         disableGame();
         Creeper.instance.gameScreen.playGameMusic(5,6);
         new UpgradeBox(68,46);
         new UpgradeBox(67,46);
         new UpgradeBox(66,46);
         new UpgradeBox(65,46);
         new UpgradeBox(64,46);
         new UpgradeBox(63,46);
         this.creeperNexus = new GlopProducerNexus();
         GameSpace.instance.glopProducerLayer.addChild(this.creeperNexus);
         this.creeperNexus.x = 0 + 0;
         this.creeperNexus.y = 0 + 0;
         GameSpace.instance.rift.addEventListener(Rift.ACTIVATING3_EVENT,this.onRiftActivated,false,0,true);
         this.creeperNexus.addEventListener(GlopProducerNexus.HOLE_COMPLETE,this.onNexusDestroyed,false,0,true);
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         enableGame();
         GameSpace.instance.paused = false;
         _loc2_ = new GlopProducer(16,19);
         _loc2_.productionBaseAmt = 5;
         _loc2_.productionInterval = 20;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(22,19);
         _loc2_.productionBaseAmt = 5;
         _loc2_.productionInterval = 20;
         _loc2_.startTime = 500;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(16,26);
         _loc2_.productionBaseAmt = 5;
         _loc2_.productionInterval = 20;
         _loc2_.startTime = 100;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(22,26);
         _loc2_.productionBaseAmt = 5;
         _loc2_.productionInterval = 20;
         _loc2_.startTime = 500;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(11,22);
         _loc2_.productionBaseAmt = 5;
         _loc2_.productionInterval = 20;
         _loc2_.startTime = 2000;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(26,22);
         _loc2_.productionBaseAmt = 5;
         _loc2_.productionInterval = 20;
         _loc2_.startTime = 2000;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(19,15);
         _loc2_.productionBaseAmt = 5;
         _loc2_.productionInterval = 20;
         _loc2_.startTime = 2000;
         GameSpace.instance.addGlopProducer(_loc2_);
         _loc2_ = new GlopProducer(19,30);
         _loc2_.productionBaseAmt = 5;
         _loc2_.productionInterval = 20;
         _loc2_.startTime = 2000;
         GameSpace.instance.addGlopProducer(_loc2_);
      }
      
      override public function update() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         super.update();
         if(updateCount == 20)
         {
            this.showDialog1();
         }
         if(updateCount == 6480)
         {
            this.showDialog2();
         }
         if(updateCount == 10800)
         {
            this.showDialog5();
         }
         if(updateCount == 12960)
         {
            this.showDialog6();
         }
         if(this.gotThorTime > 0 && updateCount == this.gotThorTime + 1620)
         {
            this.showDialog9();
         }
         if(this.gotThorTime > 0 && updateCount == this.gotThorTime + 3240)
         {
            this.showDialog10();
         }
         if(this.thorBuilt && updateCount == this.thorBuiltTime + 100)
         {
            this.showDialog11();
         }
         if(this.thorBuilt && (!this.creeperLow && updateCount > 10000 && GameSpace.instance.creeperCoverage < 1000))
         {
            this.creeperLow = true;
            this.showDialog14();
         }
         if(!this.victory1 && this.nexusDestroyedTime > 0 && updateCount > this.nexusDestroyedTime + 72)
         {
            this.victory1 = true;
            this.showDialog16();
         }
         if(!this.victory2 && this.thorDestroyedTime > 0 && updateCount > this.thorDestroyedTime + 72)
         {
            this.victory2 = true;
            this.showFinal();
         }
         if(updateCount % 36 == 0 && !this.thorBuilt)
         {
            _loc2_ = GameSpace.instance.upperPlacesLayer.numChildren - 1;
            while(_loc2_ >= 0)
            {
               _loc1_ = GameSpace.instance.upperPlacesLayer.getChildAt(_loc2_) as Place;
               if(_loc1_ is ThorsHammer)
               {
                  if(!_loc1_.building)
                  {
                     this.thorBuilt = true;
                     this.thorBuiltTime = updateCount;
                  }
               }
               _loc2_--;
            }
         }
         if(this.blackHoleOpen && updateCount % 8 == 0)
         {
            GameSpace.instance.glop.addAllGlop(-0.02);
         }
      }
      
      private function onMessageDialogOkClick(param1:Event = null) : void
      {
         GameSpace.instance.paused = false;
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.onMessageDialogOkClick);
      }
      
      private function showDialog1(param1:Event = null) : void
      {
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[OPS]\nNO!  Commander, we must have been led into a trap!  The Creeper on this world is the most intense we have ever seen.  There is no way we can defend against it much less reach the Totems!!!\n\n[Commander]\nSteady OPS!....  There has to be a way....\n\n[OPS]\nI... I don\'t see how.  Maybe you can immediately build a few Collectors and place a single Blaster at the opening in the ridge just to our west.  That should buy us some time....  but the Creeper here is so intense it will soon overflow the ridge and take the city.  If you build a couple of Mortars they might be able to keep the Creeper low enough so that it doesn\'t overflow... but Commander.... at best we will be stuck here forever in a constant battle to survive!\n\nScanners also show what looks like some kind of giant Creeper Nexus...  I\'ve never seen... I\'ve never even imagined something like this.....\n\n[Commander]\nOPS, do scanners show anything else?\n\n[OPS]\nThere is an artifact... perhaps it somehow holds our salvation...?";
         this.md.show();
         GameSpace.instance.paused = true;
         this.md.addEventListener(MessageDialog.OK_CLICK,this.createProducers,false,0,true);
      }
      
      private function showDialog2(param1:Event = null) : void
      {
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[CREEPER NEXUS]\n\n---BEGIN TRANSMISSION---\n\n<ALL THAT YOU WERE HAS BEEN UNDONE>\n<NOW YOU DELIVER THE REST OF YOUR IRRELEVANCE TO US>\n<YOU TOO WILL SOON BE UNDONE>\n\n---END TRANSMISSION---";
         this.md.show();
         GameSpace.instance.paused = true;
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showDialog3,false,0,true);
      }
      
      private function showDialog3(param1:Event = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showDialog3);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[OPS]\nCommander, I don\'t know how that transmission came through....\n\n[Commander]\nBroadcast this message on all channels OPS:\n\n\"We are not undone... we carry with us all that we have been and will be.  We are the living question that survives in spite of you.\"\n\n[OPS]\nSending Sir....";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showDialog4,false,0,true);
      }
      
      private function showDialog4(param1:Event = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showDialog4);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[CREEPER NEXUS]\n\n---BEGIN TRANSMISSION---\n\n<THE PURITY OF NOTHING IS SOON UPON THIS REALM>\n<YOUR END IS HERE>\n\n---END TRANSMISSION---";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.onMessageDialogOkClick,false,0,true);
      }
      
      private function showDialog5(param1:Event = null) : void
      {
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[OPS]\nCommander, I\'m not sure what we can do....  There is just too much Creeper.  Our weapons can\'t harm that Creeper Nexus.... \n\n[Commander]\nI won\'t give in OPS.  We must fight, there... there must be a way....!";
         this.md.show();
         GameSpace.instance.paused = true;
         this.md.addEventListener(MessageDialog.OK_CLICK,this.onMessageDialogOkClick,false,0,true);
      }
      
      private function showDialog6(param1:Event = null) : void
      {
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[PLATIUS]\nGreetings young one....";
         this.md.show();
         GameSpace.instance.paused = true;
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showDialog7,false,0,true);
      }
      
      private function showDialog7(param1:Event = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showDialog7);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[Commander]\nPlatius...?  Who..., how..., where are...?\n\n[Platius]\nCome my young friend....  There is little time.  Look for what I send.... Take it and the stone you were given by the scientist you saved.  That stone is the key.  Act quickly, you will know what you and you alone must do.\n\n[Commander]\nPLATIUS WAIT!!!???\n\n[Platius]\n-- end transmission --";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showFinalArtifact,false,0,true);
      }
      
      private function showFinalArtifact(param1:Event = null) : void
      {
         GameSpace.instance.paused = false;
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showFinalArtifact);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[OPS]\nAn object has appeared on the map just outside the ridge Commander.  Throw everything you can at that area and retrieve it!";
         this.md.show();
         this.thorTech = new Tech(50,18,Tech.TECH_THOR);
         new Explosion(this.thorTech.x,this.thorTech.y,3182640,65280,0.3,20);
         this.thorTech.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.thorTech.md.textField.text = "[OPS]\nCommander... we have retrieved the object that appeared after you spoke with Platius.... but it doesn\'t seem to do or mean anything...\n\n[Commander]\nTake this stone OPS...\n\n[OPS]\nIntegrating the stone now Commander....";
         this.thorTech.md.addEventListener(MessageDialog.OK_CLICK,this.showDialog8,false,0,true);
      }
      
      private function showDialog8(param1:Event = null) : void
      {
         this.thorTech.md.removeEventListener(MessageDialog.OK_CLICK,this.showDialog8);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[OPS]\n....unbelievable....\nThe stone has integrated into the object and it has activated.  A nano schematic for some kind of super weapon called \"Thor\" has been integrated into our computers by the object.  The object itself appears to have become some kind of extremely powerful energy source.  The readings are off the scale....  Commander, this new Thor weapon will require an unimaginable amount of energy.... but this object appears as if it can somehow produce the required energy.  Also, this weapon appears as if it will require a pilot...\n\n[Commander]\nOPS, there isn\'t much time.  I\'ll start construction of the new Thor weapon.  I may have to clear away some of the network infrastructure... this beast is going to take space and large amounts of build packets to complete.  Do everything you can to boost the city\'s output.  We need everything Odin City can deliver.  Once complete, I will personally pilot the Thor and end the Creeper once and for all.\n\n[OPS]\nSir... I\'ll do everything I can.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.onMessageDialogOkClick,false,0,true);
         this.gotThorTime = updateCount;
      }
      
      private function showDialog9(param1:Event = null) : void
      {
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[CREEPER NEXUS]\n\n---BEGIN TRANSMISSION---\n\n<THE WEAPONS OF THE OTHERS ARE IRRELEVANT>\n<THEY WILL BE UNDONE AS WELL>\n\n---END TRANSMISSION---";
         this.md.show();
      }
      
      private function showDialog10(param1:Event = null) : void
      {
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[CREEPER NEXUS]\n\n---BEGIN TRANSMISSION---\n\n<YOU WILL SOON BE UNDONE>\n\n---END TRANSMISSION---";
         this.md.show();
      }
      
      private function showDialog11(param1:Event = null) : void
      {
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[CREEPER NEXUS]\n\n---BEGIN TRANSMISSION---\n\n<NO!>\n<THE UNDOING MUST BE COMPLETED!>\n\n---END TRANSMISSION---";
         this.md.show();
         GameSpace.instance.paused = true;
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showDialog12,false,0,true);
      }
      
      private function showDialog12(param1:Event = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showDialog12);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[Commander]\nIt\'s your turn Creeper menace....  YOU will now be the one undone!";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showDialog13,false,0,true);
      }
      
      private function showDialog13(param1:Event = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showDialog12);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[OPS]\nCommander, the Thor is unbelievable!  With the Thor you can clear away unbelievable amounts of Creeper!  This will allow us to build a network and reach the Totems..... but what coordinates do I enter?  Where will we flee to next?\n\n[Commander]\nWe aren\'t fleeing anywhere OPS.  I know what Platius meant now.  Enter the coordinates I\'m sending.  I\'ll clear away the Creeper and connect the Totems, just make sure the coordinates are entered and Totem packets are ready to send.\n\n[OPS]\nWhere do the coordinates lead?\n\n[Commander]\nI don\'t know OPS..... I really don\'t know.  I just know these are the coordinates we are supposed to enter.\n\n[OPS]\nSir, I\'ve followed you through everything... I believe in you.  Entering the coordinates...";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.onMessageDialogOkClick,false,0,true);
      }
      
      private function showDialog14(param1:Event = null) : void
      {
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[CREEPER NEXUS]\n\n---BEGIN TRANSMISSION---\n\n<THE POWER OF THE OTHERS IS TRULY IMPRESSIVE>\n<BUT THEIR POWER CAN NOT UNDO US>\n<WE ARE ETERNAL AND UNENDING!>\n\n---END TRANSMISSION---";
         this.md.show();
         GameSpace.instance.paused = true;
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showDialog15,false,0,true);
      }
      
      private function showDialog15(param1:Event = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showDialog15);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[OPS]\nCommander that thing appears to be right.  Thor can destroy any Creeper it emits, but you can\'t damage the Creeper Nexus!\n\n[Commander]\nMaintaining the assault OPS.  I\'ll dish out everything Thor has....\nI\'ll hold back the Creeper until we can get the Totems charged.  Maybe once the Rift activates.....\nThere has to be a way OPS, there has to!";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showDialog15_2,false,0,true);
      }
      
      private function showDialog15_2(param1:Event = null) : void
      {
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[CREEPER NEXUS]\n\n---BEGIN TRANSMISSION---\n\n<NOW BEAR WITNESS TO OUR ALL ENDING SPORES!>\n\n---END TRANSMISSION---";
         this.md.show();
         GameSpace.instance.paused = true;
         this.md.addEventListener(MessageDialog.OK_CLICK,this.onMessageDialogOkClick,false,0,true);
         var _loc2_:GlopBlobProducer = new GlopBlobProducer();
         var _loc3_:GlopBlobProducerWave = new GlopBlobProducerWave(72,999,10,4320,0.2,GlopBlobProducerWave.SIDE_LEFT);
         _loc2_.waves.push(_loc3_);
         GameSpace.instance.glopBlobProducer = _loc2_;
      }
      
      private function onRiftActivated(param1:Event = null) : void
      {
         GameSpace.instance.glopBlobProducer = null;
         this.blackHoleOpen = true;
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[OPS]\nCommander!!!!  The Rift has opened.... the coordinates you gave me have opened the Rift onto the black hole in the galactic core!  This has never been done... it can\'t be done!!!!!!\n\nThe Rift channel is conducting massive amounts of gravitational attraction back to the Rift on this end.  Everything will be sucked in and destroyed!!!!!";
         this.md.show();
         GameSpace.instance.paused = true;
         this.md.addEventListener(MessageDialog.OK_CLICK,this.onMessageDialogOkClick,false,0,true);
      }
      
      private function onNexusDestroyed(param1:Event = null) : void
      {
         this.nexusDestroyedTime = updateCount;
      }
      
      private function showDialog16(param1:Event = null) : void
      {
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,650,-1,true);
         this.md.textField.text = "[OPS]\nThe Creeper Nexus and all of the emitters have been sucked into the black hole!\nWe have defeated the Nexus and saved our people!";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showDialog17,false,0,true);
      }
      
      private function showDialog17(param1:Event = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showDialog17);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         if(this.thorBuilt)
         {
            this.md.textField.text = "[OPS]\nCo_m_and_r...  Come in Com_an_er!!!\nThe bla_k h_le is st_ll o_en a_d wi_l de_tr_y ev_ryth_ng!!!\n\n[Commander]\nOPS, OPS!!!  Come in!  I can\'t allow the black hole to destroy everything after all we have been through.... There is only one choice!  I will pilot the Thor into the hole and detonate its power source at the event horizon.  This might close the Rift and save the planet!  Heading in now OPS....\n\nTake care of the city... It has been an honor and privilege to lead our people!";
            this.md.show();
            this.md.addEventListener(MessageDialog.OK_CLICK,this.sendInThor,false,0,true);
         }
         else
         {
            this.md.textField.text = "[KNUCKLE CRACKER]\nWell aren\'t you just AWESOME!  You defeated the Creeper and you never built Thor.  If you had built Thor, then you\'d be closing the Black Hole right about now by flying it in and sacrificing yourself.  But, you were so good at this game that you never built it.  You just had to take on the Creeper old school style.  Well, we will just overlook this for the moment and pretend that you did.  Btw, since you are so good at this maybe you should go make and play some custom maps!";
            this.md.show();
            this.md.addEventListener(MessageDialog.OK_CLICK,this.onThorAtHole,false,0,true);
         }
      }
      
      private function sendInThor(param1:Event = null) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         this.onMessageDialogOkClick();
         var _loc4_:int = GameSpace.instance.upperPlacesLayer.numChildren - 1;
         while(_loc4_ >= 0)
         {
            _loc3_ = GameSpace.instance.upperPlacesLayer.getChildAt(_loc4_) as Place;
            if(_loc3_ is ThorsHammer)
            {
               _loc2_ = _loc3_ as ThorsHammer;
               break;
            }
            _loc4_--;
         }
         if(_loc2_ != null)
         {
            _loc2_.mouseEnabled = false;
            _loc2_.mouseChildren = false;
            GameSpace.instance.controlPanel.onCancelButtonClick();
            _loc2_.move(GameSpace.instance.rift.gameSpaceX,GameSpace.instance.rift.gameSpaceY);
            _loc2_.addEventListener(ThorsHammer.AT_DESTINATION,this.onThorAtHole,false,0,true);
         }
      }
      
      private function onThorAtHole(param1:Event = null) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc4_:int = GameSpace.instance.upperPlacesLayer.numChildren - 1;
         while(_loc4_ >= 0)
         {
            _loc3_ = GameSpace.instance.upperPlacesLayer.getChildAt(_loc4_) as Place;
            if(_loc3_ is ThorsHammer)
            {
               _loc2_ = _loc3_ as ThorsHammer;
               break;
            }
            _loc4_--;
         }
         if(_loc2_ != null)
         {
            _loc2_.destroy();
            (_loc5_ = new NexusDestroyedSound()).play();
         }
         GameSpace.instance.rift.destroy();
         this.blackHoleOpen = false;
         new Explosion(GameSpace.instance.rift.x,GameSpace.instance.rift.y,6316128,16777215,5,50);
         new Explosion(GameSpace.instance.rift.x,GameSpace.instance.rift.y,6316128,16777215,4,50);
         new Explosion(GameSpace.instance.rift.x,GameSpace.instance.rift.y,6316128,16777215,3,50);
         new Explosion(GameSpace.instance.rift.x,GameSpace.instance.rift.y,6316128,16777215,2,50);
         new Explosion(GameSpace.instance.rift.x,GameSpace.instance.rift.y,6316128,16777215,1,50);
         this.thorDestroyedTime = updateCount;
      }
      
      private function showFinal(param1:Event = null) : void
      {
         var _loc2_:Sprite = new Sprite();
         _loc2_.alpha = 0;
         _loc2_.graphics.beginFill(0);
         _loc2_.graphics.drawRect(0,0,700,525);
         _loc2_.graphics.endFill();
         GameSpace.instance.tutorialLayer.addChild(_loc2_);
         GameSpace.instance.paused = true;
         Creeper.instance.gameScreen.stopGameMusic();
         Tweener.addTween(_loc2_,{
            "time":2,
            "delay":2,
            "transition":"linear",
            "_autoAlpha":1,
            "onComplete":this.showFinal2
         });
      }
      
      private function showFinal2(param1:Event = null) : void
      {
         Creeper.instance.gameScreen.playGameMusic(7,7);
         Tweener.addTween(this,{
            "time":4,
            "onComplete":this.showFinal3
         });
      }
      
      private function showFinal3(param1:Event = null) : void
      {
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[Platius]\nHello again young one....";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showFinal4,false,0,true);
      }
      
      private function showFinal4(param1:Event = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showFinal4);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[Commander]\nPlatius....  Where.... Where am I?\n\n[Platius]\nYou are with me young one.\n\n[Commander]\nAm I dead?";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showFinal5,false,0,true);
      }
      
      private function showFinal5(param1:Event = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showFinal5);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[Platius]\nYou would be.... had I not saved you....\n\nYou released the energy of the Thor reactor and sealed the Rift.  You would have been completely destroyed along with the Thor had I not taken you away at the last moment.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showFinal6,false,0,true);
      }
      
      private function showFinal6(param1:Event = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showFinal6);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[Commander]\nWHO are you Platius?\n\n[Platius]\nI have had many names.  I have walked amongst your people when they left the plains of ancient Earth.  I have been there when the first stones were set at Babylon.  When your ancestors sailed for new worlds I was there.  Through great and terrible wars I have been there.  For the thousands of years you have spread through this galaxy I have been there.  And now, most recently, you have come to know me as Platius.  Your people know me as the \"Old Man\".";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showFinal7,false,0,true);
      }
      
      private function showFinal7(param1:Event = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showFinal7);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[Commander]\nYOU ARE THE OLD MAN??  I don\'t understand how you could be all of those people or how you could help us now...\n\nWhat is the Creeper and where did it come from?  Where are you from and how are you able to help us?  How did you know what would happen and where we would be?....\n\n[Platius]\nHa ha young one!  Patience... in time you will understand everything.  For now I can tell you that what you call the \"Creeper\" is a degenerated form of a race called the Loki.  You see, this galaxy is but a grain in the vast multiverse expanse.  Space is nearly infinite and extends far, far beyond what you call the observable universe.  But, time is not infinite.... at least not for this reality.  So there was a beginning and the Loki were amongst the first to rise to greatness.  They rivaled even my people in their power and wisdom.  But long before your world was even formed, the Loki changed.  They peered into other realities at their greatest moment and when they looked away they were forever changed.  They became a force of destruction that sought to destroy all of the other races.  They desired the \"purity of nothingness\" above all things.  My people fought them for millions of years.  But their power was too great... ";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showFinal8,false,0,true);
      }
      
      private function showFinal8(param1:Event = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showFinal8);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[Platius]\nMy people..... my people are now gone.  I and I alone carry their memory.  My people sacrificed everything to weaken the Loki as much as they could.  Had they not done so, all beings everywhere would have fallen to the Loki.  In a cataclysm that spanned a galactic cluster, all of my people fought and sacrificed themselves to destroy the Loki.  Only I was chosen to stay behind.  Only I would bear the task of continuing the memory of my race.... Only I.....";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showFinal9,false,0,true);
      }
      
      private function showFinal9(param1:Event = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showFinal9);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[Commander]\nPlatius... that is incredible.  But the Loki were not all destroyed?\n\n[Platius]\nNo young one... the Loki were stronger.  They were nearly destroyed, but a single Nexus remained.  It hid in the ruins of the conflict with its rage growing stronger with each passing millennium.  Then when the memories of the great conflict had all but passed into oblivion, it emerged.  The rage and destruction of the Loki once again ravaged worlds where new life had emerged and grown.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showFinal10,false,0,true);
      }
      
      private function showFinal10(param1:Event = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showFinal10);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[Commander]\nHow long ago was this Platius?\n\n[Platius]\nWhen your Earth was covered with giant and terrible beasts, the Loki Nexus emerged.  But the Loki were far from Earth.  Many thousands of galaxies would fall before they would come to your people.\n\n[Commander]\nYou were on Earth tens of millions of years ago?\n\n[Platius]\nYes young one.  The Earth held great potential, and greatness would be necessary to fight the Loki.  So I have seeded many worlds with the \"encouragements\" of intelligence.  For your Earth, only a small impact would destroy the beasts and open a path for your emergence.  Your people would grow with \"encouragements\" along the way.  And this path has brought you to this moment.";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showFinal11,false,0,true);
      }
      
      private function showFinal11(param1:Event = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showFinal11);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[Commander]\nBut we were nearly destroyed... everything we were is gone...\n\n[Platius]\nOh young one... you still have much to learn.  Your people live and their greatness will rise again.  You have defeated a Nexus which so few have.  You will grow from this world in the millennia to come and perhaps one day we will all stand in victory over the last of the Loki...\n\n[Commander]\nPlatius, what abou...\n\n[Platius]\nIt is time for me to go young one.  Do not worry I will not be far.  You have much left to do for your people.\n\n[Commander]\nPlatius wait!";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.showFinal12,false,0,true);
      }
      
      private function showFinal12(param1:Event = null) : void
      {
         this.md.removeEventListener(MessageDialog.OK_CLICK,this.showFinal12);
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,550,-1,true);
         this.md.textField.text = "[Platius]\nI return you now to your great city.  Lead your people in peace and return to greatness.... Commander.\n\n\nAnd oh yes, do not become too complacent.....\nFor I will need you again soon.\n\nGoodbye my young friend, goodbye...... \n             ....for now....";
         this.md.show();
         this.md.addEventListener(MessageDialog.OK_CLICK,this.exitGame,false,0,true);
      }
      
      private function exitGame(param1:Event = null) : void
      {
         Creeper.instance.gameScreen.showResultsScreen();
      }
   }
}
