import * as React from 'react';

 
interface Props{
	name: string;
}

interface State{
	
}

export default class Test extends React.Component<Props,State>{

	constructor(props: Props){
        super(props);
        this.state = {};	
    }

	render(){
		return <div>Hello {this.props.name}!</div>;
	}

}
