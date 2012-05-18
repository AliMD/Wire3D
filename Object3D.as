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
