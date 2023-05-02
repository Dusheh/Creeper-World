package com.wbwar.creeper.util
{
   import caurina.transitions.Tweener;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   
   public class GraphLegendButton extends Sprite
   {
      
      public static const WIDTH:int = 120;
      
      public static const HEIGHT:int = 18;
       
      
      private var titleText:TextField;
      
      private var color:Number;
      
      private var background:Shape;
      
      private var block:Shape;
      
      private var _selected:Boolean = true;
      
      public function GraphLegendButton(param1:String, param2:Number)
      {
         super();
         this.color = param2;
         this.background = new Shape();
         addChild(this.background);
         this.background.visible = false;
         this.background.graphics.beginFill(9474048);
         this.background.graphics.drawRect(0,0,WIDTH,HEIGHT);
         this.background.graphics.endFill();
         this.titleText = Text.text(param1,10,16777215);
         this.titleText.filters = [new DropShadowFilter(2)];
         addChild(this.titleText);
         this.titleText.x = 15;
         this.block = new Shape();
         addChild(this.block);
         this.draw();
         useHandCursor = true;
         buttonMode = true;
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      public function set selected(param1:Boolean) : void
      {
         this._selected = param1;
         this.draw();
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function draw() : void
      {
         this.block.graphics.clear();
         if(this._selected)
         {
            this.block.graphics.beginFill(this.color);
         }
         else
         {
            this.block.graphics.beginFill(0);
         }
         this.block.graphics.drawRect(4,4,10,10);
         this.block.graphics.endFill();
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         Tweener.addTween(this.background,{
            "time":1,
            "_autoAlpha":1
         });
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         Tweener.addTween(this.background,{
            "time":1,
            "_autoAlpha":0
         });
      }
   }
}
