package com.wbwar.creeper
{
   import com.wbwar.creeper.util.ColorUtil;
   import flash.display.GradientType;
   import flash.display.InterpolationMethod;
   import flash.display.Shape;
   import flash.display.SpreadMethod;
   import flash.display.Sprite;
   import flash.filters.BlurFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   
   public final class RiftBody extends Sprite
   {
       
      
      private var rings:Array;
      
      private var rr:Array;
      
      private var rs:Array;
      
      private var orbStar:Shape;
      
      private var orb:Shape;
      
      private var orbScale:Number = -0.01;
      
      private var ringsSprite:Sprite;
      
      private var riftSprite:Sprite;
      
      private var holeSprite:Sprite;
      
      private var holeStar:Shape;
      
      private var hole:Shape;
      
      public function RiftBody()
      {
         this.rings = [];
         this.rr = [];
         this.rs = [];
         super();
         mouseEnabled = false;
         mouseChildren = false;
         this.ringsSprite = new Sprite();
         this.ringsSprite.mouseEnabled = false;
         this.ringsSprite.mouseChildren = false;
         this.rings[0] = this.getRing(60,40);
         this.rr[0] = 7;
         this.rs[0] = 0.1;
         this.ringsSprite.addChild(this.rings[0]);
         this.rings[1] = this.getRing(60,40);
         this.rr[1] = -12;
         this.rs[1] = 0.13;
         this.ringsSprite.addChild(this.rings[1]);
         this.rings[2] = this.getRing(60,40);
         this.rr[2] = 0;
         this.rs[2] = 0.17;
         this.ringsSprite.addChild(this.rings[2]);
         this.ringsSprite.filters = [new GlowFilter(16711680,1,8,8)];
         this.orbStar = ColorUtil.star(5,20,16,16777215);
         this.orbStar.filters = [new GlowFilter(16776960,1,8,8,2,1)];
         this.orb = new Shape();
         var _loc2_:Matrix = new Matrix();
         _loc2_.createGradientBox(40,40,0,-20,-20);
         this.orb.graphics.beginGradientFill(GradientType.RADIAL,[16777215,10526880],[1,0],[64,225],_loc2_,SpreadMethod.PAD,InterpolationMethod.RGB,0);
         this.orb.graphics.drawCircle(0,0,17);
         this.orb.graphics.endFill();
         this.orb.filters = [new GlowFilter(16776960,1,8,8,2,1)];
         this.riftSprite = new Sprite();
         this.riftSprite.mouseEnabled = false;
         this.riftSprite.mouseChildren = false;
         addChild(this.riftSprite);
         this.riftSprite.addChild(this.orb);
         this.riftSprite.addChild(this.orbStar);
         this.riftSprite.addChild(this.ringsSprite);
         this.holeSprite = new Sprite();
         this.holeSprite.mouseEnabled = false;
         this.holeSprite.mouseChildren = false;
         addChild(this.holeSprite);
         this.holeSprite.visible = false;
         this.holeStar = ColorUtil.star(20,30,16,0);
         this.holeStar.alpha = 0.5;
         this.holeStar.filters = [new BlurFilter(16,16)];
         this.hole = new Shape();
         this.hole.graphics.beginFill(0,0.1);
         this.hole.graphics.drawCircle(0,0,15);
         this.hole.graphics.endFill();
         this.hole.graphics.beginFill(0,0.3);
         this.hole.graphics.drawCircle(0,0,10);
         this.hole.graphics.endFill();
         this.hole.graphics.beginFill(0,0.5);
         this.hole.graphics.drawCircle(0,0,5);
         this.hole.graphics.endFill();
         this.hole.graphics.beginFill(0);
         this.hole.graphics.drawCircle(0,0,2);
         this.hole.graphics.endFill();
         this.holeSprite.addChild(this.holeStar);
         this.holeSprite.addChild(this.hole);
      }
      
      public function update() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         if(GameSpace.instance.suppressCityExit)
         {
            this.riftSprite.visible = false;
            this.holeSprite.visible = true;
            this.holeStar.rotation += 2;
         }
         else
         {
            this.riftSprite.visible = true;
            this.holeSprite.visible = false;
            _loc2_ = 0;
            while(_loc2_ < this.rings.length)
            {
               _loc1_ = this.rings[_loc2_] as Shape;
               _loc1_.rotation += this.rr[_loc2_];
               if(_loc1_.scaleY >= 1 || _loc1_.scaleY <= 0)
               {
                  this.rs[_loc2_] = -this.rs[_loc2_];
               }
               _loc1_.scaleY += this.rs[_loc2_];
               if(_loc1_.scaleY < 0)
               {
                  _loc1_.scaleY = 0;
               }
               if(_loc1_.scaleY > 1)
               {
                  _loc1_.scaleY = 1;
               }
               _loc2_++;
            }
            this.orbStar.rotation += 3;
         }
      }
      
      private function getRing(param1:int, param2:int) : Shape
      {
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.lineStyle(3,16777215);
         _loc3_.graphics.drawEllipse(-param1 / 2,-param2 / 2,param1,param2);
         return _loc3_;
      }
   }
}
