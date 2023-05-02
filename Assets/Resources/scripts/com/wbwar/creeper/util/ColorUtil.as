package com.wbwar.creeper.util
{
   import caurina.transitions.Tweener;
   import com.adobe.utils.ArrayUtil;
   import com.wbwar.creeper.GameSpace;
   import flash.display.BitmapData;
   import flash.display.BitmapDataChannel;
   import flash.display.DisplayObject;
   import flash.display.GradientType;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.SpreadMethod;
   import flash.display.Sprite;
   import flash.filters.BlurFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ColorUtil
   {
      
      public static const filter_normal:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
      
      public static const filter_superbright:Array = [2,0,0,0,0,0,2,0,0,0,0,0,2,0,0,0,0,0,1,0];
      
      public static const filter_brighter:Array = [1.6,0,0,0,0,0,1.6,0,0,0,0,0,1.6,0,0,0,0,0,1,0];
      
      public static const filter_bright:Array = [1.3,0,0,0,0,0,1.3,0,0,0,0,0,1.3,0,0,0,0,0,1,0];
      
      public static const filter_dark:Array = [0.8,0,0,0,0,0,0.8,0,0,0,0,0,0.8,0,0,0,0,0,1,0];
      
      public static const filter_superdark:Array = [0.5,0,0,0,0,0,0.5,0,0,0,0,0,0.5,0,0,0,0,0,1,0];
      
      public static const filter_bw:Array = [0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0];
      
      public static var displayWidth:int;
      
      public static var displayHeight:int;
      
      public static var controlPanelHeight:int = 30;
       
      
      public function ColorUtil()
      {
         super();
      }
      
      public static function pushFilter(param1:DisplayObject, param2:Object) : void
      {
         var _loc3_:Array = ArrayUtil.copyArray(param1.filters);
         _loc3_.push(param2);
         param1.filters = _loc3_;
      }
      
      public static function popFilter(param1:DisplayObject) : void
      {
         var _loc2_:Array = ArrayUtil.copyArray(param1.filters);
         _loc2_.pop();
         param1.filters = _loc2_;
      }
      
      public static function world(param1:int, param2:int, param3:int, param4:int, param5:int) : Sprite
      {
         var _loc6_:Sprite = new Sprite();
         var _loc7_:Shape;
         (_loc7_ = new Shape()).cacheAsBitmap = true;
         _loc6_.addChild(_loc7_);
         var _loc8_:Shape;
         (_loc8_ = new Shape()).cacheAsBitmap = true;
         _loc6_.addChild(_loc8_);
         var _loc9_:Shape;
         (_loc9_ = new Shape()).cacheAsBitmap = true;
         _loc6_.addChild(_loc9_);
         var _loc10_:BitmapData = new BitmapData(200,200,true,0);
         var _loc11_:int = 120;
         var _loc12_:int = 80;
         var _loc13_:int = 3;
         var _loc14_:int = param1;
         var _loc15_:Boolean = false;
         var _loc16_:Boolean = false;
         var _loc17_:int = 0;
         var _loc18_:Boolean = false;
         var _loc19_:Point = new Point(0,0);
         var _loc20_:Point = new Point(0,0);
         var _loc21_:Array = [_loc19_,_loc20_];
         _loc10_.perlinNoise(_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_,_loc18_,_loc21_);
         var _loc22_:ColorTransform;
         (_loc22_ = new ColorTransform()).redOffset = param3;
         _loc22_.blueOffset = param4;
         _loc22_.blueOffset = param5;
         _loc10_.colorTransform(_loc10_.rect,_loc22_);
         var _loc23_:* = -16776961;
         _loc10_.threshold(_loc10_,_loc10_.rect,new Point(),"<",param2,_loc23_,65280,true);
         var _loc24_:BitmapData = new BitmapData(200,200,true,0);
         _loc11_ = 180;
         _loc12_ = 60;
         _loc13_ = 3;
         _loc14_ = param1 + 100;
         _loc15_ = false;
         _loc16_ = false;
         _loc17_ = 0;
         _loc18_ = true;
         _loc19_ = new Point(0,0);
         _loc20_ = new Point(0,0);
         _loc21_ = [_loc19_,_loc20_];
         _loc24_.perlinNoise(_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_,_loc18_,_loc21_);
         _loc24_.threshold(_loc24_,_loc24_.rect,new Point(),"<",1342177280,0,4278190080,true);
         var _loc25_:ColorTransform;
         (_loc25_ = new ColorTransform()).alphaOffset = 10;
         _loc24_.colorTransform(_loc24_.rect,_loc25_);
         var _loc26_:Matrix;
         (_loc26_ = new Matrix()).translate(-100,-100);
         _loc7_.graphics.beginBitmapFill(_loc10_,_loc26_);
         _loc7_.graphics.drawCircle(0,0,100);
         _loc7_.graphics.endFill();
         _loc8_.graphics.beginBitmapFill(_loc24_,_loc26_);
         _loc8_.graphics.drawCircle(0,0,100);
         _loc8_.graphics.endFill();
         var _loc27_:String = "null";
         var _loc28_:* = [16777200,2105376];
         var _loc29_:* = [0.4,0.8];
         var _loc30_:* = [0,255];
         var _loc31_:Matrix;
         (_loc31_ = new Matrix()).createGradientBox(210,270,0,-160,-180);
         var _loc32_:String = "null";
         _loc9_.graphics.beginGradientFill(_loc27_,_loc28_,_loc29_,_loc30_,_loc31_,_loc32_,"rgb",0.5);
         _loc9_.graphics.drawCircle(1,1,104);
         _loc9_.graphics.endFill();
         _loc6_.width = 20;
         _loc6_.height = 20;
         return _loc6_;
      }
      
      public static function drawArrow(param1:Graphics, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         param1.moveTo(param2,param3);
         param1.lineTo(param4,param5);
         var _loc6_:Number;
         var _loc7_:Number = (_loc6_ = Math.atan2(param3 - param5,param2 - param4)) - 0;
         var _loc8_:Number = _loc6_ + 0;
         param1.moveTo(param4,param5);
         param1.lineTo(param4 + Math.cos(_loc7_) * 5,param5 + Math.sin(_loc7_) * 5);
         param1.moveTo(param4,param5);
         param1.lineTo(param4 + Math.cos(_loc8_) * 5,param5 + Math.sin(_loc8_) * 5);
      }
      
      public static function cloud(param1:Number, param2:Number, param3:Number, param4:int, param5:int) : Shape
      {
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc6_:Random = new Random(param5);
         var _loc7_:Shape = new Shape();
         var _loc8_:BlurFilter;
         (_loc8_ = new BlurFilter()).blurX = 0;
         _loc8_.blurY = 0;
         _loc8_.quality = 3;
         var _loc9_:Array = new Array(_loc8_);
         _loc7_.filters = _loc9_;
         var _loc10_:int = 0;
         while(_loc10_ < param4)
         {
            _loc11_ = _loc6_.random() * 2 * 0;
            _loc12_ = _loc6_.random() * param1;
            if(Math.random() < 0.9)
            {
               _loc7_.graphics.beginFill(param2,param3);
            }
            else
            {
               _loc7_.graphics.beginFill(12632224,param3);
            }
            _loc7_.graphics.drawRect(Math.cos(_loc11_) * _loc12_,Math.sin(_loc11_) * _loc12_,_loc6_.random() * 1.8 * 0,_loc6_.random() * 1.8 * 0);
            _loc7_.graphics.endFill();
            _loc10_++;
         }
         return _loc7_;
      }
      
      public static function star(param1:Number, param2:Number, param3:int, param4:Number) : Shape
      {
         var _loc8_:* = false;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc5_:Shape = new Shape();
         var _loc6_:Number = 0 / param3;
         var _loc7_:Number = param2;
         _loc5_.graphics.beginFill(param4);
         _loc5_.graphics.moveTo(param2,0);
         var _loc9_:* = 0;
         while(_loc9_ <= param3)
         {
            _loc10_ = Math.cos(_loc9_ * _loc6_) * _loc7_;
            _loc11_ = Math.sin(_loc9_ * _loc6_) * _loc7_;
            _loc5_.graphics.lineTo(_loc10_,_loc11_);
            if(_loc8_)
            {
               _loc7_ = param2;
            }
            else
            {
               _loc7_ = param1;
            }
            _loc8_ = !_loc8_;
            _loc9_++;
         }
         _loc5_.graphics.lineTo(param2,0);
         _loc5_.graphics.endFill();
         return _loc5_;
      }
      
      public static function sphere(param1:Number, param2:Number, param3:Number = -1) : Shape
      {
         var _loc4_:Shape = new Shape();
         var _loc5_:Matrix;
         (_loc5_ = new Matrix()).createGradientBox(2.6 * param1,2.6 * param1,0,-param1 * 1.8,-param1 * 1.8);
         _loc4_.graphics.beginGradientFill(GradientType.RADIAL,[16777215,param2],[1,1],[0,255],_loc5_);
         if(param3 >= 0)
         {
            _loc4_.graphics.lineStyle(1,param3);
         }
         _loc4_.graphics.drawCircle(0,0,param1);
         _loc4_.graphics.endFill();
         return _loc4_;
      }
      
      public static function invertBitmapData(param1:BitmapData, param2:Number) : BitmapData
      {
         var _loc3_:BitmapData = new BitmapData(param1.width,param1.height,true,0);
         _loc3_.fillRect(new Rectangle(0,0,param1.width,param1.height),param2);
         _loc3_.threshold(param1,new Rectangle(0,0,param1.width,param1.height),new Point(0,0),">",0,0);
         return _loc3_;
      }
      
      public static function shadeColor(param1:DisplayObject, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         var _loc7_:Array = [param2,0,0,0,0,0,param3,0,0,0,0,0,param4,0,0,0,0,0,1,0];
         Tweener.addTween(param1,{
            "time":param6,
            "delay":param5,
            "_ColorMatrix_matrix":_loc7_
         });
      }
      
      public static function normalColor(param1:DisplayObject, param2:Number = 1) : void
      {
         Tweener.addTween(param1,{
            "time":param2,
            "_ColorMatrix_matrix":filter_normal
         });
      }
      
      public static function brightColor(param1:DisplayObject, param2:Number = 1) : void
      {
         Tweener.addTween(param1,{
            "time":param2,
            "_ColorMatrix_matrix":filter_bright
         });
      }
      
      public static function brighterColor(param1:DisplayObject, param2:Number = 1) : void
      {
         Tweener.addTween(param1,{
            "time":param2,
            "_ColorMatrix_matrix":filter_brighter
         });
      }
      
      public static function superBrightColor(param1:DisplayObject, param2:Number = 1) : void
      {
         Tweener.addTween(param1,{
            "time":param2,
            "_ColorMatrix_matrix":filter_superbright
         });
      }
      
      public static function darkColor(param1:DisplayObject, param2:Number = 1) : void
      {
         Tweener.addTween(param1,{
            "time":param2,
            "_ColorMatrix_matrix":filter_dark
         });
      }
      
      public static function superDarkColor(param1:DisplayObject, param2:Number = 1) : void
      {
         Tweener.addTween(param1,{
            "time":param2,
            "_ColorMatrix_matrix":filter_superdark
         });
      }
      
      public static function bwColor(param1:DisplayObject, param2:Number = 1) : void
      {
         Tweener.addTween(param1,{
            "time":param2,
            "_ColorMatrix_matrix":filter_bw
         });
      }
      
      public static function linesIntersect(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : Boolean
      {
         if(param1 == param5 && param2 == param6 || param1 == param7 && param2 == param8 || param3 == param5 && param4 == param6 || param3 == param7 && param4 == param8)
         {
            return false;
         }
         if((param1 == param5 && param2 == param6 || param1 == param7 && param2 == param8) && (param3 == param5 && param4 == param6 || param3 == param7 && param4 == param8))
         {
            return true;
         }
         return relativeCCW(param1,param2,param3,param4,param5,param6) * relativeCCW(param1,param2,param3,param4,param7,param8) <= 0 && relativeCCW(param5,param6,param7,param8,param1,param2) * relativeCCW(param5,param6,param7,param8,param3,param4) <= 0;
      }
      
      public static function relativeCCW(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : int
      {
         param3 -= param1;
         param4 -= param2;
         param5 -= param1;
         param6 -= param2;
         var _loc7_:*;
         if((_loc7_ = Number(param5 * param4 - param6 * param3)) == 0)
         {
            if((_loc7_ = Number(param5 * param3 + param6 * param4)) > 0)
            {
               param5 -= param3;
               param6 -= param4;
               if((_loc7_ = Number(param5 * param3 + param6 * param4)) < 0)
               {
                  _loc7_ = 0;
               }
            }
         }
         return _loc7_ < 0 ? -1 : (_loc7_ > 0 ? 1 : 0);
      }
   }
}
