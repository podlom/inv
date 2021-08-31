enum State{
	WAIT = 1,
	LOADING,
	DONE,
}

interface Script{
	name: string;
	url?: string;
	content?: string;
	require?: string[];
}

var _js = function(name:string,url:string,content?:string,require?:string[]):Script{
	return {name,url,content,require};
};

const head = <HTMLHeadElement>(document.head || document.getElementsByTagName('head')[0]);
export class AsyncLoader{

	private _wait:Script[]=[];
	private _ready: String[]=[];


	constructor(){
		this._update = this._update.bind(this);
	}
	
	add(s:Script){
		this._wait.push(s);
	}

	init(async){
		async.map(
			s=>this.add(_js.call(this, ...s))
		);
		this._update();
	}


	styles(styles){
	    const links = Array.prototype.slice.call(head.getElementsByTagName('link')).map(l=>l.href);
	    styles.map(s=>{
	    	if(links.indexOf(s)!=-1)
	    		return;
	    	let l = <HTMLLinkElement>document.createElement('link');
	        l.rel = 'stylesheet';
            l.crossOrigin = 'anonymous';
	        l.href = s;
	        return head.appendChild(l);
	    })
	}

	isLoaded(name:string){
		return this._ready.indexOf(name)!=-1;
	}

    load(source:Script|string, callback:()=>void){
        let script:Script;
        if(typeof(source)=="string"){
            script = {name:source, url:source};
        } else {
            script = source;
        }
    	let idx = this._wait.indexOf(script);
    	if(idx != -1)
    		this._wait.splice(idx,1);
        if(script.name && this._ready.indexOf(script.name)!=-1)
            return callback();
        if(script.url){
	        let s = <HTMLScriptElement>document.createElement('script');
	        head.appendChild(s);
	        s.async=true;
            s.onload = ()=>{
                if(script.name)
                    this._trigger(script.name);
                callback();
            };
            s.setAttribute('data-name', script.name);
            s.src = script.url;
        } else if(script.content) {
        	try{
        		let f = new Function(script.content);
        		f();
                if(script.name)
                    this._trigger(script.name);
        		callback();
        	} catch (e){
        		console.error('Error loading script', script);
        	}
            callback();
        } else console.error('Error loading script', script);
    }

    private _update(){
    	let load = this._wait.filter(s => !s.require || s.require.length == 0);
    	this._wait = this._wait.filter(s => s.require && s.require.length > 0);
    	load.map(s=>this.load(s,this._update));
    }

    private _trigger(n:string){
    	this._ready.push(n);
    	this._wait.map(s=>{
    		if(!s.require)
    			return;
    		let idx = s.require.indexOf(n);
    		if(idx != -1)
    			s.require.splice(idx,1);
    	});
    }

}


window['loader'] = new AsyncLoader;
if(window['styles']){
    window['styles']=window['loader'].styles(window['styles']);
    delete window['styles'];
}
if(window['async']){
    window['loader'].init(window['async']);
    delete window['async'];
}