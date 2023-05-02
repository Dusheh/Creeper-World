package com.wbwar.creeper.games
{
   public class IndividualGameData
   {
       
      
      public var gameNumber:int = -1;
      
      public var gameName:String = null;
      
      public var highScore:int = 0;
      
      public var lastScore:int = 0;
      
      public var minTime:int = 0;
      
      public var playCount:int = 0;
      
      public var lastPlayed:Number = 0;
      
      public var scoreSubmitted:Number = 0;
      
      public function IndividualGameData()
      {
         super();
      }
      
      public static function create(param1:XML) : IndividualGameData
      {
         var _loc2_:IndividualGameData = new IndividualGameData();
         _loc2_.load(param1);
         return _loc2_;
      }
      
      public function load(param1:XML) : void
      {
         var data:XML = param1;
         try
         {
            this.gameNumber = data.gameNumber;
            if(data.gameName != null && data.gameName.length() > 0)
            {
               this.gameName = data.gameName;
            }
            else
            {
               this.gameName = null;
            }
            this.highScore = data.highScore;
            this.lastScore = data.lastScore;
            this.minTime = data.minTime;
            this.playCount = data.playCount;
            this.lastPlayed = data.lastPlayed;
            this.scoreSubmitted = data.scoreSubmitted;
         }
         catch(e:Error)
         {
            gameNumber = -1;
            gameName = null;
            highScore = 0;
            minTime = 0;
            playCount = 0;
            lastPlayed = 0;
            scoreSubmitted = 0;
         }
      }
      
      public function getXML() : XML
      {
         var _loc1_:XML = <IndividualGame/>;
         _loc1_.gameNumber = this.gameNumber;
         if(this.gameName != null)
         {
            _loc1_.gameName = this.gameName;
         }
         _loc1_.highScore = this.highScore;
         _loc1_.lastScore = this.lastScore;
         _loc1_.minTime = this.minTime;
         _loc1_.playCount = this.playCount;
         _loc1_.lastPlayed = this.lastPlayed;
         _loc1_.scoreSubmitted = this.scoreSubmitted;
         return _loc1_;
      }
   }
}
