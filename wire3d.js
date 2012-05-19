/*
	Ali.MD Wire3D v1
	As Simple as Possible Pure Native Javascript 3D Rotation.
	Fork me : ali.md/wire3d
	by Ali Mihandoost - i@ali.md
*/

(function(window,undefined){
	window.wire3d = function(config){
		// variables
		config = {
			dof    : 900,
			log    : true,
			canvas : 'canvas3d',
			wallhk : false,
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
			mospos = {},
			stage  = {
				width   : cnv.width,
				height  : cnv.height,
				context : cnv.getContext('2d')
			};

		this.stage = stage;
		this.mousePos = mospos;

		config.center.x=='c' && (config.center.x=stage.width/2);
		config.center.y=='c' && (config.center.y=stage.height/2);
		mospos.extend(config.center);
			
		//core funcs
		function log (){
			console.log('Ali.MD Wire3D v1 beta :tr', config, stage); // change me if you dont like :troll
		} this.log = log;
		config.log && this.log();

		function addPoints (p) { // addPints([{x:10,y:0,z:0},{x:0,y:10,z:0}])
			( isA(p) && isO(p[0]) ) || (p = [p]); // addPints({x:10,y:0,z:0})
			p.forEach(function(p){
				isA(p) && ( p = {x:p[0], y:p[1], z:p[2]} );
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

		function resetStyle (fn){
			isF(fn) || (fn=function(){
				return {
					lineWidth : 1,
					strokeStyle : 'rgb(0,0,0,0.9)',
					fillStyle : 'rgba(50,50,200,0.7)'
				};
			});
			styles.length = 0;
			faces.forEach(function(f){
				addStyles(fn.call(this,f));
				f.s = styles.length-1;
			});
		} this.resetStyle = resetStyle;

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

			return config.wallhk || ((p[1].x-p[0].x)*(p[2].y-p[0].y)<(p[2].x-p[0].x)*(p[1].y-p[0].y));
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
						x : Math.round(dof*p3d.x/(p3d.z+dof),1),
						y : Math.round(dof*p3d.y/(p3d.z+dof),1)
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

		function r2d(r){ // radian to degree
			return r*Math.PI/180;
		}

		function rotate(r, rad) {
			r = {x:0, y:0}.extend(r);
			rad || (r = {x:r2d(r.x), y:r2d(r.y)})
			points.forEach(function(p){
				var n = {};
				n.z = p.z*Math.cos(r.x)-p.y*Math.sin(r.x);
				n.x = p.x*Math.cos(r.y)-n.z*Math.sin(r.y);
				n.y = p.y*Math.cos(r.x)+p.z*Math.sin(r.x);
				n.z = p.x*Math.sin(r.y)+n.z*Math.cos(r.y);
				p.extend(n);
			}); return this;
		} this.rotate = rotate;

		function rotateTo(p, sp) {
			sp = sp===undefined ? 0.01 : sp/100;
			p={}.extend(config.center,p);
			rotate({
				x : (config.center.y-p.y)*sp,
				y : (p.x-config.center.x)*sp
			}); return this;
		} this.rotateTo = rotateTo;

		function rotateToMouse (sp){
			rotateTo(mospos,sp); return this;
		} this.rotateToMouse=rotateToMouse;

		cnv.onmousemove=function(evt){
			mospos.extend({
				x: evt['offsetX'] ? evt.offsetX : evt.layerX,
				y: evt['offsetY'] ? evt.offsetY : evt.layerY
			});
		};
	}
})(window);

