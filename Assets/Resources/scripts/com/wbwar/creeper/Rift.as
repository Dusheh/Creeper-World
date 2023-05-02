package com.wbwar.creeper
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.util.ColorUtil;
   import com.wbwar.creeper.util.MessageDialog;
   import flash.display.GradientType;
   import flash.display.InterpolationMethod;
   import flash.display.Shape;
   import flash.display.SpreadMethod;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   
   public final class Rift extends Place
   {
      
      public static const ACTIVATING3_EVENT:String = "ACTIVATING3_EVENT";
      
      public static const STATE_OFF:int = 0;
      
      public static const STATE_ACTIVATING0:int = 1;
      
      public static const STATE_ACTIVATING1:int = 2;
      
      public static const STATE_ACTIVATING2:int = 3;
      
      public static const STATE_ACTIVATING3:int = 4;
      
      public static const STATE_ACTIVATED:int = 5;
       
      
      public var blackhole:Boolean;
      
      public var state:int;
      
      private var stateCounter:int;
      
      public var totems:Array;
      
      public var body:RiftBody;
      
      private var activatingShape0:Shape;
      
      private var activatingShape1:Shape;
      
      private var activatingShape2:Shape;
      
      private var activatingSound:Sound;
      
      public var activatingSoundChannel:SoundChannel;
      
      private var riftOpenSound:Sound;
      
      private var holeOpenSound:Sound;
      
      public var riftOpenSoundChannel:SoundChannel;
      
      private var _powered:Boolean;
      
      private var techWarningShown:Boolean;
      
      public function Rift(param1:int, param2:int)
      {
         var _loc3_:* = NaN;
         var _loc4_:* = null;
         this.totems = [];
         super(param1,param2);
         mouseEnabled = false;
         this.activatingShape0 = new Shape();
         this.activatingShape0.filters = [new GlowFilter(16776960,0.8,4,4,2,1)];
         addChild(this.activatingShape0);
         this.activatingShape1 = ColorUtil.star(5,17,16,16777215);
         _loc3_ = 17;
         (_loc4_ = new Matrix()).createGradientBox(_loc3_ * 2,_loc3_ * 2,0,-_loc3_,-_loc3_);
         this.activatingShape1.graphics.beginGradientFill(GradientType.RADIAL,[16777215,10526880],[1,0],[64,225],_loc4_,SpreadMethod.PAD,InterpolationMethod.RGB,0);
         this.activatingShape1.graphics.drawCircle(0,0,_loc3_);
         this.activatingShape1.graphics.endFill();
         this.activatingShape1.filters = [new GlowFilter(16776960,1,8,8,2,1)];
         addChild(this.activatingShape1);
         this.activatingShape1.visible = false;
         this.body = new RiftBody();
         this.body.visible = false;
         addChild(this.body);
         this.activatingShape2 = new Shape();
         addChild(this.activatingShape2);
         this.activatingShape2.visible = false;
         _loc3_ = 5;
         (_loc4_ = new Matrix()).createGradientBox(_loc3_ * 2,_loc3_ * 2,0,-_loc3_,-_loc3_);
         this.activatingShape2.graphics.beginGradientFill(GradientType.RADIAL,[16776992,10526880],[1,0],[64,225],_loc4_,SpreadMethod.PAD,InterpolationMethod.RGB,0);
         this.activatingShape2.graphics.drawCircle(0,0,_loc3_);
         this.activatingShape2.graphics.endFill();
         this.activatingShape2.graphics.lineStyle(2,5308240);
         this.activatingShape2.graphics.drawCircle(0,0,8);
         this.activatingSound = new TotemActivateSound();
         this.riftOpenSound = new RiftOpenSound();
         this.holeOpenSound = new HoleOpenSound();
      }
      
      public static function legalLocation(param1:int, param2:int, param3:Place = null) : Boolean
      {
         return true;
      }
      
      public function set powered(param1:Boolean) : void
      {
         this._powered = param1;
      }
      
      public function get powered() : Boolean
      {
         return this._powered;
      }
      
      override public function get maxHealth() : Number
      {
         return 0;
      }
      
      override public function get operateEnergy() : Number
      {
         return 0;
      }
      
      override public function destroy(param1:Boolean = false) : void
      {
         if(this.riftOpenSoundChannel != null)
         {
            this.riftOpenSoundChannel.stop();
         }
         visible = false;
      }
      
      public function DEBUGACTIVATE() : void
      {
         this.activate();
      }
      
      private function activate() : void
      {
         this.state = STATE_ACTIVATING0;
         this.activatingSoundChannel = this.activatingSound.play(0,99999999);
      }
      
      public function addTotem(param1:Totem) : void
      {
         this.totems.push(param1);
      }
      
      override public function update() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:Boolean = false;
         var _loc7_:* = null;
         super.update();
         if(this.state == STATE_ACTIVATING0)
         {
            for each(_loc1_ in this.totems)
            {
               _loc1_.setActivated(true);
            }
            this.state = STATE_ACTIVATING1;
         }
         else if(this.state == STATE_ACTIVATING1)
         {
            this.activatingShape0.graphics.lineStyle(3,65280);
            for each(_loc1_ in this.totems)
            {
               this.activatingShape0.graphics.moveTo(_loc1_.x - x,_loc1_.y - y);
               this.activatingShape0.graphics.lineTo(0,0);
            }
            this.activatingShape1.visible = true;
            this.state = STATE_ACTIVATING2;
         }
         else if(this.state == STATE_ACTIVATING2)
         {
            if(this.stateCounter == 90)
            {
               this.stateCounter = 0;
               for each(_loc1_ in this.totems)
               {
                  _loc1_.setActivated(false);
                  _loc1_.setDone();
               }
               if(this.activatingSoundChannel != null)
               {
                  Tweener.addTween(this.activatingSoundChannel,{
                     "_sound_volume":0,
                     "time":2,
                     "onComplete":this.activatingSoundChannel.stop()
                  });
               }
               _loc2_ = new RiftOpenPopSound();
               _loc2_.play();
               if(GameSpace.instance.suppressCityExit)
               {
                  this.riftOpenSoundChannel = this.holeOpenSound.play(0,99999999);
               }
               else
               {
                  this.riftOpenSoundChannel = this.riftOpenSound.play(0,99999999);
               }
               this.activatingShape0.graphics.clear();
               this.activatingShape0.visible = false;
               this.activatingShape1.visible = false;
               this.activatingShape2.visible = true;
               this.body.visible = true;
               dispatchEvent(new Event(ACTIVATING3_EVENT));
               this.state = STATE_ACTIVATING3;
            }
            else
            {
               this.activatingShape1.rotation += 7;
            }
            ++this.stateCounter;
         }
         else if(this.state == STATE_ACTIVATING3)
         {
            if(this.stateCounter > 15)
            {
               this.stateCounter = 0;
               this.body.scaleX = 1;
               this.body.scaleY = 1;
               this.activatingShape2.visible = false;
               this.state = STATE_ACTIVATED;
               if(GameSpace.instance.suppressCityExit)
               {
                  _loc3_ = GameSpace.instance.glopProducerLayer.numChildren - 1;
                  while(_loc3_ >= 0)
                  {
                     if((_loc4_ = GameSpace.instance.glopProducerLayer.getChildAt(_loc3_)) is GlopProducer)
                     {
                        (_loc4_ as GlopProducer).fallIntoHole();
                     }
                     else if(_loc4_ is GlopProducerNexus)
                     {
                        (_loc4_ as GlopProducerNexus).fallIntoHole();
                     }
                     _loc3_--;
                  }
                  _loc3_ = GameSpace.instance.places.placesLayer.numChildren - 1;
                  while(_loc3_ >= 0)
                  {
                     if(!((_loc5_ = GameSpace.instance.places.placesLayer.getChildAt(_loc3_) as Place) is BaseGun))
                     {
                        _loc5_.fallIntoHole();
                     }
                     _loc3_--;
                  }
               }
            }
            else
            {
               this.activatingShape2.scaleX += 0.5;
               this.activatingShape2.scaleY = this.activatingShape2.scaleX;
               this.activatingShape2.alpha = 1 - this.stateCounter / 15;
               this.body.scaleX = this.stateCounter / 15;
               this.body.scaleY = this.body.scaleX;
            }
            ++this.stateCounter;
            this.body.update();
         }
         else if(this.state == STATE_ACTIVATED)
         {
            this.body.update();
         }
         else if(updateCount % 36 == 0)
         {
            _loc6_ = false;
            for each(_loc1_ in this.totems)
            {
               if(_loc1_.energyLevel < _loc1_.operateEnergy)
               {
                  _loc6_ = true;
                  break;
               }
            }
            if(!_loc6_)
            {
               _loc3_ = GameSpace.instance.places.placesLayer.numChildren - 1;
               while(_loc3_ >= 0)
               {
                  if((_loc7_ = GameSpace.instance.places.placesLayer.getChildAt(_loc3_)) is Tech || _loc7_ is Ruin || _loc7_ is SurvivalPod)
                  {
                     _loc6_ = true;
                     this.showTechWarning();
                     break;
                  }
                  _loc3_--;
               }
            }
            if(!_loc6_)
            {
               this.activate();
            }
         }
      }
      
      private function showTechWarning() : void
      {
         var md:MessageDialog = null;
         if(!this.techWarningShown)
         {
            this.techWarningShown = true;
            md = new MessageDialog(MessageDialog.SIDE_TOP,-1,450,100,true);
            md.textField.text = "[OPS]\nCollect any nano schematics, ruins, and survival pods!\nThen we can energize the Rift.";
            md.show();
            md.addEventListener(MessageDialog.OK_CLICK,function():void
            {
               md.remove();
            },false,0,true);
         }
      }
      
      override protected function getXMLRoot() : XML
      {
         return <Rift/>;
      }
   }
}
