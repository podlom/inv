(window.webpackJsonp=window.webpackJsonp||[]).push([["Mail"],{"./src/Mail/Guide.tsx":
/*!****************************!*\
  !*** ./src/Mail/Guide.tsx ***!
  \****************************/
/*! exports provided: default */function(e,t,a){"use strict";a.r(t);var i,s,n=a(/*! tslib */"./node_modules/tslib/tslib.es6.js"),l=a(/*! react */"react");!function(e){e[e.props=0]="props",e[e.import=1]="import",e[e.template=2]="template",e[e.send=3]="send"}(i||(i={})),function(e){e[e.wait=0]="wait",e[e.success=1]="success",e[e.fail=2]="fail"}(s||(s={}));var r=function(e){function t(t){var a=e.call(this,t)||this;return a.state={mid:t.mid,mailings:a.props.mailings},a.selectMailing=a.selectMailing.bind(a),a.addMailing=a.addMailing.bind(a),void 0===a.state.mailings&&a.loadMailings(),a}return n.__extends(t,e),t.prototype.render=function(){var e=this,t=void 0;return this.state.mid&&!(t=this.state.mailings.find(function(t){return t.id==e.state.mid}))&&this.props.mailing&&this.props.mailing.id==this.state.mid&&(t=this.props.mailing),l.createElement("div",{className:"mail_guide"},t?l.createElement(o,{mailing:t,back:this.selectMailing.bind(this,0),updateMailing:this.updateMailing}):l.createElement(c,{onSelect:this.selectMailing,mailings:this.state.mailings,addMailing:this.addMailing,basepath:this.props.basepath}))},t.prototype.loadMailings=function(){var e=this;fetch(this.props.basepath+".json?count=1000",{credentials:"include"}).then(function(e){return e.json()}).then(function(t){e.setState({mailings:t.items})})},t.prototype.selectMailing=function(e){this.setState({mid:e})},t.prototype.addMailing=function(e){var t=[e].concat(this.state.mailings);this.setState({mailings:t,mid:e.id})},t.prototype.updateMailing=function(e){var t=this.state.mailings.map(function(t){return t.id==e.id?e:t});this.setState({mailings:t,mid:e.id})},t}(l.Component);t.default=r;var c=function(e){function t(t){var a=e.call(this,t)||this;return a.state={text:"",disabled:!1},a.onText=a.onText.bind(a),a.onNew=a.onNew.bind(a),a}return n.__extends(t,e),t.prototype.render=function(){var e=this;return l.createElement("article",{id:"mailinglist"},l.createElement("header",null,l.createElement("div",{className:"breadcrumbs"},"Select Mailing"),l.createElement("div",{className:"actions"},l.createElement("input",{type:"text",required:!0,onChange:this.onText,value:this.state.text,placeholder:"Enter name"}),l.createElement("button",{onClick:this.onNew,disabled:this.state.text.length<3},"create mailing"))),"object"==typeof this.props.mailings&&this.props.mailings.map?l.createElement("div",{className:"list mailing"},this.props.mailings.map(function(t){return l.createElement("div",{key:t.id,className:"item",onClick:e.select.bind(e,t)},t.title)})," "):l.createElement("div",{className:"loading"},"Loading..."))},t.prototype.onText=function(e){this.setState({text:e.target.value})},t.prototype.onNew=function(){var e=this;this.state.text.replace(/\s/g,"").length>=3&&fetch(this.props.basepath+"/add.json",{credentials:"include",method:"POST",body:"entity[name]="+encodeURIComponent(this.state.text),headers:{"Content-Type":"application/x-www-form-urlencoded"}}).then(function(e){return e.json()}).then(function(t){e.props.addMailing(t.entity),e.setState({disabled:!1})}).catch(function(t){e.setState({disabled:!1})})},t.prototype.select=function(e,t){this.props.onSelect(e.id)},t}(l.Component),o=function(e){function t(t){var a=e.call(this,t)||this;return a.onFile=a.onFile.bind(a),a}return n.__extends(t,e),t.prototype.componentDidMount=function(){this.props},t.prototype.render=function(){return l.createElement("article",{id:"mailingview"},l.createElement("header",null,l.createElement("div",{className:"breadcrumbs"},l.createElement("a",{href:"#back",onClick:this.props.back},"<Mailing")," / ",this.props.mailing.title)),"object"==typeof this.props.mailing.stats?l.createElement("div",{className:"steps"},l.createElement("div",{className:"step1"},l.createElement("h3",null,"1. Import recipients"),l.createElement("label",null,"Select file: ",l.createElement("input",{type:"file",accept:".csv",onChange:this.onFile})))):l.createElement("div",{className:"loading"},"Loading..."))},t.prototype.onFile=function(e){var t=e.target.files.length>0?e.target.files[0]:null;this.setState({csvfile:t})},t}(l.Component)},"./src/Mail/Mailer.tsx":
/*!*****************************!*\
  !*** ./src/Mail/Mailer.tsx ***!
  \*****************************/
/*! exports provided: default */function(e,t,a){"use strict";a.r(t);var i=a(/*! tslib */"./node_modules/tslib/tslib.es6.js"),s=a(/*! react */"react"),n=function(e){function t(t){var a=e.call(this,t)||this;return a.state={active:!1,delay:5,stats:t.stats.map(function(e){return parseInt(e)})},a.start=a.start.bind(a),a.stop=a.stop.bind(a),a.tick=a.tick.bind(a),a.fetch=a.fetch.bind(a),a.changeDelay=a.changeDelay.bind(a),a}return i.__extends(t,e),t.prototype.render=function(){var e=this.state.stats[0]+this.state.stats[1]+this.state.stats[2],t=this.state.stats[1]/e*100,a=this.state.stats[2]/e*100;return console.log(this.state.stats),s.createElement("div",{className:"mailer"},s.createElement("div",{className:"row mt-3"},s.createElement("div",{className:"col col-sm-8 col-md-6 mb-3"},s.createElement("h4",{className:"h6"},"Статус отправки:"),s.createElement("ul",{className:"list-group"},s.createElement("li",{className:"list-group-item d-flex justify-content-between align-items-center"},"В ожидании",s.createElement("span",{className:"badge badge-light badge-pill queue"},this.state.stats[0])),s.createElement("li",{className:"list-group-item d-flex justify-content-between align-items-center"},"Готово",s.createElement("span",{className:"badge badge-warning badge-pill done"},this.state.stats[1])),s.createElement("li",{className:"list-group-item d-flex justify-content-between align-items-center"},"Отправлено",s.createElement("span",{className:"badge badge-pill badge-danger fail"},this.state.stats[2])),s.createElement("li",{className:"list-group-item d-flex justify-content-between align-items-center"},"Просмотры",s.createElement("span",{className:"badge badge-pill badge-info view"},this.state.stats[3])),s.createElement("li",{className:"list-group-item d-flex justify-content-between align-items-center"},"Переходы",s.createElement("span",{className:"badge badge-pill badge-success view"},this.state.stats[4])))),s.createElement("div",{className:"col col-md-6 mb-3"},s.createElement("h4",{className:"h6"},"Настройка частоты отправки писем:"),s.createElement("div",{className:"input-group mb-3"},s.createElement("div",{className:"input-group-prepend"},s.createElement("span",{className:"input-group-text"},"сек")),s.createElement("input",{type:"number",className:"form-control",value:this.state.delay,onChange:this.changeDelay}),s.createElement("div",{className:"input-group-append"},s.createElement("button",{className:"btn btn-info",disabled:this.state.active,onClick:this.start},s.createElement("i",{className:"fa fa-play","aria-hidden":"true"})),s.createElement("button",{className:"btn btn-main",disabled:!this.state.active,onClick:this.stop},s.createElement("i",{className:"fa fa-pause","aria-hidden":"true"})))),s.createElement("h4",{className:"h6"},"Прогресс отправки:"),s.createElement("div",{className:"progress mb-3"},s.createElement("div",{className:"progress-bar bg-success progress-bar-striped progress-bar-animated",role:"progressbar","aria-valuenow":a,"aria-valuemin":"0","aria-valuemax":"100",style:{width:t+"%"}}),s.createElement("div",{className:"progress-bar bg-danger progress-bar-striped progress-bar-animated",role:"progressbar","aria-valuenow":t,"aria-valuemin":"0","aria-valuemax":"100",style:{width:a+"%"}})))))},t.prototype.changeDelay=function(e){this.setState({delay:e.target.value})},t.prototype.start=function(){this.setState({active:!0},this.tick)},t.prototype.stop=function(){this.setState({active:!1}),clearTimeout(this.timer),this.timer=null},t.prototype.tick=function(){this.timer&&(clearTimeout(this.timer),this.timer=null),this.timer=setTimeout(this.fetch,1e3*this.state.delay)},t.prototype.fetch=function(){var e=this;fetch(this.props.url+".json",{credentials:"include"}).then(function(e){return e.json()}).then(function(t){t.stats?(e.setState({stats:t.stats.map(function(e){return parseInt(e)})}),e.state.active&&e.tick()):e.setState({active:!1})})},t}(s.Component);t.default=n},"./src/Mail/MailingAdd.tsx":
/*!*********************************!*\
  !*** ./src/Mail/MailingAdd.tsx ***!
  \*********************************/
/*! exports provided: default */function(e,t,a){"use strict";a.r(t);var i=a(/*! tslib */"./node_modules/tslib/tslib.es6.js"),s=a(/*! react */"react"),n=function(e){function t(t){var a=e.call(this,t)||this;return a.state={text:"",disabled:!1},a.onText=a.onText.bind(a),a.onNew=a.onNew.bind(a),a}return i.__extends(t,e),t.prototype.render=function(){return s.createElement("div",{className:"input-group"},s.createElement("input",{type:"text",className:"form-control",required:!0,onChange:this.onText,value:this.state.text,placeholder:"Введите название"}),s.createElement("div",{className:"input-group-append"},s.createElement("button",{className:"btn btn-main",onClick:this.onNew,disabled:this.state.text.length<3},"Создать рассылку")))},t.prototype.onText=function(e){this.setState({text:e.target.value})},t.prototype.onNew=function(){var e=this;this.state.text.replace(/\s/g,"").length>=3&&fetch(this.props.basepath+"/add.json",{credentials:"include",method:"POST",body:"entity[name]="+encodeURIComponent(this.state.text),headers:{"Content-Type":"application/x-www-form-urlencoded"}}).then(function(e){return e.json()}).then(function(t){e.setState({disabled:!1}),location.href=e.props.basepath+"/"+t.entity.id}).catch(function(t){e.setState({disabled:!1})})},t}(s.Component);t.default=n},"./src/Mail/index.ts":
/*!***************************!*\
  !*** ./src/Mail/index.ts ***!
  \***************************/
/*! exports provided: Mailer, MailingAdd */function(e,t,a){"use strict";a.r(t);var i=a(/*! ./Mailer */"./src/Mail/Mailer.tsx");a.d(t,"Mailer",function(){return i.default});var s=a(/*! ./MailingAdd */"./src/Mail/MailingAdd.tsx");a.d(t,"MailingAdd",function(){return s.default})},react:
/*!************************!*\
  !*** external "React" ***!
  \************************/
/*! no static exports found */function(e,t){e.exports=React}}]);