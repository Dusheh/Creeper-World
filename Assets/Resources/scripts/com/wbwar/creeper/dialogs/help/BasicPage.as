package com.wbwar.creeper.dialogs.help
{
   import com.wbwar.creeper.util.FlowContainer;
   import com.wbwar.creeper.util.Text;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class BasicPage extends Sprite
   {
      
      public static var basic1Image:Class = BasicPage_basic1Image;
      
      private static var basic1Bitmap:Bitmap = new basic1Image() as Bitmap;
      
      public static var basic2Image:Class = BasicPage_basic2Image;
      
      private static var basic2Bitmap:Bitmap = new basic2Image() as Bitmap;
      
      public static var basic3Image:Class = BasicPage_basic3Image;
      
      private static var basic3Bitmap:Bitmap = new basic3Image() as Bitmap;
      
      public static var basic4Image:Class = BasicPage_basic4Image;
      
      private static var basic4Bitmap:Bitmap = new basic4Image() as Bitmap;
      
      public static var basic5Image:Class = BasicPage_basic5Image;
      
      private static var basic5Bitmap:Bitmap = new basic5Image() as Bitmap;
       
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      private var flowContainer:FlowContainer;
      
      public function BasicPage(param1:int, param2:int)
      {
         super();
         this.WIDTH = param1;
         this.HEIGHT = param2;
         this.flowContainer = new FlowContainer(this.WIDTH,this.HEIGHT);
         this.flowContainer.addContent(Text.text("1: Build collectors to get energy.",25,9502608));
         this.flowContainer.addContent(basic1Bitmap,170);
         this.flowContainer.addContent(Text.text("2: Build weapons to fight off the Creeper.",25,9502608));
         this.flowContainer.addContent(basic2Bitmap,170);
         this.flowContainer.addContent(Text.text("3: Collect any technology and artifacts.",25,9502608));
         this.flowContainer.addContent(basic3Bitmap,170);
         this.flowContainer.addContent(Text.text("4: Connect to all Totems.",25,9502608));
         this.flowContainer.addContent(basic4Bitmap,170);
         this.flowContainer.addContent(Text.text("5: Once Totems activate, Odin City escapes!",25,9502608));
         this.flowContainer.addContent(basic5Bitmap,170);
         addChild(this.flowContainer);
      }
   }
}
