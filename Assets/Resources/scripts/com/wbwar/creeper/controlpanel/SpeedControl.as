package com.wbwar.creeper.controlpanel
{
   import com.wbwar.creeper.GameSpace;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   
   public class SpeedControl extends Sprite
   {
      
      public static const WIDTH:int = 13;
      
      public static const HEIGHT:int = 43;
       
      
      private var pausedShape:Shape;
      
      private var playShape:Shape;
      
      private var soundShape:Shape;
      
      private var noSoundShape:Shape;
      
      private var musicShape:Shape;
      
      private var noMusicShape:Shape;
      
      private var paused:Boolean;
      
      private var mute:Boolean;
      
      private var noMusic:Boolean;
      
      private var updateCount:int;
      
      public function SpeedControl()
      {
         super();
         useHandCursor = true;
         buttonMode = true;
         graphics.beginFill(5275776);
         graphics.drawRect(0,0,WIDTH,HEIGHT);
         this.playShape = new Shape();
         this.playShape.filters = [new DropShadowFilter(2)];
         addChild(this.playShape);
         this.playShape.graphics.beginFill(2162464);
         this.playShape.graphics.moveTo(0,0);
         this.playShape.graphics.lineTo(5,5);
         this.playShape.graphics.lineTo(0,10);
         this.playShape.graphics.lineTo(0,0);
         this.playShape.graphics.endFill();
         this.playShape.x = 4;
         this.playShape.y = 3;
         this.pausedShape = new Shape();
         this.pausedShape.filters = [new DropShadowFilter(2)];
         addChild(this.pausedShape);
         this.pausedShape.graphics.beginFill(16777215);
         this.pausedShape.graphics.drawRect(0,0,2,10);
         this.pausedShape.graphics.endFill();
         this.pausedShape.graphics.beginFill(16777215);
         this.pausedShape.graphics.drawRect(3,0,2,10);
         this.pausedShape.graphics.endFill();
         this.pausedShape.x = this.playShape.x;
         this.pausedShape.y = this.playShape.y;
         this.pausedShape.visible = false;
         this.soundShape = new Shape();
         this.soundShape.filters = [new DropShadowFilter(2)];
         addChild(this.soundShape);
         this.soundShape.graphics.beginFill(16776960);
         this.soundShape.graphics.moveTo(0,3);
         this.soundShape.graphics.lineTo(0,7);
         this.soundShape.graphics.lineTo(3,7);
         this.soundShape.graphics.lineTo(6,10);
         this.soundShape.graphics.lineTo(6,0);
         this.soundShape.graphics.lineTo(3,3);
         this.soundShape.graphics.lineTo(0,3);
         this.soundShape.graphics.endFill();
         this.soundShape.x = 3;
         this.soundShape.y = 16;
         this.noSoundShape = new Shape();
         addChild(this.noSoundShape);
         this.noSoundShape.graphics.lineStyle(2,16711680);
         this.noSoundShape.graphics.moveTo(0,0);
         this.noSoundShape.graphics.lineTo(6,10);
         this.noSoundShape.graphics.moveTo(6,0);
         this.noSoundShape.graphics.lineTo(0,10);
         this.noSoundShape.visible = false;
         this.noSoundShape.x = this.soundShape.x;
         this.noSoundShape.y = this.soundShape.y;
         this.musicShape = new Shape();
         this.musicShape.filters = [new DropShadowFilter(2)];
         addChild(this.musicShape);
         this.musicShape.graphics.beginFill(16776960);
         this.musicShape.graphics.moveTo(3,0);
         this.musicShape.graphics.lineTo(3,8);
         this.musicShape.graphics.lineTo(4,8);
         this.musicShape.graphics.lineTo(4,4);
         this.musicShape.graphics.lineTo(7,2);
         this.musicShape.graphics.lineTo(3,0);
         this.musicShape.graphics.endFill();
         this.musicShape.graphics.beginFill(16776960);
         this.musicShape.graphics.drawCircle(2,8,2);
         this.musicShape.graphics.endFill();
         this.musicShape.x = 3;
         this.musicShape.y = 30;
         this.noMusicShape = new Shape();
         addChild(this.noMusicShape);
         this.noMusicShape.graphics.lineStyle(2,16711680);
         this.noMusicShape.graphics.moveTo(0,0);
         this.noMusicShape.graphics.lineTo(6,10);
         this.noMusicShape.graphics.moveTo(6,0);
         this.noMusicShape.graphics.lineTo(0,10);
         this.noMusicShape.visible = false;
         this.noMusicShape.x = this.musicShape.x;
         this.noMusicShape.y = this.musicShape.y;
         addEventListener(MouseEvent.CLICK,this.onMouseClick,false,0,true);
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame,false,0,true);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         ++this.updateCount;
         if(this.updateCount % 4 == 0)
         {
            this.playShape.visible = !GameSpace.instance.paused;
            this.pausedShape.visible = !this.playShape.visible;
            this.noSoundShape.visible = GameSpace.instance.mute;
            this.noMusicShape.visible = !Creeper.instance.gameScreen.gameMusicPlaying;
         }
      }
      
      private function onMouseClick(param1:Event) : void
      {
         if(mouseY < HEIGHT / 3)
         {
            GameSpace.instance.paused = !GameSpace.instance.paused;
         }
         else if(mouseY < 2 * HEIGHT / 3)
         {
            GameSpace.instance.mute = !GameSpace.instance.mute;
         }
         else
         {
            Creeper.instance.gameScreen.toggleGameMusic();
         }
      }
   }
}
