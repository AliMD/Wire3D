/*
	Ali.MD Wire3D v1 beta
	As Simple as Possible 3D Rotation ported from Object3D.as
	by Ali Mihandoost - i@ali.md
*/

(function(window,undefined){

	!!Object.prototype.extend || (Object.prototype.extend = function(obj) {
		for(i in obj) this[i]=obj[i]; return this;
	});

	window.wire3d = function(canvas){

		//variables
		var points =[], faces = [];

		//core funcs
		function log (){
			console.log({
				points:points,
				faces:faces
			});
		} this.log = log;

		function addPoint (p3d) {
			points.push({x:0,y:0,z:0}.extend(p3d)); return this;
		} this.addPoint=addPoint;

		function addPoints (arr) {
			arr.forEach(function(point){
				addPoint(point);
			}); return this;
		} this.addPoints=addPoints;

		function addFace (points, style) {
			faces.push({
				points : points,
				style  : {
					faceColor : 'rgba(50,50,200,0.7)',
					borderWidth : 1,
					borderColor : 'rgb(0,0,0,0.9)'
				}.extend(style)
			}); return this;
		} this.addFace = addFace;

		function getVisible (p) {
			return ((p[1].x-p[0].x)*(p[2].y-p[0].y)<(p[2].x-p[0].x)*(p[1].y-p[0].y));
		}

		function drawFace (face){

		}

		this.render = function () {
			faces.forEach(function (face) {
				drawFace(face);
			}); return this;
		}

	}

})(window);

