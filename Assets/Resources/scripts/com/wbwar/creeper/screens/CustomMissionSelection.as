package com.wbwar.creeper.screens
{
   import com.wbwar.creeper.dialogs.DeleteCustomGameDialog;
   import com.wbwar.creeper.games.GameData;
   import com.wbwar.creeper.games.IndividualGameData;
   import com.wbwar.creeper.util.Button;
   import com.wbwar.creeper.util.CustomGameSelector;
   import com.wbwar.creeper.util.CustomGameSelectorEvent;
   import com.wbwar.creeper.util.CustomGameSelectorSortBar;
   import com.wbwar.creeper.util.FlowContainer;
   import com.wbwar.creeper.util.SortTriangle;
   import com.wbwar.creeper.util.Text;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   
   public class CustomMissionSelection extends Sprite
   {
      
      public static var backgroundImage:Class = CustomMissionSelection_backgroundImage;
      
      private static var backgroundBitmap:Bitmap = new backgroundImage() as Bitmap;
       
      
      public var popupLayer:Sprite;
      
      private var exitButton:Button;
      
      private var ddButton:Button;
      
      private var lockScreen:FreeplayLockScreen;
      
      private var missionsFlow:FlowContainer;
      
      private var deleteConfirm:DeleteCustomGameDialog;
      
      private var gameToDelete:String;
      
      private var cgssb:CustomGameSelectorSortBar;
      
      private var miniMap:Bitmap;
      
      private var moreMapsButton:Button;
      
      private var submitScoreScreen:CustomSubmitScoreScreen;
      
      public function CustomMissionSelection()
      {
         super();
         addChild(backgroundBitmap);
         this.popupLayer = new Sprite();
         this.popupLayer.mouseEnabled = false;
         this.popupLayer.mouseChildren = false;
         this.exitButton = new Button("Exit",10,75,17,0,0,true,12587024,0);
         addChild(this.exitButton);
         this.exitButton.x = 695 - this.exitButton.width;
         this.exitButton.y = 5;
         this.exitButton.addEventListener(MouseEvent.CLICK,function():void
         {
            Creeper.instance.gameScreen.showMainMenu();
         });
         this.ddButton = new Button("Double Down [OFF]",10,150,17,0,0,true,12603408,0);
         addChild(this.ddButton);
         this.ddButton.x = 695 - this.ddButton.width;
         this.ddButton.y = 25;
         this.ddButton.addEventListener(MouseEvent.CLICK,this.ddClick);
         this.ddButton.visible = false;
         var title:TextField = Text.text("Custom Maps",36,16777215);
         title.filters = [new GlowFilter(65280,1,16,16)];
         addChild(title);
         title.x = int(350 - title.width / 2);
         title.y = 0;
         this.moreMapsButton = new Button("Get More Maps!",12,135,20,0,0,true,1097744,0);
         addChild(this.moreMapsButton);
         this.moreMapsButton.x = int(350 - this.moreMapsButton.width / 2);
         this.moreMapsButton.y = 50;
         this.moreMapsButton.addEventListener(MouseEvent.CLICK,this.onMoreMapsClick);
         var importButton:Button = new Button("Import Custom Map",20,300,30,0,0,true,128,-1);
         importButton.filters = [new GlowFilter(3162240,1,32,32,2,BitmapFilterQuality.MEDIUM)];
         addChild(importButton);
         importButton.x = int(350 - importButton.width / 2);
         importButton.y = 80;
         importButton.addEventListener(MouseEvent.CLICK,this.onImportClick);
         this.cgssb = new CustomGameSelectorSortBar();
         addChild(this.cgssb);
         this.cgssb.x = 50;
         this.cgssb.y = 120;
         this.cgssb.addEventListener(CustomGameSelectorSortBar.EVENT_SORTCHANGED,this.onSortChanged);
         this.cgssb.numberTriangle.state = SortTriangle.STATE_UP;
         this.missionsFlow = new FlowContainer(600,360);
         addChild(this.missionsFlow);
         this.missionsFlow.x = 50;
         this.missionsFlow.y = 150;
         this.miniMap = new Bitmap();
         this.miniMap.width = 140;
         this.miniMap.height = 96;
         this.miniMap.x = 10;
         this.miniMap.y = 10;
         addChild(this.miniMap);
         addEventListener(CustomGameSelectorEvent.CLICKED,this.onGameSelectorClicked);
         addEventListener(CustomGameSelectorEvent.OVER,this.onGameSelectorOver);
         addEventListener(CustomGameSelectorEvent.OUT,this.onGameSelectorOut);
         addChild(this.popupLayer);
         this.deleteConfirm = new DeleteCustomGameDialog();
         this.deleteConfirm.x = int(350 - this.deleteConfirm.width / 2);
         this.deleteConfirm.y = 150;
         this.deleteConfirm.visible = false;
         this.deleteConfirm.addEventListener(DeleteCustomGameDialog.YES_CLICKED,this.onDeleteGame);
         addChild(this.deleteConfirm);
         this.submitScoreScreen = new CustomSubmitScoreScreen(this);
         this.submitScoreScreen.hide();
         addChild(this.submitScoreScreen);
         if(false)
         {
            this.lockScreen = new FreeplayLockScreen(Creeper.DEMO);
            addChild(this.lockScreen);
         }
      }
      
      private function onMoreMapsClick(param1:Event) : void
      {
         var _loc2_:URLRequest = new URLRequest("http://knucklecracker.com/creeperworld/viewmaps.php");
         navigateToURL(_loc2_,"creeperworldmaps");
      }
      
      private function onDeleteGame(param1:Event) : void
      {
         Creeper.deleteCustomGameFunction(this.gameToDelete);
         this.reinit(null,null,0,0,null);
      }
      
      private function onImportClick(param1:MouseEvent) : void
      {
         Creeper.importCustomGameFunction(this.onImportComplete);
      }
      
      private function onImportComplete() : void
      {
         this.reinit(null,null,0,0,null);
      }
      
      private function onGameSelectorOver(param1:CustomGameSelectorEvent) : void
      {
         this.miniMap.visible = true;
         this.miniMap.bitmapData = param1.cgs.miniMap;
         this.miniMap.width = 140;
         this.miniMap.height = 96;
      }
      
      private function onGameSelectorOut(param1:CustomGameSelectorEvent) : void
      {
         this.miniMap.visible = false;
      }
      
      private function onGameSelectorClicked(param1:CustomGameSelectorEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:* = null;
         if(param1.deleteGame)
         {
            this.gameToDelete = param1.cgs.file;
            this.deleteConfirm.visible = true;
         }
         else if(param1.score)
         {
            this.showScore(param1.cgs.file);
         }
         else if(param1.resubmit)
         {
            if(false)
            {
               _loc2_ = Creeper.getCustomGameUIDFunction(param1.cgs.file);
            }
            else
            {
               _loc2_ = "";
            }
            _loc3_ = param1.cgs.score;
            _loc4_ = param1.cgs.playCount;
            _loc5_ = param1.cgs.title;
            this.submitScoreScreen.show(param1.cgs.file,_loc2_,_loc3_,_loc4_,_loc5_);
         }
         else
         {
            _loc6_ = param1.cgs.file;
            Creeper.instance.gameScreen.launchCustomGame(_loc6_);
         }
      }
      
      private function showScore(param1:String) : void
      {
         var _loc2_:String = Creeper.getCustomGameUIDFunction(param1);
         var _loc3_:URLRequest = new URLRequest("http://knucklecracker.com/creeperworld/custommapscores.php?uid=" + _loc2_);
         navigateToURL(_loc3_,"creeperworldmapscores");
      }
      
      private function setDDButtonText() : void
      {
         if(false)
         {
            this.ddButton.text.text = "Double Down [ON!!!]";
         }
         else
         {
            this.ddButton.text.text = "Double Down [OFF]";
         }
      }
      
      private function ddClick(param1:Event) : void
      {
         Creeper.doubleDownMode = true;
         this.setDDButtonText();
      }
      
      private function onSortChanged(param1:Event) : void
      {
         this.reinit(null,null,0,0,null);
      }
      
      public function reinit(param1:String, param2:String, param3:int, param4:int, param5:String) : void
      {
         var igd:IndividualGameData = null;
         var cg:CustomGameSelector = null;
         var cgfile:String = param1;
         var cguid:String = param2;
         var lastScore:int = param3;
         var playCount:int = param4;
         var title:String = param5;
         GameData.load();
         this.ddButton.visible = false;
         igd = GameData.getSpecialGameData(8);
         if(igd.highScore > 0)
         {
            igd = GameData.getSpecialGameData(9);
            if(igd.highScore > 0)
            {
               this.ddButton.visible = true;
               this.setDDButtonText();
            }
         }
         var customGames:Array = Creeper.getCustomGamesFunction();
         if(customGames != null)
         {
            if(this.cgssb.numberTriangle.state != SortTriangle.STATE_UP)
            {
               if(this.cgssb.numberTriangle.state == SortTriangle.STATE_DOWN)
               {
                  customGames = customGames.reverse();
               }
               else if(this.cgssb.titleTriangle.state == SortTriangle.STATE_UP)
               {
                  customGames.sort(function(param1:CustomGameSelector, param2:CustomGameSelector):int
                  {
                     return param1.title.toLowerCase() > param2.title.toLowerCase() ? 1 : -1;
                  },Array.CASEINSENSITIVE);
               }
               else if(this.cgssb.titleTriangle.state == SortTriangle.STATE_DOWN)
               {
                  customGames.sort(function(param1:CustomGameSelector, param2:CustomGameSelector):int
                  {
                     return param1.title.toLowerCase() > param2.title.toLowerCase() ? 1 : -1;
                  },0 | 0);
               }
               else if(this.cgssb.playCountTriangle.state == SortTriangle.STATE_UP)
               {
                  customGames.sort(function(param1:CustomGameSelector, param2:CustomGameSelector):int
                  {
                     return param1.playCount > param2.playCount ? 1 : -1;
                  });
               }
               else if(this.cgssb.playCountTriangle.state == SortTriangle.STATE_DOWN)
               {
                  customGames.sort(function(param1:CustomGameSelector, param2:CustomGameSelector):int
                  {
                     return param1.playCount > param2.playCount ? 1 : -1;
                  },Array.DESCENDING);
               }
               else if(this.cgssb.scoreTriangle.state == SortTriangle.STATE_UP)
               {
                  customGames.sort(function(param1:CustomGameSelector, param2:CustomGameSelector):int
                  {
                     return param1.score > param2.score ? 1 : -1;
                  });
               }
               else if(this.cgssb.scoreTriangle.state == SortTriangle.STATE_DOWN)
               {
                  customGames.sort(function(param1:CustomGameSelector, param2:CustomGameSelector):int
                  {
                     return param1.score > param2.score ? 1 : -1;
                  },Array.DESCENDING);
               }
            }
            this.missionsFlow.removeAllContent();
            for each(cg in customGames)
            {
               this.missionsFlow.addContent(cg,CustomGameSelector.HEIGHT);
            }
            this.missionsFlow.refresh();
         }
         if(cguid != null)
         {
            this.submitScoreScreen.show(cgfile,cguid,lastScore,playCount,title);
         }
      }
   }
}
