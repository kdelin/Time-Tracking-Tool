﻿// Define the Packagepackage classes.view.grid {		// Import Necessary Classes	import flash.events.Event;		// Define the Class	internal dynamic class GridEvent extends Event {				// Instantiate the Class		public function GridEvent ( obj:Object ) : void {			// Run Super Instantiation Function			super ( obj.type, true, true );			// Initialize Remainind Properties			for ( var n:String in obj ) if ( !( n in this ) ) this [ n ] = obj [ n ];		}				// Override the toString Function		public override function toString ( ) : String {			// Create an Array for Name Value Pairs			var arr:Array = [ ];			// Record All Properties and their Values			for ( var n:String in this ) arr [ arr.length ] = n + '=' + this [ n ];			// Return a Report of All Properties and their Values;			return '{ ' + arr.join ( ', ' ) + ' }';		}	}}