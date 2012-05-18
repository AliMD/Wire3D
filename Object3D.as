/*
	Ali.MD.Object3D.v2b light
	As Simple as Posible 3D Rotation Class in Flash
	by Ali Mihandoost - i@ali.md
	Special tanx to Ali Vojdany for mathematical logic
*/

dynamic class Object3D {
	// Variables
	private var MovieClip_name:String;
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
	function AddFace(FaceName, Face, Colour, Outline) {
		this.FaceList[this.NumFaces] = Face;
		this.FaceList[this.NumFaces].FaceName = FaceName;
		this.FaceList[this.NumFaces].Colour = Colour;
		this.FaceList[this.NumFaces++].Outline = Outline;
	}
	function DrawFace(Face, depth) {
		var Pt2D = new Array();
		for (var i = 0; i<Face.length; i++) {
			Pt2D[i] = new Point2D((this.D*(this.PointList[Face[i]].x/(this.PointList[Face[i]].z+this.D))), (this.D*(this.PointList[Face[i]].y/(this.PointList[Face[i]].z+this.D))));
		}
		if (this.getVisible(Pt2D[0], Pt2D[1], Pt2D[2])) {
			_root[this.MovieClip_name].createEmptyMovieClip(Face.FaceName, depth);
			tellTarget (_root[this.MovieClip_name][Face.FaceName]) {
				beginFill(Face.Colour, 100);
				if (Face.Outline) {
					lineStyle(0, 0x000000, 100);
				}
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
		if (tn<>10098) {
			this.MovieClip_name = "";
			delete st;
		}
		this.D = 500;
		this.PointList = new Array();
		this.FaceList = new Array();
		this.NumPoints = 0;
		this.NumFaces = 0;
		Object3D_MC_Index++;
		trace(st);
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
	// Sample Code
	function CreateSampleObject(Num:Number) {
		switch (Num) {
		case 1 :
			this.AddPoint(gh, -gh, gh);
			this.AddPoint(gh, -gh, -gh);
			this.AddPoint(-gh, -gh, -gh);
			this.AddPoint(-gh, -gh, gh);
			this.AddPoint(0, 2*gh, 0);
			this.AddFace("Face0", [4, 0, 1], 0x00ff00, true);
			this.AddFace("Face1", [4, 1, 2], 0x0000ff, true);
			this.AddFace("Face2", [4, 2, 3], 0xffff00, true);
			this.AddFace("Face3", [4, 3, 0], 0xff0000, true);
			this.AddFace("Face4", [3, 2, 1, 0], 0x00ffff, true);
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
			this.AddFace("Face0", [0, 1, 9, 8], 0xff9900, true);
			this.AddFace("Face1", [1, 2, 10, 9], 0xffcc00, true);
			this.AddFace("Face2", [2, 3, 11, 10], 0xff9900, true);
			this.AddFace("Face3", [3, 4, 12, 11], 0xffcc00, true);
			this.AddFace("Face4", [4, 5, 13, 12], 0xff9900, true);
			this.AddFace("Face5", [5, 6, 14, 13], 0xffcc00, true);
			this.AddFace("Face6", [6, 7, 15, 14], 0xff9900, true);
			this.AddFace("Face7", [7, 0, 8, 15], 0xffcc00, true);
			this.AddFace("Face8", [8, 9, 10, 11, 12, 13, 14, 15], 0xcc0000, true);
			this.AddFace("Face9", [7, 6, 5, 4, 3, 2, 1, 0], 0xcc3300, true);
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
			this.AddFace("Face0", [0, 1, 2, 3], 0xff0000, true);
			this.AddFace("Face1", [4, 5, 6, 7], 0xffff00, true);
			this.AddFace("Face2", [7, 6, 1, 0], 0x0000ff, true);
			this.AddFace("Face3", [6, 5, 2, 1], 0xff00ff, true);
			this.AddFace("Face4", [5, 4, 3, 2], 0x00ffff, true);
			this.AddFace("Face5", [4, 7, 0, 3], 0x00ff00, true);
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
