package com.wbwar.creeper.util
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.GameSpace;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   
   public class MessageDialogScrolling extends Sprite
   {
      
      public static const OK_CLICK:String = "com.wbwar.creeper.util.MessageDialogScrolling.OK_CLICK";
      
      public static const SIDE_LEFT:int = 0;
      
      public static const SIDE_RIGHT:int = 1;
      
      public static const SIDE_TOP:int = 2;
      
      public static const SIDE_BOTTOM:int = 3;
       
      
      private var side:int;
      
      private var startX:int;
      
      private var targetX:int;
      
      private var startY:int;
      
      private var targetY:int;
      
      public var textField:TextField;
      
      public var okButton:Button;
      
      private var loc:int;
      
      private var fixedWidth:int;
      
      private var fixedHeight:int;
      
      private var centerText:Boolean;
      
      private var flowContainer:FlowContainer;
      
      public function MessageDialogScrolling(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:Boolean = false)
      {
         super();
         this.side = param1;
         this.loc = param2;
         this.fixedWidth = param3;
         this.fixedHeight = param4;
         this.centerText = param6;
         GameSpace.instance.tutorialLayer.addChild(this);
         this.textField = Text.text("",14,16777215);
         this.textField.antiAliasType = AntiAliasType.NORMAL;
         this.textField.filters = [new DropShadowFilter()];
         this.textField.x = 5;
         this.textField.y = 5;
         if(!param6)
         {
            this.textField.wordWrap = true;
            this.textField.width = param3 - 10;
         }
         this.okButton = new Button("Continue",12,100,20,0,0,true,3182640,16777215);
         this.okButton.x = param3 / 2 - this.okButton.width / 2;
         addChild(this.okButton);
         if(!param5)
         {
            this.okButton.visible = false;
         }
         else
         {
            this.okButton.addEventListener(MouseEvent.CLICK,this.onOkClick);
         }
         visible = false;
      }
      
      private function update() : void
      {
         var _loc1_:int = this.fixedWidth;
         if(!this.centerText)
         {
            this.textField.width = _loc1_ - 20;
         }
         var _loc2_:int = this.textField.height + 10 + this.okButton.height + 5;
         if(this.fixedHeight >= 0)
         {
            _loc2_ = this.fixedHeight;
         }
         if(_loc2_ > 430)
         {
            _loc2_ = 430;
         }
         this.flowContainer = new FlowContainer(_loc1_,_loc2_ - this.okButton.height - 5);
         this.flowContainer.x = 0;
         this.flowContainer.y = 0;
         addChild(this.flowContainer);
         this.flowContainer.addContent(this.textField);
         this.flowContainer.refresh();
         graphics.clear();
         graphics.lineStyle(4,7360592);
         graphics.beginFill(2101264);
         graphics.drawRoundRect(0,0,_loc1_,_loc2_,16,16);
         graphics.endFill();
         if(this.loc < 0)
         {
            if(this.side == SIDE_LEFT || this.side == SIDE_RIGHT)
            {
               this.loc = int(262 - _loc2_ / 2);
            }
            else
            {
               this.loc = int(350 - _loc1_ / 2);
            }
         }
         if(this.side == SIDE_RIGHT)
         {
            this.startX = 0 * 0 + 5;
            this.targetX = 0 * 0 - _loc1_ - 5;
            x = this.startX;
            y = this.loc;
         }
         else if(this.side == SIDE_LEFT)
         {
            this.startX = -_loc1_ - 5;
            this.targetX = 5;
            x = this.startX;
            y = this.loc;
         }
         else if(this.side == SIDE_TOP)
         {
            this.startY = -_loc2_ - 5;
            this.targetY = 5;
            x = this.loc;
            y = this.startY;
         }
         else if(this.side == SIDE_BOTTOM)
         {
            this.startY = 0 * 0 + 5;
            this.targetY = 0 * 0 - _loc2_ - 5;
            x = this.loc;
            y = this.startY;
         }
         if(this.centerText)
         {
            this.textField.x = _loc1_ / 2 - this.textField.width / 2;
         }
         this.okButton.y = _loc2_ - 5 - this.okButton.height;
      }
      
      public function onOkClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         this.hide(true);
         dispatchEvent(new Event(OK_CLICK));
      }
      
      public function show() : void
      {
         this.update();
         visible = true;
         if(this.side == SIDE_LEFT || this.side == SIDE_RIGHT)
         {
            Tweener.addTween(this,{
               "time":0.5,
               "x":this.targetX
            });
         }
         else
         {
            Tweener.addTween(this,{
               "time":0.5,
               "y":this.targetY
            });
         }
      }
      
      public function hide(param1:Boolean) : void
      {
         if(param1)
         {
            if(this.side == SIDE_LEFT || this.side == SIDE_RIGHT)
            {
               Tweener.addTween(this,{
                  "time":0.5,
                  "x":this.startX,
                  "onComplete":this.remove
               });
            }
            else
            {
               Tweener.addTween(this,{
                  "time":0.5,
                  "y":this.startY,
                  "onComplete":this.remove
               });
            }
         }
         else if(this.side == SIDE_LEFT || this.side == SIDE_RIGHT)
         {
            Tweener.addTween(this,{
               "time":0.5,
               "x":this.startX
            });
         }
         else
         {
            Tweener.addTween(this,{
               "time":0.5,
               "y":this.startY
            });
         }
      }
      
      public function remove() : void
      {
         if(GameSpace.instance.tutorialLayer.contains(this))
         {
            GameSpace.instance.tutorialLayer.removeChild(this);
         }
      }
   }
}
