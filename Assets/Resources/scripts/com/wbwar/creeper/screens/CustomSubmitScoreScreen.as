package com.wbwar.creeper.screens
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.games.GameData;
   import com.wbwar.creeper.games.IndividualGameData;
   import com.wbwar.creeper.remote.Score;
   import com.wbwar.creeper.util.Button;
   import com.wbwar.creeper.util.Text;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.net.URLLoader;
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   
   public class CustomSubmitScoreScreen extends Sprite
   {
      
      public static const WIDTH:int = 700;
      
      public static const HEIGHT:int = 525;
      
      private static const SUBMITSPRITE_WIDTH:int = 200;
      
      private static const SUBMITSPRITE_HEIGHT:int = 190;
       
      
      private var exitButton:Button;
      
      private var submitSprite:Sprite;
      
      private var nameInputTextField:TextField;
      
      private var groupInputTextField:TextField;
      
      private var systemScore:int;
      
      private var systemPlayCount:int;
      
      private var table:String;
      
      private var cgfile:String;
      
      private var cguid:String;
      
      private var systemTitle:TextField;
      
      private var systemScoreText:TextField;
      
      private var systemPlayCountText:TextField;
      
      private var submitScoreButton:Button;
      
      private var controller:CustomMissionSelection;
      
      public function CustomSubmitScoreScreen(param1:CustomMissionSelection)
      {
         var nameTitle:TextField = null;
         var groupTitle:TextField = null;
         var controller:CustomMissionSelection = param1;
         super();
         this.controller = controller;
         graphics.beginFill(0,0.85);
         graphics.drawRect(0,0,WIDTH,HEIGHT);
         graphics.endFill();
         this.submitSprite = new Sprite();
         this.submitSprite.graphics.beginFill(2105408);
         this.submitSprite.graphics.lineStyle(4,10526880);
         this.submitSprite.graphics.drawRoundRect(0,0,SUBMITSPRITE_WIDTH,SUBMITSPRITE_HEIGHT,10,7);
         this.submitSprite.graphics.endFill();
         addChild(this.submitSprite);
         this.submitSprite.x = int(WIDTH / 2 - SUBMITSPRITE_WIDTH / 2);
         this.submitSprite.y = int(HEIGHT / 2 - SUBMITSPRITE_HEIGHT / 2);
         this.exitButton = new Button("Exit",10,75,17,0,0,true,12587024,0);
         addChild(this.exitButton);
         this.exitButton.x = this.submitSprite.x + SUBMITSPRITE_WIDTH - this.exitButton.width;
         this.exitButton.y = this.submitSprite.y - 5 - this.exitButton.height;
         this.exitButton.addEventListener(MouseEvent.CLICK,function():void
         {
            hide();
         });
         nameTitle = Text.text("Your Player Name",10,16777215);
         nameTitle.x = 10;
         nameTitle.y = 9;
         this.submitSprite.addChild(nameTitle);
         var format:TextFormat = new TextFormat();
         format.font = "befont";
         format.color = 0;
         format.size = 12;
         this.nameInputTextField = new TextField();
         this.nameInputTextField.embedFonts = true;
         this.nameInputTextField.antiAliasType = AntiAliasType.ADVANCED;
         this.nameInputTextField.type = TextFieldType.INPUT;
         this.nameInputTextField.maxChars = 15;
         this.nameInputTextField.background = true;
         this.nameInputTextField.border = true;
         this.nameInputTextField.defaultTextFormat = format;
         this.nameInputTextField.x = 11;
         this.nameInputTextField.y = 25;
         this.nameInputTextField.width = 147;
         this.nameInputTextField.height = 18;
         this.submitSprite.addChild(this.nameInputTextField);
         groupTitle = Text.text("Group Name (Optional)",10,16777215);
         groupTitle.x = 10;
         groupTitle.y = 50;
         this.submitSprite.addChild(groupTitle);
         this.groupInputTextField = new TextField();
         this.groupInputTextField.embedFonts = true;
         this.groupInputTextField.antiAliasType = AntiAliasType.ADVANCED;
         this.groupInputTextField.type = TextFieldType.INPUT;
         this.groupInputTextField.maxChars = 20;
         this.groupInputTextField.background = true;
         this.groupInputTextField.border = true;
         this.groupInputTextField.defaultTextFormat = format;
         this.groupInputTextField.x = 11;
         this.groupInputTextField.y = 64;
         this.groupInputTextField.width = 147;
         this.groupInputTextField.height = 18;
         this.submitSprite.addChild(this.groupInputTextField);
         this.systemTitle = Text.text("---",14,12632256);
         this.submitSprite.addChild(this.systemTitle);
         this.systemTitle.filters = [new DropShadowFilter()];
         this.systemTitle.x = 10;
         this.systemTitle.y = 85;
         var ctext:TextField = Text.text("(Current Mission)",8,12632256);
         this.submitSprite.addChild(ctext);
         ctext.filters = [new DropShadowFilter()];
         ctext.x = int(SUBMITSPRITE_WIDTH / 2 - int(ctext.width / 2));
         ctext.y = this.systemTitle.y + 15;
         this.systemScoreText = Text.text("000",24,16777215);
         this.systemScoreText.x = SUBMITSPRITE_WIDTH / 2 - this.systemScoreText.width / 2;
         this.systemScoreText.y = this.systemTitle.y + 25;
         this.submitSprite.addChild(this.systemScoreText);
         this.systemPlayCountText = Text.text("# Plays: ",14,16777215);
         this.submitSprite.addChild(this.systemPlayCountText);
         this.systemPlayCountText.filters = [new DropShadowFilter()];
         this.systemPlayCountText.y = this.systemScoreText.y + this.systemScoreText.height - 7;
         this.submitScoreButton = new Button("Submit Score",12,100,20,0,0,true,32768,-1);
         this.submitScoreButton.x = SUBMITSPRITE_WIDTH / 2 - this.submitScoreButton.width / 2;
         this.submitScoreButton.y = SUBMITSPRITE_HEIGHT - 5 - this.submitScoreButton.height;
         this.submitSprite.addChild(this.submitScoreButton);
         this.submitScoreButton.addEventListener(MouseEvent.CLICK,this.onSubmitClick);
      }
      
      private function onSubmitClick(param1:Event) : void
      {
         var _loc2_:String = this.nameInputTextField.text;
         var _loc3_:String = this.groupInputTextField.text;
         if(_loc2_ == null || _loc2_ == "")
         {
            _loc2_ = "Anonymous";
         }
         this.submitScoreButton.enabled = false;
         GameData.playerName = _loc2_;
         GameData.groupName = _loc3_;
         GameData.save();
         Score.submitScoreCustom(this.cguid,_loc2_,_loc3_,this.systemScore,this.systemPlayCount,this.submitComplete,this.errorComplete);
      }
      
      private function submitCompleteOld(param1:Event) : void
      {
      }
      
      private function errorCompleteOld(param1:Event) : void
      {
      }
      
      private function submitComplete(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:URLLoader = URLLoader(param1.target);
         if(false)
         {
            _loc3_ = GameData.getCustomGameData(this.cgfile);
            if(_loc3_ != null)
            {
               _loc4_ = new Date();
               _loc3_.scoreSubmitted = _loc4_.getTime();
               GameData.save();
            }
         }
         this.controller.reinit(null,null,0,0,null);
         this.hide();
      }
      
      private function errorComplete(param1:Event) : void
      {
         this.hide();
      }
      
      public function show(param1:String, param2:String, param3:int, param4:int, param5:String) : void
      {
         this.cgfile = param1;
         this.cguid = param2;
         if(false)
         {
            this.nameInputTextField.text = GameData.playerName;
         }
         if(false)
         {
            this.groupInputTextField.text = GameData.groupName;
         }
         Tweener.addTween(this,{
            "time":0.5,
            "_autoAlpha":1
         });
         this.systemTitle.text = param5;
         this.systemTitle.x = this.submitSprite.width / 2 - this.systemTitle.width / 2;
         this.systemScore = param3;
         this.systemPlayCount = param4;
         this.systemScoreText.text = String(param3);
         this.systemPlayCountText.text = "# Plays: " + String(param4);
         this.systemScoreText.x = SUBMITSPRITE_WIDTH / 2 - this.systemScoreText.width / 2;
         this.systemPlayCountText.x = SUBMITSPRITE_WIDTH / 2 - this.systemPlayCountText.width / 2;
         this.submitScoreButton.enabled = true;
      }
      
      public function hide() : void
      {
         Tweener.addTween(this,{
            "time":0.5,
            "_autoAlpha":0
         });
      }
   }
}
