package org.poly2tri.visual_test {
	import flash.display.MovieClip;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.utils.setInterval;

    public class VisualTest extends MovieClip {
		protected var visiblePolygonTest:VisiblePolygonTest;

        public function VisualTest() {
			visiblePolygonTest = new VisiblePolygonTest();
			addChild(visiblePolygonTest);
			visiblePolygonTest.x = stage.stageWidth / 2;
			visiblePolygonTest.y = stage.stageHeight / 2;
			visiblePolygonTest.scaleY = visiblePolygonTest.scaleX = 0.9;
			visiblePolygonTest.cacheAsBitmap = true;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }
		
		protected function onEnterFrame(e:Event):void {
			visiblePolygonTest.rotationZ += (1 / this.stage.frameRate) * 100;
		}
    }
}
