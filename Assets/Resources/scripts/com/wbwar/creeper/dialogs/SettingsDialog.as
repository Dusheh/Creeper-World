package com.wbwar.creeper.dialogs
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.games.GameData;
   import com.wbwar.creeper.util.Button;
   import com.wbwar.creeper.util.Checkbox;
   import com.wbwar.creeper.util.Slider;
   import com.wbwar.creeper.util.Text;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   
   public class SettingsDialog extends Sprite
   {
      
      public static const DISMISS_CLICKED:String = "DISMISS_CLICKED";
      
      public static const WIDTH:int = 350;
      
      public static const HEIGHT:int = 276;
       
      
      private var dismissButton:Button;
      
      private var particlesCheck:Checkbox;
      
      private var mistCheck:Checkbox;
      
      private var musicVolumeSlider:Slider;
      
      private var speedCheck:Checkbox;
      
      public function SettingsDialog()
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc8_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = null;
         super();
         graphics.beginFill(2105376);
         graphics.lineStyle(3,16777215);
         graphics.drawRect(0,0,WIDTH,HEIGHT);
         graphics.endFill();
         filters = [new GlowFilter(0,1,8,8)];
         var _loc1_:int = (WIDTH - 30) / 2;
         _loc3_ = Text.text("GAME SETTINGS",24,16777152);
         addChild(_loc3_);
         _loc3_.x = WIDTH / 2 - _loc3_.width / 2;
         _loc3_.y = 5;
         _loc4_ = 50;
         this.particlesCheck = new Checkbox(36864,65280);
         addChild(this.particlesCheck);
         this.particlesCheck.x = 15;
         this.particlesCheck.y = _loc4_ + 4;
         var _loc5_:TextField = Text.text("Enable Particle Effects",14,16777215);
         addChild(_loc5_);
         _loc5_.x = 25;
         _loc5_.y = _loc4_ - 5;
         this.particlesCheck.checked = GameData.particleEffects;
         this.particlesCheck.addEventListener(Checkbox.CHECK_CHANGE,this.onParticlesCheckChange);
         _loc4_ += 25;
         this.mistCheck = new Checkbox(36864,65280);
         addChild(this.mistCheck);
         this.mistCheck.x = 15;
         this.mistCheck.y = _loc4_ + 4;
         var _loc6_:TextField = Text.text("Enable Mist Effects",14,16777215);
         addChild(_loc6_);
         _loc6_.x = 25;
         _loc6_.y = _loc4_ - 5;
         var _loc7_:TextField = Text.text("(GAME RESTART REQUIRED)",8,16777215);
         addChild(_loc7_);
         _loc7_.x = 170;
         _loc7_.y = _loc4_;
         this.mistCheck.checked = GameData.mistEffects;
         this.mistCheck.addEventListener(Checkbox.CHECK_CHANGE,this.onMistCheckChange);
         _loc4_ += 25;
         _loc8_ = Text.text("Music Volume",14,16777215);
         addChild(_loc8_);
         _loc8_.x = WIDTH / 2 - _loc8_.width / 2;
         _loc8_.y = _loc4_ - 5;
         this.musicVolumeSlider = new Slider(65280,36864,100,100);
         addChild(this.musicVolumeSlider);
         this.musicVolumeSlider.x = WIDTH / 2 - 50;
         this.musicVolumeSlider.y = _loc4_ + 20;
         this.musicVolumeSlider.value = Creeper.instance.gameScreen.gameMusicVolume * 100;
         this.musicVolumeSlider.addEventListener(Slider.SLIDER_CHANGING,this.onMusicVolumeSliderChange);
         this.musicVolumeSlider.addEventListener(Slider.SLIDER_CHANGED,this.onMusicVolumeSliderChanged);
         _loc4_ += 50;
         if(false)
         {
            _loc11_ = Text.text("Quick Set Window Size",14,16777215);
            addChild(_loc11_);
            _loc11_.x = WIDTH / 2 - _loc11_.width / 2;
            _loc11_.y = _loc4_ - 20;
            _loc12_ = new Button("800x600",12,100,18,0,0,true,32768,-1);
            addChild(_loc12_);
            _loc12_.x = WIDTH / 2 - _loc12_.width - 5;
            _loc12_.y = _loc4_ + 5;
            _loc12_.addEventListener(MouseEvent.CLICK,this.onOptimalWindowSizeButton0Click);
            _loc13_ = new Button("1024x768",12,100,18,0,0,true,32768,-1);
            addChild(_loc13_);
            _loc13_.x = WIDTH / 2 + 5;
            _loc13_.y = _loc4_ + 5;
            _loc13_.addEventListener(MouseEvent.CLICK,this.onOptimalWindowSizeButton1Click);
            _loc14_ = new Button("1440x1080",12,100,18,0,0,true,32768,-1);
            addChild(_loc14_);
            _loc14_.x = WIDTH / 2 - _loc12_.width - 5;
            _loc14_.y = _loc4_ + 25;
            _loc14_.addEventListener(MouseEvent.CLICK,this.onOptimalWindowSizeButton2Click);
            _loc15_ = new Button("1600x1200",12,100,18,0,0,true,32768,-1);
            addChild(_loc15_);
            _loc15_.x = WIDTH / 2 + 5;
            _loc15_.y = _loc4_ + 25;
            _loc15_.addEventListener(MouseEvent.CLICK,this.onOptimalWindowSizeButton3Click);
         }
         _loc4_ += 50;
         this.speedCheck = new Checkbox(36864,65280);
         addChild(this.speedCheck);
         this.speedCheck.x = 15;
         this.speedCheck.y = _loc4_ + 4;
         var _loc9_:TextField = Text.text("Enable Double Speed",14,16777215);
         addChild(_loc9_);
         _loc10_ = Text.text("(Up and Down Arrow will toggle this during game)",8,16777215);
         addChild(_loc10_);
         _loc9_.x = 25;
         _loc9_.y = _loc4_ - 5;
         _loc10_.x = int(_loc9_.x);
         _loc10_.y = int(_loc9_.y + 15);
         this.speedCheck.checked = GameSpace.instance.speedUp;
         this.speedCheck.addEventListener(Checkbox.CHECK_CHANGE,this.onSpeedCheckChange);
         this.dismissButton = new Button("Close",18,100,25,0,0,true,32768,-1);
         addChild(this.dismissButton);
         this.dismissButton.x = WIDTH / 2 - this.dismissButton.width / 2;
         this.dismissButton.y = HEIGHT - 5 - this.dismissButton.height;
         this.dismissButton.addEventListener(MouseEvent.CLICK,this.onDismissClick);
         visible = false;
      }
      
      public function show() : void
      {
         visible = true;
         this.speedCheck.checked = GameSpace.instance.speedUp;
      }
      
      private function onOptimalWindowSizeButton0Click(param1:Event) : void
      {
         if(false)
         {
            Creeper.optimalWindowSizeFunction(0);
         }
      }
      
      private function onOptimalWindowSizeButton1Click(param1:Event) : void
      {
         if(false)
         {
            Creeper.optimalWindowSizeFunction(1);
         }
      }
      
      private function onOptimalWindowSizeButton2Click(param1:Event) : void
      {
         if(false)
         {
            Creeper.optimalWindowSizeFunction(2);
         }
      }
      
      private function onOptimalWindowSizeButton3Click(param1:Event) : void
      {
         if(false)
         {
            Creeper.optimalWindowSizeFunction(3);
         }
      }
      
      private function onParticlesCheckChange(param1:Event) : void
      {
         GameData.particleEffects = this.particlesCheck.checked;
         GameData.save();
      }
      
      private function onSpeedCheckChange(param1:Event) : void
      {
         GameSpace.instance.speedUp = this.speedCheck.checked;
      }
      
      private function onMistCheckChange(param1:Event) : void
      {
         GameData.mistEffects = this.mistCheck.checked;
         GameData.save();
      }
      
      private function onMusicVolumeSliderChange(param1:Event) : void
      {
         Creeper.instance.gameScreen.gameMusicVolume = this.musicVolumeSlider.value / 100;
      }
      
      private function onMusicVolumeSliderChanged(param1:Event) : void
      {
         Creeper.instance.gameScreen.gameMusicVolume = this.musicVolumeSlider.value / 100;
         GameData.musicVolume = Creeper.instance.gameScreen.gameMusicVolume;
         GameData.save();
      }
      
      private function onDismissClick(param1:MouseEvent = null) : void
      {
         dispatchEvent(new Event(DISMISS_CLICKED));
         visible = false;
      }
   }
}
