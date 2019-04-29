import React, { Component } from 'react'
import SearchShop from './SearchShop'

import MapGL, {NavigationControl} from 'react-map-gl';
const qs = require("query-string")

const TOKEN = 'pk.eyJ1IjoicnVhcnRyYW5vc2EiLCJhIjoiY2p1cXRla282MTVkczQzcGl5ZWk5MTNwOCJ9.fkQQbqTMnuvR9Y3sRE_EHg';
const navStyle = {
  position: 'absolute',
  top: 0,
  left: 0,
  padding: '10px'
};
class Shop extends Component {
    constructor() {
        super()
        this.state = {
            name: "",
            id: "",
            avgPrice: "",
            type: "",
            location: "",
            description: "",
            menu: "",
            votes: 0,
            viewport: {
                latitude: 14.179,
                longitude: 121.226,
                zoom: 100,
                bearing: 0,
                pitch: 0,
                width: 500,
                height: 500,
              }
        }
    }

    componentDidMount(){
        var shopName = qs.parse(this.props.location.search, {ignoreQueryPrefix: true}).shopName
        var id = qs.parse(this.props.location.search, {ignoreQueryPrefix: true}).shopId
        console.log(qs.parse(this.props.location.search, {ignoreQueryPrefix: true}))
        this.setState({name: shopName})
        this.setState({id: id})
        fetch('http://localhost:3001/search-shop/?name='+shopName+"&id="+id)
            .then((response) => { return response.json() })
            .then((result) => {
                console.log(result)
                this.setState({avgPrice: result[0].avgPrice})
                this.setState({type: result[0].type})
                this.setState({location: result[0].location})
                this.setState({description: result[0].description})
                this.setState({menu: result[0].menu})
                this.setState({votes: result[0].votes})
            })
            .catch((e) => { console.log(e)});        
    }

    //reloads page when new data arrives
    componentWillReceiveProps(nextProps){
           window.location.reload()
    }
    

    render () {
        return (
            <div>
                <div>
                    <div>
                        <h1>Shop</h1>
                    </div>
                    <table>
                        <tbody>
                        <tr>
                            <tr>
                                <td>Shop name: </td>
                                <td>{this.state.name}</td>
                            </tr>
                             <tr>
                                <td>Shop ID: </td>
                                <td>{this.state.id}</td>
                            </tr>
                            <tr>
                                <td>Average Pricing: </td>
                                <td>{this.state.avgPrice}</td>
                            </tr>
                            <tr>
                                <td>Type: </td>
                                <td>{this.state.type}</td>
                            </tr>
                            <tr>
                                <td>Location: </td>
                                <td>{this.state.location}</td>
                            </tr>
                            <tr>
                                <td>Description: </td>
                                <td>{this.state.description}</td>
                            </tr>
                            <tr>
                                <td>Menu: </td>
                                <td>{this.state.menu}</td>
                            </tr>
                            <tr>
                                <td>Votes: </td>
                                <td>{this.state.votes}</td>
                            </tr>
                           </tr> 
                           <tr>
                           <MapGL
                            {...this.state.viewport}
                            mapStyle="mapbox://styles/mapbox/dark-v9"
                            mapboxApiAccessToken={TOKEN}>
                            <div className="nav" style={navStyle}>
                              <NavigationControl/>
                            </div>
                          </MapGL>
                           </tr>
                        </tbody>
                    </table>
                    <button onClick = {this.addShop}
                        className = "search-button">
                          Add review
                    </button>
                    <SearchShop/>
                </div>
            </div>
        )
    }
}

{/*
    View url content
    <td>{console.log(this.props)}</td>
    <td>{console.log(qs.parse(this.props.location.search, {ignoreQueryPrefix: true}).shopName)}</td>
*/}


export default Shop