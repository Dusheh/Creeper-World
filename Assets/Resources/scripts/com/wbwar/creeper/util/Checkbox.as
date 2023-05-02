package com.wbwar.creeper.util
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class Checkbox extends Sprite
   {
      
      public static var CHECK_CHANGE:String = "CHECK_CHANGE";
       
      
      private var _checked:Boolean;
      
      private var borderColor:Number;
      
      private var checkedColor:Number;
      
      public function Checkbox(param1:Number, param2:Number)
      {
         super();
         this.borderColor = param1;
         this.checkedColor = param2;
         this.draw();
         useHandCursor = true;
         buttonMode = true;
         addEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
      
      public function set checked(param1:Boolean) : void
      {
         this._checked = param1;
         this.draw();
      }
      
      public function get checked() : Boolean
      {
         return this._checked;
      }
      
      private function onMouseClick(param1:MouseEvent = null) : void
      {
         this.checked = !this.checked;
         dispatchEvent(new Event(CHECK_CHANGE));
      }
      
      private function draw() : void
      {
         graphics.clear();
         graphics.beginFill(16777215,0.1);
         graphics.drawCircle(0,0,8);
         graphics.endFill();
         graphics.lineStyle(2,this.borderColor);
         graphics.drawCircle(0,0,8);
         if(this.checked)
         {
            graphics.lineStyle();
            graphics.beginFill(this.checkedColor);
            graphics.drawCircle(0,0,6);
            graphics.endFill();
         }
      }
   }
}
