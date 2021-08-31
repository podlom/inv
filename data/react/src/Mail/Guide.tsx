import * as React from 'react';

interface Props{
	mid?: number;
	basepath: string;
	mailings?: Mailing[]
	mailing?: Mailing;
}

enum Tabs{
	props,
	import,
	template,
	send
}

interface Mailing{
	id: number;
	title: string;
	stats: number[];
	recipients?: Recipient[];
}

enum RStatus{
	wait=0,
	success=1,
	fail=2
}

interface Recipient{
	id: number;
	name: string;
	email: string;
	status: RStatus;
	data: any;
}

interface State{
	mid?: number;
	mailings?: Mailing[];
}


export default class Guide extends React.Component<Props,State>{

	timer:number;

	constructor(props){
		super(props);
		this.state = {mid: props.mid, mailings: this.props.mailings};
		this.selectMailing = this.selectMailing.bind(this);
		this.addMailing = this.addMailing.bind(this);
		if(this.state.mailings === undefined)
			this.loadMailings();
	}

	render(){
		let mailing = undefined;
		if(this.state.mid){
			mailing = this.state.mailings.find(m=>m.id == this.state.mid);
			if(!mailing && this.props.mailing && this.props.mailing.id == this.state.mid){
				mailing = this.props.mailing;
			}
		}
		return <div className="mail_guide">
			{ mailing
				? <MailingView mailing={mailing} back={this.selectMailing.bind(this,0)} updateMailing={this.updateMailing} />
				: <MailingList onSelect={this.selectMailing} mailings={this.state.mailings} addMailing={this.addMailing} basepath={this.props.basepath} />
			}
		</div>
	}

	loadMailings(){
		fetch(this.props.basepath+'.json?count=1000', {credentials: 'include'}).then(r=>r.json()).then(d=>{
			this.setState({mailings: d.items});
		});
	}

	selectMailing(mid){
		this.setState({mid});
	}

	addMailing(m:Mailing){
		let mailings = [m].concat(this.state.mailings);
		this.setState({mailings, mid:m.id});
	}

	updateMailing(m:Mailing){
		let mailings = this.state.mailings.map(i=>i.id == m.id?m:i);
		this.setState({mailings, mid:m.id});
	}

}

interface P{
	mailings: Mailing[];
	onSelect: (i:number)=>void;
	addMailing: (m:Mailing)=>void;
	basepath: string;
}


interface S{
	text: string;
	disabled: boolean;
}

class MailingList extends React.Component<P,S>{

	constructor(props){
		super(props);
		this.state = {text: '', disabled: false};
		this.onText = this.onText.bind(this);
		this.onNew = this.onNew.bind(this);
	}

	render(){
		return <article id="mailinglist"><header>
			<div className="breadcrumbs">
				Select Mailing
			</div>
			<div className="actions">
				<input type="text" required onChange={this.onText} value={this.state.text} placeholder="Enter name"/>
				<button onClick={this.onNew} disabled={this.state.text.length < 3}>create mailing</button>
			</div>
		</header>
		{typeof(this.props.mailings) == 'object' && this.props.mailings.map
			? <div className="list mailing">
			  	{this.props.mailings.map(
					m=><div key={m.id} className="item" onClick={this.select.bind(this,m)}>
						{m.title}
					</div>
				)} </div>
			: <div className="loading">Loading...</div>}
		</article>;
	}

	onText(e){
		this.setState({text: e.target.value});
	}

	onNew(){
		if(this.state.text.replace(/\s/g, '').length >= 3){
			fetch(this.props.basepath+'/add.json', {
				credentials: 'include', 
				method: 'POST', 
				body: 'entity[name]='+encodeURIComponent(this.state.text), 
				headers:{'Content-Type':'application/x-www-form-urlencoded'}
			}).then(r=>r.json()).then(d=>{
				this.props.addMailing(d.entity);
				this.setState({disabled: false});
			}).catch(e=>{
				this.setState({disabled: false});
			});
		}
	}


	select(m,e){
		this.props.onSelect(m.id);
	}
}

interface MVP{
	back: ()=>void;
	mailing: Mailing;
	updateMailing: (m:Mailing)=>void;
}

interface MVS{
	csvfile: File;

}

class MailingView extends React.Component<MVP, MVS>{

	constructor(props){
		super(props);
		this.onFile = this.onFile.bind(this);
	}

	componentDidMount(){
		this.props
	}

	render(){
		return <article id="mailingview"><header>
			<div className="breadcrumbs">
				<a href="#back" onClick={this.props.back}>&lt;Mailing</a> / {this.props.mailing.title}
			</div>
		</header>
		{typeof(this.props.mailing.stats)=='object'
			? <div className="steps">
				<div className="step1">
					<h3>1. Import recipients</h3>
					<label>Select file: <input type="file" accept=".csv" onChange={this.onFile} /></label>
					
				</div>
			</div>
			: <div className="loading">Loading...</div>
		}
		</article>;
	}

	onFile(e){
		let csvfile = e.target.files.length > 0 ? e.target.files[0] : null;
		this.setState({csvfile});
	}

}