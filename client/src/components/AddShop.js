import React, { Component } from 'react'
import { Link, withRouter } from 'react-router-dom'

class AddShop extends Component {
  constructor(){
        super()
        this.state = {
            name: "",
            avgPrice: "",
            type: "",
            location: "",
            description: "",
            menu: "",
            votes: 0
        }
        this.onChange = this.onChange.bind(this)
        this.onSubmit = this.onSubmit.bind(this)

  }

  onChange (e) {
        this.setState({ [e.target.name]: e.target.value })
    }

  onSubmit(e){
    e.preventDefault()

    fetch('http://localhost:3001/add-shop',
      {
        method: "POST",
        headers: {
          'Content-Type': "application/json"
        }, body: JSON.stringify({
            name: this.state.name,
            avgPrice: this.state.avgPrice,
            type: this.state.type,
            location: this.state.location,
            description: this.state.description,
            menu: this.state.menu,
            votes: this.state.votes
        })
      })
          .then((result) => {
              console.log({result})
          })
          .catch((e) => { console.log(e)});

  }

    render () {
        return (
            <div className = "container">
              <div className = "row">
                <form noValidate onSubmit = {this.onSubmit}>
                  <h1 className="h3 mb-3 font-weight-normal">Add Shop</h1>
                  <div className = "form-group">
                    <label htmlFor = "name"> Shop Name: </label>
                    <input type = "text"
                      className = "form-control"
                      name = "name"
                      placeholder = "Enter shop name..."
                      value = {this.state.username}
                      onChange = {this.onChange}/>
                  </div>

                  <div className = "form-group">
                    <label htmlFor = "name"> Average Pricing: </label>
                    <input type = "text"
                      className = "form-control"
                      name = "avgPrice"
                      placeholder = "Enter the average price of shop items..."
                      value = {this.state.avgPrice}
                      onChange = {this.onChange}/>
                  </div>
                  <div className = "form-group">
                    <label htmlFor = "name"> Type: </label>
                    <input type = "text"
                      className = "form-control"
                      name = "type"
                      placeholder = "Enter shop type..."
                      value = {this.state.type}
                      onChange = {this.onChange}/>
                  </div>
                  <div className = "form-group">
                    <label htmlFor = "name"> Location: </label>
                    <input type = "text"
                      className = "form-control"
                      name = "location"
                      placeholder = "Enter shop location..."
                      value = {this.state.location}
                      onChange = {this.onChange}/>
                  </div>
                  <div className = "form-group">
                    <label htmlFor = "name"> Description: </label>
                    <input type = "text"
                      className = "form-control"
                      name = "description"
                      placeholder = "Enter shop description..."
                      value = {this.state.description}
                      onChange = {this.onChange}/>
                  </div>
                  <div className = "form-group">
                    <label htmlFor = "name"> Menu: </label>
                    <input type = "text"
                      className = "form-control"
                      name = "menu"
                      placeholder = "Enter shop menu..."
                      value = {this.state.menu}
                      onChange = {this.onChange}/>
                  </div>
                  <div className = "form-group">
                    <label htmlFor = "name"> Votes: </label>
                    <input type = "text"
                      className = "form-control"
                      name = "votes"
                      placeholder = "Enter number of votes..."
                      value = {this.state.votes}
                      onChange = {this.onChange}/>
                  </div>

                  <button type = "submit"
                    className = "search-button">
                      Proceed
                  </button>

                </form>
              </div>
            </div>
        )
    }
}

export default AddShop
