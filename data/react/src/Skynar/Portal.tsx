import * as React from 'react';
import * as ReactDOM from 'react-dom';


interface P{
	name: string;
	root: HtmlElement;
	tag?: string;
}

export default class Portal extends React.Component<P>{

	static defaultProps = {
		tag: 'div'
	}
	
	constructor(props) {
		super(props);
		this.el = document.createElement(props.tag);
	}

  componentDidMount() {
  	this.props.root.appendChild(this.el);
  }

  componentWillUnmount() {
    this.props.root.removeChild(this.el);
  }

  render() {
    return ReactDOM.createPortal(
      this.props.children,
      this.el,
    );
  }
}