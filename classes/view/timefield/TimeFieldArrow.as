﻿// Define the Packagepackage classes.view.timefield {		// Import Necessary Classes	import flash.filters.DropShadowFilter;	import flash.display.MovieClip;	import flash.events.Event;			// Define the Class	internal final class TimeFieldArrow extends TimeFieldSprite {						var Arrow						:Vector.<Number> = new Vector.<Number>();				var myArrowClip					:MovieClip = new MovieClip();				var direction					:String;							// Instantiate the Class		public function TimeFieldArrow ( obj:Object ) : void {						addChild(myArrowClip);						myArrowClip.buttonMode = false;			myArrowClip.mouseEnabled = false;						direction = obj.direction;						this.buttonMode = true;						// set Event listener			TimeFieldListener.set ( { target:this, mouseOver:mouse_Over, mouseDown:mouse_Down, mouseOut:mouse_Out} );						// Set the Filters			myArrowClip.filters = [ new DropShadowFilter ( 1, 90, 0, 1, 1.5, 1.5, 1, 15, true, false, false ) ];						// Initialize/ReInitialize Properties			init ( obj );								}				// Initialize/ReInitialize Properties		public function init ( obj:Object ) : void {						for ( var n:String in obj ) if ( n in this ) this [ n ] = obj [ n ];						// Reset the Scale			scaleX = scaleY = 1;						if ( direction == "down" ) {				Arrow.push(	obj.x+10, obj.y+4, obj.x+22, obj.y+4, obj.x+16, obj.y+10);			} else {				Arrow.push(	obj.x+10, obj.y+18, obj.x+22, obj.y+18, obj.x+16, obj.y+12);			}						graphics.beginFill(0xFFFFFF);			graphics.drawRect( obj.x+0, obj.y+0, 34, 20);						myArrowClip.graphics.beginFill ( 0x999999 );			myArrowClip.graphics.drawTriangles(Arrow);		}				private function mouse_Over(e:Event):void {			this.alpha = .5;		}				private function mouse_Out(e:Event):void {			this.alpha = 1;		}				private function mouse_Down(e:Event):void {			if ( direction == "up" ) {				dispatchEvent(new Event("PICKLIST_ARROW_UP", true));			} else {				dispatchEvent(new Event("PICKLIST_ARROW_DOWN", true));			}		}	}}