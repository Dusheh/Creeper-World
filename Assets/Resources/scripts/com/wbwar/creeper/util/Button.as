package com.wbwar.creeper.util
{
   import flash.display.GradientType;
   import flash.display.InterpolationMethod;
   import flash.display.SpreadMethod;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.BlurFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.media.Sound;
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class Button extends Sprite
   {
      
      private static var clickSound:Sound;
       
      
      private var updateCount:int;
      
      private var _mystery:Boolean;
      
      private var _available:Boolean = true;
      
      private var _enabled:Boolean = true;
      
      private var subtitleTextField:TextField;
      
      public var text:TextField;
      
      private var mysteryText:TextField;
      
      private var mysteryCover:Sprite;
      
      public function Button(param1:String, param2:int, param3:int, param4:int, param5:int, param6:int, param7:Boolean, param8:Number, param9:Number)
      {
         var _loc11_:* = null;
         super();
         if(clickSound == null)
         {
            clickSound = new ClickSound();
         }
         this.text = textAdv(param1,param2,16777215);
         this.text.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         this.text.x = 1;
         addChild(this.text);
         this.text.x += param5;
         this.text.y += param6;
         this.mysteryCover = new Sprite();
         this.mysteryCover.mouseEnabled = false;
         this.mysteryCover.mouseChildren = false;
         addChild(this.mysteryCover);
         this.mysteryCover.visible = false;
         graphics.beginFill(param8);
         this.mysteryCover.graphics.beginFill(param8);
         if(param9 >= 0)
         {
            graphics.lineStyle(1,param9);
         }
         if(param3 <= 0)
         {
            if(param4 <= 0)
            {
               graphics.drawRect(0,0,this.text.width + 1,this.text.height);
               this.mysteryCover.graphics.drawRect(0,0,this.text.width + 1,this.text.height);
            }
            else
            {
               graphics.drawRect(0,0,this.text.width + 1,param4);
               this.mysteryCover.graphics.drawRect(0,0,this.text.width + 1,param4);
            }
         }
         else
         {
            if(param7)
            {
               this.text.x = int(param3 / 2 - this.text.width / 2);
            }
            if(param4 <= 0)
            {
               graphics.drawRect(0,0,param3,this.text.height);
               this.mysteryCover.graphics.drawRect(0,0,param3,this.text.height);
            }
            else
            {
               graphics.drawRect(0,0,param3,param4);
               this.mysteryCover.graphics.drawRect(0,0,param3,param4);
            }
         }
         graphics.endFill();
         this.mysteryCover.graphics.endFill();
         (_loc11_ = new Matrix()).createGradientBox(param3,param4,0,0,0);
         this.mysteryCover.graphics.beginGradientFill(GradientType.LINEAR,[0,7368816],[0,0.6],[0,255],_loc11_,SpreadMethod.PAD,InterpolationMethod.RGB,0);
         this.mysteryCover.graphics.drawRect(0,0,param3,param4);
         this.mysteryCover.graphics.endFill();
         (_loc11_ = new Matrix()).createGradientBox(param3,param4,0,0,0);
         graphics.beginGradientFill(GradientType.LINEAR,[0,16777215],[0,0.6],[0,255],_loc11_,SpreadMethod.PAD,InterpolationMethod.RGB,0);
         graphics.drawRect(0,0,param3,param4);
         graphics.endFill();
         useHandCursor = true;
         buttonMode = true;
         mouseChildren = false;
         addEventListener(MouseEvent.CLICK,this.onMouseClick);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      }
      
      public static function textAdv(param1:String, param2:uint, param3:uint) : TextField
      {
         var _loc5_:* = null;
         var _loc4_:TextField = new TextField();
         _loc5_ = new TextFormat();
         if(param2 <= 8)
         {
            _loc5_.font = "befontsmall";
         }
         else
         {
            _loc5_.font = "befont";
         }
         _loc5_.color = param3;
         _loc5_.size = param2;
         _loc4_.embedFonts = true;
         _loc4_.antiAliasType = AntiAliasType.ADVANCED;
         if(param2 <= 8)
         {
            _loc4_.sharpness = 400;
         }
         else if(param2 <= 14)
         {
            _loc4_.sharpness = 100;
         }
         _loc4_.defaultTextFormat = _loc5_;
         _loc4_.autoSize = TextFieldAutoSize.LEFT;
         _loc4_.selectable = false;
         _loc4_.mouseEnabled = false;
         if(param1 != null)
         {
            _loc4_.text = param1;
         }
         return _loc4_;
      }
      
      public function set mystery(param1:Boolean) : void
      {
         this._mystery = param1;
         if(param1)
         {
            this.text.visible = false;
            this.mysteryCover.visible = true;
            addChild(this.mysteryCover);
            ColorUtil.bwColor(this,0.5);
         }
         else
         {
            this.text.visible = true;
            this.mysteryCover.visible = false;
            ColorUtil.normalColor(this,0.5);
         }
      }
      
      public function get mystery() : Boolean
      {
         return this._mystery;
      }
      
      public function set available(param1:Boolean) : void
      {
         this._available = param1;
         this.enabled = this._available;
         if(param1)
         {
            alpha = 1;
            filters = [];
         }
         else
         {
            alpha = 0.5;
            filters = [new BlurFilter(2,2)];
         }
      }
      
      public function get available() : Boolean
      {
         return this._available;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         this._enabled = param1;
         if(param1)
         {
            alpha = 1;
         }
         else
         {
            alpha = 0.5;
         }
         if(param1)
         {
            useHandCursor = true;
            buttonMode = true;
         }
         else
         {
            useHandCursor = false;
            buttonMode = false;
         }
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function setSubtitle(param1:String, param2:Number, param3:Number, param4:Boolean = false) : void
      {
         if(param4)
         {
            this.subtitleTextField = Text.text(param1,8,0);
            this.subtitleTextField.filters = [new GlowFilter(16777215,1,2,2,2,BitmapFilterQuality.LOW)];
         }
         else
         {
            this.subtitleTextField = Text.text(param1,8,12632208);
            this.subtitleTextField.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         }
         addChild(this.subtitleTextField);
         this.subtitleTextField.x = param2;
         this.subtitleTextField.y = param3;
         this.subtitleTextField.visible = false;
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         if(!this.enabled || this.mystery)
         {
            param1.stopImmediatePropagation();
         }
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         if(this.enabled && !this.mystery)
         {
            clickSound.play();
         }
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         if(this.enabled && !this.mystery)
         {
            ColorUtil.brighterColor(this,1);
            if(this.subtitleTextField != null)
            {
               this.subtitleTextField.visible = true;
            }
         }
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         if(!this.mystery)
         {
            ColorUtil.normalColor(this,1);
            if(this.subtitleTextField != null)
            {
               this.subtitleTextField.visible = false;
            }
         }
      }
   }
}
