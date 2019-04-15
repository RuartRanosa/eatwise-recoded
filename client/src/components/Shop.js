import React, { Component } from 'react'
import SearchShop from './SearchShop'

const qs = require("query-string")

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
            votes: 0
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