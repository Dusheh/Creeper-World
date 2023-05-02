package com.wbwar.creeper.screens
{
   public class AchievementsSnapshot
   {
       
      
      public var conquest:Array;
      
      public var story:Array;
      
      public var special:Array;
      
      public function AchievementsSnapshot()
      {
         this.conquest = [];
         this.story = [];
         this.special = [];
         super();
      }
      
      public function get allConquest() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < 10)
         {
            if(this.conquest[_loc1_] == false)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      public function get allStory() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < 20)
         {
            if(this.story[_loc1_] == false)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      public function get allSpecial() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < 10)
         {
            if(this.special[_loc1_] == false)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      public function get all() : Boolean
      {
         return this.allConquest && this.allStory && this.allSpecial;
      }
      
      public function conquestMissionComplete(param1:int) : Boolean
      {
         return this.conquest[param1];
      }
      
      public function storyMissionComplete(param1:int) : Boolean
      {
         return this.story[param1];
      }
      
      public function specialMissionComplete(param1:int) : Boolean
      {
         return this.special[param1];
      }
      
      public function getConquestDifference(param1:AchievementsSnapshot) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < 10)
         {
            if(param1.conquest[_loc2_] && !this.conquest[_loc2_])
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function getStoryDifference(param1:AchievementsSnapshot) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < 20)
         {
            if(param1.story[_loc2_] && !this.story[_loc2_])
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function getSpecialDifference(param1:AchievementsSnapshot) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < 10)
         {
            if(param1.special[_loc2_] && !this.special[_loc2_])
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
   }
}
