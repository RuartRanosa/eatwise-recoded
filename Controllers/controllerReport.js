
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Prints all the reports in no particular order

exports.viewReports = function(req, res){
	var conn = res.locals.connection																				// establishes the connection to the database
	conn.query('select * from report;', (err, result) => {															// MySQL query to select all data from report table
		if(!err){																									// prints all the data received from the query in the server and client's side
			console.log(result)
			res.send(result)
		}else{
			return res.send(400, 'Could not get a connection');														// returns an error message if the connection fails 
		}
	})
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Adds a report on a shop from a user via shopId

exports.addReport = function(req, res){
	var conn = res.locals.connection  																				// establishes the connection to the database
	conn.query('insert into report(userId, reportCreation, shopId, reason) values(' + req.body.userId, + ', "' + req.body.reportCreation + '", "' + req.body.shopId + '", "' + req.body.reason + '");', (err,result) => {				// MySQL query to add the user's report on a certain shop specified by the shopId 
		if(!err){																									// prints the result both on the server and client's side
			console.log(result)
			res.send(result)
		}else{
			return res.send(400, 'Could not get a connection');														// returns an error message if the connection fails 
		}
	})
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Updates an existing report in the database via reportId 

exports.updateReport = function(req,res){
	var conn = res.locals.connection 																				// establishes the connection to the database
	var reportId = req.body.reportId																				// saves the reportId of the report to update 
	var report = req.body.reason																					// saves the content of the report 

	conn.query('update report set reason = "' + report +'" where reportId = ' + reportId + ';', (err,res) => {		// MySQL query to update report via reportId
		if(!err){ 																									// prints the result both on the server and client's side
			console.log(result)
			res.send(result)
		}else{
			return res.send(400, 'Couldnt get a connection');														// returns an error message if the connection fails 
		}
	})
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Deletes an existing report from the report table via reportId

exports.deleteReport = function(req, res){
	var conn = res.locals.connection 																				// establishes the connection to the database
	var reportId = req.body.reportId 																				// saves the reportId of the report to delete 
	conn.query('delete from report where reportId = ' + reportId + ';', (err, result) => {							// MySQL query to delete the report via reportId
		if(!err){																									// prints the result both on the server and client's side
			console.log(result)
			res.send(result)
		}else{
			return res(400, 'Couldnt get a connection');															// returns an error message if the connection fails
		}
	})
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Searches reports from a certain shop via shopId from the report table

exports.searchByShop = function(req, res){
	var conn = res.locals.connection 																				// establishes the connection to the database 
	var shopId = req.body.shopId																					// saves the shopId of the shop to search
	conn.query('select * from report where shopId = '+shopId+';', (err, result) => { 								// MySQL query to select the shop from the report table via shopId
		if(!err){			 																						// prints the result both on the server and client's side
			console.log(result)
			res.send(result)
		}else{
			return res(400, 'Couldnt get a connection');															// returns an error message if the connection fails
		}
	})
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
