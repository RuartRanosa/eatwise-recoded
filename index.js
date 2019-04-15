
const mysql = require('mysql');
const cors = require('cors')
const express = require('express')
const bodyParser = require('body-parser')
var app = express()
var port = process.env.PORT || 3001

app.use(bodyParser.json())
app.use(cors())
app.use(
    bodyParser.urlencoded({
        extended: false
    })
)


var Users = require('./Routers/router.js')

app.use(Users)

app.listen(port, () => {
    console.log("Server is running on port: " + port)
})