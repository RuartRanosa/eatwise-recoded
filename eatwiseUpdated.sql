CREATE DATABASE IF NOT EXISTS `eatwise` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `eatwise`;


create table if not exists user(
	userId int(5) not null auto_increment,
	adminAccess boolean NOT NULL,
	username varchar(50),
	email varchar(50),
	displayName varchar(50),
	password BLOB,
	location varchar(50) not null,
	primary key(userId)
); /*ENGINE = InnoDB DEFAULT CHARSET = latin1*/

create table if not exists shop(
	shopId int(5) not null auto_increment,
	name varchar(50),
	avgPrice varchar(50),
	type varchar(50),
	location varchar(50),
	description varchar(50),
	menu varchar(50),
	votes int(10),
	primary key(shopId)
); /*ENGINE = InnoDB DEFAULT CHARSET = latin1*/

create table if not exists review(
	reviewId int(5) not null auto_increment,
	userId int(5) not null,
	reviewCreation TIMESTAMP NOT NULL DEFAULT(curdate()),
	shopId int(5) not null,
	comment varchar(150),
	tips varchar(150),
	rating int(1) not null,
	primary key(reviewId)
); /*ENGINE = InnoDB DEFAULT CHARSET = latin1;*/

create table if not exists report(
	reportId int(5) not null auto_increment,
	userId int(5) not null,
	reportCreation TIMESTAMP NOT NULL DEFAULT(current_timestamp()),
	shopId int(5) not null,
	reason varchar(150),
	primary key(reportId)
); /*ENGINE = InnoDB DEFAULT CHARSET = latin1;*/

create table if not exists log_user(
	logId int(5) not null auto_increment,
	time_stamp TIMESTAMP NOT NULL DEFAULT(current_timestamp()),
	action varchar(10),
	userId int(5) not null,
	adminAccess boolean,
	username varchar(50),
	displayName varchar(50),
	password varchar(50),
	location varchar(50),
	primary key(logId)
);

create table if not exists log_shop(
	logId int(5) not null auto_increment,
	time_stamp TIMESTAMP NOT NULL DEFAULT(current_timestamp()),
	action varchar(10),
	shopId int(5) not null,
	name varchar(50),
	avgPrice varchar(50),
	type varchar(50),
	location varchar(50),
	description varchar(50),
	menu varchar(50),
	votes int(10),
	primary key(logId)
);

create table if not exists log_review(
	logId int(5) not null auto_increment,
	time_stamp TIMESTAMP NOT NULL DEFAULT(current_timestamp()),
	action varchar(10),
	reviewId int(5) not null,
	userId int(5),
	reviewCreation TIMESTAMP,
	shopId int(5),
	comment varchar(150),
	tips varchar(150),
	rating int(1),
	primary key(logId)
);

create table if not exists log_report(
	logId int(5) not null auto_increment,
	time_stamp TIMESTAMP NOT NULL DEFAULT(current_timestamp()),
	action varchar(10),
	reportId int(5) not null,
	userId int(5),
	reportCreation TIMESTAMP,
	shopId int(5),
	reason varchar(150),
	primary key(logId)
);


/* VIEW BT TYPE */

DELIMITER $$
CREATE PROCEDURE viewByType(atype varchar(50))
DETERMINISTIC
BEGIN
	SELECT * from shop where type = atype;
END $$
DELIMITER ;

/* VIEW BT RATING */

DELIMITER $$
CREATE PROCEDURE viewByRating(in param int)
DETERMINISTIC
BEGIN
	SELECT * from shopRates where avgRating >= param;
END $$
DELIMITER ;

/* ADD USER */

DELIMITER //
CREATE PROCEDURE addUser(
aadminAccess boolean,
ausername varchar(50),
aemail varchar(50),
adisplayName varchar(50),
apassword BLOB,
alocation varchar(50)
)
BEGIN
	insert into user(adminAccess, username, email, displayName, password, location) values (aadminAccess, ausername, aemail, adisplayName, AES_ENCRYPT(apassword, 'secret'), alocation);
END	//
DELIMITER ;

/* ADD SHOP */

DELIMITER //
CREATE PROCEDURE addShop(
	aname varchar(50),
	aavgPrice varchar(50),
	atype varchar(50),
	alocation varchar(50),
	adescription varchar(50),
	amenu varchar(50),
	votes int(5)
)
BEGIN
	insert into shop(name, avgPrice, type, location, description, menu, votes) values (aname, aavgPrice, atype, alocation, adescription, amenu, 0);
END	//
DELIMITER ;

/* ADD REPORT */

DELIMITER |
CREATE PROCEDURE addReport(
	auserId int(5),
	ashopId int(5),
	-- ausername varchar(50),
	areason varchar(150)
)
BEGIN
	insert into report(userId, shopId, reason) values (auserId, ashopId, areason);
END	|
DELIMITER ;

/* ADD REVIEWS */

DELIMITER |
CREATE PROCEDURE addReview(
	auserId int(5),
	ashopId int(5),
	areason varchar(150)
)
BEGIN
	insert into review(userId, shopId, reason) values (auserId, ashopId, areason);
END	|
DELIMITER ;

/* EDIT SHOP */

DELIMITER |
CREATE PROCEDURE editShop(
	ashopId int(5),
	aname varchar(50),
	aavgPrice varchar(50),
	atype varchar(50),
	alocation varchar(50),
	adescription varchar(50)
)
BEGIN
	update shop
	set name = aname, avgPrice = aavgPrice, type = atype, location = alocation, description = adescription
	where shopId = ashopId;
END	|
DELIMITER ;

/* DELETE SHOP */

DELIMITER |
CREATE PROCEDURE deleteShop(
	dshopId varchar(50)
)
BEGIN
	delete from shop where shopId = dshopId;
END	|
DELIMITER ;

/* DELETE REPORT */

DELIMITER |
CREATE PROCEDURE deleteReport(
	duserId int(5),
	dshopId int(5)
)
BEGIN
	delete from report where userId = duserId and shopId = dshopId;
END	|
DELIMITER ;

/* DELETE REVIEW */

DELIMITER |
CREATE PROCEDURE deleteReview(
	duserId int(5),
	dshopId int(5)
)
BEGIN
	delete from review where userId = duserId and shopId = dshopId;
END	|
DELIMITER ;

/* VIEW REPORTS */

DELIMITER |
CREATE PROCEDURE viewReports()
BEGIN
	select s.name, u.displayname, r.reason, r.reportCreation 
	from report r
	INNER JOIN user u on u.userId = r.userId 
	INNER JOIN shop s on s.shopId = r.shopId
	order by r.shopId;

END	|
DELIMITER ;

/* VIEW REVIEWS */

DELIMITER |
CREATE PROCEDURE viewReviews()
BEGIN
	select s.name, u.displayname, r.reason, r.reportCreation 
	from report r
	INNER JOIN user u on u.userId = r.userId 
	INNER JOIN shop s on s.shopId = r.shopId
	order by r.shopId;
END	|
DELIMITER ;

/* RANDOMIZER */

DELIMITER |
CREATE PROCEDURE randomize()
BEGIN
	select * from shop
	order by rand()
	limit 1;
END |
DELIMITER ;

/* FUNCTION TO CALCULATE AVERAGE RATING */

DELIMITER //
CREATE FUNCTION calcAvgRating(sId INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE avgRating FLOAT;
	SET avgRating = (select avg(rating) from review where shopId = sId);

	RETURN avgRating;
END //

DELIMITER ;

/**************** END OF PROCEDURES AND FUNCTIONS ****************/

call addUser(false, 'cchambers0', 'cc@gmail.com', 'Crosby', 'AeA60qT1Ms', 'Taranovskoye');
call addUser(false, 'gjensen1', 'cc@gmail.com', 'Gordon', 'RlsFC2Q', 'Dalmeny');
call addUser(false, 'hpaish2', 'cc@gmail.com', 'Hewe', 'WGkQiejkPV5', 'Mahendranagar');
call addUser(true, 'ccasbolt3', 'cc@gmail.com', 'Curr', 'h9oqbCR', 'Souto');
call addUser(false, 'hcastelin4', 'cc@gmail.com', 'Herman', 'bmumzBKqCW', 'Keruguya');
call addUser(true, 'cabramchik5', 'cc@gmail.com', 'Clywd', 'FzHd5i5HJpiW', 'Budapest');
call addUser(false, 'nbedo6', 'cc@gmail.com', 'Niel', 'w6inM9P0', 'Madamba');
call addUser(true, 'mmoakson7', 'cc@gmail.com', 'Matthias', '7fLi78phE', 'Pasarbaru');
call addUser(true, 'wbrimm8', 'cc@gmail.com', 'Warde', '4oZ3CK', 'Wakimachi');
call addUser(false, 'bternent9', 'cc@gmail.com', 'Bealle', 'AtHVgTI3iJw', 'Neftegorsk');
call addUser(true, 'lfeaka', 'cc@gmail.com', 'Lemmy', 'O7rPKc85', 'Saint-Augustin-de-Desmaures');
call addUser(true, 'bdonoherb', 'cc@gmail.com', 'Brandon', 'Gfwm36p', 'Batanamang');
call addUser(true, 'rcutmerec', 'cc@gmail.com', 'Redford', 'TgxEbRa9Si', 'Karangbaru');
call addUser(true, 'climerickd', 'cc@gmail.com', 'Cullie', '7oIYddL', 'Aguitu');
call addUser(true, 'esivyere', 'cc@gmail.com', 'Erhart', 'wvFMTuJiK', 'Examília');
call addUser(true, 'nyeldingf', 'cc@gmail.com', 'Niko', '4Yar7N', 'Usquil');
call addUser(true, 'bhamillg', 'cc@gmail.com', 'Benny', 'RRY8Bihp5VSJ', 'Shahr-e Qods');
call addUser(true, 'fturfsh', 'cc@gmail.com', 'Freeman', 'aqXiKMi', 'Bang Nam Priao');
call addUser(false, 'hbegginii', 'cc@gmail.com', 'Hayes', 'osKhcsLXTFN', 'La Rochelle');
call addUser(false, 'bonnj', 'cc@gmail.com', 'Brook', '1pClrq', 'Innoshima');
call addUser(true, 'ggreenroadk', 'cc@gmail.com', 'Giffie', 'uzeSLPlY', 'Bieniewice');
call addUser(false, 'tyackiminiel', 'cc@gmail.com', 'Torry', 'aDwp3z', 'Plettenberg Bay');
call addUser(false, 'ndunnettm', 'cc@gmail.com', 'Neel', 'gzR8c6IF6b', 'Venda Nova');
call addUser(false, 'aliesn', 'cc@gmail.com', 'Alex', 'rnVQADDfTxhq', 'Tunoshna');
call addUser(false, 'evalentino', 'cc@gmail.com', 'Ebeneser', 'fnU1xzxzt', 'Jiupu');
call addUser(true, 'tilchukp', 'cc@gmail.com', 'Trstram', '0glnwA6Zs', 'Penhascoso');
call addUser(true, 'ikiehnltq', 'cc@gmail.com', 'Isacco', 'V9QlVPh', 'Paris La Défense');
call addUser(true, 'rbrightyr', 'cc@gmail.com', 'Ron', '9mS9RwdQKVb', 'Santo Domingo');
call addUser(true, 'kwinsers', 'cc@gmail.com', 'Kyle', 'ErakDecIAJo9', 'Yeniköy');
call addUser(true, 'lzohrert', 'cc@gmail.com', 'Laurie', 'hy18PmskdYZs', 'Candoso');
call addUser(true, 'wohannayu', 'cc@gmail.com', 'Wallace', 'P3Li6pPU', 'Sano');
call addUser(false, 'ddunbletonv', 'cc@gmail.com', 'Dylan', 'd34eWrBOhgAn', 'Markivka');
call addUser(true, 'giwanowiczw', 'cc@gmail.com', 'Gothart', 'dyMl6cbq', 'Chornyanka');
call addUser(true, 'rbeverstockx', 'cc@gmail.com', 'Ryan', '9y4Ic72G2sgK', 'Lyubech');
call addUser(false, 'ngoldspinky', 'cc@gmail.com', 'Nicolai', 'Ey52QLzJh', 'Qinshi');
call addUser(true, 'charnorz', 'cc@gmail.com', 'Cully', 'OauhZG', 'Nedakonice');
call addUser(true, 'ckerton10', 'cc@gmail.com', 'Corbet', 'W0JdTSAe7SnE', 'Hengxizhen');
call addUser(true, 'zscrimgeour11', 'cc@gmail.com', 'Zacharias', 'KBvU6g', 'Floriana');
call addUser(true, 'tgriffoen12', 'cc@gmail.com', 'Travus', 'W7T0ZFQx2E', 'Long Loreh');
call addUser(true, 'cricardon13', 'cc@gmail.com', 'Calv', 'wevxlg', 'Pajung');
call addUser(true, 'mdavidescu14', 'cc@gmail.com', 'Mervin', 'NCfrv1zt', 'Poitiers');
call addUser(true, 'ntabbernor15', 'cc@gmail.com', 'Nikolaus', 'MiIhgz3MJk02', 'Wushi');
call addUser(true, 'cbrightey16', 'cc@gmail.com', 'Ches', '3SfBdQycn', 'Viana');
call addUser(true, 'hattow17', 'cc@gmail.com', 'Horace', 'PGAp7Mx4A', 'Bandeirantes');
call addUser(false, 'rbrandenberg18', 'cc@gmail.com', 'Raimundo', 'gXcpcgPKUs2', 'Birayang');
call addUser(false, 'lharteley19', 'cc@gmail.com', 'Land', 'SJb0Kfz2', 'La Paz');
call addUser(true, 'dmoakes1a', 'cc@gmail.com', 'Dirk', 'ZnXEq9JU', 'Gerong');
call addUser(true, 'sscutter1b', 'cc@gmail.com', 'Sid', 'CQ1A7HW', 'Stoney Ground');
call addUser(true, 'candrivel1c', 'cc@gmail.com', 'Craig', 'CrRhTP', 'Communal');
call addUser(false, 'rdhooge1d', 'cc@gmail.com', 'Ronny', 'bLd7PjdXF', 'Xiaozhi');

	-- call addShop('name', avgprice, 'type', 'location', 'desc', 'menu', votes);

call addShop("Miguelito's Ice Cream", "20-55", "Snack Bar", "14.174815, 121.243237", "Ice Cream Stand", "", 0);
call addShop("Mia Vita", "45-70", "Cafe", "14.1764962, 121.2426650", "Milk Tea Store", "", 0);
call addShop("Herb Republic", "45-245", "Restaurant", "14.175949, 121.242746", "Organic Restaurant", "", 0);
call addShop("Spice Jar", "60-200", "Restaurant", "14.175480, 121.242846", "Tex-Mex Restaurant", "" , 0);
call addShop("Parduch", "30-70", "Eatery", "14.175029, 121.242955", "Lutong Bahay", "", 0);
call addShop("Kainan sa Kanto", "30-80", "Eatery", "14.176952,121.242552", "Lutong Bahay", "", 0);
call addShop("Andok's", "50-250", "Restaurant", "14.173743, 121.243389", "Takeout", "", 0);
call addShop("Jerico's Bakeshop", "3-20", "Bakeshop", "14.173192, 121.243166", "Bakery", "", 0);
call addShop("Wing Bites", "70-250", "Restaurant", "14.172714, 121.242857", "Chicken Joint", "", 0);
call addShop("Rally Point", "","Restaurant", "14.173859, 121.243828", "Burger Cafe", "", 0);
call addShop("Satya Graha Cafe and Restaurant", "", "Restaurant", "14.173836, 121.244016", "Health Food Restaurant", "", 0);
call addShop("Cholo's Eatery", "40-80", "Eatery", "14.172806, 121.243228", "Lutong Bahay", "", 0);
call addShop("Papu's Siomai", "30-70", "", "14.177229, 121.242642", "Dim Sum", "", 0);
call addShop("Sean Nathan's Pastry Shop", "", "Cafe", "14.175182, 121.242995", "Pastry", "", 0);
/*Raymundo's*/
call addShop('Faustina''s', '',  'Restaurant', '14.168451, 121.241212', 'Casual dining restaurant', '', 0);
call addShop('Chubbi Habbis', '',  'Restaurant', '14.168391, 121.241240', 'Persian-Mediterranean Grill', '',0);
call addShop('Cadapan', '',  'Eatery', '14.168780, 121.241157', 'Lutong Bahay', '',0);
call addShop('Melville', '',  'Eatery', '14.168031, 121.241517', 'Lutong Bahay', '',0);
call addShop('Chicken Star', '',  'Eatery', '14.167898, 121.241654', 'Serves Chicken Rice Meals', '',0);
call addShop('Tita Vicky''s', '',  'Eatery', '14.167818, 121.241597', 'Lutong Bahay', '',0);
call addShop('Tess and Ylloy''s Canteen', '',  'Eatery', '14.168598, 121.241343', 'Lutong Bahay', '',0);
call addShop('Zoller Cuisine', '',  'Eatery', '14.167989, 121.241530', 'Lutong Bahay', '',0);
call addShop('Pedro''s Lechon', '',  'Eatery', '14.168784, 121.241277', 'Inihaw', '',0);
call addShop('Sobremasa', '',  'Restaurant', '14.169086, 121.241262', 'Lutong Bahay', '',0);
call addShop('Kappu Poteto', '20-55',  'Snack Bar', '14.168860, 121.241273', 'Fries with drinks', '',0);
/*Junction*/
call addShop('Uling Roasters', '65 up', 'Casual', '14.179015, 121.239385', 'Inihaw, Takeout', '', 0);
call addShop('Batangas Lomi House', '30-85', 'Eatery', '14.178952, 121.240059', 'Lomi', '', 0);
call addShop('Venter''s Shawarma', '69-79', 'Eatery', '14.179255, 121.239697', 'Shawarma', '', 0);
call addShop('Lugaw Royale', '12-95', 'Eatery', '14.178622, 121.240617', 'Lutong Bahay', '', 0);
call addShop('Big Mak', '28-54', 'Eatery', '14.178705, 121.240754', 'Burger Joint', '', 0);
call addShop('Shawarma Shack', '78', 'Food Stall', '14.178836, 121.240706', 'Shawarma', '', 0);
call addShop('Dimsum Factory', '20', 'Food Stall', '14.178809, 121.240721', 'Dim Sum', '', 0);
call addShop('Jollibee', '50-500', 'Fastfood', '14.179197, 121.239142', '', '', 0);
call addShop('Chooks to Go', '36-222', 'Casual', '14.179197, 121.239142', 'Takeout', '', 0);
call addShop('Goldilocks', '50-200', 'Fastfood', '14.178620, 121.241842', 'Filipino food', '', 0);
call addShop('Chowking', '50-200','Fastfood', '14.178428, 121.241725', 'Chinese Food', '', 0);
call addShop('Pizza Hut', '120-600','Fastfood', '14.179224, 121.238931', 'Pizza and pasta', '', 0);
call addShop('Greenwich', '55-600','Fastfood', '14.179197, 121.239142', 'Pizza and pasta', '', 0);
/*junction -> shakey's*/
call addShop("Mang Inasal", "60-150", "Fast Food","14.178468, 121.242620","National Hwy, Los Baños, Laguna", "",  0);
call addShop("Twinkle Pop", "50-100","Restaurant","14.178208, 121.242864","National Hwy, Los Baños, Laguna", "", 0);
call addShop("Toyang", "50-100","Filipino Restaurant","14.178362, 121.242867","National Hwy, cor. Bangkal st., Los Baños", "", 0);
call addShop("Totoy's original Pansitan", "50-100" , "Filipino Restaurant", "14.178423, 121.242945","8786, National Highway, Los Baños, 4030 Laguna","",0);
call addShop("Andok's Lechon Manok","50-200","Grill","14.178184, 121.243053","Manila S Rd, Los Baños, Laguna", "", 0);
call addShop("Lembest Lechon", "100-150", "Takeout Restaurant", "14.178117, 121.243412", "National Hwy, Los Baños, Laguna", "", 0);
call addShop("Baliwag Lechon Manok", "100-200", "Takeout Restaurant", "14.178114, 121.243445", "Manila S Rd, Los Baños, Laguna", "", 0);
call addShop("Joji's Burger", "50-100", "Hamburger Restaurant", "14.176935, 121.249843", "Manila S Rd, Los Baños", "", 0);
call addShop("Jilby's Chicharon", "50-100", "Chicken Shop", "14.176826, 121.250220", "National Highway, Los Baños, 4030 Laguna", "", 0);
call addShop("Cafe Antonio Los Banos", "50-100", "Cafe", "14.176768, 121.251382", "National Hi-way, Brgy.Maahas, Los Baños Laguna", "", 0);
call addShop("Krizzia's Silog Pancitan", "50-100", "Restaurant", "14.176794, 121.251218", "Manila S Rd, Los Baños, Laguna", "", 0);
call addShop("Waway's Eatery", "50-100", "Restaurant", "14.176724, 121.253130", "National Hwy, Los Baños, Laguna", "", 0);
call addShop("Amboy's Place", "50-100", "Restaurant", "14.176842, 121.253748", "Manila S Rd, Los Baños, Laguna", "", 0);
call addShop("Spanta's Eatery", "50-100", "Restaurant", "14.176635, 121.254820", "Manila S Rd, Los Baños, Laguna", "", 0);
call addShop("Shakey's", "50-100", "Pizza Restaurant", "14.176334, 121.259249", "National Hwy, Los Baños, Laguna", "", 0);
call addShop("Paqeato Food Park", "50-100", "Restaurant", "14.176324, 121.259298", "Los Baños, Laguna", "", 0);
call addShop("Pong's Kitchen", "50-100", "Restaurant", "14.176263, 121.259477", "Maahas National Road U-Turn Food Park, Los Baños", "", 0);
/*Grove*/
call addShop("McDonald's", "30-200", "Fastfood", "14.167957, 121.243575", "Grove, Batong Malake, Los Baños, Laguna", "", 0);
call addShop("KFC", "30-200", "Fastfood", "14.168200, 121.243698", "Grove, Batong Malake, Los Baños, Laguna", "", 0);
call addShop("Bugong Roast Chicken", "70-300", "Restaurant", "14.167877, 121.243826", "Grove, Batong Malake, Los Baños, Laguna", "", 0);
call addShop("Entablado", "80-200", "Restaurant", "14.167774, 121.243936", "Grove, Batong Malake, Los Baños, Laguna", "", 0);
call addShop("Dainty Gourmet Bites", "30-300", "Restaurant", "14.167748, 121.243834", "Grove, Batong Malake, Los Baños, Laguna", "", 0);
call addShop("Black N' Brew", "30-200", "Cafe", "14.167683, 121.243640", "Grove, Batong Malake, Los Baños, Laguna", "", 0);
call addShop("StarBucks", "100-500", "Cafe", "14.167927, 121.243510", "Grove, Batong Malake, Los Baños, Laguna", "", 0);
call addShop("Turks", "60-100", "Food Stand", "14.167970, 121.243861", "Grove, Batong Malake, Los Baños, Laguna", "", 0);
call addShop("Potato Corner", "60-100", "Food Stand", "14.168173, 121.243877", "Grove, Batong Malake, Los Baños, Laguna", "", 0);
call addShop("Yigo's Dough Box", "60-100", "Shop", "14.167686, 121.244038", "Grove, Batong Malake, Los Baños, Laguna", "", 0);
call addShop("Atticus Kobe's Garden Café", "60-300", "Cafe", "14.167717, 121.243836", "Grove, Batong Malake, Los Baños, Laguna", "", 0);
call addShop("Nasi Haus	Restaurant", "100-500", "Restaurant", "14.167621, 121.243813", "Grove, Batong Malake, Los Baños, Laguna", "", 0);
call addShop("The Shawarma Shack", "60-100", "Food Stand", "14.167964, 121.243479", "Grove, Batong Malake, Los Baños, Laguna", "", 0);
call addShop("Jollibee", "30-300", "Food Stand", "14.168190, 121.243862", "Grove, Batong Malake, Los Baños, Laguna", "", 0);
call addShop("Pizzapop", "90-500", "Pizzeria", "14.168354, 121.243803", "Grove, Batong Malake, Los Baños, Laguna", "", 0);
call addShop("Budget Tapa King", "30-300", "Casual", "14.168442, 121.244051", "Grove, Batong Malake, Los Baños, Laguna", "", 0);
call addShop("Hannarose Sizzlers", "50-200", "Casual", "14.168583, 121.244152", "Grove, Batong Malake, Los Baños, Laguna", "", 0);
call addShop("Tita Jess", "20-100", "Canteen", "14.168339, 121.243744", "Grove, Batong Malake, Los Baños, Laguna", "", 0);
call addShop("Cinco", "100-300", "Restaurant", "14.168520, 121.243845", "Grove, Batong Malake, Los Baños, Laguna", "", 0);
call addShop("Karitela", "50-250", "Cafe & Restaurant", "14.168588, 121.243824", "Grove, Batong Malake, Los Baños, Laguna", "", 0);




			