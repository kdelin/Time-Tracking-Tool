﻿// Define the Packagepackage classes.view.grid {		// Import Necessary Classes	import flash.filters.DropShadowFilter;	import flash.display.DisplayObject;	import flash.filters.GlowFilter;		// Define the Class	internal final class GridRail extends GridSprite {				// Instantiate the Class		public function GridRail ( obj:Object ) : void {			// Initialize Properties			for ( var n:String in obj ) if ( n in this ) this [ n ] = obj [ n ];			// Reset the Scale			scaleX = scaleY = 1;			// Add Content			for each ( var i:DisplayObject in obj.content ) addChild ( i );			// Create DropShadowFilter Object			filters = filters.concat ( new DropShadowFilter ( 5, 90, 0xFFFFFF, 1, 0, 5, .3, 3, true, false, false ) );			// Create GlowFilter Object			filters = filters.concat ( new GlowFilter ( 0, 1, 0, 3, 1, 1, true, false ) );			// Define Background Color			graphics.beginFill ( 0x686868 );			// Draw a Rectangle			graphics.drawRect ( 0, 0, obj.width || 780, obj.height || 20 );		}	}}