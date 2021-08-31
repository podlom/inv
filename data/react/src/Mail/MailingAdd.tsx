import * as React from 'react';

interface P{
	onSelect: (i:number)=>void;
	basepath: string;
}


interface S{
	text: string;
	disabled: boolean;
}

export default class MailingList extends React.Component<P,S>{

	constructor(props){
		super(props);
		this.state = {text: '', disabled: false};
		this.onText = this.onText.bind(this);
		this.onNew = this.onNew.bind(this);
	}

	render(){
		return <div className="mailing_add">
			<input type="text" required onChange={this.onText} value={this.state.text} placeholder="Enter name"/>
			<button onClick={this.onNew} disabled={this.state.text.length < 3}>create mailing</button>
		</div>;
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
				this.setState({disabled: false});
				location.href=this.props.basepath+'/'+d.entity.id;
			}).catch(e=>{
				this.setState({disabled: false});
			});
		}
	}
}