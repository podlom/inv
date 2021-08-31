import './sass/Url.scss';
import * as React from 'react';
import ContentEditable from '../Contenteditable';
import slugify from 'slugify';

interface Props{
	name: string;
	value: string;
	domain?: string;
	required: boolean;
	absolute?: boolean;
	multipart?: boolean;
	prefix?: string;
	source?: string;
};


interface State {
	value: string;
	valid: boolean;
};

export default class Url extends React.Component<Props,State>{

	static defaultProps:Partial<Props> = {
		required: false,
		absolute: false,
		multipart: false
	};

	private pattern:RegExp;


	constructor(props: Props){
        super(props);
        this.updatePattern();
        let value = props.value || "";
        if(props.absolute && value.substr(0,1)=='/'){
        	value = value.substr(1);
        }
        this.state = {value, valid: this.pattern.test(value)};
        this.onchange = this.onchange.bind(this);
        this.slugify = this.slugify.bind(this);
        this.focusUrl = this.focusUrl.bind(this);
        this.urlRef = React.createRef();
    }

    componentDidUpdate(prevProps, prevState, snapshot){
    	if(prevProps.multipart != this.props.multipart){
    		this.updatePattern();
    	}
    }

    updatePattern(){
		let pattern = "[\\-\\_\\.\\,\\~\\!\\:\\;\\*a-z0-9]{3,256}";
		if(this.props.multipart){
			pattern = pattern+"(/"+pattern+")*";
		}
		this.pattern = new RegExp('^'+pattern+'$');
    }

    focusUrl(){
    	this.urlRef.current.focus();
    }

    slugify(e){
		let el = document.getElementById(this.props.source) as HTMLInputElement;
		let value = slugify(el.value, {
			replacement: '-',
		  	lower: true
		}).replace(/[^a-zA-Z0-9\-\_\.\,\/\%\~\!\:\;*]/g, '');
		if(el){
			this.setState({
				value,
				valid: this.pattern.test(value)
			});
		}
	}


	render(){
		return <div className={"svr-url"+(this.state.valid?'':' svr-invalid')}>
			<div className="svr-path" onClick={this.focusUrl}>
				{this.props.domain && <span className="svr-part svr-domain">{this.props.domain}</span>}
				{this.props.prefix && this.props.prefix.split('/').filter(a=>a).map((a,i)=><span key={i} className="svr-part svr-prefix">{a}</span>)}
				<ContentEditable innerRef={this.urlRef} className="svr-part svr-value" tagName="span" html={this.state.value} onChange={this.onchange} />
				</div>
			{this.props.source && <i className="fa fa-refresh svr-slug" onClick={this.slugify}/>}
			<input type="hidden" value={(this.props.absolute ? '/' : '')+this.state.value} name={(this.props.required || (this.props.value != this.state.value)) ? this.props.name : ''} />
		</div>;
	}

	onchange(e){
		let text = e.target.text;
		this.setState({value: text, valid: this.pattern.test(text)});
	}

}
