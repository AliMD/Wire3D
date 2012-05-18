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
			log    : true,
			canvas : 'canvas3d',
			center : {
				x : 'c',
				y : 'c'
			}.extend(config.center),
			data   : {
				points : [],
				styles : [],
				faces  : []
			}.extend(config.data)
		}.extend(config); this.config = config;

		var points = config.data.points,
			styles = config.data.styles,
			faces  = config.data.faces,
			cnv    = document.getElementById(config.canvas),
			stage  = {
				width   : cnv.width,
				height  : cnv.height,
				context : cnv.getContext('2d')
			}; this.stage = stage;

			config.center.x=='c' && (config.center.x=stage.width/2);
			config.center.y=='c' && (config.center.y=stage.height/2);

		//core funcs
		function log (){
			console.log('Ali.MD Wire3D v1 beta :tr', config, stage); // change me if you dont like :troll
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
					lineWidth : 1,
					strokeStyle : 'rgb(0,0,0,0.9)',
					fillStyle : 'rgba(50,50,200,0.7)'
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

		function drawFaces (f){
			f!==undefined || (f = faces);
			//isA(f) || (f=[f]);
			f.forEach(function (f,inx) {
				// 3d -> 2d
				var p2d = [], // 2d points array of this face
					style = styles[f.s],
					dof = config.dof;
				f.p.forEach(function(n){
					p3d = points[n]; // 3d point obj of this face's point (n)
					p2d.push({
						x : (dof*p3d.x/(p3d.z+dof)),
						y : (dof*p3d.y/(p3d.z+dof))
					});
				});
				if(p2d.length<3 || !faceVisible(p2d)) return this;
				//draw face
				with(stage.context){
					beginPath();
					moveTo(p2d[0].x,p2d[0].y);
					for(var i=1;i<p2d.length;i++){
						lineTo(p2d[i].x,p2d[i].y);
					}
					closePath();
					strokeStyle = style.strokeStyle;
					lineWidth   = style.lineWidth;
					fillStyle   = style.fillStyle;
					fill();
					style.lineWidth>0 && stroke();
				}
				config.log && console.log('Draw face '+inx, p2d)
			}); return this;
		}

		function render(noclear) {
			noclear || clear();
			stage.context.save();
			stage.context.translate(config.center.x,config.center.y);
			drawFaces();
			stage.context.restore();
		} this.render = render;

		function clear(){
			stage.context.clearRect(0,0,stage.width,stage.height);
		} this.clear = clear;

		function r2d(r){
			// radian to degree
			return r*Math.PI/180;
		}

		function rotate(r, deg) {
			r = {x:0, y:0}.extend(r);
			deg && (r = {x:r2d(r.x), y:r2d(r.y)})
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

