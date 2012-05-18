// not ported to js yet !


function RotateByMouse(speed) {
	this.RotateTo(_root._xmouse,_root._ymouse,speed);
}

function LoadObj(LV:LoadVars) {
	var Cn:Boolean = true;
	for (i=0; Cn; i++) {
		var Point:Array = LV["P"+i.toString()].split(",");
		this.AddPoint(Point[0]*10,Point[1]*10,Point[2]*10);
		if (String(LV["P"+String(i+1)]) == "undefined") {
			Cn = false;
			delete Point;
		}
	}
	Cn = true;
	for (i=0; Cn; i++) {
		var Face:Array = LV["F"+i.toString()].split(",");
		this.AddFace("Face"+i.toString(),Face.slice(0, 3),0x0000c0,80,0xffffff,80,2,Face.slice(3, 6));
		if (String(LV["F"+String(i+1)]) == "undefined") {
			Cn = false;
			delete Face;
		}
	}
}
// Sample Code
function CetSmpObj(Num:Number, gh:Number, fAlpha:Number, lAlpha:Number, thickness:Number) {
	switch (Num) {
		case 0 :
			this.AddPoint(gh,-gh,gh);
			this.AddPoint(gh,gh,gh);
			this.AddPoint(-gh,gh,gh);
			this.AddPoint(-gh,-gh,gh);
			this.AddPoint(-gh,-gh,-gh);
			this.AddPoint(-gh,gh,-gh);
			this.AddPoint(gh,gh,-gh);
			this.AddPoint(gh,-gh,-gh);
			this.AddFace("Face0",[0, 1, 2, 3],16711680,fAlpha,16777215,lAlpha,thickness);
			this.AddFace("Face1",[4, 5, 6, 7],16711680,fAlpha,16777215,lAlpha,thickness);
			this.AddFace("Face2",[7, 6, 1, 0],16711680,fAlpha,16777215,lAlpha,thickness);
			this.AddFace("Face3",[6, 5, 2, 1],16711680,fAlpha,16777215,lAlpha,thickness);
			this.AddFace("Face4",[5, 4, 3, 2],16711680,fAlpha,16777215,lAlpha,thickness);
			this.AddFace("Face5",[4, 7, 0, 3],16711680,fAlpha,16777215,lAlpha,thickness);
			this.Rotate(0,0.8);
			gh = gh*1.2;
			var xup:Number = -20;
			this.AddPoint(gh,-gh+xup,gh);
			this.AddPoint(gh,-gh+xup,-gh);
			this.AddPoint(-gh,-gh+xup,-gh);
			this.AddPoint(-gh,-gh+xup,gh);
			this.AddPoint(0,2*gh,0);
			this.AddFace("Face6",[12, 8, 9],255,fAlpha,16777215,lAlpha,thickness);
			this.AddFace("Face7",[12, 9, 10],255,fAlpha,16777215,lAlpha,thickness);
			this.AddFace("Face8",[12, 10, 11],255,fAlpha,16777215,lAlpha,thickness);
			this.AddFace("Face9",[12, 11, 8],255,fAlpha,16777215,lAlpha,thickness);
			this.AddFace("Face10",[11, 10, 9, 8],255,fAlpha,16777215,lAlpha,thickness);
			break;
		case 1 :
			this.AddPoint(gh,-gh,gh);
			this.AddPoint(gh,-gh,-gh);
			this.AddPoint(-gh,-gh,-gh);
			this.AddPoint(-gh,-gh,gh);
			this.AddPoint(0,2*gh,0);
			this.AddFace("Face0",[4, 0, 1],0x00ff00,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face1",[4, 1, 2],0x00ff00,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face2",[4, 2, 3],0x00ff00,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face3",[4, 3, 0],0x00ff00,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face4",[3, 2, 1, 0],0x00ff00,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.Rotate(0,.5);
			break;
		case 2 :
			this.AddPoint(-gh/2,0,gh+gh/2);
			this.AddPoint(-gh/2,-gh,gh);
			this.AddPoint(-gh/2,-gh-gh/2,0);
			this.AddPoint(-gh/2,-gh,-gh);
			this.AddPoint(-gh/2,0,-gh-gh/2);
			this.AddPoint(-gh/2,gh,-gh);
			this.AddPoint(-gh/2,gh+gh/2,0);
			this.AddPoint(-gh/2,gh,gh);
			this.AddPoint(gh/2,0,gh+gh/2);
			this.AddPoint(gh/2,-gh,gh);
			this.AddPoint(gh/2,-gh-gh/2,0);
			this.AddPoint(gh/2,-gh,-gh);
			this.AddPoint(gh/2,0,-gh-gh/2);
			this.AddPoint(gh/2,gh,-gh);
			this.AddPoint(gh/2,gh+gh/2,0);
			this.AddPoint(gh/2,gh,gh);
			this.AddFace("Face0",[0, 1, 9, 8],0xff9900,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face1",[1, 2, 10, 9],0xffcc00,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face2",[2, 3, 11, 10],0xff9900,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face3",[3, 4, 12, 11],0xffcc00,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face4",[4, 5, 13, 12],0xff9900,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face5",[5, 6, 14, 13],0xffcc00,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face6",[6, 7, 15, 14],0xff9900,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face7",[7, 0, 8, 15],0xffcc00,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face8",[8, 9, 10, 11, 12, 13, 14, 15],0xcc0000,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face9",[7, 6, 5, 4, 3, 2, 1, 0],0xcc3300,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.Rotate(0,.5);
			break;
		case 3 :
			this.AddPoint(-gh,0,gh+gh/2);
			this.AddPoint(-gh,-gh,gh);
			this.AddPoint(-gh,-gh-gh/2,0);
			this.AddPoint(-gh,-gh,-gh);
			this.AddPoint(-gh,0,-gh-gh/2);
			this.AddPoint(-gh,gh,-gh);
			this.AddPoint(-gh,gh+gh/2,0);
			this.AddPoint(-gh,gh,gh);
			this.AddPoint(gh,0,gh+gh/2);
			this.AddPoint(gh,-gh,gh);
			this.AddPoint(gh,-gh-gh/2,0);
			this.AddPoint(gh,-gh,-gh);
			this.AddPoint(gh,0,-gh-gh/2);
			this.AddPoint(gh,gh,-gh);
			this.AddPoint(gh,gh+gh/2,0);
			this.AddPoint(gh,gh,gh);
			this.AddFace("Face0",[0, 1, 9, 8],0xcf9c00,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face1",[1, 2, 10, 9],0xcfcf00,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face2",[2, 3, 11, 10],0xcf9c00,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face3",[3, 4, 12, 11],0xcfcf00,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face4",[4, 5, 13, 12],0x9f9c00,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face5",[5, 6, 14, 13],0x9fcf00,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face6",[6, 7, 15, 14],0x9f9c00,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face7",[7, 0, 8, 15],0x9fcf00,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face8",[8, 9, 10, 11, 12, 13, 14, 15],0xCCCC00,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face9",[7, 6, 5, 4, 3, 2, 1, 0],0xCCCC11,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.Rotate(0,.5);
			break;
		default :
			this.AddPoint(gh,-gh,gh);
			this.AddPoint(gh,gh,gh);
			this.AddPoint(-gh,gh,gh);
			this.AddPoint(-gh,-gh,gh);
			this.AddPoint(-gh,-gh,-gh);
			this.AddPoint(-gh,gh,-gh);
			this.AddPoint(gh,gh,-gh);
			this.AddPoint(gh,-gh,-gh);
			this.AddFace("Face0",[0, 1, 2, 3],0xff0000,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face1",[4, 5, 6, 7],0xffff00,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face2",[7, 6, 1, 0],0x0000ff,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face3",[6, 5, 2, 1],0xff00ff,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face4",[5, 4, 3, 2],0x00ffff,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.AddFace("Face5",[4, 7, 0, 3],0x00ff00,fAlpha,0xFFFFFF,lAlpha,thickness);
			this.Rotate(0,.5);
	}
}