import * as React from 'react';
import * as brace from 'brace';
import AceEditor from 'react-ace';
import {TplConfig, Config} from './TplConfig';
import ResulstSet from './TplResultSet';

import 'brace/mode/smarty.js';
import 'brace/theme/monokai.js';

import './TplEdit.scss';
 
interface Props{
	config?: Config;
	result: string;
	text: string;
	url: string;
}


interface State{
	results: string[];
	current: number;
	text: string;
}

export default class TplEdit extends React.Component<Props,State>{

	rs:ResulstSet;

	constructor(props){
		super(props);
		this.state = {
			results: [this.props.result],
			current: 0,
			text: this.props.text,
		};
		this.onChange = this.onChange.bind(this);
		this.refResult = this.refResult.bind(this);
		this.save = this.save.bind(this);
	}

	onChange(text){
		this.setState({text});
	}

	refResult(r){
		this.rs = r;
	}

	save(e){
		e.preventDefault();
		let target = e.currentTarget
		target.disabled = true
		target.innerHTML = `
			<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
			Сохраняю...
			`
		fetch('', {method:'PUT',body:this.state.text ,credentials:'include'}).then(
			r=>{
				if(r.status == 200){
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
				
				return r.text()
			}
		).then(
			t=>this.rs.addResult(t)
		);
	}

	render(){
		return <div className="tpl_edit">
			<section className="mb-5">
				<TplConfig config={this.props.config} url={this.props.url}/>
			</section>
			<section className="mb-5">
			<h3 className="h5">HTML редаткор</h3>
			<AceEditor
				mode="smarty"
				theme="monokai"
				name="tpl"
				onChange={this.onChange}
				fontSize={14}
				showPrintMargin={true}
				showGutter={true}
				highlightActiveLine={true}
  				value={this.state.text}
  				setOptions={{
  					showLineNumbers: true,
  					tabSize: 3,
  				}}/>
  				<div className="text-right mt-3">
  					<button className="btn btn-main save-settings" onClick={this.save}><i className="fa fa-floppy-o" aria-hidden="true"></i> Сохранить шаблон</button>
  				</div>
  			</section>
  			
  			<section className="">
  				<h3 className="h5">Предпросмотр письма</h3>
  				
  				<div className="container-fluid letter-page p-5">
	  				<div className="row justify-content-md-center">
	  					<div className="col col-lg-8">
	  					<ResulstSet result={this.props.result} ref={this.refResult}/>
	  					</div>
	  				</div>
  				</div>
  			</section>
		</div>;
	}

}