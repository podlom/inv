import {createElement} from 'react';
import {render} from 'react-dom';
//import Components from './Components';
let Components = {};

interface ChildDefination{
    name: string;
    props: any;
    children?: ChildDefination[];
}

interface ComponentDefination extends ChildDefination{
    id:string;
    instance?:Element;
}



let ctx = {};
let _readDefination = function(name: string, props: any, children?: any[]):ChildDefination{
    if(children)
        children = children.map((d)=>_readDefination.call(ctx, ...d));
    return {name,props,children};
}

let getType = function(name:string){
    return new Promise((s,f)=>{
        let path = name.split('.');
        //direct laod
        try{
            let type = path.reduce((c,i)=>c[i],Components);
            console.log('f', type);
            if(typeof(type)=='function'){
                type = type();
                console.log('g', type);
            }
            if(typeof(type.then)=='function'){
                return type.then(s);
            } else {
                console.log('direct', type);
                return s(type);
            }
        } catch (e){}
        //lazy module load
        let n = name.replace(/\./g, '/');
        console.log('lazy', n);
        import(`./${n}`).then(comp=>{
            s(comp.default);
        });
    });
}

let createComponent = function(c:ComponentDefination){
    return getType(c.name).then((type:any)=>{
        console.log(type);
        if(!c.children)
            return createElement(type, c.props);
        return createElement(type, c.props, c.children.map(createComponent));
    }, error=>{
        console.error('Error loading type', c.name, error, c);
    });
}

let init = function(data){
    console.log('loader', 'init');
    return data.map(d=>{
        let id = d.shift();
        let c:ComponentDefination = _readDefination.call(ctx, ...d);
        c.id = id;
        try{
            let elem = document.getElementById(id);
            elem.classList.remove('react-loading');
            createComponent(c).then(t=>{c.instance = render(t, document.getElementById(id));});
            //c.instance = render(createComponent(c), );
        } catch(e){
            console.error('Component rendering failed', c, e);
        }
        return c;
    });

}

console.log('loader');
window['react_compoents'] = init(window['react_components']);
