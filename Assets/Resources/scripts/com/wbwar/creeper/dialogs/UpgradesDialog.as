package com.wbwar.creeper.dialogs
{
   import com.wbwar.creeper.ABM;
   import com.wbwar.creeper.AreaGun;
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.Gun;
   import com.wbwar.creeper.UpgradeBox;
   import com.wbwar.creeper.util.Button;
   import com.wbwar.creeper.util.ConfirmDialog;
   import com.wbwar.creeper.util.Text;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.media.Sound;
   import flash.text.TextField;
   
   public class UpgradesDialog extends Sprite
   {
      
      public static const WIDTH:int = 500;
      
      public static const HEIGHT:int = 270;
      
      public static const UPGRADE_ECONOMIC0:int = 1;
      
      public static const UPGRADE_ECONOMIC1:int = 2;
      
      public static const UPGRADE_ECONOMIC2:int = 3;
      
      public static const UPGRADE_WEAPON0:int = 11;
      
      public static const UPGRADE_WEAPON1:int = 12;
      
      public static const UPGRADE_WEAPON2:int = 13;
       
      
      private var energyBoostSelector:UpgradeSelector;
      
      private var cheaperSelector:UpgradeSelector;
      
      private var buildFasterSelector:UpgradeSelector;
      
      private var fireRangeSelector:UpgradeSelector;
      
      private var fireRateSelector:UpgradeSelector;
      
      private var moveFasterSelector:UpgradeSelector;
      
      private var dismissButton:Button;
      
      private var confirmDialog:ConfirmDialog;
      
      private var upgradeToPurchase:int;
      
      private var noPointsShield:Sprite;
      
      public function UpgradesDialog()
      {
         var swidth:int = 0;
         var sheight:int = 0;
         var noPointsText:TextField = null;
         super();
         this.visible = false;
         graphics.beginFill(2105376);
         graphics.lineStyle(3,16777215);
         graphics.drawRect(0,0,WIDTH,HEIGHT);
         graphics.endFill();
         filters = [new GlowFilter(0,1,8,8)];
         swidth = (WIDTH - 30) / 2;
         sheight = 50;
         var titleText:TextField = Text.text("UPGRADES",24,16777152);
         addChild(titleText);
         titleText.x = WIDTH / 2 - titleText.width / 2;
         titleText.y = 5;
         this.energyBoostSelector = new UpgradeSelector("Produce 10% more energy",2146336,swidth,sheight);
         addChild(this.energyBoostSelector);
         this.energyBoostSelector.x = 10;
         this.energyBoostSelector.y = 40;
         this.energyBoostSelector.selected = GameSpace.instance.upgradeEconomic0;
         this.energyBoostSelector.addEventListener(MouseEvent.CLICK,function():void
         {
            purchaseUpgrade(UPGRADE_ECONOMIC0);
         });
         this.cheaperSelector = new UpgradeSelector("Everything costs 10% less to build",2146336,swidth,sheight);
         addChild(this.cheaperSelector);
         this.cheaperSelector.x = 10;
         this.cheaperSelector.y = this.energyBoostSelector.y + sheight + 10;
         this.cheaperSelector.selected = GameSpace.instance.upgradeEconomic1;
         this.cheaperSelector.addEventListener(MouseEvent.CLICK,function():void
         {
            purchaseUpgrade(UPGRADE_ECONOMIC1);
         });
         this.buildFasterSelector = new UpgradeSelector("Build things 20% faster",2146336,swidth,sheight);
         addChild(this.buildFasterSelector);
         this.buildFasterSelector.x = 10;
         this.buildFasterSelector.y = this.cheaperSelector.y + sheight + 10;
         this.buildFasterSelector.selected = GameSpace.instance.upgradeEconomic2;
         this.buildFasterSelector.addEventListener(MouseEvent.CLICK,function():void
         {
            purchaseUpgrade(UPGRADE_ECONOMIC2);
         });
         this.fireRangeSelector = new UpgradeSelector("Increase fire range by 20%",12591136,swidth,sheight);
         addChild(this.fireRangeSelector);
         this.fireRangeSelector.x = WIDTH / 2 + 5;
         this.fireRangeSelector.y = 40;
         this.fireRangeSelector.selected = GameSpace.instance.upgradeWeapon0;
         this.fireRangeSelector.addEventListener(MouseEvent.CLICK,function():void
         {
            purchaseUpgrade(UPGRADE_WEAPON0);
         });
         this.fireRateSelector = new UpgradeSelector("Increase fire rate by 15%",12591136,swidth,sheight);
         addChild(this.fireRateSelector);
         this.fireRateSelector.x = WIDTH / 2 + 5;
         this.fireRateSelector.y = this.fireRangeSelector.y + sheight + 10;
         this.fireRateSelector.selected = GameSpace.instance.upgradeWeapon1;
         this.fireRateSelector.addEventListener(MouseEvent.CLICK,function():void
         {
            purchaseUpgrade(UPGRADE_WEAPON1);
         });
         this.moveFasterSelector = new UpgradeSelector("Increase move speed by 30%",12591136,swidth,sheight);
         addChild(this.moveFasterSelector);
         this.moveFasterSelector.x = WIDTH / 2 + 5;
         this.moveFasterSelector.y = this.fireRateSelector.y + sheight + 10;
         this.moveFasterSelector.selected = GameSpace.instance.upgradeWeapon2;
         this.moveFasterSelector.addEventListener(MouseEvent.CLICK,function():void
         {
            purchaseUpgrade(UPGRADE_WEAPON2);
         });
         this.noPointsShield = new Sprite();
         this.noPointsShield.visible = false;
         addChild(this.noPointsShield);
         this.noPointsShield.graphics.beginFill(16777215,0.1);
         this.noPointsShield.graphics.drawRect(0,0,WIDTH,HEIGHT);
         this.noPointsShield.graphics.endFill();
         noPointsText = Text.text("NO UPGRADE POINTS AVAILABLE TO SPEND",18,16777215);
         this.noPointsShield.addChild(noPointsText);
         noPointsText.x = WIDTH / 2 - noPointsText.width / 2;
         noPointsText.y = HEIGHT - 35 - noPointsText.height;
         this.dismissButton = new Button("Close",18,100,25,0,0,true,32768,-1);
         addChild(this.dismissButton);
         this.dismissButton.x = WIDTH / 2 - this.dismissButton.width / 2;
         this.dismissButton.y = HEIGHT - 5 - this.dismissButton.height;
         this.dismissButton.addEventListener(MouseEvent.CLICK,this.onDismissClick);
         this.confirmDialog = new ConfirmDialog(200,100,WIDTH,HEIGHT);
         this.confirmDialog.message = "Purchase Upgrade?";
         this.confirmDialog.yesCallback = this.onYesClick;
         this.confirmDialog.noCallback = this.onNoClick;
         addChild(this.confirmDialog);
         this.confirmDialog.visible = false;
         GameSpace.instance.addEventListener(UpgradeBox.UPGRADE_APPLIED,this.refresh,false,0,true);
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         if(param1)
         {
            this.refresh();
         }
      }
      
      private function refresh(param1:Event = null) : void
      {
         this.energyBoostSelector.selected = GameSpace.instance.upgradeEconomic0;
         this.cheaperSelector.selected = GameSpace.instance.upgradeEconomic1;
         this.buildFasterSelector.selected = GameSpace.instance.upgradeEconomic2;
         this.fireRangeSelector.selected = GameSpace.instance.upgradeWeapon0;
         this.fireRateSelector.selected = GameSpace.instance.upgradeWeapon1;
         this.moveFasterSelector.selected = GameSpace.instance.upgradeWeapon2;
         if(GameSpace.instance.points == 0)
         {
            this.noPointsShield.visible = true;
         }
         else
         {
            this.noPointsShield.visible = false;
         }
      }
      
      private function purchaseUpgrade(param1:int) : void
      {
         if(param1 == UPGRADE_ECONOMIC0 && GameSpace.instance.upgradeEconomic0)
         {
            return;
         }
         if(param1 == UPGRADE_ECONOMIC1 && GameSpace.instance.upgradeEconomic1)
         {
            return;
         }
         if(param1 == UPGRADE_ECONOMIC2 && GameSpace.instance.upgradeEconomic2)
         {
            return;
         }
         if(param1 == UPGRADE_WEAPON0 && GameSpace.instance.upgradeWeapon0)
         {
            return;
         }
         if(param1 == UPGRADE_WEAPON1 && GameSpace.instance.upgradeWeapon1)
         {
            return;
         }
         if(param1 == UPGRADE_WEAPON2 && GameSpace.instance.upgradeWeapon2)
         {
            return;
         }
         if(GameSpace.instance.points == 0)
         {
            return;
         }
         var _loc2_:Sound = new ClickSound();
         _loc2_.play();
         this.confirmDialog.visible = true;
         this.upgradeToPurchase = param1;
      }
      
      private function onYesClick() : void
      {
         if(this.upgradeToPurchase == UPGRADE_ECONOMIC0)
         {
            GameSpace.instance.upgradeEconomic0 = true;
            --GameSpace.instance.points;
         }
         else if(this.upgradeToPurchase == UPGRADE_ECONOMIC1)
         {
            GameSpace.instance.upgradeEconomic1 = true;
            --GameSpace.instance.points;
         }
         else if(this.upgradeToPurchase == UPGRADE_ECONOMIC2)
         {
            GameSpace.instance.upgradeEconomic2 = true;
            --GameSpace.instance.points;
         }
         else if(this.upgradeToPurchase == UPGRADE_WEAPON0)
         {
            GameSpace.instance.upgradeWeapon0 = true;
            --GameSpace.instance.points;
            Gun.setUpgradedRange();
            AreaGun.setUpgradedRange();
            ABM.setUpgradedRange();
         }
         else if(this.upgradeToPurchase == UPGRADE_WEAPON1)
         {
            GameSpace.instance.upgradeWeapon1 = true;
            --GameSpace.instance.points;
         }
         else if(this.upgradeToPurchase == UPGRADE_WEAPON2)
         {
            GameSpace.instance.upgradeWeapon2 = true;
            --GameSpace.instance.points;
         }
         this.refresh();
      }
      
      private function onNoClick() : void
      {
         this.refresh();
      }
      
      private function onDismissClick(param1:Event) : void
      {
         this.visible = false;
         GameSpace.instance.paused = false;
      }
   }
}
