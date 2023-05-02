package com.wbwar.creeper.screens
{
   import com.wbwar.creeper.util.Text;
   import flash.display.GradientType;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   
   public class AchievementsBox extends Sprite
   {
      
      public static const TYPE_CONQUEST:String = "conquest";
      
      public static const TYPE_STORY:String = "story";
      
      public static const TYPE_SPECIAL:String = "special";
      
      public static const TYPE_ALLCONQUEST:String = "allConquest";
      
      public static const TYPE_ALLSTORY:String = "allStory";
      
      public static const TYPE_ALLSPECIAL:String = "allSpecial";
      
      public static const TYPE_ALL:String = "all";
      
      public static const STAR_RED:String = "red";
      
      public static const STAR_GREEN:String = "green";
      
      public static const STAR_BLUE:String = "blue";
      
      public static const STAR_GOLD:String = "gold";
       
      
      private var _locked:Boolean;
      
      private var titleText:TextField;
      
      private var star:MovieClip;
      
      public function AchievementsBox(param1:String, param2:int = -1)
      {
         var starColor:String = null;
         var width:int = 0;
         var height:int = 0;
         var title:String = null;
         var type:String = param1;
         var mission:int = param2;
         super();
         if(type == TYPE_CONQUEST || type == TYPE_ALLCONQUEST)
         {
            starColor = STAR_BLUE;
         }
         else if(type == TYPE_STORY || type == TYPE_ALLSTORY)
         {
            starColor = STAR_RED;
         }
         else if(type == TYPE_SPECIAL || type == TYPE_ALLSPECIAL)
         {
            starColor = STAR_GREEN;
         }
         else
         {
            starColor = STAR_GOLD;
         }
         if(type == TYPE_STORY)
         {
            try
            {
               title = getDefinitionByName("com.wbwar.creeper.games.Game" + mission)["title"];
            }
            catch(e:Error)
            {
               title = "???";
            }
            width = 130;
            height = 25;
         }
         else if(type == TYPE_CONQUEST)
         {
            title = FreeplayMissionSelection.systemNames[mission];
            width = 150;
            height = 25;
         }
         else if(type == TYPE_SPECIAL)
         {
            try
            {
               title = getDefinitionByName("com.wbwar.creeper.games.SpecialGame" + mission)["title"];
            }
            catch(e:Error)
            {
               title = "???";
            }
            width = 150;
            height = 25;
         }
         else if(type == TYPE_ALLCONQUEST)
         {
            title = "Conquest King";
            width = 150;
            height = 25;
            scaleX = 1.3;
            scaleY = scaleX;
         }
         else if(type == TYPE_ALLSTORY)
         {
            title = "Lord of the Story";
            width = 170;
            height = 25;
            scaleX = 1.3;
            scaleY = scaleX;
         }
         else if(type == TYPE_ALLSPECIAL)
         {
            title = "Special Agent";
            width = 150;
            height = 25;
            scaleX = 1.3;
            scaleY = scaleX;
         }
         else
         {
            title = "Supreme Victory";
            width = 150;
            height = 25;
            scaleX = 3;
            scaleY = scaleX;
         }
         var matr:Matrix = new Matrix();
         matr.createGradientBox(width,height,0);
         graphics.beginGradientFill(GradientType.LINEAR,[10526880,7368816],[1,1],[0,255],matr);
         graphics.lineStyle(2,4210752);
         graphics.drawRect(0,0,width,height);
         graphics.endFill();
         if(starColor == STAR_RED)
         {
            this.star = new StarRed();
         }
         else if(starColor == STAR_GREEN)
         {
            this.star = new StarGreen();
         }
         else if(starColor == STAR_BLUE)
         {
            this.star = new StarBlue();
         }
         else if(starColor == STAR_GOLD)
         {
            this.star = new StarGold();
         }
         this.star.width = 23;
         this.star.height = 23;
         addChild(this.star);
         this.star.x = 15;
         this.star.y = 12;
         this.titleText = Text.text(title,14,16777215);
         this.titleText.filters = [new DropShadowFilter()];
         addChild(this.titleText);
         this.titleText.x = 25;
         this.titleText.y = 0;
         this.locked = true;
      }
      
      public function set locked(param1:Boolean) : void
      {
         this._locked = param1;
         if(param1)
         {
            alpha = 0.1;
            this.star.visible = false;
         }
         else
         {
            alpha = 1;
            this.star.visible = true;
         }
      }
      
      public function get locked() : Boolean
      {
         return this._locked;
      }
   }
}
