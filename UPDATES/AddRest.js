import React, { Component } from 'react';
import './AddRest.css';
import Application from './Map.js';
// import map from './map.png'


const menu_type_list = ["American", "Korean", "Filipino", "Japanese", "Italian"]


class AddRest extends Component {

	constructor(){
		super()
		this.state = {
			restaurant_name: "",
			restaurant_type: "",
			average_price: "",
			description: "",
			menu_type: "",
			longitude: "",
			latitude: "",
			selectedFile: null
		}

		this.handleName = this.handleName.bind(this)
		this.handleRtype = this.handleRtype.bind(this)
		this.handleAvePrice = this.handleAvePrice.bind(this)
		this.handleDesc = this.handleDesc.bind(this)
		this.handleMenu = this.handleMenu.bind(this)
	}

	handleAddRest(e) {
		fetch('backend server https:localhost:post/something', {
			method: 'POST',
			headers: {
				'Accept': 'application/json',
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				"name": this.state.restaurant_name,
				"type": this.state.restaurant_type,
				"average_price": this.state.average_price,
				"description": this.state.description,
				"menu_type": this.state.menu_type
			})
		})
		.then(function(response){
			return response.json()
		});
	}

	handleName (e) {
		this.setState({restaurant_name: e.target.value})
	}

	handleRtype (e) {
		this.setState({restaurant_type: e.target.value})
	}

	handleAvePrice (e) {
		this.setState({average_price: e.target.value})
	}

	handleDesc (e) {
		this.setState({description: e.target.value})
	}

	handleMenu (e) {
		this.setState({menu_type: e.target.value})
	}

	handlePhoto = e =>  {
		this.setState({selectedFile: e.target.files[0]})
	}

	// handleUpload = () => {

	// }
	render() {
		return (
		  <div className="AddRest"> 	
		  	
		  	<h1 id="pagename">Add Restaurant</h1>
		  	<br/>
        	<form>

        	<div id="mapbox-container">
        	<Application id="mapbox"/>
        	</div>

        	<label >Restaurant Name</label><br/>
	  		<input class="text-input" type="text" onChange={this.handleName}/>
	  		<br/>
		  	<label>Restaurant Type</label><br/>
	  		<input class="text-input" type="text" onChange={this.handleRtype}/>
	  		<br/>
	  		<label>Average Price</label><br/>
	  		<input class="text-input" type="int" onChange={this.handleAvePrice}/>
	  		<br/>
	  		<label>Description</label><br/>
	  		<textarea class="text-input" onChange={this.handleDesc}/>
	  		<br/>
	  		<label>Menu Type</label>
	  		
	  		<div class="dropdown_container">
		  		<select class="dd_button" value={this.state.menu_type} onChange={this.handleMenu}>
		  			{menu_type_list.map(x =>
		  				<option key={x} value={x}>{x}</option>
		  				)};
		  		</select>
	  		</div>

	  		<br/>

	  		<label id="add-photos-label"> Add Photos </label>
	  		
	  		<span id="upload_button" class="button">
				<label>
				<input type="file" ngf-select ng-model="new_files" ng-change="fs.uploadFiles(new_files)" multiple/>
				<span class="dd_button" id="upload-button-text">Upload pictures</span>
				</label>
			</span>
		  	
			

			<input type="submit" value="Submit" class="dd_button" id="submitbutton" onclick={this.handleAddRest}/>

		  	</form>



		  	</div>		  	
		  
		);
	}
}

export default AddRest;
