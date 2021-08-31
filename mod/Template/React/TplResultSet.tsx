import * as React from 'react';

interface Props{
	result: string;
}


interface State{
	results: string[];
	current: number;
}

export default class TplResultSet extends React.Component<Props,State>{

	iframe: HTMLIFrameElement;

	constructor(props){
		super(props);
		this.state = {
			results: [this.props.result],
			current: 0,
		};
		this.refiframe = this.refiframe.bind(this);
		this.updateFrame = this.updateFrame.bind(this);
	}

	addResult(r:string){
		let results = this.state.results.slice();
		results.push(r);
		this.setState({results, current: results.length - 1});
	}

	onChange(r){
		console.log(r);
	}

	updateFrame(){
		if(!this.iframe)
			return;
		let doc = this.iframe.contentWindow.document;
		doc.open();
		doc.write(this.getCurrentResult(this.state));
		doc.close();
	}

	componentDidUpdate(prevProps, prevState){
		if(this.getCurrentResult(prevState) != this.getCurrentResult(this.state)){
			this.updateFrame();
		}
	}

	getCurrentResult(state:State){
		if(typeof(state.results[state.current])=='string')
			return state.results[state.current];
		return state.results[state.results.length -1];
	}

	refiframe(f){
		this.iframe = f;
		this.updateFrame();
	}

	render(){
		return <div className="tpl_result">
			<iframe ref={this.refiframe} />
		</div>;
	}

}