package com.wbwar.creeper.screens
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.util.Text;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.media.Sound;
   import flash.text.TextField;
   
   public class SplashScreen extends Sprite
   {
       
      
      private var initScreen:Sprite;
      
      private var screen:Sprite;
      
      private var knuckles:Sprite;
      
      private var leftKnuckle:LogoLeftKnuckle;
      
      private var rightKnuckle:LogoRightKnuckle;
      
      private var presents:TextField;
      
      private var title:TextField;
      
      private var soundWave:Shape;
      
      public function SplashScreen()
      {
         var _loc1_:* = null;
         super();
         this.initScreen = new Sprite();
         addChild(this.initScreen);
         this.screen = new Sprite();
         addChild(this.screen);
         this.initScreen.graphics.beginFill(0);
         this.initScreen.graphics.drawRect(0,0,700,525);
         this.initScreen.graphics.endFill();
         _loc1_ = Text.text("Calibrating Fractal Energy Collectors........",18,0);
         _loc1_.filters = [new GlowFilter(4259648,1,16,16,6,BitmapFilterQuality.MEDIUM)];
         this.initScreen.addChild(_loc1_);
         _loc1_.x = 350 - int(_loc1_.width / 2);
         _loc1_.y = 200;
         this.screen.graphics.beginFill(0);
         this.screen.graphics.drawRect(0,0,700,525);
         this.screen.graphics.endFill();
         this.knuckles = new Sprite();
         this.screen.addChild(this.knuckles);
         this.leftKnuckle = new LogoLeftKnuckle();
         this.knuckles.addChild(this.leftKnuckle);
         this.rightKnuckle = new LogoRightKnuckle();
         this.knuckles.addChild(this.rightKnuckle);
         this.knuckles.alpha = 0;
         this.knuckles.visible = false;
         this.leftKnuckle.x = 258;
         this.leftKnuckle.y = 200;
         this.rightKnuckle.x = 442;
         this.rightKnuckle.y = 200;
         this.presents = Text.text("presents",18,12632256);
         this.screen.addChild(this.presents);
         this.presents.x = 350 - int(this.presents.width / 2);
         this.presents.y = 250;
         this.presents.alpha = 0;
         this.presents.visible = false;
         this.title = Text.text("",20,12632256);
         this.screen.addChild(this.title);
         this.title.x = 350 - int(this.title.width / 2);
         this.title.y = 275;
         this.title.alpha = 0;
         this.title.visible = false;
         this.soundWave = new Shape();
         this.soundWave.graphics.lineStyle(2,16777215);
         this.soundWave.graphics.moveTo(-4,-4);
         this.soundWave.graphics.curveTo(0,-8,4,-4);
         this.soundWave.graphics.moveTo(-6,-10);
         this.soundWave.graphics.curveTo(0,-14,6,-10);
         this.soundWave.graphics.moveTo(-8,-16);
         this.soundWave.graphics.curveTo(0,-20,8,-16);
         this.soundWave.graphics.moveTo(-4,4);
         this.soundWave.graphics.curveTo(0,8,4,4);
         this.soundWave.graphics.moveTo(-6,10);
         this.soundWave.graphics.curveTo(0,14,6,10);
         this.soundWave.graphics.moveTo(-8,16);
         this.soundWave.graphics.curveTo(0,20,8,16);
         this.soundWave.x = 350;
         this.soundWave.y = 200;
         this.screen.addChild(this.soundWave);
         this.soundWave.scaleX = 0;
         this.soundWave.scaleY = 0;
      }
      
      public function show() : void
      {
         Tweener.addTween(this.knuckles,{
            "time":0.75,
            "_autoAlpha":1,
            "onComplete":this.fadeInComplete
         });
         addEventListener(MouseEvent.CLICK,this.cancel);
         Creeper.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.cancel);
      }
      
      private function cancel(param1:Event = null) : void
      {
         Tweener.removeAllTweens();
         this.disappear();
      }
      
      private function fadeInComplete() : void
      {
         Tweener.addTween(this,{
            "delay":0.5,
            "onComplete":this.separateBones
         });
      }
      
      private function separateBones() : void
      {
         var _loc1_:Sound = new LogoCrackSound();
         _loc1_.play();
         var _loc2_:int = this.leftKnuckle.x - 5;
         var _loc3_:int = this.rightKnuckle.x + 5;
         Tweener.addTween(this.leftKnuckle,{
            "time":0.25,
            "x":_loc2_
         });
         Tweener.addTween(this.rightKnuckle,{
            "time":0.25,
            "x":_loc3_,
            "onComplete":this.showPresents
         });
         this.soundWave.visible = true;
         Tweener.addTween(this.soundWave,{
            "time":0.75,
            "_autoAlpha":0,
            "scaleX":2,
            "scaleY":2
         });
      }
      
      private function showPresents() : void
      {
         Tweener.addTween(this.presents,{
            "delay":1,
            "time":0.75,
            "_autoAlpha":1
         });
         Tweener.addTween(this.title,{
            "delay":1,
            "time":1.5,
            "_autoAlpha":1,
            "onComplete":this.titleComplete
         });
      }
      
      private function titleComplete() : void
      {
         Tweener.addTween(this,{
            "delay":1,
            "onComplete":this.disappear
         });
      }
      
      private function disappear() : void
      {
         Tweener.addTween(this.screen,{
            "time":1,
            "scaleX":0,
            "scaleY":0,
            "x":350,
            "y":262,
            "onComplete":this.startGame
         });
      }
      
      private function startGame() : void
      {
         Tweener.removeAllTweens();
         removeEventListener(MouseEvent.CLICK,this.cancel);
         Creeper.instance.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.cancel);
         this.screen.visible = false;
         Creeper.instance.startActualGame();
         this.hide();
      }
      
      public function hide() : void
      {
         parent.removeChild(this);
      }
   }
}
