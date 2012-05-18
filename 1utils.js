/*
	Ali.MD 1Utils
	Some usefull change to js global objects
	by Ali Mihandoost - i@ali.md
*/

(function(undefined){
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
	Number.prototype.toString=function(n,len){
		len!=undefined || (len=1);
		n!=undefined || (n=10);
		var str = this.toStr(n);
		while(str.length<len) str='0'+str;
		return str;
	}

	// adv typeof
	window.isF = function (value) { return ({}).toString.call(value) == "[object Function]" }
	window.isO = function (value) { return value instanceof Object }
	window.isA = function (value) { return value instanceof Array }

	//adv interval
	window.timeloop = function (fn,fps,that,timerId){
		!that && (that = this);
		(isF(fn) && fps>0) && start();
		function start(){
			stop();
			(interval = function(){
				fn.call(that);
				timerId = setTimeout(interval,fps);
			})();
		} this.start = start;

		function stop(){
			if(!timerId) return this;
			clearTimeout(timerId);
			timerId = null;
			return this;
		}
	}

})();