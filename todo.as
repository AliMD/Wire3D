// not ported to js yet !

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
