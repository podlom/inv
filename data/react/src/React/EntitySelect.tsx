import * as React from 'react';
import VirtualizedSelect from 'react-virtualized-select';

import 'react-select/dist/react-select.css'
import 'react-virtualized/styles.css'
import 'react-virtualized-select/styles.css'

export interface ESItemData{
    eid: string;
    title: string;
    icon?: string;
    image?: string; //!T
    tags?: string[]; //!T
    text?: string; //!T
}

interface ESState {
   value: any;
};

 interface ESProps{
    name: string;
    url: string;
    multiple: boolean;
    value: string | string[];
    count?: number;
 };


/**
 * !T add infinite list support
 */
export default class EntitySelect extends React.Component<ESProps, ESState>{

    constructor(props){
        super(props);
        this.loadOptions = this.loadOptions.bind(this);
        let value = (props.multiple ?
            (
                props.value instanceof Array ?
                    props.value : []
            ) : (
                typeof(props.value) == 'string' || typeof(props.value) == 'number' ?
                    props.value : ''
            ));
        this.state = {value};
    }

    static defaultProps = {
        multiple: false,
        value: ''

    };

    loadOptions(input, cb){
        return fetch(this.props.url+'.mjson?count='+(this.props.count || 100)+'&q='+input, {credentials: 'include'}).then((r)=>{
            return r.json()
        }).then((json)=>{
            return {options:json.items, complete:json.total <= json.count}
        })
    }

    onSelect(value){
        this.setState({value:value != null ? (Array.isArray(value) ? value.map(v=>v.eid) :  value.eid) : ''});
    }

    none(){

    }


    render(){
        let value = this.state.value instanceof Array ? JSON.stringify(this.state.value) : this.state.value
        return <div className="sri-node">
            <VirtualizedSelect
                async={true}
                loadOptions={this.loadOptions}
                onChange={this.onSelect.bind(this)}
                labelKey="title"
                valueKey="eid"
                value={this.state.value}
                multi={this.props.multiple}
            />
            <input type="hidden" key="input"
                name={this.state.value == this.props.value ? '' : this.props.name}
                onChange={this.none}
                value={value} />
        </div>
    }

}
