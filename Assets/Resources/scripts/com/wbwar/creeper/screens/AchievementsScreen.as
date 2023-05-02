package com.wbwar.creeper.screens
{
   import com.wbwar.creeper.games.GameData;
   import com.wbwar.creeper.games.IndividualGameData;
   import com.wbwar.creeper.util.Button;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class AchievementsScreen extends Sprite
   {
      
      public static var backgroundImage:Class = AchievementsScreen_backgroundImage;
      
      private static var backgroundBitmap:Bitmap = new backgroundImage() as Bitmap;
       
      
      private var exitButton:Button;
      
      private var allBox:AchievementsBox;
      
      private var allConquestBox:AchievementsBox;
      
      private var allStoryBox:AchievementsBox;
      
      private var allSpecialBox:AchievementsBox;
      
      private var conquestBoxes:Array;
      
      private var storyBoxes:Array;
      
      private var specialBoxes:Array;
      
      public function AchievementsScreen()
      {
         var i:int = 0;
         var ab:AchievementsBox = null;
         var conquestBoxesY:int = 0;
         this.conquestBoxes = [];
         this.storyBoxes = [];
         this.specialBoxes = [];
         super();
         addChild(backgroundBitmap);
         this.exitButton = new Button("Exit",10,75,17,0,0,true,12587024,0);
         addChild(this.exitButton);
         this.exitButton.x = 695 - this.exitButton.width;
         this.exitButton.y = 5;
         this.exitButton.addEventListener(MouseEvent.CLICK,function():void
         {
            Creeper.instance.gameScreen.showMainMenu();
         });
         this.allBox = new AchievementsBox(AchievementsBox.TYPE_ALL);
         addChild(this.allBox);
         this.allBox.x = int(350 - this.allBox.width / 2);
         this.allBox.y = 50;
         this.allConquestBox = new AchievementsBox(AchievementsBox.TYPE_ALLCONQUEST);
         addChild(this.allConquestBox);
         this.allConquestBox.x = 10;
         this.allConquestBox.y = 155;
         this.allStoryBox = new AchievementsBox(AchievementsBox.TYPE_ALLSTORY);
         addChild(this.allStoryBox);
         this.allStoryBox.x = 240;
         this.allStoryBox.y = 155;
         this.allSpecialBox = new AchievementsBox(AchievementsBox.TYPE_ALLSPECIAL);
         addChild(this.allSpecialBox);
         this.allSpecialBox.x = 496;
         this.allSpecialBox.y = 155;
         var deltaYBox:int = 30;
         var conquestBoxesX:int = 20;
         conquestBoxesY = 200;
         i = 0;
         while(i < 5)
         {
            ab = new AchievementsBox(AchievementsBox.TYPE_CONQUEST,i);
            this.conquestBoxes.push(ab);
            addChild(ab);
            ab.x = conquestBoxesX;
            ab.y = conquestBoxesY + i * deltaYBox;
            i++;
         }
         var storyBoxesX:int = int(350);
         var storyBoxesY:int = 200;
         i = 0;
         while(i < 10)
         {
            ab = new AchievementsBox(AchievementsBox.TYPE_STORY,i);
            this.storyBoxes.push(ab);
            addChild(ab);
            ab.x = storyBoxesX - 130 - 5;
            ab.y = storyBoxesY + i * deltaYBox;
            i++;
         }
         i = 0;
         while(i < 10)
         {
            ab = new AchievementsBox(AchievementsBox.TYPE_STORY,i + 10);
            this.storyBoxes.push(ab);
            addChild(ab);
            ab.x = storyBoxesX + 5;
            ab.y = storyBoxesY + i * deltaYBox;
            i++;
         }
         var specialBoxesX:int = 530;
         var specialBoxesY:int = 200;
         i = 0;
         while(i < 10)
         {
            ab = new AchievementsBox(AchievementsBox.TYPE_SPECIAL,i);
            this.specialBoxes.push(ab);
            addChild(ab);
            ab.x = specialBoxesX;
            ab.y = specialBoxesY + i * deltaYBox;
            i++;
         }
      }
      
      public static function getSnapshot() : AchievementsSnapshot
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc1_:AchievementsSnapshot = new AchievementsSnapshot();
         GameData.load();
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc5_ = true;
            _loc4_ = _loc3_ * 5;
            while(_loc4_ < _loc3_ * 5 + 5)
            {
               _loc2_ = GameData.getRandomGameData(_loc4_ + 1);
               if(_loc2_.highScore <= 0)
               {
                  _loc5_ = false;
                  break;
               }
               _loc4_++;
            }
            _loc1_.conquest[_loc3_] = _loc5_;
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 20)
         {
            _loc2_ = GameData.getStoryGameData(_loc3_);
            _loc1_.story[_loc3_] = _loc2_.highScore > 0;
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            _loc2_ = GameData.getSpecialGameData(_loc3_);
            _loc1_.special[_loc3_] = _loc2_.highScore > 0;
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function refresh() : void
      {
         var _loc2_:int = 0;
         GameData.load();
         var _loc4_:AchievementsSnapshot = getSnapshot();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            (this.conquestBoxes[_loc2_] as AchievementsBox).locked = !_loc4_.conquest[_loc2_];
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 20)
         {
            (this.storyBoxes[_loc2_] as AchievementsBox).locked = !_loc4_.story[_loc2_];
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            (this.specialBoxes[_loc2_] as AchievementsBox).locked = !_loc4_.special[_loc2_];
            _loc2_++;
         }
         this.allConquestBox.locked = !_loc4_.allConquest;
         this.allStoryBox.locked = !_loc4_.allStory;
         this.allSpecialBox.locked = !_loc4_.allSpecial;
         this.allBox.locked = !_loc4_.all;
      }
   }
}
