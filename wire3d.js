/*
	Ali.MD Wire3D v1 beta
	As Simple as Possible 3D Rotation ported from Object3D.as
	by Ali Mihandoost - i@ali.md
*/

(function(window,undefined){
	// global useful functions
	!!Object.prototype.extend || (Object.prototype.extend = function(obj) {
		for(i in obj) this[i]=obj[i]; return this;
	});

	function isF(value) { return ({}).toString.call(value) == "[object Function]" }
	function isO(value) { return value instanceof Object }
	function isA(value) { return value instanceof Array }

	window.wire3d = function(config){
		// variables
		config = {
			dof    : 500,
			canvas : 'canvas3d',
			log : true,
			data : {
				points : [],
				styles : [],
				faces  : []
			}.extend(config.data)
		}.extend(config);

		this.data = config.data;

		var points = this.data.points,
			styles = this.data.styles,
			faces  = this.data.faces,
			cnv    = document.getElementById(config.canvas),
			stage  = {width : cnv.width, height:cnv.height},
			ctx    = cnv.getContext('2d'); this.ctx = ctx;
		//core funcs
		function log (){
			console.log('Ali.MD Wire3D v1 beta :tr', config, this.data, ctx); // change me if you dont like :troll
		} this.log = log;
		config.log && this.log();

		function addPoints (p) {
			isA(p) || (p = [p]);
			p.forEach(function(p){
				points.push({
					x:0, y:0, z:0
				}.extend(p));
			}); return this;
		} this.addPoints=addPoints;

		function addStyles (s){
			isA(s) || (s = [s]);
			s.forEach(function(s){
				styles.push({
					borderWidth : 1,
					borderColor : 'rgb(0,0,0,0.9)',
					faceColor : 'rgba(50,50,200,0.7)'
				}.extend(s));
			}); return this;
		} this.addStyles = addStyles;

		function addFaces (f){ // addFaces([{p:[0,1,2],s:1},{p:[1,2,0],s:1}]);
			( isA(f) && ( isO(f[0]) || isA(f[0]) ) ) || (f = [f]); // addFace({p:[0,1,2],s:1})
			f.forEach(function(f){
				isA(f) && (f={p:f}); // addFaces([0,1,2]) or addFaces([[0,1,2],[1,2,0]]);
				faces.push({
					p : [0,0,0], // points index
					s : 0 // style index
				}.extend(f));
			}); return this;
		} this.addFaces = addFaces;

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

		function clear(){
			ctx.clearRect(0,0,stage.width,stage.height);
		} this.clear = clear;

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

