﻿// Define the Packagepackage classes.view.picklist {		import flash.events.Event;		public class pickListEvent extends Event {		/// set up custom events		public static const PICKLIST_ITEM_OVER				:String = "Pick List Item Over";		public static const PICKLIST_ITEM_OUT				:String = "Pick List Item Out";		public static const PICKLIST_ITEM_CLICK				:String = "Pick List Item Selected";				public static const PICKLIST_INPUT_FOCUS_IN			:String = "Pick List Input Text In Focus";		public static const PICKLIST_INPUT_FOCUS_OUT		:String = "Pick List Input Text Out Focus";				public static const PICKLIST_INPUT_HINT				:String = "Pick List Input Text Hint";				// set up vars		public var content									:String;						public function pickListEvent(type:String, bubbles:Boolean, cancelable:Boolean, content:String):void {			super(type, bubbles, cancelable);			this.content = content;		}				override public function clone():Event {			return new pickListEvent(this.type, this.bubbles, this.cancelable, this.content);		}		override	 public function toString():String {			return formatToString("pickListEvent","type","bubbles","cancelable","eventPhase","content");		}	}			}