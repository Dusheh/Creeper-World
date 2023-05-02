package com.wbwar.creeper.screens
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.util.Button;
   import com.wbwar.creeper.util.Text;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.media.Sound;
   import flash.text.TextField;
   
   public class ResultAchievements extends Sprite
   {
       
      
      private var achievements:Sprite;
      
      private var continueButton:Button;
      
      public function ResultAchievements()
      {
         super();
         graphics.beginFill(0,0.9);
         graphics.drawRect(0,0,700,525);
         graphics.endFill();
         var _loc1_:TextField = Text.text("Achievement Awarded!!!",32,16777215);
         _loc1_.filters = [new GlowFilter(0,1,8,8)];
         _loc1_.x = 350 - _loc1_.width / 2;
         _loc1_.y = 50;
         addChild(_loc1_);
         this.achievements = new Sprite();
         addChild(this.achievements);
         this.continueButton = new Button("Continue",10,100,18,0,0,true,32768,-1);
         addChild(this.continueButton);
         this.continueButton.x = 350 - this.continueButton.width / 2;
         this.continueButton.y = 520 - this.continueButton.height;
         this.continueButton.addEventListener(MouseEvent.CLICK,this.hide);
         visible = false;
         alpha = 0;
      }
      
      public function show() : void
      {
         var _loc1_:Sound = new UpgradeAvailableSound();
         _loc1_.play();
         Tweener.addTween(this,{
            "time":0.5,
            "_autoAlpha":1
         });
      }
      
      public function hide(param1:Event = null) : void
      {
         Tweener.addTween(this,{
            "time":0.5,
            "_autoAlpha":0
         });
      }
      
      public function clearAchievements() : void
      {
         var _loc1_:int = this.achievements.numChildren - 1;
         while(_loc1_ >= 0)
         {
            this.achievements.removeChildAt(_loc1_);
            _loc1_--;
         }
      }
      
      public function setAchievement(param1:String, param2:int = -1) : void
      {
         var _loc3_:AchievementsBox = new AchievementsBox(param1,param2);
         this.achievements.addChild(_loc3_);
         if(param1 == AchievementsBox.TYPE_ALL)
         {
            _loc3_.y = 100;
         }
         else if(param1 == AchievementsBox.TYPE_ALLCONQUEST || param1 == AchievementsBox.TYPE_ALLSTORY || param1 == AchievementsBox.TYPE_ALLSPECIAL)
         {
            _loc3_.y = 200;
         }
         else
         {
            _loc3_.y = 250;
         }
         _loc3_.locked = false;
         _loc3_.x = 350 - _loc3_.width / 2;
         _loc3_.filters = [new GlowFilter(16748544,1,16,16)];
      }
   }
}
