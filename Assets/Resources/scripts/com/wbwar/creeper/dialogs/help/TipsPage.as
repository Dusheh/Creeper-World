package com.wbwar.creeper.dialogs.help
{
   import com.wbwar.creeper.util.FlowContainer;
   import com.wbwar.creeper.util.Text;
   import flash.display.Sprite;
   
   public class TipsPage extends Sprite
   {
       
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      private var flowContainer:FlowContainer;
      
      public function TipsPage(param1:int, param2:int)
      {
         super();
         this.WIDTH = param1;
         this.HEIGHT = param2;
         this.flowContainer = new FlowContainer(this.WIDTH,this.HEIGHT);
         this.flowContainer.addContent(Text.text("1: Attack deep Creeper with Mortars.",22,9502608));
         this.flowContainer.addContent(Text.text("- Go after depressions where Creeper pools up.",14,12632256));
         this.flowContainer.addContent(Text.text("- Mortars are most effective on deep Creeper.",14,12632256));
         this.flowContainer.addContent(Text.text("- Bombarding a pool will relieve the pressure on higher surrounding areas.",14,12632256),75);
         this.flowContainer.addContent(Text.text("2: Attack thin Creeper with Blasters.",22,9502608));
         this.flowContainer.addContent(Text.text("- Blasters are most efficient on thin Creeper.",14,12632256),75);
         this.flowContainer.addContent(Text.text("3: Use Drones to bomb distant Creeper pools.",22,9502608));
         this.flowContainer.addContent(Text.text("- Bombing distant pools can relieve pressure on your front.",14,12632256),75);
         this.flowContainer.addContent(Text.text("4: Don\'t engage the Creeper too early.",22,9502608));
         this.flowContainer.addContent(Text.text("- The longer you wait, the more energy you have to build your base.",14,12632256),75);
         this.flowContainer.addContent(Text.text("5: Use Deactivate on weapons to save energy.",22,9502608));
         this.flowContainer.addContent(Text.text("- Deactivating a weapon stops all energy drain from that weapon.",14,12632256));
         this.flowContainer.addContent(Text.text("- While deactivated, the weapon won\'t fire or charge up.",14,12632256),75);
         this.flowContainer.addContent(Text.text("6: Use Disarm on weapons to build up a force.",22,9502608));
         this.flowContainer.addContent(Text.text("- Disarming a weapon only prevents the weapon from firing.",14,12632256));
         this.flowContainer.addContent(Text.text("- Disarm weapons to prevent firing when you are building up a force.",14,12632256),75);
         this.flowContainer.addContent(Text.text("7: Cap off emitters.",22,9502608));
         this.flowContainer.addContent(Text.text("- Fight to get a blaster in range of an emitter.",14,12632256));
         this.flowContainer.addContent(Text.text("- Once capped, all but one blaster can be redeployed.",14,12632256),75);
         this.flowContainer.addContent(Text.text("8: Be brave and put weapons in danger.",22,9502608));
         this.flowContainer.addContent(Text.text("- Blasters and Mortars can take some limited exposure to Creeper.",14,12632256));
         this.flowContainer.addContent(Text.text("- Send Mortars on \'bombing runs\' into deep Creeper territory.",14,12632256),75);
         this.flowContainer.addContent(Text.text("9: Pause the game.",22,9502608));
         this.flowContainer.addContent(Text.text("- You can queue things to build and move while the game is paused.",14,12632256),75);
         this.flowContainer.addContent(Text.text("10: Use keyboard shortcuts",22,9502608));
         this.flowContainer.addContent(Text.text("- Hover over a button, the shortcut key will appear in the corner.",14,12632256),75);
         addChild(this.flowContainer);
      }
   }
}
