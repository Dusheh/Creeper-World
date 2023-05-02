package com.wbwar.creeper.screens
{
   import com.wbwar.creeper.games.GameData;
   import com.wbwar.creeper.games.IndividualGameData;
   import com.wbwar.creeper.util.Text;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   
   public class MissionSystem extends Sprite
   {
      
      public static var starImage:Class = MissionSystem_starImage;
      
      private static const WORLD_ORBIT_RADIUS:int = 45;
      
      private static const STAR_RADIUS:int = 19;
       
      
      private var starBitmap:Bitmap;
      
      public var systemName:String;
      
      public var startWorld:int;
      
      public var endWorld:int;
      
      private var star:Shape;
      
      private var worlds:Array;
      
      private var scoreTextField:TextField;
      
      private var playCountTextField:TextField;
      
      private var _locked:Boolean;
      
      private var _score:int;
      
      private var lockShield:Sprite;
      
      public var fms:FreeplayMissionSelection;
      
      public function MissionSystem(param1:FreeplayMissionSelection, param2:String, param3:int, param4:int, param5:Number, param6:Number)
      {
         var _loc7_:* = null;
         var _loc12_:* = null;
         this.starBitmap = new starImage() as Bitmap;
         super();
         this.x = param5;
         this.y = param6;
         this.fms = param1;
         addChild(this.starBitmap);
         this.starBitmap.x = -30;
         this.starBitmap.y = -24;
         this.systemName = param2;
         this.startWorld = param3;
         this.endWorld = param4;
         _loc7_ = Text.text(param2,18,16777215);
         addChild(_loc7_);
         _loc7_.x = -_loc7_.width / 2;
         _loc7_.y = -WORLD_ORBIT_RADIUS - 15 - _loc7_.height;
         _loc7_.filters = [new DropShadowFilter()];
         this.scoreTextField = Text.text("",12,10551184);
         addChild(this.scoreTextField);
         this.scoreTextField.y = -STAR_RADIUS - this.scoreTextField.height;
         this.scoreTextField.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         var _loc8_:TextField = Text.text("Score",12,16777215);
         addChild(_loc8_);
         _loc8_.x = int(-_loc8_.width / 2);
         _loc8_.y = -STAR_RADIUS - 15;
         _loc8_.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         this.playCountTextField = Text.text("",8,10551184);
         addChild(this.playCountTextField);
         this.playCountTextField.y = STAR_RADIUS - 13;
         this.playCountTextField.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         this.worlds = [];
         var _loc9_:Number = 0 / (param4 - param3 + 1);
         var _loc10_:* = 0;
         graphics.lineStyle(1,16777215);
         var _loc11_:int = param3;
         while(_loc11_ <= param4)
         {
            _loc12_ = new MissionSystemWorld(this,_loc11_,int(Math.cos(_loc10_) * WORLD_ORBIT_RADIUS),int(Math.sin(_loc10_) * WORLD_ORBIT_RADIUS));
            this.worlds[_loc11_] = _loc12_;
            addChild(_loc12_);
            _loc10_ += _loc9_;
            if(_loc11_ == param3)
            {
               graphics.moveTo(_loc12_.x,_loc12_.y);
            }
            else
            {
               graphics.lineTo(_loc12_.x,_loc12_.y);
            }
            _loc11_++;
         }
         graphics.lineTo(0,-WORLD_ORBIT_RADIUS);
         this.lockShield = new Sprite();
         this.lockShield.graphics.beginFill(0,0);
         this.lockShield.graphics.drawCircle(0,0,WORLD_ORBIT_RADIUS + 30);
         this.lockShield.graphics.endFill();
         this.lockShield.visible = false;
         addChild(this.lockShield);
      }
      
      public function reinit() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         for each(_loc4_ in this.worlds)
         {
            _loc1_ = GameData.getRandomGameData(_loc4_.gameNumber);
            _loc4_.reinit(_loc1_);
            _loc2_ += _loc1_.highScore;
            _loc3_ += _loc1_.playCount;
         }
         this.scoreTextField.text = String(_loc2_);
         this.scoreTextField.x = int(-this.scoreTextField.width / 2);
         this.playCountTextField.text = "# Plays: " + String(_loc3_);
         this.playCountTextField.x = int(-this.playCountTextField.width / 2);
         this.locked = false;
         if(this.startWorld != 1)
         {
            _loc5_ = this.startWorld - 5;
            while(_loc5_ < this.startWorld)
            {
               _loc1_ = GameData.getRandomGameData(_loc5_);
               if(_loc1_.highScore <= 0)
               {
                  this.locked = true;
                  break;
               }
               _loc5_++;
            }
         }
      }
      
      public function set locked(param1:Boolean) : void
      {
         this._locked = param1;
         if(param1)
         {
            this.lockShield.visible = true;
            alpha = 0.3;
         }
         else
         {
            this.lockShield.visible = false;
            alpha = 1;
         }
      }
      
      public function get locked() : Boolean
      {
         return this._locked;
      }
   }
}
