import * as React from 'react';

interface Props{
	url: string;
	stats: number[];
}


interface State{
	active: boolean;
	stats: number[];
	delay: number;
}


export default class Mailer extends React.Component<Props,State>{

	timer:number;

	constructor(props){
		super(props);
		this.state = {active: false, delay: 5, stats:props.stats.map(i=>parseInt(i))};
		this.start = this.start.bind(this);
		this.stop = this.stop.bind(this);
		this.tick = this.tick.bind(this);
		this.fetch = this.fetch.bind(this);
		this.changeDelay = this.changeDelay.bind(this);
	}
/*


 */

	render(){
		let total = this.state.stats[0] + this.state.stats[1] + this.state.stats[2];
		let done = this.state.stats[1]/total*100+'%';
		let fail = this.state.stats[2]/total*100+'%'
		console.log(total, this.state.stats[1]/total*100, this.state.stats[1]/total*100+'%');
		return <div className="mailer">
			<h3>Mailing status: <span className="queue">{this.state.stats[0]}</span>/<span className="done">{this.state.stats[1]}</span>/<span className="fail">{this.state.stats[2]}</span></h3>
			<div className="progress">
				<div className="done" style={{flex: '0 0 '+done}}></div>
				<div className="fail" style={{width: '0 0 '+fail}}></div>
				<div className="other"></div>
			</div>
			<label>Send delay (sec): <input type="number" value={this.state.delay} onChange={this.changeDelay}/></label>
			<button className="button green" disabled={this.state.active} onClick={this.start}>Start</button>
			<button className="button red" disabled={!this.state.active} onClick={this.stop}>Stop</button>
		</div>
	}

	changeDelay(e){
		this.setState({delay:e.target.value});
	}

	start(){
		this.setState({active: true}, this.tick);
	}

	stop(){
		this.setState({active: false});
		clearTimeout(this.timer);
		this.timer = null;
	}

	tick(){
		if(this.timer){
			clearTimeout(this.timer);
			this.timer = null;
		}
		this.timer = setTimeout(this.fetch, this.state.delay*1000);
	}

	fetch(){
		fetch(this.props.url+'.json', {credentials: 'include'}).then(r=>r.json()).then(d=>{
			if(d.stats){
				this.setState({stats:d.stats.map(i=>parseInt(i))});
				if(this.state.active){
					this.tick();
				}
			} else {
				this.setState({active: false});
			}
		});
	}



}