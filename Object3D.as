/*
	Ali.MD.Object3D.v1beta (As Simple as posible 3D Rotate in Flash)
	by Ali Mihandoost - i@ali.md
	Special tanx to Ali Vojdany for mathematical logic
*/

function Point2D(x, y) {
	this.x = x;
	this.y = y;
}

function Point3D(x, y, z) {
	this.x = x;
	this.y = y;
	this.z = z;
}

function Object3D(screenX, screenY) {
	this.screenX = screenX;
	this.screenY = screenY;
	this.D = 500;
	this.PointList = new Array();
	this.FaceList = new Array();
	this.NumPoints = 0;
	this.NumFaces = 0;
}

Object3D.prototype.AddPoint = function(x, y, z) {
	this.PointList[this.NumPoints++] = new Point3D(x, y, z);
};

Object3D.prototype.AddFace = function(FaceName, Face, Colour, Outline) {
	this.FaceList[this.NumFaces] = Face;
	this.FaceList[this.NumFaces].FaceName = FaceName;
	this.FaceList[this.NumFaces].Colour = Colour;
	this.FaceList[this.NumFaces++].Outline = Outline;
};

Object3D.prototype.DrawFace = function(Face, depth) {
	var Pt2D = new Array();
	for (var i = 0; i<Face.length; i++) {
		Pt2D[i] = new Point2D((this.D*(this.PointList[Face[i]].x/(this.PointList[Face[i]].z+this.D)))+this.screenX, (this.D*(this.PointList[Face[i]].y/(this.PointList[Face[i]].z+this.D)))+this.screenY);
	}
	if (this.getVisible(Pt2D[0], Pt2D[1], Pt2D[2])) {
		_root.createEmptyMovieClip(Face.FaceName, depth);
		tellTarget (_root[Face.FaceName]) {
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
		_root[Face.FaceName].removeMovieClip();
	}
};

Object3D.prototype.getVisible = function(p1, p2, p3) {
	return ((p2.x-p1.x)*(p3.y-p1.y)<(p3.x-p1.x)*(p2.y-p1.y));
};

Object3D.prototype.DrawObject3D = function() {
	for (var i = 0; i<this.FaceList.length; i++) {
		this.DrawFace(this.FaceList[i], i);
	}
};

Object3D.prototype.RotateObject3D = function(x, y) {
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
};

Object3D.prototype.Delete = function (){
    var i = 0;
    while (i < this.FaceList.length)
    {
        removeMovieClip(this.FaceList[i].FaceName);
        i++;
    }
};

function Stop3D(objName) {
    _root.onMouseDown = null;
    _root.onMouseMove = null;
    _root.onMouseUp = null;
    _root.onEnterFrame = null;
    this[objName].Delete();
    delete this[objName];
}

// main test

var fx;
var fy;
var gh;
var fAlpha;
var lAlpha;
var obj;
var den;
var omx;
var omy;
var xa;
var ya;
var mb;
var Render;
var FrameRate;
FrameRate = 30;
Render = true;
omx = 0;
omy = 0;
xa = 0;
ya = 0.001000;
gh = 50;
fAlpha = 20;
lAlpha = 80;
fx = 400;
fy = 275 - gh;
den = 0.980000;
mb = false;

Robj = new Object3D(fx, fy);

Robj.AddPoint(gh, -gh, gh);
Robj.AddPoint(gh, gh, gh);
Robj.AddPoint(-gh, gh, gh);
Robj.AddPoint(-gh, -gh, gh);
Robj.AddPoint(-gh, -gh, -gh);
Robj.AddPoint(-gh, gh, -gh);
Robj.AddPoint(gh, gh, -gh);
Robj.AddPoint(gh, -gh, -gh);
Robj.AddFace("Face0", [0, 1, 2, 3], 16711680, fAlpha, 16777215, lAlpha);
Robj.AddFace("Face1", [4, 5, 6, 7], 16711680, fAlpha, 16777215, lAlpha);
Robj.AddFace("Face2", [7, 6, 1, 0], 16711680, fAlpha, 16777215, lAlpha);
Robj.AddFace("Face3", [6, 5, 2, 1], 16711680, fAlpha, 16777215, lAlpha);
Robj.AddFace("Face4", [5, 4, 3, 2], 16711680, fAlpha, 16777215, lAlpha);
Robj.AddFace("Face5", [4, 7, 0, 3], 16711680, fAlpha, 16777215, lAlpha);
Robj.RotateObject3D(0, 0.800000);

gh = gh * 1.200000;
xup = -20;

Robj.AddPoint(gh, -gh + xup, gh);
Robj.AddPoint(gh, -gh + xup, -gh);
Robj.AddPoint(-gh, -gh + xup, -gh);
Robj.AddPoint(-gh, -gh + xup, gh);
Robj.AddPoint(0, 2 * gh, 0);
Robj.AddFace("Face6", [12, 8, 9], 255, fAlpha, 16777215, lAlpha);
Robj.AddFace("Face7", [12, 9, 10], 255, fAlpha, 16777215, lAlpha);
Robj.AddFace("Face8", [12, 10, 11], 255, fAlpha, 16777215, lAlpha);
Robj.AddFace("Face9", [12, 11, 8], 255, fAlpha, 16777215, lAlpha);
Robj.AddFace("Face10", [11, 10, 9, 8], 255, fAlpha, 16777215, lAlpha);

// Events
_root.onEnterFrame = function () {
    xa = (fy - _root._ymouse) / 1500;
    ya = (_root._xmouse - fx) / 1500;
    Render = true;
};

_root.onMouseDown = function () {
    mb = true;
    ya = 0;
    xa = 0;
    omx = _root._xmouse;
    omy = _root._ymouse;
    _root.onEnterFrame = null;
};

_root.onMouseMove = function () {
    if (mb)
    {
        ya = (_root._xmouse - omx) / 35;
        xa = (omy - _root._ymouse) / 35;
        Render = true;
        omx = _xmouse;
        omy = _ymouse;
    }
};

_root.onMouseUp = function () {
    mb = false;
    _root.onEnterFrame = function (){
        if (Math.abs(xa) < 0.000100 && Math.abs(ya) < 0.000100){
            _root.onEnterFrame = null;
        } // end if
        xa = xa * den;
        ya = ya * den;
        Render = true;
    };
};


// Action of Frame 1 
stop();

dl.onRelease = function () {
    Stop3D("Robj");
};

RobjFr = setInterval(function () {
    if (Render){
        Robj.RotateObject3D(xa, ya);
        Robj.DrawObject3D();
        Render = false;
    }
}, 1000 / FrameRate);
