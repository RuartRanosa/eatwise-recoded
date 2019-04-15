import React, { Component } from 'react';
import { Button } from 'react-bootstrap';
import { Link, withRouter } from 'react-router-dom'
import SearchShop from './SearchShop'

import pic1 from './../1.jpg'
import pic2 from './../2.jpg'
import pic3 from './../3.jpg'
import dropdownMenu from './../dropdown.png';
import './../App.css';
import elementType from 'prop-types-extra/lib/elementType';
import StarRatingComponent from 'react-star-rating-component';
import Image from 'react-bootstrap/Image'



class Landing extends Component {
    constructor(){
        super()
        this.state = {
            user:[],
            shops: [],
            shopName: ""
        }
        this.getData = this.getData.bind(this)
    }

    componentDidMount(){
        this.getData()
    }


     getData() {
        
    }


    render(){
      
      {/*
        const data = this.state.user
        const items = data.map((i) => <li key = {i.userId}>
        Username: {i.username}
        Admin Access: {i.adminAccess}
        Display Name: {i.displayName}
      </li>)
      */}
{/*
      <div className="App">
        <header className="App-header">
          <div className="clogo">
            <img src={logo} className="logopic" /> 
          </div>
            <SearchShop/>
          </header>
        </div>
*/}
      return (  
        <div className="App">
          <header className="App-header">
            <body className="App-body">
              <article className="slideshow">
                <article className="pictures">
                  <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                    <div class="carousel-inner">
                      <div class="carousel-item active">
                        <img class="d-block w-100" src={pic2} alt="First slide" className="pic2"/>
                      </div>
                      <div class="carousel-item">
                        <img class="d-block w-100" src={pic3} alt="Second slide" className="pic2"/>
                      </div>
                      <div class="carousel-item">
                        <img class="d-block w-100" src={pic1} alt="Third slide" className="pic2"/>
                      </div>
                    </div>
                    <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
                      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                      <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
                      <span class="carousel-control-next-icon" aria-hidden="true"></span>
                      <span class="sr-only">Next</span>
                    </a>
                  </div> 
                </article>
              <SearchShop/>

              </article>
            </body>
          </header>
        </div>
      );   
    }
}

export default Landing
