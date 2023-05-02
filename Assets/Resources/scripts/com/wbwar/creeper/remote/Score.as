package com.wbwar.creeper.remote
{
   import com.hurlant.crypto.hash.MD5;
   import com.hurlant.util.Hex;
   import com.wbwar.creeper.games.GameData;
   import com.wbwar.creeper.games.IndividualGameData;
   import com.wbwar.creeper.util.RC4;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   
   public class Score
   {
      
      public static const GAMETYPE_STORY:int = 0;
      
      public static const GAMETYPE_CONQUEST:int = 1;
      
      public static const GAMETYPE_SPECIAL:int = 2;
      
      private static var loader:URLLoader;
       
      
      public function Score()
      {
         super();
      }
      
      public static function submitScore(param1:String, param2:String, param3:String, param4:int, param5:int, param6:Function, param7:Function) : void
      {
         var _loc8_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         _loc8_ = (_loc8_ = "1") + "\n";
         _loc8_ = (_loc8_ = (_loc8_ = "1") + "\n" + param1) + "\n";
         _loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = "1") + "\n" + param1) + "\n" + param2) + "\n";
         _loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = "1") + "\n" + param1) + "\n" + param2) + "\n" + param3) + "\n";
         _loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = "1") + "\n" + param1) + "\n" + param2) + "\n" + param3) + "\n" + param4) + "\n";
         _loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = "1") + "\n" + param1) + "\n" + param2) + "\n" + param3) + "\n" + param4) + "\n" + param5) + "\n";
         var _loc9_:MD5 = new MD5();
         _loc8_ += Hex.fromArray(_loc9_.hash(Hex.toArray(Hex.fromString(_loc8_))));
         var _loc10_:String = RC4.encrypt(_loc8_,RC4.decrypt("4890928b4e8152aadf996098b9","spaceestate11"));
         var _loc11_:URLVariables;
         (_loc11_ = new URLVariables()).scoredata = _loc10_;
         try
         {
            (_loc12_ = new URLRequest()).url = "http://knucklecracker.com/creeperworld/submitscoreB.php";
            _loc12_.data = _loc11_;
            _loc12_.method = URLRequestMethod.POST;
            (_loc13_ = new URLLoader()).load(_loc12_);
            _loc13_.addEventListener(Event.COMPLETE,param6);
            _loc13_.addEventListener(IOErrorEvent.IO_ERROR,param7);
         }
         catch(e:Error)
         {
         }
      }
      
      public static function submitScoreCustom(param1:String, param2:String, param3:String, param4:int, param5:int, param6:Function, param7:Function) : void
      {
         var _loc8_:* = null;
         var _loc12_:* = null;
         _loc8_ = (_loc8_ = "1") + "\n";
         _loc8_ = (_loc8_ = (_loc8_ = "1") + "\n" + param1) + "\n";
         _loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = "1") + "\n" + param1) + "\n" + param2) + "\n";
         _loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = "1") + "\n" + param1) + "\n" + param2) + "\n" + param3) + "\n";
         _loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = "1") + "\n" + param1) + "\n" + param2) + "\n" + param3) + "\n" + param4) + "\n";
         _loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = (_loc8_ = "1") + "\n" + param1) + "\n" + param2) + "\n" + param3) + "\n" + param4) + "\n" + param5) + "\n";
         var _loc9_:MD5 = new MD5();
         _loc8_ += Hex.fromArray(_loc9_.hash(Hex.toArray(Hex.fromString(_loc8_))));
         var _loc10_:String = RC4.encrypt(_loc8_,RC4.decrypt("4890928b4e8152aadf996098b9","spaceestate11"));
         var _loc11_:URLVariables;
         (_loc11_ = new URLVariables()).scoredata = _loc10_;
         try
         {
            (_loc12_ = new URLRequest()).url = "http://knucklecracker.com/creeperworld/submitscorecustom.php";
            _loc12_.data = _loc11_;
            _loc12_.method = URLRequestMethod.POST;
            loader = new URLLoader();
            loader.load(_loc12_);
            loader.addEventListener(Event.COMPLETE,param6);
            loader.addEventListener(IOErrorEvent.IO_ERROR,param7);
         }
         catch(e:Error)
         {
         }
      }
      
      public static function submitScoreUncharted(param1:String, param2:String, param3:String, param4:int, param5:int, param6:Function, param7:Function) : void
      {
         var data:String = null;
         var request:URLRequest = null;
         var loader:URLLoader = null;
         var map:String = param1;
         var user:String = param2;
         var group:String = param3;
         var score:int = param4;
         var playCount:int = param5;
         var submitComplete:Function = param6;
         var errorComplete:Function = param7;
         data = "1";
         data += "\n";
         data += map;
         data += "\n";
         data += user;
         data += "\n";
         data += group;
         data += "\n";
         data += score;
         data += "\n";
         data += playCount;
         data += "\n";
         var m:MD5 = new MD5();
         data += Hex.fromArray(m.hash(Hex.toArray(Hex.fromString(data))));
         var edata:String = RC4.encrypt(data,RC4.decrypt("4890928b4e8152aadf996098b9","spaceestate11"));
         var variables:URLVariables = new URLVariables();
         variables.scoredata = edata;
         try
         {
            request = new URLRequest();
            request.url = "http://knucklecracker.com/creeperworld/submitscoreuncharted.php";
            request.data = variables;
            request.method = URLRequestMethod.POST;
            loader = new URLLoader();
            loader.load(request);
            loader.addEventListener(Event.COMPLETE,submitComplete,false,0,true);
            loader.addEventListener(IOErrorEvent.IO_ERROR,errorComplete,false,0,true);
         }
         catch(e:Error)
         {
         }
      }
      
      public static function submitScoreOld(param1:String, param2:String, param3:int, param4:Function, param5:Function) : void
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc14_:* = null;
         var _loc15_:* = null;
         _loc6_ = (_loc6_ = "1") + "\n";
         _loc6_ = (_loc6_ = (_loc6_ = "1") + "\n" + param1) + "\n";
         _loc6_ = (_loc6_ = (_loc6_ = (_loc6_ = "1") + "\n" + param1) + "\n" + param2) + "\n";
         _loc6_ = (_loc6_ = (_loc6_ = (_loc6_ = (_loc6_ = "1") + "\n" + param1) + "\n" + param2) + "\n" + param3) + "\n";
         var _loc9_:* = "";
         var _loc10_:* = "";
         if(param3 == GAMETYPE_STORY)
         {
            _loc8_ = 0;
            while(_loc8_ < 20)
            {
               _loc7_ = GameData.getStoryGameData(_loc8_);
               _loc9_ += _loc7_.highScore;
               _loc10_ += _loc7_.playCount;
               if(_loc8_ < 19)
               {
                  _loc9_ += ",";
                  _loc10_ += ",";
               }
               _loc8_++;
            }
         }
         else if(param3 == GAMETYPE_CONQUEST)
         {
            _loc8_ = 1;
            while(_loc8_ <= 25)
            {
               _loc7_ = GameData.getRandomGameData(_loc8_);
               _loc9_ += _loc7_.highScore;
               _loc10_ += _loc7_.playCount;
               if(_loc8_ < 25)
               {
                  _loc9_ += ",";
                  _loc10_ += ",";
               }
               _loc8_++;
            }
         }
         else if(param3 == GAMETYPE_SPECIAL)
         {
            _loc8_ = 0;
            while(_loc8_ < 10)
            {
               _loc7_ = GameData.getSpecialGameData(_loc8_);
               _loc9_ += _loc7_.highScore;
               _loc10_ += _loc7_.playCount;
               if(_loc8_ < 9)
               {
                  _loc9_ += ",";
                  _loc10_ += ",";
               }
               _loc8_++;
            }
         }
         _loc6_ = (_loc6_ += _loc9_) + "\n";
         _loc6_ = (_loc6_ = (_loc6_ += _loc9_) + "\n" + _loc10_) + "\n";
         var _loc11_:MD5 = new MD5();
         _loc6_ += Hex.fromArray(_loc11_.hash(Hex.toArray(Hex.fromString(_loc6_))));
         var _loc12_:String = RC4.encrypt(_loc6_,RC4.decrypt("4890928b4e8152aadf996098b9","spaceestate11"));
         var _loc13_:URLVariables;
         (_loc13_ = new URLVariables()).scoredata = _loc12_;
         try
         {
            (_loc14_ = new URLRequest()).url = "http://knucklecracker.com/creeperworld/submitscore.php";
            _loc14_.data = _loc13_;
            _loc14_.method = URLRequestMethod.POST;
            (_loc15_ = new URLLoader()).load(_loc14_);
            _loc15_.addEventListener(Event.COMPLETE,param4);
            _loc15_.addEventListener(IOErrorEvent.IO_ERROR,param5);
         }
         catch(e:Error)
         {
         }
      }
   }
}
