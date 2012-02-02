﻿// Define the Packagepackage classes.view.inputfield {		// Import Necessary Classes	import flash.filters.DropShadowFilter;	import flash.text.TextField;	import flash.text.AntiAliasType;	import flash.text.TextFormat;	import flash.text.TextFieldType;	import flash.events.Event;	import flash.utils.setTimeout;	import flash.sampler.NewObjectSample;	// Define the Class	internal class InputText extends TextField {				// Instantiate the Class		public function InputText ( obj:Object = null ) : void {			// Ensure that an Object Exists			obj = obj || { }			// Set the Text Format			defaultTextFormat = new TextFormat ( 'Arial', 13, 0x333333, false, false, false, null, null, 'left', 19, 0, 0, -1 );			// Set Event Listeners			InputListener.set ( { target:this, focusOut:on_blur } );			// Set Anti-Alias Property			antiAliasType = AntiAliasType.ADVANCED;			// Set Type			type = TextFieldType.INPUT;			// Allow Double Clicks			doubleClickEnabled = true;			// Prevent Multiple Lines			multiline = false;			// Set the Width			width = obj.width || 200;			// Set the Height			height = obj.width || 45;			// Set the Top Position			y = obj.y || 0;			// Specify the Use of Embeded Fonts			embedFonts = true;			// Initialize/ReInitialize Properties			init ( obj );		}				// Initialize/ReInitialize Properties		public function init ( obj:Object ) : void {			// Initialize/Reinitialize Properties			for ( var n:String in obj ) if ( n in this ) this [ n ] = obj [ n ];		}				// React to Focus Out Events		private function on_blur ( evt:Event ) : void {			// Dispatch a Blur Event			dispatchEvent ( new Event ( 'blur', true ) );		}				// Override the Text Property		public override function set text ( val:String ) : void {			// Only Change Text when Necessary			if ( val !== null && typeof val !== 'undefined' && val != super.text ) super.text = '\n' + val;			trace ( htmlText )		}	}}