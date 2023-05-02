package fl.controls.dataGridClasses
{
   import fl.controls.LabelButton;
   
   public class HeaderRenderer extends LabelButton
   {
      
      private static var defaultStyles:Object = {
         "upSkin":"HeaderRenderer_upSkin",
         "downSkin":"HeaderRenderer_downSkin",
         "overSkin":"HeaderRenderer_overSkin",
         "disabledSkin":"HeaderRenderer_disabledSkin",
         "selectedDisabledSkin":"HeaderRenderer_selectedDisabledSkin",
         "selectedUpSkin":"HeaderRenderer_selectedUpSkin",
         "selectedDownSkin":"HeaderRenderer_selectedDownSkin",
         "selectedOverSkin":"HeaderRenderer_selectedOverSkin",
         "textFormat":null,
         "disabledTextFormat":null,
         "textPadding":5
      };
       
      
      public var _column:uint;
      
      public function HeaderRenderer()
      {
         super();
         focusEnabled = false;
      }
      
      public static function getStyleDefinition() : Object
      {
         return defaultStyles;
      }
      
      public function get column() : uint
      {
         return _column;
      }
      
      public function set column(param1:uint) : void
      {
         _column = param1;
      }
      
      override protected function drawLayout() : void
      {
         var _loc1_:Number = Number(getStyleValue("textPadding"));
         textField.height = NaN;
         textField.visible = false;
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:Number = icon == null ? 0 : Number(NaN);
         var _loc5_:Number = Math.max(0,Math.min(_loc2_,width - 2 * _loc1_ - _loc4_));
         if(icon != null)
         {
            icon.x = width - _loc1_ - 0 - 2;
            icon.y = Math.round((height - 0) / 2);
         }
         textField.width = _loc5_;
         textField.x = _loc1_;
         textField.y = Math.round((height - 0) / 2);
         background.width = width;
         background.height = height;
      }
   }
}
