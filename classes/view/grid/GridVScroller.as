﻿// Define the Packagepackage classes.view.grid {		// Import Necessary Classes	import flash.filters.GlowFilter;	import flash.display.Shape;	import flash.display.DisplayObject;	import flash.geom.Rectangle;	import flash.events.Event;		// Define the Class	internal final class GridVScroller extends GridSprite {						// Define Default Arguments		internal const arg:Object = { width: 10, height: 135, scroll:0, data: { totalRows:0, visibleRows:3 } };		// Crate a Vector for GridSlider Objects		public var gridslider:Vector.<GridSlider> = new <GridSlider> [ ];				// Instantiate the Class		public function GridVScroller ( obj:Object ) : void {			// Show Slider			addChild ( new GridSlider ( { blurX:0 } ) );			// Initialize Properties			init ( obj );			// Set the GlowFilter			filters = filters.concat ( new GlowFilter ( 0, 1, 3, 3, 0.796875, 3, true, false ) );			// Listen for Events			GridListener.set ( { target:this, vScroll:on_scroll } );		}				// Initialize/Reinitialize Properties		public override function on_init ( ) : void {			// Clear Graphics			graphics.clear ( );			// Define Background Color			graphics.beginFill ( 0xBDBDBD );			// Draw an Rectangle			graphics.drawRect ( 0, 0, arg.width, arg.height );			// Calculate Slider Size			var siz:Number = Math.max ( 0, Math.min ( 1, arg.data.visibleRows / arg.data.totalRows ) ) * height;			// Calculate Slider Gap			var gap:Number = height - siz;			// Update Slider			gridslider [ 0 ].init ( { height:siz, y:gap * arg.scroll, visible:!!gap, drag:new Rectangle ( 0, 0, 0, gap ) } );		}				// React to Drag Event		private function on_scroll ( evt:GridEvent ) : void {			// Save a Reference to the Scroll Position			evt.scroll = Math.ceil ( evt.scroll * ( arg.data.totalRows - .99 - arg.data.visibleRows ) );		}	}}