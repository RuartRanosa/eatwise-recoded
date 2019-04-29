import React, {Component } from 'react'
import {Link} from 'react-router-dom'
import jwt_decode from 'jwt-decode'
import SearchShop from './SearchShop'
import AddShop from './AddShop'
import './Profile.css';
import ppic from './../img_avatar.png'


class Profile extends Component {
    
    render () {
       
        return (
            <div className="pdiv">

                    <img src={ppic} className="profile-pic"/>
                    <table className="ptable">
                    <tr><h2>MANALAC, JOSE ENRICO</h2></tr>
                        <tr className="ptr">
                            <td>kurtmanalac_</td>
                        </tr>
                        <tr className="ptr">
                            <td>kurt_pogi@yahoo.com</td>
                        </tr>
                        <tr><td><br/></td></tr>
                        <tr className="ptr">
                            <td>
                                <button class= "btn btn-danger">
                                    Add Shop
                                </button>  
                            </td>
                        </tr>
                    </table>

                    <article className="csearch-bars2">
                        <input type="text" class="search2" placeholder="Search for restaurants..." />
                    </article>

            </div>
        )
    }
}

export default Profile