﻿// Define the Packagepackage classes.view.cursor {		// Import Necessary Classes	import flash.display.Shape;	import flash.ui.Mouse;	import flash.geom.Point;	import flash.ui.MouseCursorData;	import flash.display.BitmapData;	import flash.utils.getDefinitionByName;		// Define the Class	public class Cursor {				//  Create an Array for Pre-Existing Cursors		private static var obj:Object = { auto:null, ibeam:null, hand:null, arrow:null, button:null };				// Retrieve Cursors		public static function set ( cursor:Class ) : void {			// Do Nothing if the Cursor Doesn't Exists			if ( !( 'NAME' in cursor ) ) return;			// Save a Reference to the Cursor Name			var nam:String = cursor [ 'NAME' ];			// Check that the Cursor Isn't Registered			if ( !( nam in obj ) ) {				// Instantiate the Cursor				var shp:Shape = new cursor ( );				// Create a BitmapData Object				var bmp:BitmapData = obj [ nam ] = new BitmapData ( 24, 24, true, 0 );				// Create a MouseCursorData Object				var cus:MouseCursorData = new MouseCursorData ( );				// Draw the Cursor Shape to the BitmapData 				bmp.draw ( shp );				// Associate the BitmapData to the MouseCursorData				cus.data = new <BitmapData> [ bmp ];				// Center the MouseCursorData Hotspot				cus.hotSpot = new Point ( 12.5, 12.5 );				// Register the MouseCursorData				Mouse.registerCursor ( nam, cus );			}			// Set the Mouse Cursor Accordingly			Mouse.cursor = nam;		}	}}