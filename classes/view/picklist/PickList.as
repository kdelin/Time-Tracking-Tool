﻿// Define the Packagepackage classes.view.picklist {		// Import Necessary Classes	import flash.filters.DropShadowFilter;	import flash.display.DisplayObject;	import flash.filters.GlowFilter;	import flash.events.Event;	import flash.display.MovieClip;	import flash.display.Stage;	import flash.events.KeyboardEvent;		import classes.view.picklist.PLArrow;	import classes.view.picklist.PLInputText;	import classes.view.picklist.PLInputHint;	import classes.view.picklist.pickListEvent;			// Define the Class	public final class PickList extends PickListSprite {				// Crate a Vector for Arrow Objects		public var upA:Vector.<Number> = new <Number> [ 0, 0, 7, 0, 3.5, 4.5 ];		public var downA:Vector.<Number> = new <Number> [ 0, 0, 7, 0, 3.5, 4.5 ];				private var rc							:int;   						// number of rows in list		private var trc							:int;   						// temp number of rows in list		private var mh							:int;	 						// height used for backround graphic		private var ih							:int = 44.5;					// height of input field			private var lh							:int = 29;						// height of list item		private var ly							:int = 23;						// list y		private var si							:int = 0;						// picklist array index for scrolling		private var tsi							:int = 0;						// temp picklist array index for scroll highlighting							private var nt							:String;						// new text, used as temp holder				private var ud							:Boolean = false;				// direction of pick list - true = up, false = down		public var mc_hint						:MovieClip = new MovieClip();	// movieclip that holds hint text		public var mc_input						:MovieClip = new MovieClip();	// movieclip that holds input text		public var mc_list						:MovieClip = new MovieClip();	// movieclip that holds pick list		public var mc_arrows_up					:MovieClip = new MovieClip();	// movieclip that holds scroll arrows		public var mc_arrows_down				:MovieClip = new MovieClip();	// movieclip that holds scroll arrows				public var nobj							:Object = new Object();			// new object used as temp object								// Instantiate the Class		public function PickList (obj:Object = null ) : void {						// Ensure that an Object Exists - populate temp obj			obj = obj || new Object ( ); nobj = obj;						// Listen for events					this.addEventListener(pickListEvent.PICKLIST_ITEM_CLICK, listItemClick);			this.addEventListener(pickListEvent.PICKLIST_INPUT_FOCUS_IN, trackKeys);			this.addEventListener("PICKLIST_ARROW_UP", arrowUp);			this.addEventListener("PICKLIST_ARROW_DOWN", arrowDown);									PLInputListener.set ( { target:this, addedToStage:on_added });					}				// Proceed once added to stage		public function on_added(e:Event ):void {						stage.addEventListener(KeyboardEvent.KEY_DOWN, onArrows);						// Create MovieClip that will house Picklist items			addChild(mc_hint);			addChild(mc_input);			addChild(mc_list);			addChild(mc_arrows_up);			addChild(mc_arrows_down);						// Create GlowFilter Object			filters = filters.concat ( new GlowFilter ( 0, 1, 3, 3, 1, 1, true, false ) );			// Create DropShadowFilter Object			filters = filters.concat ( new DropShadowFilter ( 10, 89.9993809572637, 0, 1, 20, 20, 0.09765625,3, true, false, false ) );			// Create DropShadowFilter Object			filters = filters.concat ( new DropShadowFilter ( 2, 89.9993809572637, 0, 1, 6, 6, 0.5, 3, false, false, false ) );									// set up number of rows in picklist			rc = nobj.rowInfo.length; trc = rc;						// determine if list is going up or down						if ( nobj.y > (stage.stageHeight/2)-ih ) { ud = true; };						// check list height, determine if list is too big			// if too big, set tb to true			// and create a new row count for shorter list						resizeList();										// place existing content						nt = nobj.rowInfo[nobj.index]; nt = nt.substring(1);			mc_hint.addChild(new PLInputHint({ text:nt }));			mc_input.addChild(new PLInputText({ text:nt }));						// add list items to stage						drawList();						// Initialize/Reinitialize Properties			init ( nobj );		}				// Initialize/Reinitialize Properties		public function init ( obj:Object = null ) : void {						// Initialize/Reinitialize Properties			for ( var n:String in obj ) if ( n in this ) this [ n ] = obj [ n ];						// Reset the Scale			scaleX = scaleY = 1;						// Draw graphics			drawGraphics();					}						//// FUNCTIONS FOR HANDLING CONTENT, CREATING LIST AND RESIZING THE GRAPHICS FOR THE LIST				private function removeAllItems():void { 							// REMOVE ALL LIST ITEMS AND HINT 			mc_hint.removeChildAt(0);						removeListItems();		}				private function removeListItems():void {							// REMOVE JUST THE ITEMS IN THE PICK LIST			var c:int = mc_list.numChildren;						for ( var x:int = c; x--; ) { mc_list.removeChildAt(x); };		}				private function resizeList():void {								// RESIZE THE LIST IF NEEDED AND ADD ARROWS			mh = lh*rc; 						if ( ud ) {				if ( mh > nobj.y-ih) {										mh = int(nobj.y-ih);					trc = int((nobj.y-ih)/lh)-3;					ly = ly+lh;										mc_arrows_down.addChild(new PLArrow({ direction:"down", width:nobj.width, height:lh, y:0}));					mc_arrows_up.addChild(new PLArrow({ direction:"up", width:nobj.width, height:lh, y:0}));					mc_arrows_down.y = -(ih-5);					mc_arrows_up.y = -(mh-5);								}			} else {				if ( mh > (stage.stageHeight-nobj.y)-ih) {					mh = ((stage.stageHeight-nobj.y)-(ih*2))+10;					trc = (mh/lh)-3;					ly = ly+lh;										mc_arrows_down.addChild(new PLArrow({ direction:"down", width:nobj.width, height:lh, y:0}));					mc_arrows_up.addChild(new PLArrow({ direction:"up", width:nobj.width, height:lh, y:0}));					mc_arrows_down.y = mh+5;					mc_arrows_up.y = ih+5;				}			}		}				private function drawList():void {									// CREATE PICK LIST ITEMS						var yc:int = 0;						for ( var i:int = si; i < trc+si; i++ ) {				if ( ud ) {										if ( i == tsi ) {						mc_list.addChild(new PLitem({ mw:nobj.width, y:-((ly-10)+(lh*(yc+1))), text:nobj.rowInfo[i], over:true }));					} else {						mc_list.addChild(new PLitem({ mw:nobj.width, y:-((ly-10)+(lh*(yc+1))), text:nobj.rowInfo[i], over:false }));					}				} else {										if ( i == tsi ) {						mc_list.addChild(new PLitem({ mw:nobj.width, y:ly+(lh*(yc+1)), text:nobj.rowInfo[i], over:true }));					} else {						mc_list.addChild(new PLitem({ mw:nobj.width, y:ly+(lh*(yc+1)), text:nobj.rowInfo[i], over:false }));					}				}				yc++;			}		}				private function drawGraphics():void {								// DRAW GRAPHICS FOR BACKGROUND						graphics.clear();			graphics.beginFill(0xFFFFFF);			graphics.drawRect( 0, 0, nobj.width, ih);									mc_list.graphics.beginFill(0xFFFFFF);						if ( mh < mc_list.height ) {				mh = mc_list.height + 20;			}						if ( ud ) {				mc_list.graphics.drawRect( 0, -(mh+1), nobj.width, mh );			} else {				mc_list.graphics.drawRect( 0, ih+1, nobj.width, mh );			}					}				private function trackKeys(e:pickListEvent):void {					// REBUILT THE PICK LIST AS USER TYPES IN INPUT FIELD						removeAllItems();						var a	:Array = new Array(); 							// array to hold final list			var ta	:Array = new Array();							// temp array to hold match list						var t	:String = e.content; t = t.toLowerCase();		// text from input field			var tl	:int = t.length;								// length of input field			var th	:String = "";									// hint text, used as temp holder						for ( var x:int = 0; x < rc; x++ ) {										var s:String = nobj.rowInfo[x]; s = s.substring(1); s = s.substr(0, tl); s = s.toLowerCase();								if ( t == s && t.length > 0 ) { ta.push(nobj.rowInfo[x]); };							}						if ( ta.length > 0 ) { a.push(ta[0]); };									for ( x = 0; x < rc; x++ ) { 				if ( ta[0] != nobj.rowInfo[x] ) { a.push(nobj.rowInfo[x]); };							}						for ( x = 0; x < trc; x++ ) { 				if ( x == 0 && ta.length != 0) {										// handle hint copy 					th = a[x];					th = e.content + th.substring(tl+1);										mc_hint.addChild(new PLInputHint({ text:th }));										if ( ud ) { 						mc_list.addChild(new PLitem({ mw:nobj.width, y:-((ly-10)+(lh*(x+1))), text:a[x], over:true }));					} else {						mc_list.addChild(new PLitem({ mw:nobj.width, y:ly+(lh*(x+1)), text:a[x], over:true }));					}				} else {					if ( x == 0 ) { mc_hint.addChild(new PLInputHint({ text:"" })); };										if ( ud ) {						mc_list.addChild(new PLitem({ mw:nobj.width, y:-((ly-10)+(lh*(x+1))), text:a[x], over:false }));					} else {						mc_list.addChild(new PLitem({ mw:nobj.width, y:ly+(lh*(x+1)), text:a[x], over:false }));					}				}			}						drawGraphics();		}				//// Functions for handling button and key commands						private function arrowUp(e:Event):void { if ( ud ) { listUp(); } else { listDown(); }; };				private function arrowDown(e:Event):void { if ( !ud ) { listUp(); } else { listDown(); }; }				private function arrowUp2():void { if ( ud ) { listUp2(); } else { listDown2(); }; };				private function arrowDown2():void { if ( !ud ) { listUp2(); } else { listDown2(); }; }				private function listUp():void {			if ( si < rc-trc ) { 				si++;				removeListItems();				drawList();			}		}				private function listDown():void {			if ( si > 0 ) {				si--;				removeListItems();				drawList();			}		}				private function listUp2():void {						if ( si < rc ) {				if ( si < rc-trc ) { 										si++;					tsi = si;					removeListItems();					drawList();				} else if ( tsi < rc-1 ) {					tsi++; 					removeListItems();					drawList();				}							}		}				private function listDown2():void {			if ( si >= 0 ) {								if ( tsi > si ) {										tsi--;					removeListItems();					drawList();				} else if ( tsi == 1 ) {										tsi--;					removeListItems();					drawList();				} else if ( tsi > si ) {										si--;					tsi = si;					removeListItems();					drawList();				}										}		}				/// respond to key commands				private function onArrows(e:KeyboardEvent):void {			if (e.keyCode == 38 ) { // up key				arrowUp2();			} else if (e.keyCode == 40 ) { // down key				arrowDown2();			} else if (e.keyCode == 13 ) { // enter key				enterKey();			}		}				// respond to pick list item click - replace input text				private function listItemClick(e:pickListEvent):void {			mc_input.removeChildAt(0);			nt = e.content; nt = nt.substring(1);			mc_input.addChild( new PLInputText ({ text:nt }));		}				// End all Loops and Listeners		public function end ( evt:Event = null ) : void {			dispatchEvent ( new Event ( 'end', true ) );		}	}}