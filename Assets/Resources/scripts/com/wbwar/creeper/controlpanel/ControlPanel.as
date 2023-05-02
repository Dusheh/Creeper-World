package com.wbwar.creeper.controlpanel
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.Place;
   import com.wbwar.creeper.controlpanel.menu.BuildMenu;
   import com.wbwar.creeper.controlpanel.menu.PlaceMenu;
   import com.wbwar.creeper.dialogs.HelpDialog;
   import com.wbwar.creeper.util.Button;
   import com.wbwar.creeper.util.Text;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.utils.getTimer;
   
   public class ControlPanel extends Sprite
   {
       
      
      private var showFPS:Boolean = false;
      
      private var frameRateText:TextField;
      
      public var turboText:TextField;
      
      private var lastTime:int = -1;
      
      private var lastUpdateCount:int = -1;
      
      private var playMoreButton:Button;
      
      private var menuButton:Button;
      
      public var menu:Sprite;
      
      private var optionsButton:Button;
      
      private var helpButton:Button;
      
      public var cancelButton:Button;
      
      private var mainMenuButton:Button;
      
      public var missionTimeViewer:MissionTimeViewer;
      
      private var glopBlobWaveViewer:GlopBlobWaveViewer;
      
      public var stashViewer:StashViewer;
      
      public var pointViewer:PointViewer;
      
      private var heightViewer:HeightViewer;
      
      private var speedControl:SpeedControl;
      
      public var buildMenu:BuildMenu;
      
      public var placeMenu:PlaceMenu;
      
      private var _place:Place;
      
      public function ControlPanel()
      {
         super();
         graphics.beginFill(2105376);
         graphics.drawRect(0,0,0 * 0,45);
         graphics.endFill();
         this.frameRateText = Text.text("",8,0);
         this.frameRateText.filters = [new DropShadowFilter(1,45,16777215)];
         addChild(this.frameRateText);
         this.frameRateText.x = 0 * 0 - 20;
         this.frameRateText.y = -15;
         this.frameRateText.visible = false;
         this.turboText = Text.text("DOUBLE SPEED",8,0);
         this.turboText.filters = [new GlowFilter(16777215)];
         addChild(this.turboText);
         this.turboText.x = 273;
         this.turboText.y = 33;
         this.turboText.visible = false;
         this.turboText.mouseEnabled = false;
         this.buildMenu = new BuildMenu();
         this.buildMenu.visible = true;
         addChild(this.buildMenu);
         this.placeMenu = new PlaceMenu();
         this.placeMenu.visible = false;
         addChild(this.placeMenu);
         this.cancelButton = new Button(" CANCEL",9,45,42,0,8,true,9465872,7368816);
         this.cancelButton.setSubtitle("[space]",7,17);
         addChild(this.cancelButton);
         this.cancelButton.visible = false;
         this.cancelButton.x = 337;
         this.cancelButton.y = 1;
         this.missionTimeViewer = new MissionTimeViewer();
         addChild(this.missionTimeViewer);
         this.missionTimeViewer.x = 445;
         this.missionTimeViewer.y = 1;
         this.glopBlobWaveViewer = new GlopBlobWaveViewer();
         addChild(this.glopBlobWaveViewer);
         this.glopBlobWaveViewer.x = 447;
         this.glopBlobWaveViewer.y = 22;
         this.glopBlobWaveViewer.visible = false;
         this.pointViewer = new PointViewer();
         addChild(this.pointViewer);
         this.pointViewer.x = 385;
         this.pointViewer.y = 1;
         this.pointViewer.visible = false;
         this.heightViewer = new HeightViewer();
         addChild(this.heightViewer);
         this.heightViewer.x = 415;
         this.heightViewer.y = 2;
         this.stashViewer = new StashViewer();
         addChild(this.stashViewer);
         this.stashViewer.x = 513;
         this.stashViewer.y = 1;
         this.speedControl = new SpeedControl();
         addChild(this.speedControl);
         this.speedControl.x = 625;
         this.speedControl.y = 1;
         this.optionsButton = new Button("Options",9,60,14,0,0,true,7368720,-1);
         addChild(this.optionsButton);
         this.optionsButton.x = 639;
         this.optionsButton.y = 1;
         this.helpButton = new Button("Help",9,60,14,0,0,true,5292048,-1);
         addChild(this.helpButton);
         this.helpButton.x = 639;
         this.helpButton.y = 16;
         this.mainMenuButton = new Button("Exit Game",9,60,13,0,-1,true,7352336,-1);
         addChild(this.mainMenuButton);
         this.mainMenuButton.x = 639;
         this.mainMenuButton.y = 31;
         this.cancelButton.addEventListener(MouseEvent.CLICK,this.onCancelButtonClick,false,0,true);
         this.optionsButton.addEventListener(MouseEvent.CLICK,this.onOptionsClick,false,0,true);
         this.helpButton.addEventListener(MouseEvent.CLICK,this.onHelpClick,false,0,true);
         this.mainMenuButton.addEventListener(MouseEvent.CLICK,this.onMainMenuClick,false,0,true);
         Creeper.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false,0,true);
         if(false)
         {
            Creeper.setupRightClickFunction(Creeper.instance.stage,this.onCancelButtonClick);
         }
      }
      
      public function set place(param1:Place) : void
      {
         this._place = param1;
         this.placeMenu.place = param1;
         if(param1 == null)
         {
            this.buildMenu.visible = true;
            this.placeMenu.visible = false;
            this.cancelButton.visible = false;
         }
         else
         {
            this.buildMenu.visible = false;
            this.placeMenu.visible = true;
            this.cancelButton.visible = true;
         }
      }
      
      public function update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.showFPS)
         {
            _loc1_ = getTimer();
            _loc2_ = GameSpace.instance.updateCount;
            if(this.lastTime > 0)
            {
               this.frameRateText.text = String(int((_loc2_ - this.lastUpdateCount) / ((_loc1_ - this.lastTime) / 1000) * 10) / 10);
            }
            this.lastTime = _loc1_;
            this.lastUpdateCount = GameSpace.instance.updateCount;
         }
         this.turboText.visible = GameSpace.instance.speedUp;
         this.glopBlobWaveViewer.update();
         this.missionTimeViewer.update();
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 80)
         {
            GameSpace.instance.paused = !GameSpace.instance.paused;
         }
         else if(param1.keyCode == 187)
         {
            this.showFPS = !this.showFPS;
            this.frameRateText.visible = this.showFPS;
         }
         else if(param1.keyCode == 8)
         {
            GameSpace.instance.takeSnapshot();
         }
         else if(param1.keyCode != 186)
         {
            if(param1.keyCode != 87)
            {
               if(param1.keyCode != 90)
               {
                  if(param1.keyCode == 27)
                  {
                     this.onCancelButtonClick(null);
                  }
                  else if(param1.keyCode == 32)
                  {
                     this.onCancelButtonClick(null);
                  }
                  else if(param1.keyCode == 77)
                  {
                     GameSpace.instance.mute = !GameSpace.instance.mute;
                  }
                  else if(param1.keyCode == 38)
                  {
                     GameSpace.instance.speedUp = true;
                     this.turboText.visible = true;
                  }
                  else if(param1.keyCode == 40)
                  {
                     GameSpace.instance.speedUp = false;
                     this.turboText.visible = false;
                  }
               }
            }
         }
      }
      
      private function onMenuClick(param1:MouseEvent) : void
      {
         if(this.menu.y >= 0)
         {
            Tweener.addTween(this.menu,{
               "time":1,
               "y":-33
            });
         }
         else
         {
            Tweener.addTween(this.menu,{
               "time":1,
               "y":0
            });
         }
      }
      
      public function onCancelButtonClick(param1:MouseEvent = null) : void
      {
         if(param1 != null)
         {
            param1.stopImmediatePropagation();
         }
         GameSpace.instance.places.removeAllSelections();
         GameSpace.instance.places.placeToAdd = null;
         GameSpace.instance.places.placeToMove = null;
         this.place = null;
         this.buildMenu.buttonHighlight.visible = false;
         this.cancelButton.visible = false;
         dispatchEvent(new Event("ControlPanel_Cancel"));
      }
      
      private function onOptionsClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         GameSpace.instance.showSettingsDialog();
      }
      
      private function onHelpClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         GameSpace.instance.tutorialLayer.addChild(HelpDialog.instance);
         HelpDialog.instance.x = 350;
         HelpDialog.instance.y = 250;
         HelpDialog.instance.visible = true;
         GameSpace.instance.paused = true;
      }
      
      private function onMainMenuClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         GameSpace.instance.showExitDialog();
      }
      
      public function finish() : void
      {
         Creeper.instance.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this.buildMenu.visible = false;
         this.placeMenu.visible = false;
      }
   }
}
