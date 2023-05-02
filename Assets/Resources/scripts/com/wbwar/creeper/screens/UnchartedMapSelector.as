package com.wbwar.creeper.screens
{
   import com.wbwar.creeper.BaseGun;
   import com.wbwar.creeper.GameSpace;
   import com.wbwar.creeper.GlopProducer;
   import com.wbwar.creeper.Terrain;
   import com.wbwar.creeper.Totem;
   import com.wbwar.creeper.UpgradeBox;
   import com.wbwar.creeper.games.GameData;
   import com.wbwar.creeper.games.IndividualGameData;
   import com.wbwar.creeper.games.RandomGame;
   import com.wbwar.creeper.util.Button;
   import com.wbwar.creeper.util.Spinner;
   import com.wbwar.creeper.util.Text;
   import com.wbwar.creeper.util.Time;
   import fl.controls.DataGrid;
   import fl.controls.dataGridClasses.DataGridColumn;
   import fl.data.DataProvider;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   
   public class UnchartedMapSelector extends Sprite
   {
      
      public static const LAUNCHMAP:String = "com.wbwar.creeper.screens.UnchartedMapSelector.LAUNCHMAP";
      
      public static const RESUBMIT:String = "com.wbwar.creeper.screens.UnchartedMapSelector.RESUBMIT";
      
      private static var days:Array = [31,28,31,30,31,30,31,31,30,31,30,31];
       
      
      public var WIDTH:int = 650;
      
      public var HEIGHT:int = 400;
      
      private var todayButton:Button;
      
      private var randomButton:Button;
      
      private var monthSpinner:Spinner;
      
      private var daySpinner:Spinner;
      
      private var year1Spinner:Spinner;
      
      private var year2Spinner:Spinner;
      
      private var year3Spinner:Spinner;
      
      private var year4Spinner:Spinner;
      
      private var miniMap:Bitmap;
      
      private var scoreTitle:TextField;
      
      private var scoreTextField:TextField;
      
      private var timeTextField:TextField;
      
      private var playCountText:TextField;
      
      private var resubmitButton:Button;
      
      public var selectedMap:int;
      
      public var selectedDate:String;
      
      private var happyDayText:TextField;
      
      private var dg:DataGrid;
      
      private var dataProvider:DataProvider;
      
      private var dgText:TextField;
      
      private var viewScoresButton:Button;
      
      private var nextDayButton:Button;
      
      private var prevDayButton:Button;
      
      private var lastDay:int = -1;
      
      private var lastMonth:int = -1;
      
      private var lastYear1:int = -1;
      
      private var lastYear2:int = -1;
      
      private var lastYear3:int = -1;
      
      private var lastYear4:int = -1;
      
      public function UnchartedMapSelector()
      {
         var _loc1_:* = null;
         super();
         this.monthSpinner = new Spinner(100,16);
         this.monthSpinner.valueBased = true;
         this.monthSpinner.values = ["January","February","March","April","May","June","July","August","September","October","November","December"];
         this.monthSpinner.valueIndex = 0;
         addChild(this.monthSpinner);
         this.monthSpinner.x = 25;
         this.monthSpinner.y = 75;
         this.monthSpinner.addEventListener(Spinner.CHANGE,this.onDateChange);
         this.daySpinner = new Spinner(30,16);
         this.daySpinner.min = 1;
         this.daySpinner.max = 31;
         this.daySpinner.value = 1;
         addChild(this.daySpinner);
         this.daySpinner.x = this.monthSpinner.x + this.monthSpinner.width + 20;
         this.daySpinner.y = this.monthSpinner.y;
         this.daySpinner.addEventListener(Spinner.CHANGE,this.onDateChange);
         this.year1Spinner = new Spinner(20,16);
         this.year1Spinner.min = 0;
         this.year1Spinner.max = 9;
         this.year1Spinner.value = 0;
         addChild(this.year1Spinner);
         this.year1Spinner.x = this.daySpinner.x + this.daySpinner.width + 20;
         this.year1Spinner.y = this.daySpinner.y;
         this.year1Spinner.addEventListener(Spinner.CHANGE,this.onDateChange);
         this.year2Spinner = new Spinner(20,16);
         this.year2Spinner.min = 0;
         this.year2Spinner.max = 9;
         this.year2Spinner.value = 0;
         addChild(this.year2Spinner);
         this.year2Spinner.x = this.year1Spinner.x + this.year1Spinner.width + 5;
         this.year2Spinner.y = this.year1Spinner.y;
         this.year2Spinner.addEventListener(Spinner.CHANGE,this.onDateChange);
         this.year3Spinner = new Spinner(20,16);
         this.year3Spinner.min = 0;
         this.year3Spinner.max = 9;
         this.year3Spinner.value = 0;
         addChild(this.year3Spinner);
         this.year3Spinner.x = this.year2Spinner.x + this.year2Spinner.width + 5;
         this.year3Spinner.y = this.year2Spinner.y;
         this.year3Spinner.addEventListener(Spinner.CHANGE,this.onDateChange);
         this.year4Spinner = new Spinner(20,16);
         this.year4Spinner.min = 0;
         this.year4Spinner.max = 9;
         this.year4Spinner.value = 0;
         addChild(this.year4Spinner);
         this.year4Spinner.x = this.year3Spinner.x + this.year3Spinner.width + 5;
         this.year4Spinner.y = this.year3Spinner.y;
         this.year4Spinner.addEventListener(Spinner.CHANGE,this.onDateChange);
         this.setToday();
         _loc1_ = Text.text("Select a date in the past, present, or future and defeat the Creeper.",15,14739455);
         var _loc2_:TextField = Text.text("(Get the best score for \'today\', for your birthday, or for a famous date in history!)",12,12634111);
         addChild(_loc1_);
         addChild(_loc2_);
         _loc1_.x = int(this.WIDTH / 2 - _loc1_.width / 2);
         _loc1_.y = 10;
         _loc2_.x = int(this.WIDTH / 2 - _loc2_.width / 2);
         _loc2_.y = _loc1_.y + _loc1_.height;
         _loc1_.filters = [new DropShadowFilter()];
         _loc2_.filters = [new DropShadowFilter()];
         var _loc3_:TextField = Text.text("Month",16,16777215);
         addChild(_loc3_);
         _loc3_.x = this.monthSpinner.x + 50 - int(_loc3_.width / 2);
         _loc3_.y = this.monthSpinner.y - _loc3_.height - 2;
         _loc3_.filters = [new DropShadowFilter()];
         var _loc4_:TextField = Text.text("Day",16,16777215);
         addChild(_loc4_);
         _loc4_.x = this.daySpinner.x + 15 - int(_loc4_.width / 2);
         _loc4_.y = _loc3_.y;
         _loc4_.filters = [new DropShadowFilter()];
         var _loc5_:TextField = Text.text("Year",16,16777215);
         addChild(_loc5_);
         _loc5_.x = this.year1Spinner.x + 50;
         _loc5_.y = _loc3_.y;
         _loc5_.filters = [new DropShadowFilter()];
         this.miniMap = new Bitmap();
         addChild(this.miniMap);
         this.miniMap.x = 90;
         this.miniMap.y = this.monthSpinner.y + 80;
         this.scoreTitle = Text.text("Score: ",10,16777215);
         this.scoreTitle.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         addChild(this.scoreTitle);
         this.scoreTitle.x = this.miniMap.x;
         this.scoreTitle.y = this.miniMap.y;
         this.scoreTextField = Text.text("",10,16777215);
         this.scoreTextField.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         addChild(this.scoreTextField);
         this.scoreTextField.x = this.scoreTitle.x + this.scoreTitle.width - 2;
         this.scoreTextField.y = this.scoreTitle.y;
         this.timeTextField = Text.text("",8,16777215);
         this.timeTextField.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         addChild(this.timeTextField);
         this.timeTextField.x = this.scoreTitle.x + int(this.scoreTitle.width - 2);
         this.timeTextField.y = this.scoreTitle.y + 10;
         this.playCountText = Text.text("",8,16777215);
         this.playCountText.filters = [new GlowFilter(0,1,2,2,2,BitmapFilterQuality.LOW)];
         addChild(this.playCountText);
         this.playCountText.x = this.miniMap.x;
         this.playCountText.y = this.miniMap.y + 144 - 14;
         this.prevDayButton = new Button("<< Prev",12,75,20,0,0,true,1056896,0);
         this.todayButton = new Button("Today",12,75,20,0,0,true,1056896,0);
         this.nextDayButton = new Button("Next >>",12,75,20,0,0,true,1056896,0);
         this.randomButton = new Button("Random",12,75,20,0,0,true,9445520,0);
         addChild(this.prevDayButton);
         addChild(this.todayButton);
         addChild(this.nextDayButton);
         addChild(this.randomButton);
         this.prevDayButton.x = this.monthSpinner.x + 10;
         this.prevDayButton.y = 115;
         this.todayButton.x = this.prevDayButton.x + this.prevDayButton.width + 5;
         this.todayButton.y = 115;
         this.nextDayButton.x = this.todayButton.x + this.todayButton.width + 5;
         this.nextDayButton.y = 115;
         this.randomButton.x = this.nextDayButton.x + this.nextDayButton.width + 5;
         this.randomButton.y = 115;
         this.prevDayButton.addEventListener(MouseEvent.CLICK,this.onPrevDay);
         this.todayButton.addEventListener(MouseEvent.CLICK,this.onTodayClick);
         this.nextDayButton.addEventListener(MouseEvent.CLICK,this.onNextDay);
         this.randomButton.addEventListener(MouseEvent.CLICK,this.onRandomClick);
         var _loc6_:Button = new Button("LAUNCH",24,250,35,0,0,true,32768,-1);
         addChild(_loc6_);
         _loc6_.x = this.miniMap.x + 105 - _loc6_.width / 2;
         _loc6_.y = this.miniMap.y + 144 + 10;
         _loc6_.addEventListener(MouseEvent.CLICK,this.onLaunch);
         this.resubmitButton = new Button("Resubmit Score",10,90,17,0,0,true,2117664,0);
         addChild(this.resubmitButton);
         this.resubmitButton.x = int(this.miniMap.x + 210 - this.resubmitButton.width - 3);
         this.resubmitButton.y = this.miniMap.y + 2;
         this.resubmitButton.addEventListener(MouseEvent.CLICK,this.onResubmit);
         this.happyDayText = Text.text("Happy Birthday USA!",8,16777215);
         addChild(this.happyDayText);
         this.happyDayText.x = int(this.WIDTH / 2 - this.happyDayText.width / 2);
         this.happyDayText.y = this.HEIGHT - this.happyDayText.height - 2;
         this.happyDayText.visible = false;
         graphics.lineStyle(1,9502608,0.5);
         graphics.beginFill(2134048,0.3);
         graphics.drawRect(0,0,this.WIDTH,this.HEIGHT);
         graphics.endFill();
         this.filters = [new DropShadowFilter()];
         this.onDateChange(null);
         this.dataProvider = new DataProvider();
         this.dg = new DataGrid();
         this.dg.focusEnabled = false;
         this.dg.sortableColumns = false;
         this.dg.move(365,155);
         this.dg.width = 275;
         this.dg.rowCount = 10;
         var _loc7_:DataGridColumn;
         (_loc7_ = new DataGridColumn("mapName")).headerText = "Chrono Map";
         _loc7_.sortOptions = Array.CASEINSENSITIVE;
         var _loc8_:DataGridColumn;
         (_loc8_ = new DataGridColumn("score")).headerText = "Score";
         _loc8_.width = 60;
         _loc8_.sortOptions = Array.NUMERIC;
         var _loc9_:DataGridColumn;
         (_loc9_ = new DataGridColumn("playCount")).headerText = "Plays";
         _loc9_.width = 50;
         _loc9_.sortOptions = Array.NUMERIC;
         this.dg.addColumn(_loc7_);
         this.dg.addColumn(_loc8_);
         this.dg.addColumn(_loc9_);
         this.dg.dataProvider = this.dataProvider;
         addChild(this.dg);
         this.dg.selectable = true;
         this.dg.addEventListener(Event.CHANGE,this.gridItemSelected);
         this.dgText = Text.text("X",12,16777215);
         addChild(this.dgText);
         this.dgText.y = this.dg.y - this.dgText.height;
         this.viewScoresButton = new Button("View Online Scores",12,135,20,0,0,true,1097744,0);
         addChild(this.viewScoresButton);
         this.viewScoresButton.x = int(_loc6_.x + _loc6_.width / 2 - this.viewScoresButton.width / 2);
         this.viewScoresButton.y = _loc6_.y + _loc6_.height + 15;
         this.viewScoresButton.addEventListener(MouseEvent.CLICK,this.onViewScoresClick);
         this.refreshList();
      }
      
      public static function zeroPad(param1:int, param2:int) : String
      {
         var _loc3_:String = "" + param1;
         while(_loc3_.length < param2)
         {
            _loc3_ = "0" + _loc3_;
         }
         return _loc3_;
      }
      
      private static function isLeapYear(param1:int) : Boolean
      {
         return Boolean(param1 % 4 == 0 && param1 % 100 != 0 || param1 % 400 == 0);
      }
      
      public static function getDateFromDays(param1:int) : Object
      {
         var _loc4_:int = 0;
         var _loc2_:int = param1 + 1;
         var _loc3_:int = _loc2_ * 10000 / 3652425;
         _loc2_ -= int(3652425 * _loc3_ / 10000);
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         while(_loc4_ < _loc2_ && _loc5_ <= 11)
         {
            _loc4_ += days[_loc5_];
            if(_loc5_ == 1 && isLeapYear(_loc3_))
            {
               _loc4_++;
            }
            _loc5_++;
         }
         if(--_loc5_ == 1 && isLeapYear(_loc3_))
         {
            _loc4_--;
         }
         _loc6_ = _loc2_ - _loc4_ + days[_loc5_];
         return {
            "year":_loc3_,
            "month":_loc5_,
            "day":_loc6_
         };
      }
      
      private function onNextDay(param1:MouseEvent) : void
      {
         var _loc2_:int = this.selectedMap;
         _loc2_++;
         if(_loc2_ > 3652423)
         {
            _loc2_ = 3652423;
         }
         this.setSpinnersFromDays(_loc2_);
         this.onDateChange(null);
      }
      
      private function onPrevDay(param1:MouseEvent) : void
      {
         var _loc2_:int = this.selectedMap;
         _loc2_--;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         this.setSpinnersFromDays(_loc2_);
         this.onDateChange(null);
      }
      
      private function onViewScoresClick(param1:Event) : void
      {
         var _loc2_:URLRequest = new URLRequest("http://knucklecracker.com/creeperworld/viewscores.php?missionGroup=chronom&month=" + this.monthSpinner.valueIndex + "&" + "day=" + this.daySpinner.value + "&" + "year1=" + this.year1Spinner.value + "&" + "year2=" + this.year2Spinner.value + "&" + "year3=" + this.year3Spinner.value + "&" + "year4=" + this.year4Spinner.value);
         navigateToURL(_loc2_,"creeperworldscores");
      }
      
      private function setToday() : void
      {
         var _loc1_:Date = new Date();
         this.monthSpinner.valueIndex = _loc1_.getMonth();
         this.daySpinner.value = _loc1_.getDate();
         var _loc2_:int = _loc1_.getFullYear();
         var _loc3_:int = int(_loc2_ / 1000);
         _loc2_ -= _loc3_ * 1000;
         var _loc4_:int = int(_loc2_ / 100);
         _loc2_ -= _loc4_ * 100;
         var _loc5_:int = int(_loc2_ / 10);
         _loc2_ -= _loc5_ * 10;
         var _loc6_:int = int(_loc2_);
         this.year1Spinner.value = _loc3_;
         this.year2Spinner.value = _loc4_;
         this.year3Spinner.value = _loc5_;
         this.year4Spinner.value = _loc6_;
      }
      
      private function onTodayClick(param1:Event) : void
      {
         this.setToday();
         this.onDateChange(null);
      }
      
      private function onRandomClick(param1:Event) : void
      {
         var _loc2_:int = Math.random() * 3652423;
         this.setSpinnersFromDays(_loc2_);
         this.onDateChange(null);
      }
      
      private function gridItemSelected(param1:Event) : void
      {
         var _loc2_:UnchartedGameRow = this.dg.selectedItem as UnchartedGameRow;
         if(_loc2_ != null)
         {
            this.setSpinnersFromDays(_loc2_.mapNumber);
            this.onDateChange(null);
         }
      }
      
      private function sortOnTime(param1:UnchartedGameRow, param2:UnchartedGameRow) : int
      {
         if(param1.playTime > param2.playTime)
         {
            return 1;
         }
         if(param1.playTime < param2.playTime)
         {
            return -1;
         }
         return 0;
      }
      
      public function refreshList() : void
      {
         var _loc3_:* = null;
         GameData.load();
         var _loc1_:Dictionary = GameData.getUnchartedGames();
         var _loc2_:Array = new Array();
         for each(_loc3_ in _loc1_)
         {
            if(_loc3_.playCount > 0)
            {
               _loc2_.push(new UnchartedGameRow(true,int(_loc3_.gameName),_loc3_.highScore,_loc3_.playCount,_loc3_.lastPlayed));
            }
         }
         _loc2_.sort(this.sortOnTime,0 | 0);
         this.dgText.text = "" + _loc2_.length + " Played Maps (Click to Select)";
         this.dgText.x = int(this.dg.x + this.dg.width / 2 - this.dgText.width / 2);
         this.dataProvider.removeAll();
         this.dataProvider.addItems(_loc2_);
      }
      
      private function onLaunch(param1:Event) : void
      {
         stage.focus = null;
         dispatchEvent(new Event(LAUNCHMAP));
      }
      
      private function onResubmit(param1:Event) : void
      {
         dispatchEvent(new Event(RESUBMIT));
      }
      
      public function reinit() : void
      {
         this.onDateChange(null);
         this.refreshList();
      }
      
      private function onDateChange(param1:Event) : void
      {
         if(param1 != null)
         {
            this.dg.selectedIndex = -1;
         }
         var _loc2_:int = this.year1Spinner.value;
         var _loc3_:int = this.year2Spinner.value;
         var _loc4_:int = this.year3Spinner.value;
         var _loc5_:int = this.year4Spinner.value;
         var _loc6_:int = _loc2_ * 1000 + _loc3_ * 100 + _loc4_ * 10 + _loc5_;
         var _loc7_:int = this.monthSpinner.valueIndex;
         var _loc8_:int = this.getDaysInMonth(_loc7_,_loc6_);
         this.daySpinner.max = _loc8_;
         var _loc9_:int = this.daySpinner.value;
         var _loc10_:int = int(3652425 * _loc6_ / 10000);
         var _loc11_:int = 0;
         while(_loc11_ < _loc7_)
         {
            _loc10_ += this.getDaysInMonth(_loc11_,_loc6_);
            _loc11_++;
         }
         _loc10_ += _loc9_ - 1;
         this.selectedMap = _loc10_;
         this.selectedDate = this.monthSpinner.values[_loc7_] + " " + _loc9_ + ", " + zeroPad(_loc6_,4);
         this.createMiniMap(this.selectedMap);
         var _loc12_:IndividualGameData = GameData.getUnchartedGameData(String(this.selectedMap));
         this.scoreTextField.text = String(_loc12_.highScore);
         this.timeTextField.text = "(" + Time.getTimeString(_loc12_.minTime / 36) + ")";
         this.playCountText.text = "# Plays: " + String(_loc12_.playCount);
         if(_loc12_.highScore > 0 && _loc12_.scoreSubmitted == 0)
         {
            this.resubmitButton.visible = true;
         }
         else
         {
            this.resubmitButton.visible = false;
         }
         if(_loc7_ == 6 && _loc9_ == 4 && _loc6_ >= 1776)
         {
            this.happyDayText.visible = true;
         }
         else
         {
            this.happyDayText.visible = false;
         }
      }
      
      private function getDaysInMonth(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         if(param1 == 1 && isLeapYear(param2))
         {
            _loc3_++;
         }
         return _loc3_;
      }
      
      private function setSpinnersFromDays(param1:int) : void
      {
         var _loc2_:Object = getDateFromDays(param1);
         var _loc3_:int = _loc2_.year;
         var _loc4_:int = _loc2_.month;
         var _loc5_:int = _loc2_.day;
         this.monthSpinner.valueIndex = _loc4_;
         this.daySpinner.value = _loc5_;
         var _loc6_:int = int(_loc3_ / 1000);
         _loc3_ -= _loc6_ * 1000;
         var _loc7_:int = int(_loc3_ / 100);
         _loc3_ -= _loc7_ * 100;
         var _loc8_:int = int(_loc3_ / 10);
         _loc3_ -= _loc8_ * 10;
         var _loc9_:int = int(_loc3_);
         this.year1Spinner.value = _loc6_;
         this.year2Spinner.value = _loc7_;
         this.year3Spinner.value = _loc8_;
         this.year4Spinner.value = _loc9_;
      }
      
      private function createMiniMap(param1:int) : void
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc2_:RandomGame = new RandomGame(100000000 + param1);
         var _loc3_:BitmapData = new BitmapData(0,0,false);
         this.miniMap.width = 210;
         this.miniMap.height = 144;
         var _loc4_:Terrain;
         (_loc4_ = new Terrain()).background = int(_loc2_.getBackground());
         _loc4_.setData(_loc2_.getTerrainHeight());
         _loc4_.update();
         var _loc5_:* = 0;
         for each(_loc7_ in _loc2_.xml.places.elements())
         {
            _loc11_ = _loc7_.name();
            _loc6_ = null;
            if(_loc11_ == "Totem")
            {
               _loc6_ = Totem.getPlacementSprite(false);
               _loc4_.addChild(_loc6_);
               _loc6_.scaleX = _loc5_;
               _loc6_.scaleY = _loc5_;
            }
            if(_loc6_ != null)
            {
               _loc6_.x = _loc7_.gameSpaceX * 0 + 0;
               _loc6_.y = _loc7_.gameSpaceY * 0 + 0;
            }
         }
         for each(_loc7_ in _loc2_.xml.specialplaces.elements())
         {
            _loc11_ = _loc7_.name();
            _loc6_ = null;
            if(_loc11_ == "BaseGun")
            {
               _loc6_ = BaseGun.getHelpImage();
               _loc4_.addChild(_loc6_);
               _loc6_.scaleX = _loc5_ / 0;
               _loc6_.scaleY = _loc5_ / 0;
            }
            if(_loc6_ != null)
            {
               _loc6_.x = _loc7_.gameSpaceX * 0 + 0;
               _loc6_.y = _loc7_.gameSpaceY * 0 + 0;
            }
         }
         for each(_loc8_ in _loc2_.gproducers)
         {
            _loc6_ = GlopProducer.getBodyShape();
            _loc4_.addChild(_loc6_);
            _loc6_.x = _loc8_.x * 0 + 0;
            _loc6_.y = _loc8_.y * 0 + 0;
            _loc6_.scaleX = _loc5_;
            _loc6_.scaleY = _loc5_;
         }
         for each(_loc9_ in _loc2_.upgradeBoxes)
         {
            _loc12_ = new Shape();
            _loc4_.addChild(_loc12_);
            UpgradeBox.drawPlacementShape(_loc12_);
            _loc12_.x = _loc9_.x * 0 + 0;
            _loc12_.y = _loc9_.y * 0 + 0;
            _loc12_.scaleX = _loc5_;
            _loc12_.scaleY = _loc5_;
         }
         (_loc10_ = new Matrix()).scale(0.3,0.3);
         _loc3_.draw(_loc4_,_loc10_);
         this.miniMap.bitmapData = _loc3_;
      }
   }
}
