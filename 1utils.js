/*
	Ali.MD 1Utils
	Some usefull change to js global objects
	by Ali Mihandoost - i@ali.md
*/

(function(undefined){
	// use a single debug config for all scripts ;)
	window.deBug = true;

	// add extend to Objects
	!!Object.prototype.extend || (Object.prototype.extend = function() {
		var target = this;
	    [].forEach.call(arguments,function(source) {
	      for (key in source) target[key] = source[key];
	    }); return target;
	});

	// add dec for rounds
	'round floor ceil'.split(' ').forEach(function(m){
		Math['org'+m]=Math[m];
		Math[m]=function(num,dec){
			dec=(dec>0)?Math.pow(10,dec):1;
			return Math['org'+m].call(this,num*dec)/dec;
		}
	});

	// new random with min & max
	Math.orgrandom=Math.random;
	Math.random=function(min,max,dec){
		max!=undefined || (max=min) || (min=0);// use min az max -> random(10) 0-10
		dec!=undefined || (dec=3);
		return Math.floor(Math.orgrandom() * (max - min + 1) + min,dec);
	}

	// a callibrate func for change range of numbers
	Math.getInRange=function (x, arr) {// arr = [x1,x2,y1,y2] // x is input and new y return
		return ((arr[3] - arr[2]) * (x - arr[0])) / (arr[1] - arr[0]) + arr[2];
	}

	// fix len toString
	Number.prototype.toStr=Number.prototype.toString;
	Number.prototype.toString=function(n,len,zap){ // zap : zero after point
		n   !== undefined || (n   = 10);	
		len !== undefined || (len = 1); // len befor point
		zap !== undefined || (zap = 0);

		var str = this.toStr(n),
		strlen  = str.length,
		dotpos  = str.indexOf('.');
		if(dotpos == -1 && zap>0){
			str += '.';
			dotpos = strlen;
			strlen ++;
		}

		for(var i=strlen-dotpos-1; i<zap; i++) str+='0'; // add zero after
		for(var i = dotpos!=-1?dotpos:0; i<len-strlen; i++) str='0'+str; // add zero befor
		return str;
	}

	// adv typeof
	window.isF = function (value) { return ({}).toString.call(value) == "[object Function]" }
	window.isO = function (value) { return value instanceof Object }
	window.isA = function (value) { return value instanceof Array }

	//adv interval
	window.timeloop = function (fn,fps,fpscheck,that,timerId){
		!that && (that = this);
		(fps===undefined || fps>1000) && (fps = 40);

		var targetFps = fps, delay = Math.floor(1000/fps), i = 0, now = Date.now(), last = now;
		var showfps = function(fps){
			console.log('FPS : '+fps.toString(10,2,1));
		};

		function start(){
			stop();
			(interval = function(){
				fn.call(that);
				if(fpscheck){
					i++;
					now = Date.now();
					if(now-last >= 1000){
						
						fps<1000 && ( fps += (targetFps<i?-1:1)*(Math.abs(targetFps-i)<5?0.5:4) );
						delay = Math.floor(1000/fps);
						showfps.call(that,i,fps);
						i = 0; last = now;
					}
				}
				timerId = setTimeout(interval,delay);
			})();
		} this.start = start;

		function stop(){
			if(!timerId) return this;
			clearTimeout(timerId);
			timerId = null;
			return this;
		} this.stop = stop;

		this.onFps = function(fn){
			showfps = fn;
		};

		(isF(fn) && fps>0) && start();
	}

})();