﻿// Define the Packagepackage classes.view.picklist {		// Import Necessary Classes	import flash.filters.GlowFilter;	import flash.display.Shape;	import flash.filters.DropShadowFilter;	import flash.display.*;	import flash.events.Event;		import flash.filters.DropShadowFilter;	import flash.text.TextField;	import flash.text.AntiAliasType;	import flash.text.TextFormat;	import flash.text.TextFieldType;	import flash.events.Event;	import flash.utils.setTimeout;	import flash.events.TimerEvent;	import flash.utils.Timer;		import flash.events.KeyboardEvent;			// Define the Class	internal final class PLArrow extends PickListSprite {						var Arrow						:Vector.<Number> = new Vector.<Number>();				var myArrowClip					:MovieClip = new MovieClip();				var direction					:String;							// Instantiate the Class		public function PLArrow ( obj:Object ) : void {						addChild(myArrowClip);						direction = obj.direction;						// set Event listener			PLInputListener.set ( { target:this, mouseOver:mouse_Over, mouseDown:mouse_Down, mouseOut:mouse_Out} );						// Set the Filters			myArrowClip.filters = [ new DropShadowFilter ( 1, 90, 0, 1, 1.5, 1.5, 1, 15, true, false, false ) ];						// Initialize/ReInitialize Properties			init ( obj );								}				// Initialize/ReInitialize Properties		public function init ( obj:Object ) : void {						for ( var n:String in obj ) if ( n in this ) this [ n ] = obj [ n ];						// Reset the Scale			scaleX = scaleY = 1;						if ( direction == "down" ) {				Arrow.push(((obj.width-10)/2)-8, obj.y+(obj.height/2-5), ((obj.width-10)/2)+8, obj.y+(obj.height/2-5), ((obj.width-10)/2), obj.y+(obj.height/2+5));			} else {				Arrow.push(((obj.width-10)/2)-8, obj.y+(obj.height/2+5), ((obj.width-10)/2)+8, obj.y+(obj.height/2+5), ((obj.width-10)/2), obj.y+(obj.height/2-5));			}						graphics.beginFill(0xFFFFFF);			graphics.drawRect( 10, obj.y, obj.width-20, obj.height);						myArrowClip.graphics.beginFill ( 0x999999 );			myArrowClip.graphics.drawTriangles(Arrow);		}				private function mouse_Over(e:Event):void {			this.alpha = .5;		}				private function mouse_Out(e:Event):void {			this.alpha = 1;		}				private function mouse_Down(e:Event):void {			if ( direction == "up" ) {				dispatchEvent(new Event("PICKLIST_ARROW_UP", true));			} else {				dispatchEvent(new Event("PICKLIST_ARROW_DOWN", true));			}		}	}}