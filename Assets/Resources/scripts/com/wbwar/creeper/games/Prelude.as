package com.wbwar.creeper.games
{
   import caurina.transitions.Tweener;
   import com.wbwar.creeper.screens.MissionSelection;
   import com.wbwar.creeper.util.Button;
   import com.wbwar.creeper.util.Callback;
   import com.wbwar.creeper.util.ColorUtil;
   import com.wbwar.creeper.util.Text;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.text.TextField;
   
   public class Prelude extends Sprite
   {
       
      
      private var worlds:Array;
      
      private var hopeWorld:Sprite;
      
      private var worldSeeds:Array;
      
      private var worldThres:Array;
      
      private var worldRed:Array;
      
      private var worldGreen:Array;
      
      private var worldBlue:Array;
      
      private var worldNames:Array;
      
      private var worldPop:Array;
      
      private var game:Game0;
      
      private var textBox:Sprite;
      
      private var continueButton:Button;
      
      private var textToShow:String;
      
      private var oldWorld:Sprite;
      
      private var music:Sound;
      
      private var musicSC:SoundChannel;
      
      public function Prelude(param1:Game0)
      {
         var b:Bitmap = null;
         var w:Sprite = null;
         var game:Game0 = param1;
         this.worlds = [];
         this.worldSeeds = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
         this.worldThres = [50,60,70,100,55,86,45,76,65,57,88,95,63,65,77,83,91,80,70,60];
         this.worldRed = [10,10,10,200,20,150,40,30,90,20,50,20,150,60,40,70,30,30,40,40];
         this.worldGreen = [10,100,150,110,100,90,60,140,130,120,100,90,90,80,70,110,140,150,180,120];
         this.worldBlue = [30,250,30,40,140,80,60,120,100,60,70,50,80,90,20,30,50,80,30,60];
         this.worldNames = ["Antlia","Sagitta","Aquila","Pavo","Caelum","Canis","Vela","Corvus","Draco","Fornax","Indus","Apus","Orion","Ara","Pictor","Leo","Taurus","Cetus","Ursa","Volans"];
         this.worldPop = ["13.7 billion","12.2 billion","10.8 billion","15.3 billion","20.4 billion","5.4 billion","8.2 billion","10.5 billion","8.7 billion","3.3 billion","14 billion","12.2 billion","13.1 billion","13.9 billion","9.3 billion","7.6 billion","5.1 billion","6 billion","18.2 billion","14 billion"];
         super();
         this.game = game;
         graphics.beginFill(0);
         graphics.drawRect(0,0,700,525);
         graphics.endFill();
         b = new MissionSelection.backgroundImage();
         b.alpha = 0;
         b.visible = false;
         addChild(b);
         var cancelText:TextField = Text.text("[SPACE] to Skip",8,10526880);
         addChild(cancelText);
         cancelText.x = 700 - cancelText.width - 5;
         cancelText.y = 520 - cancelText.height;
         Creeper.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false,0,true);
         this.textBox = new Sprite();
         addChild(this.textBox);
         this.textBox.y = 30;
         var i:int = 0;
         while(i < 20)
         {
            w = ColorUtil.world(this.worldSeeds[i],this.worldThres[i],this.worldRed[i],this.worldGreen[i],this.worldBlue[i]);
            w.width = 200;
            w.height = 200;
            this.worlds[i] = w;
            i++;
         }
         this.hopeWorld = ColorUtil.world(100,50,100,10,100);
         this.hopeWorld.width = 250;
         this.hopeWorld.height = 250;
         this.hopeWorld.x = 350;
         this.hopeWorld.y = 300;
         addChild(this.hopeWorld);
         this.hopeWorld.visible = false;
         this.continueButton = new Button("Continue",12,120,20,0,0,true,32768,-1);
         this.continueButton.visible = false;
         addChild(this.continueButton);
         this.continueButton.x = 350 - this.continueButton.width / 2;
         this.continueButton.y = 520 - this.continueButton.height;
         this.continueButton.addEventListener(MouseEvent.CLICK,this.onContinueClick);
         Tweener.addTween(b,{
            "time":5,
            "_autoAlpha":0.7
         });
         Callback.callback(function():void
         {
            showText("In the year 13,271 Humankind had colonized\nthousands of worlds.");
         },2000);
         Callback.callback(function():void
         {
            showText("They found none their equal as they spread\ninto a fantastic and bountiful empire.");
         },9000);
         Callback.callback(function():void
         {
            showText("At the height of their greatness they walked\namongst the stars as though they were gods. ");
         },16000);
         Callback.callback(function():void
         {
            showText("But gods they were not...");
         },25000);
         Callback.callback(function():void
         {
            showText("It fell from the sky without purpose or reason.");
         },30000);
         Callback.callback(function():void
         {
            showText("Fifty worlds fell on the first day.\n500 billion lives were lost.");
         },36000);
         Callback.callback(function():void
         {
            showText("World after world fell as man\nwas routed from existence.");
         },42000);
         Callback.callback(function():void
         {
            showText("Nothing could stop what would\ncome to be called the Creeper.");
         },48000);
         Callback.callback(function():void
         {
            showText("It wanted nothing, it could not be reasoned with.");
         },54000);
         Callback.callback(function():void
         {
            showText("It seemed as though its only purpose was\nto undo all that Man had done.");
         },60000);
         Callback.callback(function():void
         {
            showText("But all was not yet lost....");
         },69000);
         Callback.callback(function():void
         {
            showText("The last survivors of humanity have\ngathered at a world called Hope.");
         },76000);
         Callback.callback(function():void
         {
            showText("Assembled by the visions of a crazed Old Man,\nthe last of Humankind marks its final hours.");
         },82000);
         Callback.callback(function():void
         {
            showText("A great city has been built to house\nthe 50 thousand that survive.");
         },88000);
         Callback.callback(function():void
         {
            showText("It will journey from world to world...\nNever staying longer than it must.");
         },94000);
         Callback.callback(function():void
         {
            showText("Guided by the path set by the Old Man,\nHumanity\'s final journey has begun.");
         },100000);
         Callback.callback(function():void
         {
            continueButton.visible = true;
         },102000);
         Callback.callback(this.showHope,76000);
         var wst:int = 38000;
         Callback.callback(function():void
         {
            showWorld(0);
         },wst);
         Callback.callback(function():void
         {
            showWorld(1);
         },wst + 5000);
         Callback.callback(function():void
         {
            showWorld(2);
         },wst + 10000);
         Callback.callback(function():void
         {
            showWorld(3);
         },wst + 15000);
         Callback.callback(function():void
         {
            showWorld(4);
         },wst + 20000);
         Callback.callback(function():void
         {
            showWorld(5);
         },wst + 23000);
         Callback.callback(function():void
         {
            showWorld(6);
         },wst + 25000);
         Callback.callback(function():void
         {
            showWorld(7);
         },wst + 26000);
         Callback.callback(function():void
         {
            showWorld(8);
         },wst + 26500);
         Callback.callback(function():void
         {
            showWorld(10);
         },wst + 26500 + 200);
         Callback.callback(function():void
         {
            showWorld(11);
         },wst + 26500 + 400);
         Callback.callback(function():void
         {
            showWorld(12);
         },wst + 26500 + 600);
         Callback.callback(function():void
         {
            showWorld(13);
         },wst + 26500 + 800);
         Callback.callback(function():void
         {
            showWorld(14);
         },wst + 26500 + 1000);
         Callback.callback(function():void
         {
            showWorld(15);
         },wst + 26500 + 1200);
         Callback.callback(function():void
         {
            showWorld(16);
         },wst + 26500 + 1400);
         Callback.callback(function():void
         {
            showWorld(17);
         },wst + 26500 + 1600);
         Callback.callback(function():void
         {
            showWorld(18);
         },wst + 26500 + 1800);
         Callback.callback(function():void
         {
            showWorld(19);
         },wst + 26500 + 2000);
         Callback.callback(function():void
         {
            showWorld(0);
         },wst + 26500 + 2200);
         Callback.callback(function():void
         {
            showWorld(1);
         },wst + 26500 + 2400);
         Callback.callback(function():void
         {
            showWorld(2);
         },wst + 26500 + 2600);
         Callback.callback(function():void
         {
            showWorld(3);
         },wst + 26500 + 2800);
         Callback.callback(function():void
         {
            showWorld(4);
         },wst + 26500 + 3000);
         Callback.callback(function():void
         {
            showWorld(5);
         },wst + 26500 + 3200);
         Callback.callback(function():void
         {
            showWorld(6);
         },wst + 26500 + 3400);
         Callback.callback(function():void
         {
            showWorld(9);
         },wst + 26500 + 3600);
         Callback.callback(function():void
         {
            showWorld(7);
         },wst + 26500 + 3800);
         Callback.callback(function():void
         {
            showWorld(8);
         },wst + 26500 + 4000);
         Callback.callback(function():void
         {
            showWorld(9);
         },wst + 26500 + 4200);
         Callback.callback(function():void
         {
            showWorld(-1);
         },wst + 26500 + 4400);
         this.music = new MusicOperaHouse();
         this.musicSC = this.music.play(0,2);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 32)
         {
            this.onContinueClick(null);
         }
      }
      
      private function onContinueClick(param1:Event) : void
      {
         Creeper.instance.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         visible = false;
         if(this.musicSC != null)
         {
            this.musicSC.stop();
         }
         this.game.actualGameStart();
         this.game.prelude = null;
      }
      
      private function showText(param1:String) : void
      {
         this.textToShow = param1;
         Tweener.addTween(this.textBox,{
            "time":1,
            "_autoAlpha":0,
            "onComplete":this.showTextUp
         });
      }
      
      private function showTextUp() : void
      {
         var _loc1_:* = null;
         while(this.textBox.numChildren)
         {
            this.textBox.removeChildAt(0);
         }
         _loc1_ = Text.text(this.textToShow,24,15790320);
         _loc1_.filters = [new DropShadowFilter(4,45,4210752)];
         this.textBox.addChild(_loc1_);
         this.textBox.x = 350 - _loc1_.width / 2;
         Tweener.addTween(this.textBox,{
            "time":1,
            "_autoAlpha":1
         });
      }
      
      private function showHope() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         _loc1_ = Text.text("Name: Hope",12,16777215);
         _loc2_ = Text.text("Population: 49,825",12,10551200);
         this.hopeWorld.addChild(_loc1_);
         this.hopeWorld.addChild(_loc2_);
         _loc1_.x = -_loc1_.width / 2;
         _loc2_.x = -_loc2_.width / 2;
         _loc1_.y = 105;
         _loc2_.y = 120;
         this.hopeWorld.visible = false;
         this.hopeWorld.alpha = 0;
         Tweener.addTween(this.hopeWorld,{
            "time":5,
            "_autoAlpha":1
         });
      }
      
      private function showWorld(param1:int) : void
      {
         var w:Sprite = null;
         var n:TextField = null;
         var p:TextField = null;
         var d:TextField = null;
         var ow:Sprite = null;
         var wn:int = param1;
         if(wn != -1)
         {
            w = this.worlds[wn];
            w.y = 300;
            n = Text.text("Name: " + this.worldNames[wn],12,16777215);
            p = Text.text("Population: " + this.worldPop[wn],12,10551200);
            d = Text.text("Status: DEAD",12,16752800);
            w.addChild(n);
            w.addChild(p);
            w.addChild(d);
            n.x = -n.width / 2;
            p.x = -p.width / 2;
            d.x = -d.width / 2;
            n.y = 105;
            p.y = 120;
            d.y = 135;
            addChild(w);
         }
         if(this.oldWorld != null)
         {
            ow = this.oldWorld;
            Tweener.addTween(ow,{
               "time":2,
               "_autoAlpha":0,
               "x":0,
               "onComplete":function():void
               {
                  removeChild(ow);
               }
            });
         }
         if(wn != -1)
         {
            w.x = 800;
            w.alpha = 0;
            Tweener.addTween(w,{
               "time":0.8,
               "_autoAlpha":1,
               "x":350
            });
            this.oldWorld = w;
         }
      }
   }
}
