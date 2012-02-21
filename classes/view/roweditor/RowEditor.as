﻿ // Define the Packagepackage classes.view.roweditor {		// Import Necessary Classes	import flash.display.Sprite;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.globalization.DateTimeFormatter;	import flash.globalization.LocaleID;	import flash.text.TextField;	import flash.display.DisplayObject;	import flash.filters.DropShadowFilter;		// Define the Class	public final class RowEditor extends Sprite {				// Save a Reference to a DropShadowFilter for Hilighting		private var sdw:DropShadowFilter = new DropShadowFilter ( 2, 89.9993809572637, 0, 1, 6, 6, 0.5, 3, false, false, false );		// Create DateTimeFormatter Object for Date Time Format		private var dte:DateTimeFormatter = new DateTimeFormatter ( LocaleID.DEFAULT );		// Create a Variable for Field Inputs		private var npt:Vector.<TextField>;		// Create a Variable for Field Labels		private var lbl:Vector.<TextField>;		// Create a Variable for Field Sprites		private var fld:Vector.<Sprite>;		// Create a Variable for Field Picklists		private var lst:Array = [ ];		// Create a Variable for Field Types		private var typ:Vector.<Function> = new <Function> [ ];				// Instantiate the Class		public function RowEditor ( obj:Object ) : void {			// Setup Date Time Format Pattern			dte.setDateTimePattern ( 'MM/dd/yy h:00 a z' );			// Save a Reference to All Field Sprites			fld = new <Sprite> [ input1_mc, input2_mc, input3_mc, input4_mc, input5_mc, input6_mc, input7_mc, input8_mc, input9_mc ];			// Save a Reference to All Field Inputs			npt = new <TextField> [ input1_mc.input_fld, input2_mc.input_fld, input3_mc.input_fld, input4_mc.input_fld, input5_mc.input_fld, input6_mc.input_fld, input7_mc.input_fld, input8_mc.input_fld, input9_mc.input_fld ];			// Save a Reference to All Field Labels			lbl = new <TextField> [ input1_mc.label_fld, input2_mc.label_fld, input3_mc.label_fld, input4_mc.label_fld, input5_mc.label_fld, input6_mc.label_fld, input7_mc.label_fld, input8_mc.label_fld, input9_mc.label_fld ];			// Save a Reference to Field Picklist Options			lst = obj.lists as Array || [ ];			// Save a Reference to All Field Types			var arr:Array = obj.formats as Array || [ ];			// Make Functions for Formating Data			for ( var n:int = typ.length = arr.length; n--; ) typ [ n ] = do_type ( arr [ n ] );			// Lock Vecors for Optimized Iteration			fld.fixed = npt.fixed = lbl.fixed = typ.fixed = true;			// Save a Reference to the Labels			var lbs:Array = obj.labels as Array || [ ];			// Save a Reference to the Values			var vls:Array = obj.values as Array || [ ];			//  Save a Referece to the Maximum Number of Fields			var max:int =  min ( fld.length - 1, lbs.length );			// Position the Lower Hirizontal Line			line_mc.y = fld [ max - 1 ].y + 60;			// Position the Close Button			close_btn.y = line_mc.y + 20;			// Set the Background Height			bg_mc.height = close_btn.y + 55;			// Set the Y Position			x = ( 800 - width ) * .5;			// Set the Y Position			y = ( 800 - height ) * .5;			// Loop through the Fields			for ( n = fld.length; n--; ) {				// Check that There's No Data for the Field				if ( !( fld [ n ].visible = n < max ) ) continue;				// Dsiplay the Appropriate Label				lbl [ n ].htmlText = '<b>' +  ( lbs [ n ] || '' ) + '          ';				// Dsiplay the Appropriate Value				npt [ n ].text = typ [ n ] ( vls [ n ] );				// Position the Field Input Appropriately				npt [ n ].x += lbl [ n ].textWidth;				// Set the Field Input Width				npt [ n ].width -= lbl [ n ].textWidth;				// Prevent Errant Mouse Events				fld [ n ].mouseChildren = false;			}			// Listen for Added to Stage Event			addEventListener ( Event.ADDED_TO_STAGE, on_added );		}				// React to Added to Stage Event		private function on_added ( evt:Event ) : void {			// Listen for Mouse Down Event			stage.addEventListener ( MouseEvent.MOUSE_DOWN, on_down, false, 0, true );		}				// React to Mouse Down Event		private function on_down ( evt:MouseEvent ) : void {			// Save a Reference to the Event Target			var tar:DisplayObject = evt.target as DisplayObject;			// Close the Editor			if ( tar === close_btn || !contains ( tar ) ) parent.removeChild ( this );		}				// Make Functions for Formating Data		private function do_type ( typ:String ) : Function {			// Check that the Type is Hours			if ( typ === 'hours' ) {				// Return a Function for Formating Hours				return function ( num:Number ) : String {					// Save a Refernece to the Hours as an Integer					var hrs:int = int ( num );					// Return the Formated Hours and Minutes					return ( ( hrs * .1 ).toFixed ( 1 ) + ':' + ( int ( ( num - hrs ) * 60 ) * .1 ).toFixed ( 1 ) ).replace ( /\./g, '' );				}			}			// Return a Function for Formating Dates			if ( typ === 'date' ) return function ( mil:Number ) : String { return dte.format ( new Date ( mil ) ) };			// Check that the Type is Picklist			if ( typ === 'picklist' ) {				// Save a Reference to the Picklist Options				var als:Array = lst.shift ( ) || [ ];				// Return a Function for Formatiing Picklists				return function ( ndx:int ) : String { return als [ ndx ] || '' };			}			// Return a Function for Formatiing Text			return function ( val:Object = '' ) : String { return val.toString ( ) };		}				// Calculate Math.min But Faster		private function min ( a:Number, b:Number ) : Number { return a < b ? a : b }	}}