﻿// Define the Packagepackage classes.view.grid {		// Import Necessary Classes	import flash.globalization.DateTimeFormatter;	import flash.globalization.LocaleID;		// Define the Class	internal dynamic final class GridColumnData extends Array {				// Define Default Arguments		internal const arg:Object = { columnLabels: [ ], index:0, columnFormats: [ ], picklistData: [ ], rowData: [ [ ] ], columnWidths: [ ] };		// Craete a DateTimeFormatter Object		private const fmt:DateTimeFormatter = new DateTimeFormatter ( LocaleID.DEFAULT ); 		// Create a Varianble for the Column Aliases		public var aliases:Array = [ ];		// Create a Varianble for the Column Label		public var heading:String = '';		// Create a Varianble for the Column Format		public var format:String;		// Create a Varianble for the Column Position		public var x:Number = 0;				// Instantiate the Class		public function GridColumnData ( obj:Object ) : void {			// Limit Enumeration			for ( var i:String in this ) this.setPropertyIsEnumerable ( i, false );			// Initialize Arguments			for ( i in obj ) if ( i in arg ) arg [ i ] = obj [ i ];			// Setup the Pattern for Date Formats			fmt.setDateTimePattern ( 'MM/dd/yy hh:mm a z' );			// Save a Reference to the Column Heading			heading = arg.columnLabels [ arg.index ];			// Save a Reference to the Column Format			format = arg.columnFormats [ arg.index ];			// Save a Reference to Aliases			if ( format === 'picklist' ) aliases = arg.picklistData.pop ( ) || [ ];			// Save a Reference to the Number of Rows			length = arg.rowData.length;			// Save a Reference to the Array of Column Widths			var arr:Array = arg.columnWidths;			// Convert Column Width into Column Position;			for ( var n:int = arg.index; n; ) x += arr [ --n ] ? Math.max ( 156, arr [ n ] ) : 0;			// Loop through Column Data			for ( n = length; n--; ) {				// Create an Object for Column Data				var row:Object = this [ n ] = { };				// Save a Reference to the Cell Format				row.format = format;				// Save a Reference to the Row Index				row.index = n;				// Save a Reference to the Row Value				row.value = arg.rowData [ n ][ arg.index ];				// Overwrite the Object's toString Function				row.toString = function ( ) : String {					// Return the Appropriate Alias According to the Value					if ( aliases.length ) return String ( aliases [ this.value ] || '' );					// Check that the Format is Hours					if ( format === 'hours' ) {						// Save a Referecen to the Value						var val:Number = Number ( this.value );						// Return the Value in Hours:Minutes Format						return ( ( int ( val ) * .1 ).toFixed ( 1 ) + ':' + ( int ( ( val - int ( val ) ) * 60 ) * .1 ).toFixed ( 1 ) ).replace ( /\./g, '' );					}					// Return the Value in Date Format					if ( format === 'date' ) return fmt.format ( new Date ( this.value ) );					// Return the Raw Value					return String ( this.value );				};			}		}	}}