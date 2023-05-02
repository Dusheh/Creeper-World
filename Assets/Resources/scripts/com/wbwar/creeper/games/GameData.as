package com.wbwar.creeper.games
{
   import com.wbwar.creeper.util.RC4;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class GameData
   {
      
      public static var playerName:String;
      
      public static var groupName:String;
      
      public static var muteMainMusic:Boolean = false;
      
      public static var musicVolume:Number = 0.5;
      
      public static var mistEffects:Boolean = true;
      
      public static var particleEffects:Boolean = true;
      
      private static var unchartedGames:Dictionary = new Dictionary();
      
      private static var specialGames:Array = [];
      
      private static var randomGames:Array = [];
      
      private static var storyGames:Array = [];
      
      private static var customGames:Dictionary = new Dictionary();
       
      
      public function GameData()
      {
         super();
      }
      
      public static function getUnchartedGames() : Dictionary
      {
         return unchartedGames;
      }
      
      public static function getUnchartedGameData(param1:String) : IndividualGameData
      {
         var _loc2_:* = null;
         _loc2_ = unchartedGames[param1];
         if(_loc2_ == null)
         {
            _loc2_ = new IndividualGameData();
            _loc2_.gameName = param1;
            unchartedGames[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public static function getSpecialGameData(param1:int) : IndividualGameData
      {
         var _loc2_:* = null;
         _loc2_ = specialGames[param1];
         if(_loc2_ == null)
         {
            _loc2_ = new IndividualGameData();
            _loc2_.gameNumber = param1;
            specialGames[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public static function getRandomGameData(param1:int) : IndividualGameData
      {
         var _loc2_:* = null;
         _loc2_ = randomGames[param1];
         if(_loc2_ == null)
         {
            _loc2_ = new IndividualGameData();
            _loc2_.gameNumber = param1;
            randomGames[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public static function getStoryGameData(param1:int) : IndividualGameData
      {
         var _loc2_:* = null;
         _loc2_ = storyGames[param1];
         if(_loc2_ == null)
         {
            _loc2_ = new IndividualGameData();
            _loc2_.gameNumber = param1;
            storyGames[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public static function getCustomGameData(param1:String) : IndividualGameData
      {
         var _loc2_:* = null;
         _loc2_ = customGames[param1];
         if(_loc2_ == null)
         {
            _loc2_ = new IndividualGameData();
            _loc2_.gameName = param1;
            customGames[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public static function load() : void
      {
         var d:String = null;
         var ba:ByteArray = null;
         var result:String = null;
         try
         {
            d = Persist.getData() as String;
            if(d != null)
            {
               ba = RC4.decryptBA(d,RC4.decrypt("4b061fadebe13b","spaceestate12"));
               ba.uncompress();
               result = ba.toString();
               loadGameDataString(result);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public static function save() : void
      {
         var s:String = null;
         var od:ByteArray = null;
         var result:String = null;
         try
         {
            s = getGameDataString();
            od = new ByteArray();
            od.writeUTFBytes(s);
            od.compress();
            result = RC4.encryptBA(od,RC4.decrypt("4b061fadebe13b","spaceestate12"));
            Persist.saveData(result);
         }
         catch(e:Error)
         {
         }
      }
      
      private static function loadGameDataString(param1:String) : void
      {
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc2_:XML = new XML(param1);
         if(_loc2_.playerName.length() > 0)
         {
            playerName = _loc2_.playerName;
         }
         else
         {
            playerName = null;
         }
         if(_loc2_.groupName.length() > 0)
         {
            groupName = _loc2_.groupName;
         }
         else
         {
            groupName = null;
         }
         if(_loc2_.muteMainMusic.length() > 0)
         {
            muteMainMusic = _loc2_.muteMainMusic == "true";
         }
         else
         {
            muteMainMusic = false;
         }
         if(_loc2_.musicVolume.length() > 0)
         {
            musicVolume = _loc2_.musicVolume;
         }
         else
         {
            musicVolume = 0.5;
         }
         if(_loc2_.mistEffects.length() > 0)
         {
            mistEffects = _loc2_.mistEffects == "true";
         }
         else
         {
            mistEffects = true;
         }
         if(_loc2_.particleEffects.length() > 0)
         {
            particleEffects = _loc2_.particleEffects == "true";
         }
         else
         {
            particleEffects = true;
         }
         randomGames = [];
         storyGames = [];
         var _loc4_:XMLList;
         var _loc5_:XMLList = (_loc4_ = _loc2_.unchartedGames).elements();
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length())
         {
            _loc3_ = IndividualGameData.create(_loc5_[_loc6_]);
            if(_loc3_.gameName != null)
            {
               unchartedGames[_loc3_.gameName] = _loc3_;
            }
            _loc6_++;
         }
         var _loc7_:XMLList;
         _loc5_ = (_loc7_ = _loc2_.specialGames).elements();
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length())
         {
            _loc3_ = IndividualGameData.create(_loc5_[_loc6_]);
            if(_loc3_.gameNumber >= 0)
            {
               specialGames[_loc3_.gameNumber] = _loc3_;
            }
            _loc6_++;
         }
         var _loc8_:XMLList;
         _loc5_ = (_loc8_ = _loc2_.randomGames).elements();
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length())
         {
            _loc3_ = IndividualGameData.create(_loc5_[_loc6_]);
            if(_loc3_.gameNumber >= 0)
            {
               randomGames[_loc3_.gameNumber] = _loc3_;
            }
            _loc6_++;
         }
         var _loc9_:XMLList;
         _loc5_ = (_loc9_ = _loc2_.storyGames).elements();
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length())
         {
            _loc3_ = IndividualGameData.create(_loc5_[_loc6_]);
            if(_loc3_.gameNumber >= 0)
            {
               storyGames[_loc3_.gameNumber] = _loc3_;
            }
            _loc6_++;
         }
         var _loc10_:XMLList;
         _loc5_ = (_loc10_ = _loc2_.customGames).elements();
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length())
         {
            _loc3_ = IndividualGameData.create(_loc5_[_loc6_]);
            if(_loc3_.gameName != null)
            {
               customGames[_loc3_.gameName] = _loc3_;
            }
            _loc6_++;
         }
      }
      
      private static function getGameDataString() : String
      {
         var _loc2_:* = null;
         var _loc1_:* = "<games>\n";
         if(playerName == null)
         {
            _loc1_ += "<playerName></playerName>\n";
         }
         else
         {
            _loc1_ += "<playerName>" + playerName + "</playerName>\n";
         }
         if(groupName == null)
         {
            _loc1_ += "<groupName></groupName>\n";
         }
         else
         {
            _loc1_ += "<groupName>" + groupName + "</groupName>\n";
         }
         _loc1_ += "<muteMainMusic>" + String(muteMainMusic) + "</muteMainMusic>\n";
         _loc1_ += "<musicVolume>" + String(musicVolume) + "</musicVolume>\n";
         _loc1_ += "<mistEffects>" + String(mistEffects) + "</mistEffects>\n";
         _loc1_ += "<particleEffects>" + String(particleEffects) + "</particleEffects>\n";
         _loc1_ += "<unchartedGames>\n";
         for each(_loc2_ in unchartedGames)
         {
            if(_loc2_.gameName != null && (_loc2_.playCount > 0 || _loc2_.lastScore > 0))
            {
               _loc1_ += _loc2_.getXML();
               _loc1_ += "\n";
            }
         }
         _loc1_ += "</unchartedGames>\n";
         _loc1_ += "<specialGames>\n";
         for each(_loc2_ in specialGames)
         {
            if(_loc2_.gameNumber >= 0)
            {
               _loc1_ += _loc2_.getXML();
               _loc1_ += "\n";
            }
         }
         _loc1_ += "</specialGames>\n";
         _loc1_ += "<randomGames>\n";
         for each(_loc2_ in randomGames)
         {
            if(_loc2_.gameNumber >= 0)
            {
               _loc1_ += _loc2_.getXML();
               _loc1_ += "\n";
            }
         }
         _loc1_ += "</randomGames>\n";
         _loc1_ += "<storyGames>\n";
         for each(_loc2_ in storyGames)
         {
            if(_loc2_.gameNumber >= 0)
            {
               _loc1_ += _loc2_.getXML();
               _loc1_ += "\n";
            }
         }
         _loc1_ += "</storyGames>\n";
         _loc1_ += "<customGames>\n";
         for each(_loc2_ in customGames)
         {
            if(_loc2_.gameName != null)
            {
               _loc1_ += _loc2_.getXML();
               _loc1_ += "\n";
            }
         }
         _loc1_ += "</customGames>\n";
         return _loc1_ + "</games>\n";
      }
   }
}
