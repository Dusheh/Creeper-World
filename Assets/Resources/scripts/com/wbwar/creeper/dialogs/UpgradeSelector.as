package com.wbwar.creeper.dialogs
{
   import com.wbwar.creeper.util.Text;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class UpgradeSelector extends Sprite
   {
       
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      private var text:String;
      
      private var backgroundColor:Number;
      
      private var textTextField:TextField;
      
      private var _selected:Boolean;
      
      private var _over:Boolean;
      
      public function UpgradeSelector(param1:String, param2:Number, param3:int, param4:int)
      {
         super();
         this.text = param1;
         this.backgroundColor = param2;
         this.WIDTH = param3;
         this.HEIGHT = param4;
         this.textTextField = Text.text(param1,12,16777215);
         this.textTextField.x = this.WIDTH / 2 - this.textTextField.width / 2;
         this.textTextField.y = this.HEIGHT / 2 - this.textTextField.height / 2;
         addChild(this.textTextField);
         this.draw();
         useHandCursor = true;
         buttonMode = true;
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      public function set selected(param1:Boolean) : void
      {
         var _loc2_:Boolean = false;
         if(param1 != this._selected)
         {
            _loc2_ = true;
         }
         this._selected = param1;
         if(_loc2_)
         {
            this.draw();
         }
         if(param1)
         {
            useHandCursor = false;
            buttonMode = false;
         }
         else
         {
            useHandCursor = true;
            buttonMode = true;
         }
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set over(param1:Boolean) : void
      {
         this._over = param1;
         this.draw();
      }
      
      public function get over() : Boolean
      {
         return this._over;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         if(!visible)
         {
            this.over = false;
         }
      }
      
      private function onMouseOver(param1:Event) : void
      {
         this.over = true;
      }
      
      private function onMouseOut(param1:Event) : void
      {
         this.over = false;
      }
      
      private function draw() : void
      {
         graphics.clear();
         var _loc1_:* = 0.2;
         if(this.over)
         {
            _loc1_ = 0.4;
         }
         if(this.selected)
         {
            _loc1_ = 1;
         }
         graphics.beginFill(this.backgroundColor,_loc1_);
         graphics.drawRoundRect(0,0,this.WIDTH,this.HEIGHT,10,5);
         graphics.endFill();
      }
   }
}
