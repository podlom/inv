import * as React from 'react';
import EntitySelect from '../Skynar/EntitySelect';

export interface Config{
	subject: string;
	from_name: string;
	to: EmailList | boolean;
	cc: EmailList;
	bcc: EmailList;
}

interface EmailList{
	[key:string]:string;
}
 
interface Props{
	config?: Config;
	url: string;
}


interface State{
	active: number;
	config?: Config;
}

let headers = new Headers;
headers.set('Content-Type', 'text/json;charset=UTF-8');

export class TplConfig extends React.Component<Props,State>{

	constructor(props){
		super(props);
		this.state = {
			active: 0,
			config: this.props.config ? Object.assign({}, this.props.config) : null
		};
		this.save = this.save.bind(this);
	}

	onChange(r){
		console.log(r);
	}

	updateItem(name, value){
		let config = Object.assign({}, this.state.config);
		config[name]=value;
		this.setState({config});
	}

	input(name, label, type='text'){
		let active = this.state.config && typeof(this.state.config[name])=='string';
		let value = active ? this.state.config[name] : 'Disabled';
		return <ActiveLabledInput 
			key={name}
			active={active} 
			value={value}
			label={label}
			type={type}
			onChange={this.updateItem.bind(this, name)}
		/>;
	}

	list(name, label, type='text'){
		let active = this.state.config && typeof(this.state.config[name])=='object';
		let value = active ? this.state.config[name] : 'Disabled';
		return <EmailListInput 
			key={name}
			active={active} 
			value={value}
			label={label}
			type={type}
			onChange={this.updateItem.bind(this, name)}
		/>;
	}

	save(e){
		e.preventDefault();
		let target = e.currentTarget
		target.disabled = true
		target.innerHTML = `
			<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
			Сохраняю...
			`
		fetch(
			location.pathname+'.json', 
			{headers, method: 'POST', body:JSON.stringify(this.state.config), 
			credentials:'include'}
		).then(response => {
			if(response.status == 200){
				target.innerHTML = `
					<i class="fa fa-check" aria-hidden="true"></i> Сохранено
				`
				setTimeout(() => {
					target.disabled = false
					target.innerHTML = `
						<i class="fa fa-floppy-o" aria-hidden="true"></i> Сохранить настройки
					`
				}, 3000)
			} else {
				target.innerHTML = `
					При сохранении возникла ошибка!
				`
			}
		});
	}

	render(){
		return <div className="tpl_config">
				{this.input('subject', 'Тема письма')}
			
			<div className="form-group">
			<label>Сервер для рассылки</label>
			<EntitySelect
				onChange={this.updateItem.bind(this, 'from')}
				value={this.state.config['from']}
				multiple={false}
				name="from"
				url={this.props.url}
			/>
			</div>

			{this.input('from_name', 'От кого')}
			{this.list('to', 'TO')}
			{this.list('cc', 'CC')}
			{this.list('bcc', 'BCC')}
			<div className="form-group text-right">
				<button className="btn btn-main save-settings" onClick={this.save}><i className="fa fa-floppy-o" aria-hidden="true"></i> Сохранить настройки</button>
			</div>
		</div>;
	}

}

interface ALI{
	active:boolean;
	label: string;
	value: any;
	type?: string;
	onChange?: (val)=>void;
}

interface ListState{
	emails: [string, string][];
}

class EmailListInput extends React.Component<ALI, ListState>{

	constructor(props){
		super(props);
		this.state = {
			emails: Object.keys(this.props.value).map(
				k=>[k,this.props.value[k]] as [string, string])
		};
		this.add = this.add.bind(this);
		this.upd =this.upd.bind(this);
	}

	upd(){
		this.props.onChange(this.state.emails.reduce((c,v)=>{
			c[v[0]]=v[1];
			return c;
		}, {}));
	}

	update(index, pos, value){
		let emails = this.state.emails.slice();
		emails[index][pos]=value;
		this.setState({emails}, this.upd);
	}

	add(e){
		e.preventDefault();
		let emails = this.state.emails.slice();
		emails.push(['','']);
		this.setState({emails}, this.upd);
	}

	remove(i,e){
		e.preventDefault();
		let emails = this.state.emails.slice();
		emails.splice(i,1);
		this.setState({emails}, this.upd);
	}

	render(){
		return this.props.active && <fieldset className={this.props.active?'':'disabled'}>
			<p>{this.props.label}</p>
			<div>
			{console.log(this.state.emails)}
			{this.props.active && this.state.emails.map(
				(v,i)=><span key={i} >
					<ActiveLabledInput active label="Name"  value={v[1]} onChange={this.update.bind(this, i, 1)} />
					<ActiveLabledInput active label="Email"  value={v[0]} onChange={this.update.bind(this, i, 0)} type="email" />
					<button className="remove" onClick={this.remove.bind(this,i)}><i className="fi fi-delete"></i></button>
				</span>
				)}
			{this.props.active && <button className="add" key="b" onClick={this.add}>+</button>}
			</div>
		</fieldset>
	}
}

class ActiveLabledInput extends React.Component<ALI>{

	onChange(e){
		this.props.onChange(e.target.value);
	}
	onblur(e) {
		if(e.target.value == '') {

		}
	}

	render(){
		return <div className="form-group"><span className={this.props.active?'input':'disabled input'}>
				<label>{this.props.label}</label>
				<input value={this.props.value} className="form-control" onBlur={this.onblur.bind(this)} placeholder={this.props.label} onChange={this.onChange.bind(this)} type={this.props.type || 'text'} disabled={!this.props.active} />
			</span></div>
	}

}