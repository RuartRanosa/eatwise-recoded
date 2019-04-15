
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// View all review from the review table in particular order

exports.viewReviews = function(req, res){
	var conn = res.locals.connection 																				// establishes the connection to the database																	
	conn.query('select * from review;', (err, result) => {															// MySQL query to select all data in review table
		if(!err){
			console.log(result)																						// returns result to server
			res.send(result)																						// returns result to client
		}else{
			return res.send(400, 'Could not get a connection');														// returns error message when connection fails
		}
	})
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Adds a review made by user
// Records shopId and userId 

exports.addReview = function(req, res){
	var conn = res.locals.connection																				// establishes connection to the database
	conn.query('insert into review(userId, reviewCreation, shopId, comment, tips, rating) values(' + req.body.userId, + ', "' + req.body.reviewCreation + '", "' + req.body.shopId + '", "' + req.body.comment + '", "' + req.body.tips + '", "' + req.body.rating + '");', (err,result) => { 											// MySQL query to insert the new review in the review table
		if(!err){
			console.log(result)																						// returns result to server
			res.send(result)																						// returns result to client
		}else{
			return res.send(400, 'Couldnt get a connection');														// returns error message when connection fails
		}
	})
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Update existing review in review table via reviewId 

exports.updateReview = function(req,res){
	var conn = res.locals.connection																				// establishes the connection to the database
	var reviewId = req.body.reviewId																				// saves the reviewId of the review to update
	var review = req.body.comment																					// saves the content of the updated review

	conn.query('update review set comment = "' + review +'" where reviewId = ' + reviewId + ';', (err,res) => {		// MySQL query to update the existing review via reviewId
		if(!err){
			console.log(result)																						// returns result to server
			res.send(result)																						// returns result to client
		}else{
			return res.send(400, 'Couldnt get a connection');														// returns error message when connection fails
		}
	})
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Deletes an existing review via reviewId

exports.deleteReview = function(req, res){
	var conn = res.locals.connection																				// establishes the connection to the database
	var reviewId = req.body.reviewId																				// saves the reviewId of the review to delete
	conn.query('delete from review where reviewId = ' + reviewId + ';', (err, result) => {							// MySQL query to delete existing review from the reivew table via reviewId
		if(!err){
			console.log(result)																						// returns result to the server
			res.send(result) 																						// returns result to the client
		}else{
			return res(400, 'Couldnt get a connection'); 															// returns error message when connection fails
		}
	})
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Searches all review by shop

exports.searchByShop = function(req, res){
	var conn = res.locals.connection 																				// establishes the connection to the database
	var shopId = req.body.shopId																					// saves the shopId of the shop where review are to be returned
	conn.query('select * from review where shopId = '+shopId+';', (err, result) => {								// MySQL query to select all reviews from a certain shop via shopId from review table
		if(!err){
			console.log(result)																						// returns result to server
			res.send(result) 	 																					// returns result to client
		}else{
			return res(400, 'Couldnt get a connection'); 															// returns error message when connection fails
		}
	})
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
