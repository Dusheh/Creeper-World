package com.wbwar.creeper.games
{
   import flash.net.SharedObject;
   
   public class Persist
   {
       
      
      public function Persist()
      {
         super();
      }
      
      public static function getData() : Object
      {
         var data:Object = null;
         var lso:SharedObject = null;
         if(false)
         {
            return Creeper.loadGameDataFunction();
         }
         try
         {
            lso = SharedObject.getLocal("creeperworld","/");
            data = lso.data.gameData;
         }
         finally
         {
            lso.close();
         }
         return data;
      }
      
      public static function saveData(param1:Object) : void
      {
         var lso:SharedObject = null;
         var gameData:Object = param1;
         if(false)
         {
            Creeper.saveGameDataFunction(gameData);
         }
         else
         {
            try
            {
               lso = SharedObject.getLocal("creeperworld","/");
               lso.data.gameData = gameData;
               lso.flush();
            }
            finally
            {
               lso.close();
            }
         }
      }
   }
}
