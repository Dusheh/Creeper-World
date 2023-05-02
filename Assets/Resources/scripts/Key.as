package
{
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import mx.binding.BindingManager;
   import mx.core.DeferredInstanceFromFunction;
   import mx.core.IFlexModuleFactory;
   import mx.events.PropertyChangeEvent;
   import spark.components.Button;
   import spark.components.Group;
   import spark.components.Label;
   import spark.components.SkinnableContainer;
   import spark.components.TextInput;
   import spark.events.TextOperationEvent;
   
   public class Key extends SkinnableContainer
   {
      
      public static var VALID_KEY:String = "VALID_KEY";
       
      
      private var _509099837invalidLabel:Label;
      
      private var _3288497key0:TextInput;
      
      private var _3288498key1:TextInput;
      
      private var _3288499key2:TextInput;
      
      private var _3288500key3:TextInput;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function Key()
      {
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.mxmlContentFactory = new DeferredInstanceFromFunction(this._Key_Array1_c);
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         var factory:IFlexModuleFactory = param1;
         super.moduleFactory = factory;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration(null,styleManager);
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.backgroundColor = 0;
         };
      }
      
      override public function initialize() : void
      {
         super.initialize();
      }
      
      private function onShow(param1:Event = null) : void
      {
         this.key0.setFocus();
      }
      
      public function get key() : String
      {
         var _loc1_:String = this.key0.text + "-" + this.key1.text + "-" + this.key2.text + "-" + this.key3.text;
         return _loc1_.toUpperCase();
      }
      
      private function onLinkClick(param1:Event = null) : void
      {
         var _loc2_:URLRequest = new URLRequest("http://knucklecracker.com");
         navigateToURL(_loc2_,"_blank");
      }
      
      private function onEnterKey(param1:Event = null) : void
      {
         if(!this.validateKey())
         {
            this.invalidLabel.text = "The key you entered appears to be invalid.  Please double check and try again";
         }
         else
         {
            this.invalidLabel.text = "";
            dispatchEvent(new Event(VALID_KEY));
         }
      }
      
      private function validateKey() : Boolean
      {
         var _loc1_:String = this.key0.text + "-" + this.key1.text + "-" + this.key2.text + "-" + this.key3.text;
         _loc1_ = _loc1_.toUpperCase();
         return Gate.check(_loc1_);
      }
      
      private function onKey0Change(param1:Event) : void
      {
         if(this.key0.text.length >= 4)
         {
            this.key1.setFocus();
         }
      }
      
      private function onKey1Change(param1:Event) : void
      {
         if(this.key1.text.length >= 4)
         {
            this.key2.setFocus();
         }
      }
      
      private function onKey2Change(param1:Event) : void
      {
         if(this.key2.text.length >= 4)
         {
            this.key3.setFocus();
         }
      }
      
      private function onKey3KD(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            this.onEnterKey();
         }
      }
      
      private function _Key_Array1_c() : Array
      {
         return [this._Key_Label1_c(),this._Key_Label2_c(),this._Key_Label3_c(),this._Key_Group1_c(),this._Key_Button1_c(),this._Key_Label4_i(),this._Key_Label5_c(),this._Key_Label6_c(),this._Key_Label7_c()];
      }
      
      private function _Key_Label1_c() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.y = 10;
         _loc1_.text = "Creeper World";
         _loc1_.horizontalCenter = -1;
         _loc1_.setStyle("fontSize",36);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("color",4821224);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _Key_Label2_c() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.y = 145;
         _loc1_.text = "Activation Key Entry";
         _loc1_.horizontalCenter = 0;
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("fontSize",18);
         _loc1_.setStyle("color",16777215);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _Key_Label3_c() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.y = 181;
         _loc1_.text = "Enter your 16 character activation key to unlock Creeper World";
         _loc1_.horizontalCenter = 0;
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("color",16777215);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _Key_Group1_c() : Group
      {
         var _loc1_:Group = new Group();
         _loc1_.y = 207;
         _loc1_.width = 245;
         _loc1_.height = 46;
         _loc1_.horizontalCenter = 0;
         _loc1_.mxmlContent = [this._Key_TextInput1_i(),this._Key_TextInput2_i(),this._Key_TextInput3_i(),this._Key_TextInput4_i()];
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _Key_TextInput1_i() : TextInput
      {
         var _loc1_:TextInput = new TextInput();
         _loc1_.x = 10;
         _loc1_.y = 10;
         _loc1_.width = 50;
         _loc1_.maxChars = 4;
         _loc1_.displayAsPassword = false;
         _loc1_.editable = true;
         _loc1_.enabled = true;
         _loc1_.text = "";
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.addEventListener("change",this.__key0_change);
         _loc1_.id = "key0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.key0 = _loc1_;
         BindingManager.executeBindings(this,"key0",this.key0);
         return _loc1_;
      }
      
      public function __key0_change(param1:TextOperationEvent) : void
      {
         this.onKey0Change(param1);
      }
      
      private function _Key_TextInput2_i() : TextInput
      {
         var _loc1_:TextInput = new TextInput();
         _loc1_.x = 68;
         _loc1_.y = 10;
         _loc1_.width = 50;
         _loc1_.maxChars = 4;
         _loc1_.displayAsPassword = false;
         _loc1_.editable = true;
         _loc1_.enabled = true;
         _loc1_.text = "";
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.addEventListener("change",this.__key1_change);
         _loc1_.id = "key1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.key1 = _loc1_;
         BindingManager.executeBindings(this,"key1",this.key1);
         return _loc1_;
      }
      
      public function __key1_change(param1:TextOperationEvent) : void
      {
         this.onKey1Change(param1);
      }
      
      private function _Key_TextInput3_i() : TextInput
      {
         var _loc1_:TextInput = new TextInput();
         _loc1_.x = 126;
         _loc1_.y = 10;
         _loc1_.width = 50;
         _loc1_.maxChars = 4;
         _loc1_.displayAsPassword = false;
         _loc1_.editable = true;
         _loc1_.enabled = true;
         _loc1_.text = "";
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.addEventListener("change",this.__key2_change);
         _loc1_.id = "key2";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.key2 = _loc1_;
         BindingManager.executeBindings(this,"key2",this.key2);
         return _loc1_;
      }
      
      public function __key2_change(param1:TextOperationEvent) : void
      {
         this.onKey2Change(param1);
      }
      
      private function _Key_TextInput4_i() : TextInput
      {
         var _loc1_:TextInput = new TextInput();
         _loc1_.x = 184;
         _loc1_.y = 10;
         _loc1_.width = 50;
         _loc1_.maxChars = 4;
         _loc1_.displayAsPassword = false;
         _loc1_.editable = true;
         _loc1_.enabled = true;
         _loc1_.text = "";
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.addEventListener("keyDown",this.__key3_keyDown);
         _loc1_.id = "key3";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.key3 = _loc1_;
         BindingManager.executeBindings(this,"key3",this.key3);
         return _loc1_;
      }
      
      public function __key3_keyDown(param1:KeyboardEvent) : void
      {
         this.onKey3KD(param1);
      }
      
      private function _Key_Button1_c() : Button
      {
         var _loc1_:Button = new Button();
         _loc1_.y = 261;
         _loc1_.label = "Enter Key";
         _loc1_.horizontalCenter = 0;
         _loc1_.addEventListener("click",this.___Key_Button1_click);
         _loc1_.addEventListener("keyDown",this.___Key_Button1_keyDown);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      public function ___Key_Button1_click(param1:MouseEvent) : void
      {
         this.onEnterKey(param1);
      }
      
      public function ___Key_Button1_keyDown(param1:KeyboardEvent) : void
      {
         this.onEnterKey(param1);
      }
      
      private function _Key_Label4_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.y = 291;
         _loc1_.horizontalCenter = 0;
         _loc1_.setStyle("color",16777215);
         _loc1_.id = "invalidLabel";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.invalidLabel = _loc1_;
         BindingManager.executeBindings(this,"invalidLabel",this.invalidLabel);
         return _loc1_;
      }
      
      private function _Key_Label5_c() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.text = "If you don\'t have an activation key visit KnuckleCracker.com to purchase one.";
         _loc1_.horizontalCenter = 0;
         _loc1_.bottom = 67;
         _loc1_.setStyle("color",16777215);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _Key_Label6_c() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.y = 68;
         _loc1_.text = "-----";
         _loc1_.horizontalCenter = 0;
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("color",4821224);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textDecoration","none");
         _loc1_.setStyle("fontStyle","italic");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _Key_Label7_c() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.y = 497;
         _loc1_.text = "Copyright 2016 Knuckle Cracker, LLC";
         _loc1_.horizontalCenter = -1;
         _loc1_.setStyle("color",11514547);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get invalidLabel() : Label
      {
         return this._509099837invalidLabel;
      }
      
      public function set invalidLabel(param1:Label) : void
      {
         var _loc2_:Object = this._509099837invalidLabel;
         if(_loc2_ !== param1)
         {
            this._509099837invalidLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"invalidLabel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get key0() : TextInput
      {
         return this._3288497key0;
      }
      
      public function set key0(param1:TextInput) : void
      {
         var _loc2_:Object = this._3288497key0;
         if(_loc2_ !== param1)
         {
            this._3288497key0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"key0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get key1() : TextInput
      {
         return this._3288498key1;
      }
      
      public function set key1(param1:TextInput) : void
      {
         var _loc2_:Object = this._3288498key1;
         if(_loc2_ !== param1)
         {
            this._3288498key1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"key1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get key2() : TextInput
      {
         return this._3288499key2;
      }
      
      public function set key2(param1:TextInput) : void
      {
         var _loc2_:Object = this._3288499key2;
         if(_loc2_ !== param1)
         {
            this._3288499key2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"key2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get key3() : TextInput
      {
         return this._3288500key3;
      }
      
      public function set key3(param1:TextInput) : void
      {
         var _loc2_:Object = this._3288500key3;
         if(_loc2_ !== param1)
         {
            this._3288500key3 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"key3",_loc2_,param1));
            }
         }
      }
   }
}
