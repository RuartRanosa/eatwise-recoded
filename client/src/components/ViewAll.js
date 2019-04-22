import React, { Component } from 'react'
import { BrowserRouter as Router } from 'react-router-dom'
import kfc from './../chicken.jpeg';
import './ViewAll.css'
class ViewAll extends Component{
	constructor() {
		super()
		this.state = {
			page: []
		};

	}

	componentDidMount(){
		//a method which is automatically called after the component is instantiated
		//send a message to games-server
		//populate this.sate.games with the data sent back

		fetch('http://localhost:3001/ViewAll')
			.then(response => response.json())
			.then(body => {
				this.setState({page: body})

			})
			.catch((e) => {console.log(e)});
	}

	render(){
		return(
			<div className="ViewAllPage">
				<h2> LIST OF RESTAURANTS </h2>
				<div id = "center" type = "container">
					this.state.page.map(store,i) => {
						//return
							<div id = "thumbnail">
		 						<a href = {store.website}>
			    					<img src={store.picture} id="picture" /> 
			  					</a>
			  					<div id = "link-container"> 
			  						<a id = "link-to-page" href = {store.website}>
			    						{store.name}
			  						</a>
			  					</div>
			  			</div> 
						
					}					
	      </div> 
      </div>
		)
	}
}

export default ViewAll