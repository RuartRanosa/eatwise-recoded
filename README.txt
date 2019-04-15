// INSTALL APPLICATIONS TO BE USED ========================================================================
	1.) install mariadb
			https://computingforgeeks.com/install-mariadb-10-on-ubuntu-18-04-and-centos-7/
	2.) install nodejs
			sudo npm cache clean -f
			sudo npm install -g n
			sudo n stable
// LOAD DATABASE ==========================================================================================
	1.) open mysql/ mariadb by typing in cmd:
			mysql -u root -p
			// enter your password if prompted

	2.) load database by typing:
			source eatwise.sql

// INSTALLATION ===========================================================================================
	# Go to any directory (In my case "Desktop")
	
	1.) mkdir Eatwise
	
	2.) cd Eatwise
	
	3.) mkdir back-end 
	
	4.) cd back-end
	
	5.) do the following:
		npm init								
		npm install mysql	
		npm install --save express  	
		npm install --save express body-parser 	
		npm install --save express-session
		npm install bcryptjs			
		npm install express-jwt			
		npm install request						
		npm install cors

	6.) cd ../
	
	7.) install create-react-app
		sudo npm install -g create-react-app
	
	8.) create folder "front-end"	
		create-react-app front-end
		cd front-end
	
	9.) do the following:
		npm install react-bootstrap
		npm install --save react-router react-router-dom
		npm install --save axios
		npm install jwt-decode
		npm install query-string
		npm install react-star-rating-component --save

	10.) copy files from back-end and front-end folders from team drive to your local back-end and front-end folders
		10.1.) for the back-end subfolder copy the following:
				Controllers 		(folder)
				Routers 			(folder)
				index.json			(file)
				request.js 			(file)

		10.2.) For the front-end subfolder copy the following:
				src 				(folder)

	11.) Edit router.js in back-end/Routers
				let connection = mysql.createConnection({
				    host: 'localhost',
				    user: 'root',
				    password: '',
				    database: 'eatwise'
				});
		// change the password value to the password of your mariadb/ mysql database 

	12.) modify "package.json" in the "front-end" subfolder and add "proxy": "http://localhost:3000",
			ex.				{
							  "name": "front-end",
							  "version": "0.1.0",
							  "private": true,
							  "dependencies": {
							    "axios": "^0.18.0",
							    "react": "^16.8.4",
							    "react-dom": "^16.8.4",
							    "react-router": "^5.0.0",
							    "react-router-dom": "^5.0.0",
							    "react-scripts": "2.1.8"
							  },
							  "scripts": {
							    "start": "react-scripts start",
							    "build": "react-scripts build",
							    "test": "react-scripts test",
							    "eject": "react-scripts eject"
							  },
							  "eslintConfig": {
							    "extends": "react-app"
							  },
		    HERE------->>>	  "proxy": "http://localhost:3000",
							  "browserslist": [
							    ">0.2%",
							    "not dead",
							    "not ie <= 11",
							    "not op_mini all"
							  ]
							} 

// RUN SERVERS ==============================================================================================
	1. open 2 terminals

	2. cd Eatwise/back-end 			(in the 1st terminal)

	3. node index.js 				(start nodejs server)
	
	4. cd Eatwise/front-end 		(in the 2nd terminal)

	5. npm start 					(start reactjs)


