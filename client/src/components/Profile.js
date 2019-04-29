import React, {Component } from 'react'
import {Link} from 'react-router-dom'
import jwt_decode from 'jwt-decode'
import SearchShop from './SearchShop'
import AddShop from './AddShop'
import AddRest from './AddRest'
import './Profile.css';
import ppic from './../img_avatar.png'



class Profile extends Component {
    constructor() {
        super()
        this.state = {
            username: '',
            display_name: '',
            email: '',
            shop: [],
            shopName: "",
            showAdminTools: false,
            showAddShop: false
        }

        this.addShop = this.addShop.bind(this)

    }

    componentDidMount () {
        var token = localStorage.usertoken
        console.log(token)
        var decoded = jwt_decode(token)
        console.log("decoded token")
        this.setState({
            username: decoded.username,
            display_name: decoded.display_name,
            email: decoded.email
        })
    }
    
    addShop(){
        if(this.state.showAddShop === false){
            this.setState({showAddShop: true})
            console.log(this.state.showAddShop)
        }else{
            this.setState({showAddShop: false})
            console.log(this.state.showAddShop)
        }
    }


    render () {
        {if(this.state.showAddShop){
            var shop = (
                <AddRest/>
            )
         } 
   
        }
        return (
                // <table>
                //     <tbody>
                //     <tr><h2>PROFILE</h2></tr>
                //         <tr>
                //             <td>Username</td>
                //             <td>{this.state.username}</td>
                //         </tr>
                //         <tr>
                //             <td>Display Name</td>
                //             <td>{this.state.display_name}</td>
                //         </tr>
                //         <tr>
                //             <td>Email</td>
                //             <td>{this.state.email}</td>
                //         </tr>
                //     </tbody>
                // </table>
                // <button onClick = {this.addShop}
                //     className = "search-button">
                //       Add Shop
                // </button>  
            <div className="pdiv">
                <img src={ppic} className="profile-pic"/>
                    <table className="ptable">
                    <tr>{this.state.username}</tr>
                        <tr className="ptr">
                            <td>{this.state.display_name}</td>
                        </tr>
                        <tr className="ptr">
                            <td>{this.state.email}</td>
                        </tr>
                        <tr><td><br/></td></tr>
                        <tr className="ptr">
                            <td>
                                <button 
                                    class= "btn btn-danger"
                                    onClick = {this.addShop}>
                                    Add Shop
                                </button>  
                            </td>
                        </tr>
                    </table>
               

                {shop}
                <SearchShop/>
            </div>
        )
    }
}

export default Profile