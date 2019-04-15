///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Prints all the shops in no particular order

exports.viewShops = function(req, res){
	var conn = res.locals.connection																				// establishes the connection to the database
	conn.query('select * from shop;', (err, result) => {															// MySQL query to select all data from report table
		if(!err){																									// prints all the data received from the query in the server and client's side
			console.log(result)
			res.send(result)
		}else{
			return res.send(400, 'Could not get a connection');														// returns an error message if the connection fails 
		}
	})
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Adds a shop from a user

exports.addShop = function(req, res){
	var conn = res.locals.connection																				// establishes the connection to the database
	conn.query('insert into shop(name, avgPrice, type, location, description, menu, votes) values("'+req.body.name+'","'+req.body.avgPrice+'","'+req.body.type+'","'+req.body.location+'","'+req.body.description+'","'+req.body.menu+'",'+req.body.votes+');', (err,result) => {
		if(!err){																									// prints the result both on the server and client's side
			console.log(result)
			res.send(result)
		}else{
			console.log(err)
			return res.send(400, 'Couldnt get a connection');														// returns an error message if the connection fails 
		}
	})
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Updates an existing shop in the database via shopId 

exports.updateShop = function(req,res){
	var conn = res.locals.connection 																				// establishes the connection to the database
	var shopId = req.body.shopId																				   // saves the shopId of the shop to update 
	var shop = req.body.name																					  // saves the content of the shop

	conn.query('update shop set name = "' + shop +'" where shopId = ' + shopId + ';', (err,res) => {			 // MySQL query to update shop via shopId
		if(!err){ 																								// prints the result both on the server and client's side
			console.log(result)
			res.send(result)
		}else{
			return res.send(400, 'Couldnt get a connection');												   // returns an error message if the connection fails 
		}
	})
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Deletes an existing shop from the shop table via shopId

exports.deleteShop = function(req, res){
	var conn = res.locals.connection 																	    // establishes the connection to the database
	var shopId = req.body.shopId 																			// saves the shopId of the shop to delete 
	conn.query('delete from shop where shopId = ' + shopId + ';', (err, result) => {						// MySQL query to delete the shop via shopId
		if(!err){																						    // prints the result both on the server and client's side
			console.log(result)
			res.send(result)
		}else{
			return res(400, 'Couldnt get a connection');													// returns an error message if the connection fails
		}
	})
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Searches names of shops via shopId from the shop table

exports.searchByName = function(req, res){
	var conn = res.locals.connection 																		// establishes the connection to the database 
	var shopName = req.query.name																			// saves the shopName of the shop to search
	console.log(shopName)
	conn.query('select * from shop where name = "'+shopName+'";', (err, result) => { 								// MySQL query to select the shopName from the shop table via shopName
		if(!err){			 																				// prints the result both on the server and client's side
			console.log(result)
			res.send(result)
		}else{
			return res.status(400).send('Couldnt get a connection')
            // return res.send(400, 'Couldnt get a connection');															// returns an error message if the connection fails
        }
	})
}

exports.searchByNameAndId = function(req, res){
	var conn = res.locals.connection 																		// establishes the connection to the database 
	var shopName = req.query.name																			// saves the shopName of the shop to search
	var shopId = req.query.id
	console.log(shopName)
	conn.query('select * from shop where name = "'+shopName+'" && shopId="'+shopId+'";', (err, result) => { 								// MySQL query to select the shopName from the shop table via shopName
		if(!err){			 																				// prints the result both on the server and client's side
			console.log(result)
			res.send(result)
		}else{
			return res.status(400).send('Couldnt get a connection')
            // return res.send(400, 'Couldnt get a connection');															// returns an error message if the connection fails
        }
	})
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////