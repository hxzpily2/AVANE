package views.client {
	import com.tuarua.ffprobe.Probe;
	
	import events.FormEvent;
	
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	import views.forms.Stepper;
	
	public class PicturePanel extends Sprite {
		private var wStppr:Stepper;
		private var hStppr:Stepper;
		private var holder:Sprite = new Sprite();
		private var txtHolder:Sprite = new Sprite();
		private var sourceLbl:TextField = new TextField(400,32,"", "Fira Sans Semi-Bold 13", 13, 0xD8D8D8);
		private var wLbl:TextField = new TextField(60,32,"Width:", "Fira Sans Semi-Bold 13", 13, 0xD8D8D8);
		private var hLbl:TextField = new TextField(60,32,"Height:", "Fira Sans Semi-Bold 13", 13, 0xD8D8D8);
		private var _probe:Probe;
		public function PicturePanel() {
			super();
			
			sourceLbl.vAlign = hLbl.vAlign = wLbl.vAlign = VAlign.TOP;
			sourceLbl.hAlign = hLbl.hAlign = wLbl.hAlign = HAlign.LEFT;
			sourceLbl.touchable = hLbl.touchable = wLbl.touchable = false;
			sourceLbl.batchable = hLbl.batchable = wLbl.batchable = true;
			
			sourceLbl.x = 50;
			sourceLbl.y = 37;
			wLbl.y = hLbl.y = 70;
			
			wStppr = new Stepper(65,String(0),4,2);
			
			wStppr.addEventListener(FormEvent.CHANGE,onFormChange);
			wStppr.x = 100;
			
			wLbl.x = wStppr.x - 50;
			

			hStppr = new Stepper(65,String(0),4,2);
			hStppr.addEventListener(FormEvent.CHANGE,onFormChange);
			hStppr.x = 250;
			wStppr.y = hStppr.y = 67;
			hStppr.enable(false);
			
			hLbl.alpha = 0.25;
			hLbl.x = hStppr.x - 50;
			
			holder.addChild(wStppr);
			holder.addChild(hStppr);
			
			addChild(holder);
			
			addChild(sourceLbl);
			txtHolder.addChild(wLbl);
			txtHolder.addChild(hLbl);
			addChild(txtHolder);
			txtHolder.flatten();
			
		}
		public function update(probe:Probe):void {
			_probe = probe;
			wStppr.value = probe.videoStreams[0].width;
			wStppr.maxValue = probe.videoStreams[0].width;
			hStppr.value = probe.videoStreams[0].height;
			
			sourceLbl.text = "Source:  " + probe.videoStreams[0].width + "x" + probe.videoStreams[0].height + ",     Aspect ratio:  " + probe.videoStreams[0].displayAspectRatio;
			
		}
		private function onFormChange(event:FormEvent):void {
			var test:int;
			switch(event.currentTarget){
				case wStppr:
					var n:Number = event.params.value / _probe.videoStreams[0].width;
					var hProposed:int = Math.floor(_probe.videoStreams[0].height * n);
					hStppr.value = hProposed;
					break;
			}
		}
		
		public function getResize():Object {
			var obj:Object;
			if(wStppr.value != _probe.videoStreams[0].width){
				obj = new Object();
				obj.width = wStppr.value;
				obj.height = hStppr.value;
			}
			return obj;
		}
		
		public function freeze():void {
			wStppr.freeze();
			hStppr.freeze();
		}
		public function unfreeze():void {
			wStppr.unfreeze();
			hStppr.unfreeze();
		}
	}
}