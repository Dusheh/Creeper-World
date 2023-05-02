package com.wbwar.creeper
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.util.MessageDialog;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.media.Sound;
   
   public class GlopProducerNexus extends Shape
   {
      
      public static const HOLE_COMPLETE:String = "Hole_Complete";
       
      
      private var md:MessageDialog;
      
      public function GlopProducerNexus()
      {
         super();
         graphics.lineStyle(2,0);
         graphics.moveTo(0,-6);
         graphics.lineTo(0,6);
         graphics.moveTo(-6,0);
         graphics.lineTo(6,0);
         graphics.moveTo(-4,-4);
         graphics.lineTo(4,4);
         graphics.moveTo(4,-4);
         graphics.lineTo(-4,4);
         graphics.lineStyle();
         graphics.moveTo(0,0);
         graphics.beginFill(2105504);
         graphics.drawCircle(0,0,4);
         graphics.endFill();
         graphics.beginFill(7373055);
         graphics.drawCircle(0,0,2);
         graphics.endFill();
         scaleX = 3;
         scaleY = scaleX;
      }
      
      public function fallIntoHole() : void
      {
         Tweener.addTween(this,{
            "time":10,
            "delay":5,
            "transition":"easeInExpo",
            "x":GameSpace.instance.rift.x,
            "y":GameSpace.instance.rift.y,
            "onStart":this.message,
            "onComplete":this.holeComplete
         });
      }
      
      private function message() : void
      {
         this.md = new MessageDialog(MessageDialog.SIDE_TOP,-1,300,-1,false);
         this.md.textField.text = "[CREEPER NEXUS]\nNOOOOOOOOOOOOOOO!!!!!!!!";
         this.md.show();
      }
      
      private function holeComplete() : void
      {
         new Explosion(GameSpace.instance.rift.x,GameSpace.instance.rift.y,96,255,3,30);
         new Explosion(GameSpace.instance.rift.x,GameSpace.instance.rift.y,96,255,2,30);
         new Explosion(GameSpace.instance.rift.x,GameSpace.instance.rift.y,96,255,1,30);
         var _loc1_:Sound = new NexusDestroyedSound();
         _loc1_.play();
         this.md.hide(true);
         visible = false;
         dispatchEvent(new Event(HOLE_COMPLETE));
      }
   }
}
