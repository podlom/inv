(window.webpackJsonp=window.webpackJsonp||[]).push([["React"],{"./src/React/EntitySelect.tsx":
/*!************************************!*\
  !*** ./src/React/EntitySelect.tsx ***!
  \************************************/
/*! exports provided: default */function(t,e,n){"use strict";n.r(e);var r=n(/*! tslib */"./node_modules/tslib/tslib.es6.js"),s=n(/*! react */"react"),o=n(/*! react-virtualized-select */"./node_modules/react-virtualized-select/dist/commonjs/index.js"),i=n.n(o);!function(){var t=new Error("Cannot find module 'react-select/dist/react-select.css'");throw t.code="MODULE_NOT_FOUND",t}();n(/*! react-virtualized/styles.css */"./node_modules/react-virtualized/styles.css"),n(/*! react-virtualized-select/styles.css */"./node_modules/react-virtualized-select/styles.css");var a=function(t){function e(e){var n=t.call(this,e)||this;n.loadOptions=n.loadOptions.bind(n);var r=e.multiple?e.value instanceof Array?e.value:[]:"string"==typeof e.value||"number"==typeof e.value?e.value:"";return n.state={value:r},n}return r.__extends(e,t),e.prototype.loadOptions=function(t,e){return fetch(this.props.url+".mjson?count="+(this.props.count||100)+"&q="+t,{credentials:"include"}).then(function(t){return t.json()}).then(function(t){return{options:t.items,complete:t.total<=t.count}})},e.prototype.onSelect=function(t){this.setState({value:null!=t?Array.isArray(t)?t.map(function(t){return t.eid}):t.eid:""})},e.prototype.none=function(){},e.prototype.render=function(){var t=this.state.value instanceof Array?JSON.stringify(this.state.value):this.state.value;return s.createElement("div",{className:"sri-node"},s.createElement(i.a,{async:!0,loadOptions:this.loadOptions,onChange:this.onSelect.bind(this),labelKey:"title",valueKey:"eid",value:this.state.value,multi:this.props.multiple}),s.createElement("input",{type:"hidden",key:"input",name:this.state.value==this.props.value?"":this.props.name,onChange:this.none,value:t}))},e.defaultProps={multiple:!1,value:""},e}(s.Component);e.default=a},"./src/React/PortalTest.tsx":
/*!**********************************!*\
  !*** ./src/React/PortalTest.tsx ***!
  \**********************************/
/*! exports provided: default */function(t,e,n){"use strict";n.r(e);var r=n(/*! tslib */"./node_modules/tslib/tslib.es6.js"),s=n(/*! react */"react"),o=function(t){function e(e){var n=t.call(this,e)||this;return n.state={counter:0,portals:[]},n}return r.__extends(e,t),e.prototype.componentDidMount=function(){var t=this;this.props.slots.map(function(e){return window.react_loader.createPortal(e).then(function(e){return t.setState(function(n){return{portals:t.state.portals.concat([e])}})})})},e.prototype.modify=function(t){this.setState(function(e){return{counter:e.counter+t}})},e.prototype.render=function(){var t=this;return s.createElement("div",null,this.state.portals.map(function(e,n){return e([t.render_counter()],n)}))},e.prototype.render_counter=function(){return s.createElement("div",{className:"counter"},s.createElement("span",{onClick:this.modify.bind(this,-1)},"[ - ]")," { ","  ",s.createElement("b",null,this.state.counter)," "," } ",s.createElement("span",{onClick:this.modify.bind(this,1)},"[ + ]"))},e}(s.Component);e.default=o},"./src/React/index.ts":
/*!****************************!*\
  !*** ./src/React/index.ts ***!
  \****************************/
/*! exports provided: EntitySelect, Test */function(t,e,n){"use strict";n.r(e);var r=n(/*! ./EntitySelect */"./src/React/EntitySelect.tsx");n.d(e,"EntitySelect",function(){return r.default});var s=n(/*! ./test */"./src/React/test.tsx");n.d(e,"Test",function(){return s.default})},"./src/React/test.tsx":
/*!****************************!*\
  !*** ./src/React/test.tsx ***!
  \****************************/
/*! exports provided: default */function(t,e,n){"use strict";n.r(e);var r=n(/*! tslib */"./node_modules/tslib/tslib.es6.js"),s=n(/*! react */"react"),o=function(t){function e(e){var n=t.call(this,e)||this;return n.state={},n}return r.__extends(e,t),e.prototype.render=function(){return s.createElement("div",null,"Hello ",this.props.name,"!")},e}(s.Component);e.default=o},"./src/React/testportal.tsx":
/*!**********************************!*\
  !*** ./src/React/testportal.tsx ***!
  \**********************************/
/*! exports provided: default */function(t,e,n){"use strict";n.r(e);var r=n(/*! tslib */"./node_modules/tslib/tslib.es6.js"),s=n(/*! react */"react"),o=n(/*! react-dom */"react-dom"),i=function(t){function e(e){var n=t.call(this,e)||this;return n.state={votes:e.votes},n}return r.__extends(e,t),e.prototype.render=function(){return s.createElement("div",null,o.createPortal(s.createElement("span",null,"2"),document.getElementById("testlike")),"Hello !")},e}(s.Component);e.default=i},react:
/*!************************!*\
  !*** external "React" ***!
  \************************/
/*! no static exports found */function(t,e){t.exports=React},"react-dom":
/*!***************************!*\
  !*** external "ReactDOM" ***!
  \***************************/
/*! no static exports found */function(t,e){t.exports=ReactDOM}}]);