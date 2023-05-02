package com.wbwar.creeper.controlpanel
{
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.util.Bar;
   import com.wbwar.creeper.util.Text;
   import flash.display.Sprite;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class StashViewer extends Sprite
   {
      
      public static const WIDTH:int = 110;
       
      
      private var stashTitleText:TextField;
      
      private var energyRateTitleText:TextField;
      
      private var energyDrainTitleText:TextField;
      
      private var queueTitleText:TextField;
      
      private var bar:Bar;
      
      private var energyRateBar:Bar;
      
      private var energyDrainBar:Bar;
      
      private var queueBar:Bar;
      
      private var stashValueText:TextField;
      
      private var energyRateValueText:TextField;
      
      private var energyDrainValueText:TextField;
      
      private var queueValueText:TextField;
      
      private var stashText:TextField;
      
      private var rateText:TextField;
      
      private var lastStash:Number = -1;
      
      private var lastEnergyConsumed:Number = -1;
      
      private var updateCount:int;
      
      private var barStart:int = 49;
      
      public function StashViewer()
      {
         super();
         this.bar = new Bar(WIDTH - this.barStart,15,1089552);
         this.bar.border = 0;
         addChild(this.bar);
         this.bar.x = this.barStart;
         this.bar.y = 0;
         this.bar.setValue(0,1);
         this.energyRateBar = new Bar(WIDTH - this.barStart,8,3206960);
         this.energyRateBar.border = 0;
         addChild(this.energyRateBar);
         this.energyRateBar.x = this.barStart;
         this.energyRateBar.y = 17;
         this.energyRateBar.setValue(0,1);
         this.energyDrainBar = new Bar(WIDTH - this.barStart,8,16777008);
         this.energyDrainBar.border = 0;
         addChild(this.energyDrainBar);
         this.energyDrainBar.x = this.barStart;
         this.energyDrainBar.y = 26;
         this.energyDrainBar.setValue(0,1);
         this.queueBar = new Bar(WIDTH - this.barStart,8,16724016);
         this.queueBar.border = 0;
         addChild(this.queueBar);
         this.queueBar.x = this.barStart;
         this.queueBar.y = 35;
         this.queueBar.setValue(0,1);
         this.stashValueText = Text.text("",9,16777215);
         this.stashValueText.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         addChild(this.stashValueText);
         this.energyRateValueText = Text.text("",8,16777215);
         this.energyRateValueText.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         addChild(this.energyRateValueText);
         this.energyDrainValueText = Text.text("",8,16777215);
         this.energyDrainValueText.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         addChild(this.energyDrainValueText);
         this.energyDrainValueText.text = "0";
         this.energyDrainValueText.x = this.barStart + int((WIDTH - this.barStart) / 2 - this.energyDrainValueText.width / 2);
         this.energyDrainValueText.y = 22;
         this.queueValueText = Text.text("",8,16777215);
         this.queueValueText.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         addChild(this.queueValueText);
         this.stashTitleText = Text.text("ENERGY",11,8450176,TextFieldAutoSize.RIGHT);
         this.energyRateTitleText = Text.text("COLLECTION",8,9498768,TextFieldAutoSize.RIGHT);
         this.energyDrainTitleText = Text.text("DEPLETION",8,16777152,TextFieldAutoSize.RIGHT);
         this.queueTitleText = Text.text("DEFICIT",8,16761024,TextFieldAutoSize.RIGHT);
         addChild(this.stashTitleText);
         addChild(this.energyRateTitleText);
         addChild(this.energyDrainTitleText);
         addChild(this.queueTitleText);
         this.stashTitleText.x = 0;
         this.stashTitleText.y = 0;
         this.energyRateTitleText.x = 2;
         this.energyRateTitleText.y = 13;
         this.energyDrainTitleText.x = 7;
         this.energyDrainTitleText.y = 22;
         this.queueTitleText.x = 19;
         this.queueTitleText.y = 31;
      }
      
      public function update() : void
      {
         var _loc1_:Number = NaN;
         ++this.updateCount;
         this.bar.setValue(int(GameSpace.instance.stash / 5),GameSpace.instance.stashMax / 5);
         this.energyRateBar.setValue(GameSpace.instance.dynamicContent.energyAccumulationRate / 5,10);
         if(GameSpace.instance.baseGun != null)
         {
            this.queueBar.setValue(GameSpace.instance.energyQueueLength,100);
         }
         else
         {
            this.queueBar.setValue(0,100);
         }
         this.queueValueText.text = " " + GameSpace.instance.energyQueueLength + " ";
         this.queueValueText.x = this.barStart + int((WIDTH - this.barStart) / 2 - this.queueValueText.width / 2);
         this.queueValueText.y = 31;
         if(this.updateCount % 2 == 0)
         {
            if(this.lastEnergyConsumed != -1)
            {
               _loc1_ = GameSpace.instance.energyConsumed - this.lastEnergyConsumed;
               this.energyDrainBar.setValue(_loc1_ / 2 / 5,10);
               this.energyDrainValueText.text = " " + int(_loc1_ / 2 / 5 * 10) / 10 + " ";
               this.energyDrainValueText.x = this.barStart + int((WIDTH - this.barStart) / 2 - this.energyDrainValueText.width / 2);
               this.energyDrainValueText.y = 22;
            }
            this.lastEnergyConsumed = GameSpace.instance.energyConsumed;
         }
         if(this.lastStash != -1 && GameSpace.instance.stash != this.lastStash)
         {
            _loc1_ = GameSpace.instance.stash - this.lastStash;
         }
         this.stashValueText.text = " " + int(GameSpace.instance.stash / 5) + "/" + int(GameSpace.instance.stashMax / 5) + " ";
         this.stashValueText.x = this.barStart + (WIDTH - this.barStart) / 2 - this.stashValueText.width / 2;
         this.energyRateValueText.text = " " + int(GameSpace.instance.dynamicContent.energyAccumulationRate / 5 * 10) / 10 + " ";
         this.energyRateValueText.x = this.barStart + int((WIDTH - this.barStart) / 2 - this.energyRateValueText.width / 2);
         this.energyRateValueText.y = 13;
         this.lastStash = GameSpace.instance.stash;
      }
   }
}
