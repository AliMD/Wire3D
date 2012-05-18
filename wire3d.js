/*
	Ali.MD Wire3D v1 beta
	As Simple as Possible 3D Rotation ported from Object3D.as
	by Ali Mihandoost - i@ali.md
*/

(function(window,undefined){

	!!Object.prototype.extend || (Object.prototype.extend = function(obj) {
		for(i in obj) this[i]=obj[i]; return this;
	});

	window.wire3d = function(config){

		//variables
		config = {
			dof    : 500,
			canvas : 'canvas3d'
		}.extend(config);

		var points = [], faces = [];

		//core funcs
		function log (){
			console.log({
				points:points,
				faces:faces
			});
		} this.log = log;

		function addPoint (p3d) {
			points.push({x:0, y:0, z:0}.extend(p3d)); return this;
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

		function faceVisible (p) {
			return ((p[1].x-p[0].x)*(p[2].y-p[0].y)<(p[2].x-p[0].x)*(p[1].y-p[0].y));
		}

		function drawFace (face){

		}

		function render() {
			faces.forEach(function (face) {
				drawFace(face);
			}); return this;
		} this.render = render;

		function rotate(r) {
			r = {x:0,y:0}.extend(r);
			points.forEach(function(p,i){
				var n = points[i]; //byref
				n.z = p.z*Math.cos(r.x) - p.y*Math.sin(r.x);
				n.x = p.x*Math.cos(r.y) - n.z*Math.sin(r.y);
				n.y = p.y*Math.cos(r.x) + p.z*Math.sin(r.x);
				n.z = p.x*Math.sin(r.y) + n.z*Math.cos(r.y);
			}); return this;
		} this.rotate = rotate;

	}

})(window);

