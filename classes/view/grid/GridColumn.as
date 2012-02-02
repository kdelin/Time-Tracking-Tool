﻿// Define the Packagepackage classes.view.grid {	import flash.geom.Rectangle;	import flash.events.Event;		// Define the Class	internal final class GridColumn extends GridSprite {				// Crate a Vector for GridVLine Objects		public var gridvline:Vector.<GridVLine> = new <GridVLine> [ ];		// Crate a Vector for GridRow Objects		public var gridrow:Vector.<GridRow> = new <GridRow> [ ];		// Crate a Vector for GridHeader Objects		public var gridheader:Vector.<GridHeader> = new <GridHeader> [ ];		// Crate a Vector for GridColumn Objects		public var columns:Vector.<GridColumn> = new <GridColumn> [ ];		// Create a Variable for Column Index		public var index:uint = 0;		// Create a Variable for Column Data		public var Data:Object;		// Create a Variable for Calcuating Drag Distance		private var moved:Number;				// Instantiate the Class		public function GridColumn ( obj:Object ) : void {			// Initialize Properties			for ( var n:String in obj ) if ( n in this ) this [ n ] = obj [ n ];			// Reset the Scale			scaleX = scaleY = 1;			// Add a Header Row			addChild ( new GridHeader ( { content:[ new GridHeading ( { y:13, text:Data.label || '' } ) ] } ) );			// Add Remaining Rows			for ( var i:int = Data.rowVlaues; i < 15; ) addChild ( new GridRow ( { y:height, index:i++, content:[ new GridText ( { y:13 } ) ] } ) );			// Add Vertial Line			addChild ( new GridVLine ( { x:-5, height:675 } ) );			// Set/Reset Event Listeners			GridListener.set ( { target:this, startResize:do_resize, stopResize:reset_mouse,  resizeUpdate:on_move } );		}				// Set/Reset Event Listeners		private function reset_mouse ( evt:Event ) {			// Stop Resizing			stopDrag ( );		}				// React to Resize Update Events		private function on_move ( evt:Event ) {			// Save a Reference to the Distance Moved			var dif:Number = x - moved;			// Move Columns on the Right			for ( var n:int = columns.length; --n > index; ) columns [ n ].x += dif;			// Save the Current Position			moved = x;		}				// React to Start Resize Events		private function do_resize ( evt:Event ) {			// Save a Reference to the Left Column			var col:GridColumn = columns [ index - 1 ];			// Calculate Drag Area			var rec:Rectangle = new Rectangle ( col.x + 156, y, col.width, 0 );			// Save the Current Position			moved = x;			// Start Resizing			startDrag ( false, rec );		}				// Show Row Data		internal function showData ( arr:Vector.<Vector.<String>> ) : void {			// Loop through the Data Array			for each ( var row:GridRow in gridrow ) {				//				if ( row.index >= arr.length ){					//					row.gridtext [ 0 ].text = '';					//					return;				}				// Save a Refernece to Data				var data:Vector.<String> = arr [ row.index ];				// Populate Row Text				row.gridtext [ 0 ].text = String ( data [ index ] );			}		}	}}