
// ** Ali.MD.Object3D.v2light (A Light Class for 3D Rotation in Flash) **
// ** This Class and Algoritm Developed by Ali Mihan Doust **
// ** and many tanks to Ali Vojdany for helping me in math formulas **

dynamic class Ali.MD.Object3D.v2light.wireframe {
	// Variables
	private var Root:MovieClip; 
	private var rbm:Boolean = false;// rbm = Rotate By Mouse
	private var NumPoints:Number = 0;
	private var MovieClip_name:String;
	static var Object3D_MC_Index:Number = 0;
	//master fuction
	function wireframe(X:Number, Y:Number,rootmc:MovieClip) {
		if (!rootmc) rootmc=_root;
		this.Root=rootmc
		this.MovieClip_name = "Object3D_MC"+Object3D_MC_Index.toString();
		this.Root.createEmptyMovieClip(this.MovieClip_name,Object3D_MC_Index);
		this.Root[this.MovieClip_name]._x = X;
		this.Root[this.MovieClip_name]._y = Y;
		this.D = 500;
		this.PointList = new Array();
		this.FaceList = new Array();
		this.NumPoints = 0;
		this.NumFaces = 0;
		Object3D_MC_Index++;
	}
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
		this.PointList[this.NumPoints] = new Point3D(x, y, z);
		return this.NumPoints++;
	}
	function AddFace(FaceName, Face, fColour, fAlpha, lColour, lAlpha, thickness, DrawLine) {
		this.FaceList[this.NumFaces] = Face;
		this.FaceList[this.NumFaces].FaceName = FaceName;
		this.FaceList[this.NumFaces].fColour = fColour;
		this.FaceList[this.NumFaces].fAlpha = fAlpha;
		this.FaceList[this.NumFaces].lColour = lColour;
		this.FaceList[this.NumFaces].thickness = thickness;
		this.FaceList[this.NumFaces].DrawLine = DrawLine;
		this.FaceList[this.NumFaces++].lAlpha = lAlpha;
	}
	function DrawFace(Face, depth) {
		var Pt2D = new Array();
		for (var i = 0; i<Face.length; i++) {
			Pt2D[i] = new Point2D((this.D*(this.PointList[Face[i]].x/(this.PointList[Face[i]].z+this.D))), (this.D*(this.PointList[Face[i]].y/(this.PointList[Face[i]].z+this.D))));
		}
		this.Root[this.MovieClip_name].createEmptyMovieClip(Face.FaceName,depth);
		tellTarget (this.Root[this.MovieClip_name][Face.FaceName]) {
			moveTo(Pt2D[0].x,Pt2D[0].y);
			for (var i = 1; i<Pt2D.length; i++) {
				if (Face.DrawLine[i-1] == 0) {
					lineStyle();
				} else {
					lineStyle(Face.thickness,Face.lColour,Face.lAlpha,false,"none","none","bevel");
				}
				lineTo(Pt2D[i].x,Pt2D[i].y);
			}
		}
	}
	function getVisible(p1, p2, p3) {
		return ((p2.x-p1.x)*(p3.y-p1.y)<(p3.x-p1.x)*(p2.y-p1.y));
	}
	function Render() {
		for (var i = 0; i<this.FaceList.length; i++) {
			this.DrawFace(this.FaceList[i],i);
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
	function RotateTo(px, py, speed) {
		speed = speed/5000;
		x = (this.Root[this.MovieClip_name]._y-py)*speed;
		y = (px-this.Root[this.MovieClip_name]._x)*speed;
		this.Rotate(x,y);
	}
	function RotateByMouse(speed) {
		this.RotateTo(_root._xmouse,_root._ymouse,speed);
	}
	function Clear() {
		this.Root[this.MovieClip_name].removeMovieClip();
		this.Root.createEmptyMovieClip(this.MovieClip_name,Object3D_MC_Index);
		this.PointList = new Array();
		this.FaceList = new Array();
		this.NumPoints = 0;
		this.NumFaces = 0;
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

	// Method to return property values
	function get Movie_Clip():String {
		return this.Root[this.MovieClip_name];
	}
	function get MovieClipName():String {
		return this.MovieClip_name;
	}
	function set MovieClipName(Name:String) {
		this.MovieClip_name = Name;
	}
	function get PointsLen():Number {
		return this.NumPoints;
	}
	function set PointsLen(tmp) {
		trace("PointsLen Property is ReadOnly .");
	}
	function About():String {
		return " ** Ali.MD.Object3D.v2light (A Light Class for 3D Rotation in Flash) **\n ** This Class and Algoritm Developed by Ali Mihan Doust **\n ** and many tanks to Ali Vojdany for helping me in math formulas **";
	}
}