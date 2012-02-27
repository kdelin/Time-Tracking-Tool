﻿// Define the Packagepackage classes.view.timefield {		// Import Necessary Classes	import flash.filters.DropShadowFilter;	import flash.display.DisplayObject;	import flash.filters.GlowFilter;	import flash.events.Event;	import flash.display.MovieClip;	import flash.display.Stage;	import flash.events.KeyboardEvent;	import flash.events.MouseEvent;	import flash.events.FocusEvent;	import flash.utils.Timer;	import flash.events.TimerEvent;	import flash.text.TextField;	import flash.text.AntiAliasType;	import flash.text.TextFormat;	import flash.text.TextFieldType;		import classes.view.timefield.TimeFieldArrow;	import classes.view.timefield.TimeFieldEvent;	import classes.view.timefield.TimeFieldInput;			// Define the Class	public final class TimeField extends TimeFieldSprite {				private var h							:int;   						// my hour		private var m							:String;   						// my minute				private var nt							:String;						// new text, used as temp holder				private var mc_arrows					:MovieClip = new MovieClip();	// movieclip that holds scroll arrows				private var nobj						:Object = new Object();			// new object used as temp object				private var stageDelay					:Timer = new Timer(50, 1);			// timer delay for mouse event				// Instantiate the Class		public function TimeField (obj:Object = null ) : void {						TimeFieldListener.set ( { target:this, addedToStage:on_added });						// Ensure that an Object Exists - populate temp obj			obj = obj || new Object ( ); nobj = obj;			nt = nobj.time;						var st:String = nt;			var str:Array = st.split(".");			h = str[0]; m = str[1];						if ( m == "" || m == null ) m = "00";						if ( m == "5" ) m = "30";						if ( nt.substr(0, 1) == "0" ) { nt = nt.substring(1); }; nt = h + ":" + m;					}				// Proceed once added to stage		public function on_added(e:Event ):void {						// Listen for events					stageDelay.addEventListener(TimerEvent.TIMER, addMouse);			stageDelay.start();						// Initialize/Reinitialize Properties			init ( nobj );		}				private function addMouse(e:TimerEvent):void {			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseOut);			stage.addEventListener("PICKLIST_ARROW_UP", arrowUp);			stage.addEventListener("PICKLIST_ARROW_DOWN", arrowDown);			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyComplete);					}							// Initialize/Reinitialize Properties		public function init ( obj:Object = null ) : void {						// Initialize/Reinitialize Properties			for ( var n:String in obj ) if ( n in this ) this [ n ] = obj [ n ];						// Reset the Scale			scaleX = scaleY = 1;						// Draw graphics			drawGraphics();					}						//// FUNCTIONS FOR HANDLING CONTENT, CREATING UPDATING THE GRAPHICS CONTENT				private function calculateTime():void {						var st:String = nt;			var str:Array = st.split(":");			h = str[0]; m = str[1];						if ( m == "" || m == null ) m = "00";						if ( nt.substr(0, 1) == "0" ) { nt = nt.substring(1); }; nt = h + ":" + m;		}				private function drawGraphics():void {									input_bg.width = nobj.width || 100;						label_fld.htmlText = '<b>' + ( nobj.label && nobj.label + '       ' || '' );						input_fld.text = nt;			input_fld.x += label_fld.textWidth;						addChild(mc_arrows);									mc_arrows.addChild(new TimeFieldArrow({ direction:"up", x:0, y:1 }));			mc_arrows.addChild(new TimeFieldArrow({ direction:"down", x:0, y:11 }));						mc_arrows.x = nobj.width-30;					}				private function updateInput():void {			input_fld.text = nt;		}				// react to up arrow and adjust time		private function arrowUp(e:Event):void {						calculateTime();						if ( m == "30" ) { m = "00"; h++; } else { m = "30"; };						nt = String(h + ":" + m);						updateInput();				}				// react to down arrow and adjust time		private function arrowDown(e:Event):void { 					calculateTime();					if ( h > 0 ) { if ( m == "00" ) { m = "30"; h--; } else { m = "00";	} } else if ( h == 0 && m == "30" ) { m = "00";	};			nt = String(h + ":" + m);								updateInput();		}						/// respond to key commands				public function onKey(e:KeyboardEvent):void {						if (e.keyCode == 38 ) {											// up key				dispatchEvent(new Event("PICKLIST_ARROW_UP", true));			} else if (e.keyCode == 40 ) { 									// down key				dispatchEvent(new Event("PICKLIST_ARROW_DOWN", true));			} else if (e.keyCode == 13 ) { 									// enter key				closeTimeField();			}						// handle typing in the text field						var tt			:String = input_fld.text;				// text in input field			var l			:int = input_fld.length;				// length of text in input field			var c			:int = input_fld.caretIndex;			// location of the caret			var k			:int = e.keyCode;				// what key has been typed			var s			:int = (tt.search ( ":" ))+1;	// location of the semicolon						if ( k > 47 && k < 58 || k == 8 || k == 13 || k == 37 || k == 38 || k == 39 || k == 40   ) {				if ( k == 8 && s == c ) {					input_fld.setSelection( c - 1, c - 1 );					e.preventDefault();				}				// if editing the minutes, only allow the 0 and the 3 and the up and down and delete buttons				if ( c >= s ) { if ( k == 8 || k == 13 || k == 38 || k == 40 || k == 48 || k == 51 ) {					// don't allow more than two digits after the colon					if ( c == s+1 ) { if ( k == 8 || k == 13 || k == 48 ) { } else { e.preventDefault(); };};					if ( c >= s+2 ) { if ( k == 8 || k == 13 ) { } else { e.preventDefault(); };};				} else { e.preventDefault(); };};							} else {				e.preventDefault();			}		}				// handle if user selects all and deletes or writes over colon		private function onKeyComplete(e:KeyboardEvent):void {						if (  input_fld.length == 1 && input_fld.text != ":" ) { input_fld.appendText(":"); };			if ( input_fld.text == "" ) { input_fld.text = "00:00"; };						nt = input_fld.text;		}				// check to see if user clicks outside of component		private function onMouseOut(e:MouseEvent):void {			// Save a Refernece to the Target			var tar:DisplayObject = e.target as DisplayObject;			// Do Nothing If We Still Have Focus			if ( tar === this || contains ( tar ) ) return;			closeTimeField();		}				// close TimeField if user clicks outside of component		private function closeTimeField():void {						if ( m == "30" ) m = "5";						nt = h + "." + m;						dispatchEvent(new TimeFieldEvent(TimeFieldEvent.DONE, true, false, nt));			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKey);			stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseOut);			// Remove Us From the Stage			parent.removeChild ( this );		}						// End all Loops and Listeners		public function end ( evt:Event = null ) : void {			dispatchEvent ( new Event ( 'end', true ) );		}	}}