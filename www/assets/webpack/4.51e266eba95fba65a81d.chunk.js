(window.webpackJsonp=window.webpackJsonp||[]).push([[4],{"./src/Components.ts":
/*!***************************!*\
  !*** ./src/Components.ts ***!
  \***************************/
/*! exports provided: default */function(t,e,n){"use strict";n.r(e);var s=n(/*! ./React */"./src/React/index.ts"),i=n(/*! ./Mail */"./src/Mail/index.ts");e.default={React:s,Mail:i}},"./src/React/EntitySelect.tsx":
/*!************************************!*\
  !*** ./src/React/EntitySelect.tsx ***!
  \************************************/
/*! exports provided: default */function(t,e,n){"use strict";n.r(e);var s=n(/*! tslib */"./node_modules/tslib/tslib.es6.js"),i=n(/*! react */"react"),r=n(/*! react-virtualized-select */"./node_modules/react-virtualized-select/dist/commonjs/index.js"),a=n.n(r),o=(n(/*! react-select/dist/react-select.css */"./node_modules/react-select/dist/react-select.css"),n(/*! react-virtualized/styles.css */"./node_modules/react-virtualized/styles.css"),n(/*! react-virtualized-select/styles.css */"./node_modules/react-virtualized-select/styles.css"),function(t){function e(e){var n=t.call(this,e)||this;n.loadOptions=n.loadOptions.bind(n);var s=e.multiple?e.value instanceof Array?e.value:[]:"string"==typeof e.value||"number"==typeof e.value?e.value:"";return n.state={value:s},n}return s.__extends(e,t),e.prototype.loadOptions=function(t,e){return fetch(this.props.url+".mjson?count="+(this.props.count||100)+"&q="+t,{credentials:"include"}).then(function(t){return t.json()}).then(function(t){return{options:t.items,complete:t.total<=t.count}})},e.prototype.onSelect=function(t){this.setState({value:null!=t?Array.isArray(t)?t.map(function(t){return t.eid}):t.eid:""})},e.prototype.none=function(){},e.prototype.render=function(){var t=this.state.value instanceof Array?JSON.stringify(this.state.value):this.state.value;return i.createElement("div",{className:"sri-node"},i.createElement(a.a,{async:!0,loadOptions:this.loadOptions,onChange:this.onSelect.bind(this),labelKey:"title",valueKey:"eid",value:this.state.value,multi:this.props.multiple}),i.createElement("input",{type:"hidden",key:"input",name:this.state.value==this.props.value?"":this.props.name,onChange:this.none,value:t}))},e.defaultProps={multiple:!1,value:""},e}(i.Component));e.default=o},"./src/React/index.ts":
/*!****************************!*\
  !*** ./src/React/index.ts ***!
  \****************************/
/*! exports provided: EntitySelect, Test */function(t,e,n){"use strict";n.r(e);var s=n(/*! ./EntitySelect */"./src/React/EntitySelect.tsx");n.d(e,"EntitySelect",function(){return s.default});var i=n(/*! ./test */"./src/React/test.tsx");n.d(e,"Test",function(){return i.default})},"./src/React/test.tsx":
/*!****************************!*\
  !*** ./src/React/test.tsx ***!
  \****************************/
/*! exports provided: default */function(t,e,n){"use strict";n.r(e);var s=n(/*! tslib */"./node_modules/tslib/tslib.es6.js"),i=n(/*! react */"react"),r=function(t){function e(e){var n=t.call(this,e)||this;return n.state={},n}return s.__extends(e,t),e.prototype.render=function(){return i.createElement("div",null,"Hello ",this.props.name,"!")},e}(i.Component);e.default=r}}]);