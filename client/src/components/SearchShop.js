import React, { Component } from 'react'
import { Link, withRouter } from 'react-router-dom'
import './../App.css';
import pic1 from './../3.jpg'
import StarRatingComponent from 'react-star-rating-component';
import Image from 'react-bootstrap/Image'
import { Button } from 'react-bootstrap';

class SearchShop extends Component {
  constructor(){
        super()
        this.state = {
            shops: [],
            total: 0
        }
        this.searchShop = this.searchShop.bind(this)
        this.randomize = this.randomize.bind(this)
  }

  searchShop(e){
    const query = e.target.value;

    fetch('http://localhost:3001/search-all-shops/?name='+query)
          .then((response) => { return response.json() })
          .then((result) => {
              console.log(result)
              this.setState({shops: result})
          })
          .catch((e) => { console.log(e)});

  }

  randomize(){
    const array = []
    var min = 1;
    const rand = Math.floor(min + Math.random() * (this.state.total - min));
    console.log(rand)
    fetch('http://localhost:3001/view-shops/')
            .then((response) => { return response.json() })
            .then((result) => {
                console.log(result[rand])
                array.push(result[rand])
                console.log(array)
                this.setState({shops: array})
            })
            .catch((e) => { console.log(e)});

  }


  componentDidMount(){
    fetch('http://localhost:3001/view-shops/')
            .then((response) => { return response.json() })
            .then((result) => {
                console.log(result)
                this.setState({shops: result})
                this.setState({total: result.length})
            })
            .catch((e) => { console.log(e)});
  }

    render () {
        {/*Function for returning all shops that match the searched word*/}
        const Suggestions = (props) => {
          const data = props  
          const options = this.state.shops.map((r) => (
            <Link to={"/shop/?shopName="+r.name+"&shopId="+r.shopId}> 
              <div className="search-item">
                <table class = "text-left">
                  
                    <td> 
                      <li key={r.shopId}>
                        <div class="image">
                          <Image class="d-block w-100" src={pic1} alt="Third slide" className="pic2" rounded/>
                          <h5><span>
                            {r.name}
                            <StarRatingComponent 
                              editing={false}
                              starCount={5}
                              value={r.votes}
                            />
                          </span></h5>
                          <h6><span>Description: {r.description} </span></h6>
                          
                        </div>
                    </li>
                    </td>
                  
               </table>
              </div>
            </Link>
          ))
          return <ul>{options}</ul>
        }

        return (
              <body>
                  {/*=================Search bar & results =================*/}
                <article className="csearch-bar">
                  <Button className = "search-button"
                    onClick = {this.randomize} 
                    >Randomize</Button>
                  <input type="text"
                    className="search-bar"
                    name="Search"
                    placeholder="Search for restaurants..."
                    value={this.state.query}
                    onChange={this.searchShop}
                  />
                  <Suggestions results = {this.state.shops} />
                {/*=========================================================*/}
                </article>
              </body>            
        )
    }
}

export default SearchShop