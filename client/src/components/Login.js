import React, { Component } from 'react'
import { login } from './UserFunctions'
import { Button } from 'react-bootstrap';
import { Link, withRouter } from 'react-router-dom'

class Login extends Component {
    constructor() {
        super()
        this.state = {
            email: '',
            password: '',
        }
        this.onChange = this.onChange.bind(this)
        this.onSubmit = this.onSubmit.bind(this)
    }

    onChange (e) {
        this.setState({ [e.target.name]: e.target.value })
    }

    onSubmit (e) {
        e.preventDefault()

        const user = {
            email: this.state.email,
            password: this.state.password
        }

        login(user).then(res => {
            if (res) {
                this.props.history.push(`/profile`)
            }
        })
    }

    render () {
        return (
            // <div className="container">
            //     <div className="row">
            //         <div className="col-md-6 mt-5 mx-auto">
            //             <form noValidate onSubmit={this.onSubmit}>
            //                 <h1 className="h3 mb-3 font-weight-normal">Please sign in</h1>
            //                 <div className="form-group">
            //                     <label htmlFor="email">Email Address</label>
            //                     <input type="email"
            //                         className="form-control"
            //                         name="email"
            //                         placeholder="Enter Email"
            //                         value={this.state.email}
            //                         onChange={this.onChange} />
            //                 </div>
            //                 <div className="form-group">
            //                     <label htmlFor="password">Password</label>
            //                     <input type="password"
            //                         className="form-control"
            //                         name="password"
            //                         placeholder="Enter Password"
            //                         value={this.state.password}
            //                         onChange={this.onChange} />
            //                 </div>
            //                 <button type="submit"
            //                     className = "btn btn-lg btn-primary btn-lock">
            //                     Sign in
            //                 </button>
            //             </form>
            //         </div>
            //     </div>
            // </div>

            // <div class="modal fade" id="modalLoginForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            //     <form noValidate onSubmit={this.onSubmit}>
            //           <div class="modal-dialog" role="document">
            //             <div class="modal-content">
            //               <div class="modal-header text-center">
            //                 <h4 class="modal-title w-100 font-weight-bold">Sign in</h4>
            //                 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            //                   <span aria-hidden="true">&times;</span>
            //                 </button>
            //               </div>

            //               <div class="modal-body mx-3">
            //                 <div class="md-form mb-5">
            //                   <i class="fas fa-envelope prefix grey-text"> </i>
            //                   <input type="email"
            //                    id="defaultForm-email" 
            //                    class="form-control validate" 
            //                    name="email"
            //                    placeholder="Email" 
            //                    value={this.state.email}
            //                    onChange={this.onChange}/>
            //                   <label data-error="wrong" data-success="right" for="defaultForm-email"> </label>
            //                 </div>

            //                 <div class="md-form mb-4">
            //                   <i class="fas fa-lock prefix grey-text"> </i>
            //                   <input type="password" 
            //                     id="defaultForm-pass" 
            //                     class="form-control validate" 
            //                     name="password"
            //                     placeholder="Password"
            //                     value={this.state.password}
            //                     onChange={this.onChange}/>
            //                   <label data-error="wrong" data-success="right" for="defaultForm-pass"> </label>
            //                 </div>

            //               </div>
            //               <div class="modal-footer d-flex justify-content-center">
            //                 <button type="submit"
            //                   // data-dismiss="modal"
            //                   class="btn btn-default">
            //                     Login
            //                 </button>
            //               </div>
            //             </div>
            //           </div>
            //     </form>
            // </div>

           
              <form noValidate onSubmit={this.onSubmit}>  
                <table>
                    <tr>
                        <td class="row1">Email</td>
                        <td class="row1">Password</td>
                    </tr>
                    <tr>
                        <td>
                            <input type="email" class="inputtext"
                            name="email"
                            placeholder="Email"
                            value={this.state.email}
                            onChange={this.onChange}></input>
                        </td>
                        <td>
                            <input type="password" class="inputtext"
                            name="password"
                            placeholder="Password"
                            value={this.state.password}
                            onChange={this.onChange}></input>
                        </td>
                        <td>
                            <Button type="submit" className="header-button">Login</Button>
                        </td>
                        <Link to="/register"><Button className="header-button"> Sign-up</Button> </Link>
                    </tr>
                    <tr>
                        
                    </tr>
                    </table>
                  </form>      
                
        )
    }
}

export default Login