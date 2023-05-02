package com.wbwar.creeper.games
{
   import com.dynamicflash.util.Base64;
   import com.wbwar.creeper.ABM;
   import com.wbwar.creeper.AreaGun;
   import com.wbwar.creeper.DroneBase;
   import com.wbwar.creeper.EnergyAmp;
   import com.wbwar.creeper.EnergyStorage;
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopBlobProducer;
   import com.wbwar.creeper.GlopBlobProducerWave;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.Gun;
   import com.wbwar.creeper.Logistics;
   import com.wbwar.creeper.Mine;
   import com.wbwar.creeper.Node;
   import com.wbwar.creeper.Relay;
   import com.wbwar.creeper.Ruin;
   import com.wbwar.creeper.SurvivalPod;
   import com.wbwar.creeper.Tech;
   import com.wbwar.creeper.UpgradeBox;
   import com.wbwar.creeper.util.BackgroundImageLoader;
   import com.wbwar.creeper.util.MessageDialog;
   import com.wbwar.creeper.util.MessageDialogScrolling;
   import flash.display.Bitmap;
   import flash.utils.unescapeMultiByte;
   
   public class CustomGame extends Game
   {
       
      
      private var md:MessageDialogScrolling;
      
      public var workingMap:Boolean;
      
      public var gameName:String;
      
      public var creeperColor:int = 3355545;
      
      public var creeperMistColor1:int = 5263568;
      
      public var creeperMistColor2:int = 5263600;
      
      private var lockedCity:Boolean = false;
      
      public var hash:String;
      
      public function CustomGame(param1:String = null)
      {
         var bil:BackgroundImageLoader = null;
         var encodedBackgroundData:String = null;
         var customGame:String = param1;
         super();
         this.gameName = customGame;
         try
         {
            if(false)
            {
               this.hash = Creeper.getCustomGameUIDFunction(customGame);
            }
            if(false)
            {
               xml = Creeper.loadCustomGameFunction(customGame);
            }
            else
            {
               xml = null;
            }
            if(xml == null)
            {
               xml = <game>
						<terrain><terrainHeight/></terrain>
						<walls><wallData/></walls>
						<background><backgroundMap>0</backgroundMap></background>
						<places/>
						<specialplaces>
							<BaseGun>
							  <gameSpaceX>35</gameSpaceX>
							  <gameSpaceY>24</gameSpaceY>
							  <health>0</health>
							  <energyLevel>0</energyLevel>
							</BaseGun>
							<Rift>
							  <gameSpaceX>35</gameSpaceX>
							  <gameSpaceY>24</gameSpaceY>
							  <health>0</health>
							  <energyLevel>0</energyLevel>
							</Rift>
						</specialplaces>
						<title>ERROR%20LOADING%20%20MAP%20</title>
						<opening>ERROR%20LOADING%20%20MAP%20</opening>
					</game>;
            }
            if(false && xml.custombackground.length() > 0)
            {
               bil = new BackgroundImageLoader();
               encodedBackgroundData = "null";
               super.hasCustomBackground = true;
               bil.loadByteArray(Base64.decodeToByteArray(encodedBackgroundData),this.onCustomBackgroundLoaded);
            }
            if(xml.creeper.color != null && xml.creeper.color.length() > 0)
            {
               this.creeperColor = xml.creeper.color;
               this.creeperMistColor1 = xml.creeper.mistColor1;
               this.creeperMistColor2 = xml.creeper.mistColor2;
            }
            gameTitle = unescapeMultiByte(xml.title);
         }
         catch(e:Error)
         {
         }
      }
      
      private function onCustomBackgroundLoaded(param1:Bitmap) : void
      {
         super.customBackground = param1;
      }
      
      override public function gameStart() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc17_:* = null;
         var _loc18_:Number = NaN;
         super.gameStart();
         GameSpace.instance.controlPanel.buildMenu.nodeButton.mystery = xml.tech.collector == "false";
         GameSpace.instance.controlPanel.buildMenu.relayButton.mystery = xml.tech.relay == "false";
         GameSpace.instance.controlPanel.buildMenu.energyStoreButton.mystery = xml.tech.storage == "false";
         GameSpace.instance.controlPanel.buildMenu.logisticsButton.mystery = xml.tech.speed == "false";
         GameSpace.instance.controlPanel.buildMenu.energyAmpButton.mystery = xml.tech.reactor == "false";
         GameSpace.instance.controlPanel.buildMenu.gunButton.mystery = xml.tech.blaster == "false";
         GameSpace.instance.controlPanel.buildMenu.areaGunButton.mystery = xml.tech.mortar == "false";
         GameSpace.instance.controlPanel.buildMenu.abmButton.mystery = xml.tech.sam == "false";
         GameSpace.instance.controlPanel.buildMenu.droneBaseButton.mystery = xml.tech.drone == "false";
         GameSpace.instance.controlPanel.buildMenu.thorsHammerButton.mystery = xml.tech.thor != "true";
         for each(_loc1_ in xml.upgrades.elements())
         {
            new UpgradeBox(_loc1_.gameSpaceX,_loc1_.gameSpaceY);
         }
         for each(_loc3_ in xml.pods.elements())
         {
            _loc2_ = new SurvivalPod(_loc3_.gameSpaceX,_loc3_.gameSpaceY);
            _loc2_.md.textField.text = "Survivors rescued!";
         }
         for each(_loc5_ in xml.ruins.elements())
         {
            (_loc4_ = new Ruin(_loc5_.gameSpaceX,_loc5_.gameSpaceY)).md.textField.text = unescapeMultiByte(_loc5_.desc);
         }
         for each(_loc6_ in xml.techs.elements())
         {
            _loc7_ = new Tech(_loc6_.gameSpaceX,_loc6_.gameSpaceY,_loc6_.tech);
            GameSpace.instance.places.addPlace(_loc7_);
         }
         for each(_loc6_ in xml.collectors.elements())
         {
            _loc8_ = new Node(_loc6_.gameSpaceX,_loc6_.gameSpaceY);
            _loc8_.health = _loc8_.maxHealth;
            GameSpace.instance.places.addPlace(_loc8_);
         }
         for each(_loc6_ in xml.relays.elements())
         {
            _loc9_ = new Relay(_loc6_.gameSpaceX,_loc6_.gameSpaceY);
            _loc9_.health = _loc9_.maxHealth;
            GameSpace.instance.places.addPlace(_loc9_);
         }
         for each(_loc6_ in xml.storage.elements())
         {
            _loc10_ = new EnergyStorage(_loc6_.gameSpaceX,_loc6_.gameSpaceY);
            _loc10_.health = _loc10_.maxHealth;
            GameSpace.instance.places.addPlace(_loc10_);
         }
         for each(_loc6_ in xml.speed.elements())
         {
            _loc11_ = new Logistics(_loc6_.gameSpaceX,_loc6_.gameSpaceY);
            _loc11_.health = _loc11_.maxHealth;
            GameSpace.instance.places.addPlace(_loc11_);
         }
         for each(_loc6_ in xml.reactors.elements())
         {
            _loc12_ = new EnergyAmp(_loc6_.gameSpaceX,_loc6_.gameSpaceY);
            _loc12_.health = _loc12_.maxHealth;
            GameSpace.instance.places.addPlace(_loc12_);
         }
         for each(_loc6_ in xml.blasters.elements())
         {
            _loc13_ = new Gun(_loc6_.gameSpaceX,_loc6_.gameSpaceY);
            _loc13_.health = _loc13_.maxHealth;
            if(_loc6_.armed == "true")
            {
               _loc13_.energyLevel = _loc13_.operateEnergy;
            }
            if(_loc6_.locked == "true")
            {
               _loc13_.locked = true;
            }
            GameSpace.instance.places.addPlace(_loc13_);
         }
         for each(_loc6_ in xml.mortars.elements())
         {
            _loc14_ = new AreaGun(_loc6_.gameSpaceX,_loc6_.gameSpaceY);
            _loc14_.health = _loc14_.maxHealth;
            if(_loc6_.armed == "true")
            {
               _loc14_.energyLevel = _loc14_.operateEnergy;
            }
            if(_loc6_.locked == "true")
            {
               _loc14_.locked = true;
            }
            GameSpace.instance.places.addPlace(_loc14_);
         }
         for each(_loc6_ in xml.sams.elements())
         {
            _loc15_ = new ABM(_loc6_.gameSpaceX,_loc6_.gameSpaceY);
            _loc15_.health = _loc15_.maxHealth;
            if(_loc6_.armed == "true")
            {
               _loc15_.energyLevel = _loc15_.operateEnergy;
            }
            if(_loc6_.locked == "true")
            {
               _loc15_.locked = true;
            }
            GameSpace.instance.places.addPlace(_loc15_);
         }
         for each(_loc6_ in xml.drones.elements())
         {
            _loc16_ = new DroneBase(_loc6_.gameSpaceX,_loc6_.gameSpaceY);
            _loc16_.health = _loc16_.maxHealth;
            if(_loc6_.armed == "true")
            {
               _loc16_.energyLevel = DroneBase.DRONE_ENERGY_COST;
            }
            if(_loc6_.locked == "true")
            {
               _loc16_.locked = true;
            }
            GameSpace.instance.places.addPlace(_loc16_);
         }
         for each(_loc6_ in xml.mines.elements())
         {
            _loc17_ = new Mine(_loc6_.gameSpaceX,_loc6_.gameSpaceY);
            _loc17_.health = _loc17_.maxHealth;
            GameSpace.instance.places.addPlace(_loc17_);
         }
         if(xml.player.energycolor != null && xml.player.energycolor.length() > 0)
         {
            _loc18_ = 2130706432 | xml.player.energycolor;
            GameSpace.instance.energyGrid.createBitmap(_loc18_);
         }
         if(xml.player.lockedcity != null && xml.player.lockedcity.length() > 0)
         {
            if(xml.player.lockedcity == "true")
            {
               this.lockedCity = true;
            }
         }
         if(this.lockedCity)
         {
            GameSpace.instance.baseGun.canMove = false;
         }
         disableGame();
         Creeper.instance.gameScreen.playGameMusic(2,4);
      }
      
      override public function update() : void
      {
         super.update();
         if(updateCount == 10)
         {
            GameSpace.instance.gameDisabled = true;
            this.showDialog();
         }
      }
      
      private function showDialog() : void
      {
         this.md = new MessageDialogScrolling(MessageDialog.SIDE_TOP,-1,650,-1,true);
         this.md.textField.htmlText = unescapeMultiByte(xml.opening);
         this.md.show();
         this.md.addEventListener(MessageDialogScrolling.OK_CLICK,this.createProducers,false,0,true);
      }
      
      private function createProducers(param1:Object = null) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:int = 0;
         enableGame();
         GameSpace.instance.gameDisabled = false;
         if(this.lockedCity)
         {
            GameSpace.instance.baseGun.canMove = false;
         }
         for each(_loc3_ in xml.emitters.elements())
         {
            _loc2_ = new GlopProducer(_loc3_.gameSpaceX,_loc3_.gameSpaceY);
            _loc2_.productionBaseAmt = _loc3_.intensity;
            _loc2_.productionInterval = _loc3_.frequency;
            _loc2_.startTime = _loc3_.startTime;
            GameSpace.instance.addGlopProducer(_loc2_);
         }
         if(xml.sporewaves.elements().length() > 0)
         {
            _loc4_ = new GlopBlobProducer();
            for each(_loc6_ in xml.sporewaves.elements())
            {
               _loc7_ = _loc6_.side;
               _loc8_ = 0;
               if(_loc7_.toLowerCase() == "top")
               {
                  _loc8_ = 0;
               }
               else if(_loc7_.toLowerCase() == "bottom")
               {
                  _loc8_ = 0;
               }
               else if(_loc7_.toLowerCase() == "left")
               {
                  _loc8_ = 0;
               }
               else if(_loc7_.toLowerCase() == "right")
               {
                  _loc8_ = 0;
               }
               _loc5_ = new GlopBlobProducerWave(_loc6_.time,_loc6_.count,1,1,_loc6_.intensity,_loc8_);
               _loc4_.waves.push(_loc5_);
            }
            GameSpace.instance.glopBlobProducer = _loc4_;
         }
      }
   }
}
