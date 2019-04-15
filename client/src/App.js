import React, { Component } from 'react';
import { BrowserRouter as Router, Route } from 'react-router-dom'

import Navbar from './components/Navbar'
import Landing from './components/Landing'
import Register from './components/Register'
import Profile from './components/Profile'
import Login from './components/Login'
import Shop from './components/Shop'

class App extends Component {
    render() {
        return (
            <Router>
                <Navbar/>
                <Route exact path="/" component={Landing} />
                <Route exact path="/register" component={Register} />
                <Route exact path="/login" component={Login} />
                <Route exact path="/profile" component={Profile} />
                <Route exact path="/shop" component={Shop} />
            </Router>
        );
    }
}

export default App;
