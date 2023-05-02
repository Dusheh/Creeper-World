package com.wbwar.creeper.util
{
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class ClassUtil
   {
       
      
      public function ClassUtil()
      {
         super();
      }
      
      public static function getClass(param1:Object) : Class
      {
         return Class(getDefinitionByName(getQualifiedClassName(param1)));
      }
   }
}
