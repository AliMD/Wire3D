/*
	Ali.MD.Object3D.v2 light
	As Simple as Posible 3D Rotation Class in Flash
	by Ali Mihandoost - i@ali.md
	Special tanx to Ali Vojdany for mathematical logic
*/

dynamic class Object3D {
	// Variables
	private var rbm:Boolean = false;
	// rbm = Rotate By Mouse
	private var MovieClip_name:String;
	private var otn:Number = 10098;
	static var Object3D_MC_Index:Number = 0;
	// Constructor function
	function Point2D(x, y) {
		this.x = x;
		this.y = y;
	}
	function Point3D(x, y, z) {
		this.x = x;
		this.y = y;
		this.z = z;
	}
	function AddPoint(x, y, z) {
		this.PointList[this.NumPoints++] = new Point3D(x, y, z);
	}
	function AddFace(FaceName, Face, fColour, fAlpha, lColour, lAlpha, thickness) {
		this.FaceList[this.NumFaces] = Face;
		this.FaceList[this.NumFaces].FaceName = FaceName;
		this.FaceList[this.NumFaces].fColour = fColour;
		this.FaceList[this.NumFaces].fAlpha = fAlpha;
		this.FaceList[this.NumFaces].lColour = lColour;
		this.FaceList[this.NumFaces].thickness = thickness;
		this.FaceList[this.NumFaces++].lAlpha = lAlpha;
	}
	function DrawFace(Face, depth) {
		var Pt2D = new Array();
		for (var i = 0; i<Face.length; i++) {
			Pt2D[i] = new Point2D((this.D*(this.PointList[Face[i]].x/(this.PointList[Face[i]].z+this.D))), (this.D*(this.PointList[Face[i]].y/(this.PointList[Face[i]].z+this.D))));
		}
		if (this.getVisible(Pt2D[0], Pt2D[1], Pt2D[2])) {
			_root[this.MovieClip_name].createEmptyMovieClip(Face.FaceName, depth);
			tellTarget (_root[this.MovieClip_name][Face.FaceName]) {
				beginFill(Face.fColour, Face.fAlpha);
				lineStyle(Face.thickness, Face.lColour, Face.lAlpha);
				moveTo(Pt2D[0].x, Pt2D[0].y);
				for (var i = 1; i<Face.length; i++) {
					lineTo(Pt2D[i].x, Pt2D[i].y);
				}
				lineTo(Pt2D[0].x, Pt2D[0].y);
				endFill();
			}
		} else {
			_root[this.MovieClip_name][Face.FaceName].removeMovieClip();
		}
	}
	function Object3D(X:Number, Y:Number) {
		this.MovieClip_name = "Object3D_MC"+Object3D_MC_Index.toString();
		_root.createEmptyMovieClip(this.MovieClip_name, Object3D_MC_Index);
		_root[this.MovieClip_name]._x = X;
		_root[this.MovieClip_name]._y = Y;
		st = About();
		tn = 0;
		for (i=0; i<st.length; i++) {
			tn += Number(st.charCodeAt(i));
		}
		if (tn<>otn) {
			this.Clear();
			this.MovieClip_name = "";
			delete st;
		}
		this.D = 500;
		this.PointList = new Array();
		this.FaceList = new Array();
		this.NumPoints = 0;
		this.NumFaces = 0;
		if (Object3D_MC_Index == 0) {
			trace(st);
		}
		Object3D_MC_Index++;
	}
	function getVisible(p1, p2, p3) {
		return ((p2.x-p1.x)*(p3.y-p1.y)<(p3.x-p1.x)*(p2.y-p1.y));
	}
	function Render() {
		for (var i = 0; i<this.FaceList.length; i++) {
			this.DrawFace(this.FaceList[i], i);
		}
	}
	function Rotate(x, y) {
		for (var i = 0; i<this.PointList.length; i++) {
			var px = this.PointList[i].x;
			var py = this.PointList[i].y;
			var pz = this.PointList[i].z;
			var temp_y = py*Math.cos(x)+pz*Math.sin(x);
			var temp_z1 = pz*Math.cos(x)-py*Math.sin(x);
			var temp_x = px*Math.cos(y)-temp_z1*Math.sin(y);
			var temp_z = px*Math.sin(y)+temp_z1*Math.cos(y);
			this.PointList[i] = new Point3D(temp_x, temp_y, temp_z);
		}
	}
	function RotateTo(px, py) {
		x = (_root[this.MovieClip_name]._y-py)/1500;
		y = (px-_root[this.MovieClip_name]._x)/1500;
		this.Rotate(x, y);
	}
	function RotateByMouse() {
		this.RotateTo(_root._xmouse, _root._ymouse);
	}
	function Clear() {
		_root[this.MovieClip_name].removeMovieClip();
		_root.createEmptyMovieClip(this.MovieClip_name, Object3D_MC_Index);
		this.PointList = new Array();
		this.FaceList = new Array();
		this.NumPoints = 0;
		this.NumFaces = 0;
	}
	function LoadObj(LV:LoadVars) {
		var Cn:Boolean = true;
		for (i=0; Cn; i++) {
			var Point:Array = LV["P"+i.toString()].split(",");
			this.AddPoint(Point[0]*10, Point[1]*10, Point[2]*10);
			if (String(LV["P"+String(i+1)]) == "undefined") {
				Cn = false;
				delete Point;
			}
		}
		Cn = true;
		for (i=0; Cn; i++) {
			var Face:Array = LV["F"+i.toString()].split(",");
			this.AddFace("Face"+i.toString(), Face.slice(0, 3), 0x3366FF, 80, 0x111111, 80, 4);
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
			this.AddPoint(gh, -gh, gh);
			this.AddPoint(gh, gh, gh);
			this.AddPoint(-gh, gh, gh);
			this.AddPoint(-gh, -gh, gh);
			this.AddPoint(-gh, -gh, -gh);
			this.AddPoint(-gh, gh, -gh);
			this.AddPoint(gh, gh, -gh);
			this.AddPoint(gh, -gh, -gh);
			this.AddFace("Face0", [0, 1, 2, 3], 16711680, fAlpha, 16777215, lAlpha, thickness);
			this.AddFace("Face1", [4, 5, 6, 7], 16711680, fAlpha, 16777215, lAlpha, thickness);
			this.AddFace("Face2", [7, 6, 1, 0], 16711680, fAlpha, 16777215, lAlpha, thickness);
			this.AddFace("Face3", [6, 5, 2, 1], 16711680, fAlpha, 16777215, lAlpha, thickness);
			this.AddFace("Face4", [5, 4, 3, 2], 16711680, fAlpha, 16777215, lAlpha, thickness);
			this.AddFace("Face5", [4, 7, 0, 3], 16711680, fAlpha, 16777215, lAlpha, thickness);
			this.Rotate(0, 0.8);
			gh = gh*1.2;
			var xup:Number = -20;
			this.AddPoint(gh, -gh+xup, gh);
			this.AddPoint(gh, -gh+xup, -gh);
			this.AddPoint(-gh, -gh+xup, -gh);
			this.AddPoint(-gh, -gh+xup, gh);
			this.AddPoint(0, 2*gh, 0);
			this.AddFace("Face6", [12, 8, 9], 255, fAlpha, 16777215, lAlpha, thickness);
			this.AddFace("Face7", [12, 9, 10], 255, fAlpha, 16777215, lAlpha, thickness);
			this.AddFace("Face8", [12, 10, 11], 255, fAlpha, 16777215, lAlpha, thickness);
			this.AddFace("Face9", [12, 11, 8], 255, fAlpha, 16777215, lAlpha, thickness);
			this.AddFace("Face10", [11, 10, 9, 8], 255, fAlpha, 16777215, lAlpha, thickness);
			break;
		case 1 :
			this.AddPoint(gh, -gh, gh);
			this.AddPoint(gh, -gh, -gh);
			this.AddPoint(-gh, -gh, -gh);
			this.AddPoint(-gh, -gh, gh);
			this.AddPoint(0, 2*gh, 0);
			this.AddFace("Face0", [4, 0, 1], 0x00ff00, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face1", [4, 1, 2], 0x00ff00, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face2", [4, 2, 3], 0x00ff00, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face3", [4, 3, 0], 0x00ff00, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face4", [3, 2, 1, 0], 0x00ff00, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.Rotate(0, .5);
			break;
		case 2 :
			this.AddPoint(-gh/2, 0, gh+gh/2);
			this.AddPoint(-gh/2, -gh, gh);
			this.AddPoint(-gh/2, -gh-gh/2, 0);
			this.AddPoint(-gh/2, -gh, -gh);
			this.AddPoint(-gh/2, 0, -gh-gh/2);
			this.AddPoint(-gh/2, gh, -gh);
			this.AddPoint(-gh/2, gh+gh/2, 0);
			this.AddPoint(-gh/2, gh, gh);
			this.AddPoint(gh/2, 0, gh+gh/2);
			this.AddPoint(gh/2, -gh, gh);
			this.AddPoint(gh/2, -gh-gh/2, 0);
			this.AddPoint(gh/2, -gh, -gh);
			this.AddPoint(gh/2, 0, -gh-gh/2);
			this.AddPoint(gh/2, gh, -gh);
			this.AddPoint(gh/2, gh+gh/2, 0);
			this.AddPoint(gh/2, gh, gh);
			this.AddFace("Face0", [0, 1, 9, 8], 0xff9900, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face1", [1, 2, 10, 9], 0xffcc00, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face2", [2, 3, 11, 10], 0xff9900, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face3", [3, 4, 12, 11], 0xffcc00, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face4", [4, 5, 13, 12], 0xff9900, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face5", [5, 6, 14, 13], 0xffcc00, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face6", [6, 7, 15, 14], 0xff9900, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face7", [7, 0, 8, 15], 0xffcc00, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face8", [8, 9, 10, 11, 12, 13, 14, 15], 0xcc0000, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face9", [7, 6, 5, 4, 3, 2, 1, 0], 0xcc3300, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.Rotate(0, .5);
			break;
		case 3 :
			this.AddPoint(-gh, 0, gh+gh/2);
			this.AddPoint(-gh, -gh, gh);
			this.AddPoint(-gh, -gh-gh/2, 0);
			this.AddPoint(-gh, -gh, -gh);
			this.AddPoint(-gh, 0, -gh-gh/2);
			this.AddPoint(-gh, gh, -gh);
			this.AddPoint(-gh, gh+gh/2, 0);
			this.AddPoint(-gh, gh, gh);
			this.AddPoint(gh, 0, gh+gh/2);
			this.AddPoint(gh, -gh, gh);
			this.AddPoint(gh, -gh-gh/2, 0);
			this.AddPoint(gh, -gh, -gh);
			this.AddPoint(gh, 0, -gh-gh/2);
			this.AddPoint(gh, gh, -gh);
			this.AddPoint(gh, gh+gh/2, 0);
			this.AddPoint(gh, gh, gh);
			this.AddFace("Face0", [0, 1, 9, 8], 0xcf9c00, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face1", [1, 2, 10, 9], 0xcfcf00, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face2", [2, 3, 11, 10], 0xcf9c00, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face3", [3, 4, 12, 11], 0xcfcf00, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face4", [4, 5, 13, 12], 0x9f9c00, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face5", [5, 6, 14, 13], 0x9fcf00, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face6", [6, 7, 15, 14], 0x9f9c00, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face7", [7, 0, 8, 15], 0x9fcf00, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face8", [8, 9, 10, 11, 12, 13, 14, 15], 0xCCCC00, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face9", [7, 6, 5, 4, 3, 2, 1, 0], 0xCCCC11, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.Rotate(0, .5);
			break;
		default :
			this.AddPoint(gh, -gh, gh);
			this.AddPoint(gh, gh, gh);
			this.AddPoint(-gh, gh, gh);
			this.AddPoint(-gh, -gh, gh);
			this.AddPoint(-gh, -gh, -gh);
			this.AddPoint(-gh, gh, -gh);
			this.AddPoint(gh, gh, -gh);
			this.AddPoint(gh, -gh, -gh);
			this.AddFace("Face0", [0, 1, 2, 3], 0xff0000, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face1", [4, 5, 6, 7], 0xffff00, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face2", [7, 6, 1, 0], 0x0000ff, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face3", [6, 5, 2, 1], 0xff00ff, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face4", [5, 4, 3, 2], 0x00ffff, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.AddFace("Face5", [4, 7, 0, 3], 0x00ff00, fAlpha, 0xFFFFFF, lAlpha, thickness);
			this.Rotate(0, .5);
		}
	}
	// Method to return property values
	function get MovieClipName():String {
		return this.MovieClip_name;
	}
	function set MovieClipName(Name:String) {
		this.MovieClip_name = Name;
	}
	function About():String {
		return ("Ali.MD.Object3D.v2b light\nAs Simple as Posible 3D Rotation Class in Flash\nby Ali Mihandoost - i@ali.md\nSpecial tanx to Ali Vojdany for mathematical logic");
	}
}
