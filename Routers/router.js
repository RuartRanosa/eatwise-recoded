const mysql = require('mysql');
const express = require("express")
const app = express.Router()
const cors = require("cors")

app.use(cors())

process.env.SECRET_KEY = 'secret'

let connection = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'eatwise',
    connectionLimit: 10
});

// instantiate controllers
const controllerUser = require('./../Controllers/controllerUser.js')
const controllerShop = require('./../Controllers/controllerShop.js')
const controllerReview = require('./../Controllers/controllerReview.js')
const controllerReport = require('./../Controllers/controllerReport.js')


/* FORMAT
app.<method>(<'/path'>, function(req, res, next){
	res.locals.<variable_name> = <variable> // necessary to be able to pass a variable
	next()									// necessary to prevent endless wating for server
}, <controller_name>.<function_name>)		// call function in controller.js
*/

app.get('/', (req, res, next) => {
	res.send("Welcome to Eatwise Server!")
	next()
})

app.get('/view-users', (req, res, next) => {
		res.locals.connection = connection		
		next()
	}, controllerUser.viewUsers)

app.post('/add-user', (req, res, next) => {
		res.locals.connection = connection		
		next()
	}, controllerUser.addUser)

app.put('/update-user', (req, res, next) => {
		res.locals.connection = connection		
		next()
	}, controllerUser.updateUser)


app.delete('/delete-user', (req, res, next) => {
		res.locals.connection = connection		
		next()
	}, controllerUser.deleteUser)


app.post('/register', (req, res, next) => {
	res.locals.connection = connection	
	next()
}, controllerUser.register)

app.post('/login', (req, res, next) => {
	res.locals.connection = connection	
	next()
}, controllerUser.login)

app.get('/search-all-shops', (req, res, next) =>{
	res.locals.connection = connection		
	next()
}, controllerShop.searchByName)

app.get('/search-shop', (req, res, next) =>{
	res.locals.connection = connection		
	next()
}, controllerShop.searchByNameAndId)

app.get('/view-shops', (req, res, next) =>{
	res.locals.connection = connection		
	next()
}, controllerShop.viewShops)


app.post('/add-shop', (req, res, next) => {
	res.locals.connection = connection		
	next()
}, controllerShop.addShop)


module.exports = app








	 

	// connection.end(function(err) {
	//   if (err) {
	//     return console.log('error:' + err.message);
	//   }
	//   console.log('Close the database connection.');
	// })
