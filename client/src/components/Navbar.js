import React, { Component } from 'react'
import dropdownMenu from './../dropdown.png';
import './../App.css';
import logo from './../logo2.png';
import { Button } from 'react-bootstrap';
import { Link, withRouter } from 'react-router-dom'
import Login from './Login'
import Register from './Register'

class Navbar extends Component {
    logOut (e) {
        e.preventDefault()
        localStorage.removeItem('usertoken')
        this.props.history.push('/')
    }

    render () {
        {/*==================== Content of menu changes depending if user is logged in or not ====================*/}
        const loginRegLink = (
            // <div className="dropdown-menu">
            //     <Link to="/" className="dropdown-item"> Home </Link>
            //     <Link to="/login"  className="dropdown-item"> Log-in </Link>
            //     <Link to="/register"  className="dropdown-item"> Sign-up </Link>
            //     {/* <Link to="/login"  class="dropdown-item"> View Restaurants </Link> */}
            // </div>

            // <div class="dropdown show" className="cdropdown">
            //         <Login history = {this.props.history}/>
            //         <Register history = {this.props.history}/>
            //         <div class="dropdown-menu">
            //             <Link to="/" class="dropdown-item"> Home </Link>
            //             <Link to="" class="dropdown-item" data-toggle="modal" data-target="#modalLoginForm">Log-in</Link>
            //             <Link to="" class="dropdown-item" data-toggle="modal" data-target="#modalRegisterForm">Sign-up</Link>
            //         </div>
            // </div>
            <div className="header">
                <table>
                    <tr><p></p></tr>
                    <tr>
                        <td>
                            <Login history = {this.props.history}/>
                        </td>
                    </tr>
                 </table>   
             </div>           
            
            
        )

        const userLink = (
             // <div class="dropdown show" className="cdropdown">
             //        <div class="dropdown-menu">
             //            <Link to="/" class="dropdown-item"> Home </Link>
             //            <Link to="/profile" class="dropdown-item" data-toggle="modal" data-target="#modalLoginForm">Profile</Link>
             <div className="header">
                <table>
                    <tr><p></p></tr><tr>
                    <td>
                        <Link to="/profile">
                            <Button className="header-button"> Profile </Button>
                        </Link>
                    </td>
                    <td>
                        <Link to="" onClick={this.logOut.bind(this)}>
                            <Button className="header-button">Logout</Button>
                        </Link>
                    
                    </td>
                    </tr>

                 </table>   
             </div>           
            //         </div>
            // </div>

            // <div className="dropdown-menu">
            //     <Link to="/" className="dropdown-item"> Home </Link>
            //     <Link to="/profile" className="dropdown-item"> User </Link>
            //     <a href="" onClick={this.logOut.bind(this)} className="dropdown-item">Logout</a>
            // </div>
        )
        {/*=======================================================================================================*/}
        return (
                <header className="App-header">
                    <div className="clogo">
                        <Link to="/">
                            <img src={logo} className="logopic" />
                        </Link> 
                    </div>
                    {localStorage.usertoken ? userLink : loginRegLink}
                </header>
        
            // <div className="App">
            // <header className="App-header">
            //     <div className="clogo">
            //              <img src={logo} className="logopic" /> 
            //     </div>
            //     <table className="dropdown show">
            //         <tr>
            //             <td class="row1">Email</td>
            //             <td class="row1">Password</td>
            //         </tr>
            //         <tr>
            //             <td>
            //                 <input type="text" class="inputtext"></input>
            //             </td>
            //             <td>
            //                 <input type="text" class="inputtext"></input>
            //             </td>
            //             <td>
            //                 <button className="search-button">Login</button>
            //             </td>
            //         </tr>
            //         <tr>
                        
            //         </tr>
            //         </table>

            //     </header>
            // </div>
        )
    }
}

export default withRouter(Navbar)
