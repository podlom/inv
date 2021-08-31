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
		fetch('', {method:'PUT',body:this.state.text ,credentials:'include'}).then(
			r=>r.text()
		).then(
			t=>this.rs.addResult(t)
		);
	}

	render(){
		return <div className="tpl_edit">
			<TplConfig config={this.props.config} url={this.props.url}/>
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
  			<button className="save-settings" onClick={this.save}>Save Template</button>
  			<ResulstSet result={this.props.result} ref={this.refResult}/>
		</div>;
	}

}