package com.wbwar.creeper.dialogs.help
{
   import com.wbwar.creeper.BaseGun;
   import com.wbwar.creeper.util.Button;
   import com.wbwar.creeper.util.Text;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   
   public class UnitButton extends Button
   {
       
      
      private var WIDTH:int = 50;
      
      private var HEIGHT:int = 50;
      
      private var _active:Boolean;
      
      private var cover:Shape;
      
      public function UnitButton(param1:String)
      {
         var _loc2_:* = NaN;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param1 == "Gun" || param1 == "AreaGun" || param1 == "ABM" || param1 == "DroneBase" || param1 == "ThorsHammer" || param1 == "")
         {
            _loc2_ = 11550784;
         }
         else
         {
            _loc2_ = 4239424;
         }
         if(param1 == "BaseGun")
         {
            this.WIDTH = 100;
            this.HEIGHT = 100;
         }
         super("",8,this.WIDTH,this.HEIGHT,0,0,false,_loc2_,16777215);
         if(param1 == "BaseGun")
         {
            _loc3_ = BaseGun.getHelpImage();
            addChild(_loc3_);
            _loc3_.x = this.WIDTH / 2;
            _loc3_.y = this.HEIGHT / 2;
            _loc3_.scaleX = 1;
            _loc3_.scaleY = _loc3_.scaleX;
         }
         else if(param1 != "")
         {
            _loc3_ = getDefinitionByName("com.wbwar.creeper." + param1)["getPlacementSprite"](false);
            addChild(_loc3_);
            _loc3_.x = this.WIDTH / 2;
            _loc3_.y = this.HEIGHT / 2;
            _loc3_.scaleX = 2;
            _loc3_.scaleY = _loc3_.scaleX;
         }
         else
         {
            _loc4_ = Text.text("?",28,16777215);
            addChild(_loc4_);
            _loc4_.x = this.WIDTH / 2 - _loc4_.width / 2;
            _loc4_.y = this.HEIGHT / 2 - _loc4_.height / 2;
         }
         this.cover = new Shape();
         this.cover.graphics.beginFill(0,0.6);
         this.cover.graphics.drawRect(0,0,this.WIDTH,this.HEIGHT);
         this.cover.graphics.endFill();
         addChild(this.cover);
      }
      
      public function set active(param1:Boolean) : void
      {
         this._active = param1;
         this.cover.visible = !param1;
      }
   }
}
