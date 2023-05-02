package com.wbwar.creeper.dialogs.help
{
   import com.wbwar.creeper.util.FlowContainer;
   import com.wbwar.creeper.util.Text;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class AdvPage extends Sprite
   {
      
      public static var adv1Image:Class = AdvPage_adv1Image;
      
      private static var adv1Bitmap:Bitmap = new adv1Image() as Bitmap;
      
      public static var adv2Image:Class = AdvPage_adv2Image;
      
      private static var adv2Bitmap:Bitmap = new adv2Image() as Bitmap;
      
      public static var adv3Image:Class = AdvPage_adv3Image;
      
      private static var adv3Bitmap:Bitmap = new adv3Image() as Bitmap;
      
      public static var adv4Image:Class = AdvPage_adv4Image;
      
      private static var adv4Bitmap:Bitmap = new adv4Image() as Bitmap;
       
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      private var flowContainer:FlowContainer;
      
      public function AdvPage(param1:int, param2:int)
      {
         super();
         this.WIDTH = param1;
         this.HEIGHT = param2;
         this.flowContainer = new FlowContainer(this.WIDTH,this.HEIGHT);
         this.flowContainer.addContent(Text.text("1: Manage energy use (don\'t overbuild).",22,9502608));
         this.flowContainer.addContent(adv1Bitmap,170);
         this.flowContainer.addContent(Text.text("2: Use Relays to reach tough areas.",22,9502608));
         this.flowContainer.addContent(adv2Bitmap,170);
         this.flowContainer.addContent(Text.text("3: Build storage and speed for large networks.",22,9502608));
         this.flowContainer.addContent(adv3Bitmap,170);
         this.flowContainer.addContent(Text.text("4: Build reactors for energy when confined.",22,9502608));
         this.flowContainer.addContent(adv4Bitmap,170);
         addChild(this.flowContainer);
      }
   }
}
