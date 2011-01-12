package org.poly2tri {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import org.poly2tri.Edge;
	import org.poly2tri.Point;
	import org.poly2tri.Sweep;
	import org.poly2tri.SweepContext;
	import org.poly2tri.Triangle;

	public class VisiblePolygon {
		protected var sweepContext:SweepContext;
		protected var sweep:Sweep;
		protected var triangulated:Boolean;

		public function VisiblePolygon() {
			this.reset();
		}
		
		public function addPolyline(polyline:Vector.<Point>):void {
			this.sweepContext.addPolyline(polyline);
		}

		public function addHole(polyline:Vector.<Point>):void {
			this.sweepContext.addHole(polyline);
		}

		public function reset():void {
			this.sweepContext = new SweepContext();
			this.sweep = new Sweep(sweepContext);
			this.triangulated = false;
		}
		
		protected function performTriangulationOnce():void {
			if (this.triangulated) return;
			this.triangulated = true;
			this.sweep.triangulate();
		}
		
		static public function parseVectorPoints(str:String, dx:Number = 0.0, dy:Number = 0.0):Vector.<Point> {
			var points:Vector.<Point> = new Vector.<Point>();
			for each (var xy_str:String in str.split(',')) {
				var xyl:Array = xy_str.replace(/^\s+/, '').replace(/\s+$/, '').split(' ');
				points.push(new Point(parseFloat(xyl[0]) + dx, parseFloat(xyl[1]) + dy));
			}
			return points;
		}
		
		public function drawShape(g:Graphics):void {
			var t:Triangle;
			var pl:Vector.<Point>;
			
			performTriangulationOnce();
			for each (t in this.sweepContext.triangles) {
				pl = t.points;
				g.beginFill(0xFF0000);
				{
					g.moveTo(pl[0].x, pl[0].y);
					g.lineTo(pl[1].x, pl[1].y);
					g.lineTo(pl[2].x, pl[2].y);
					g.lineTo(pl[0].x, pl[0].y);
				}
				g.endFill();
			}
			
			g.lineStyle(1, 0x0000FF, 1);
			for each (t in this.sweepContext.triangles) {
				pl = t.points;
				g.moveTo(pl[0].x, pl[0].y);
				g.lineTo(pl[1].x, pl[1].y);
				g.lineTo(pl[2].x, pl[2].y);
				g.lineTo(pl[0].x, pl[0].y);
			}
			
			g.lineStyle(2, 0x00FF00, 1);
			for each (var e:Edge in this.sweepContext.edge_list) {
				g.moveTo(e.p.x, e.p.y);
				g.lineTo(e.q.x, e.q.y);
			}
		}
	}

}