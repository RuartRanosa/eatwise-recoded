CREATE DATABASE IF NOT EXISTS `eatwise` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `eatwise`;


create table if not exists user(
	userId int(5) not null auto_increment,
	adminAccess boolean NOT NULL,
	username varchar(50),
	email varchar(50),
	displayName varchar(50),
	password varchar(50),
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
	reviewCreation TIMESTAMP NOT NULL DEFAULT current_timestamp,
	shopId int(5) not null,
	comment varchar(150),
	tips varchar(150),
	rating int(1) not null,
	primary key(reviewId)
); /*ENGINE = InnoDB DEFAULT CHARSET = latin1;*/

create table if not exists report(
	reportId int(5) not null auto_increment,
	userId int(5) not null,
	reportCreation TIMESTAMP NOT NULL DEFAULT current_timestamp,
	shopId int(5) not null,
	reason varchar(150),
	primary key(reportId)
); /*ENGINE = InnoDB DEFAULT CHARSET = latin1;*/

create table if not exists log_user(
	logId int(5) not null auto_increment,
	time_stamp TIMESTAMP NOT NULL DEFAULT current_timestamp,
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
	time_stamp TIMESTAMP NOT NULL DEFAULT current_timestamp,
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
	time_stamp TIMESTAMP NOT NULL DEFAULT current_timestamp,
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
	time_stamp TIMESTAMP NOT NULL DEFAULT current_timestamp,
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

insert into user (userId, adminAccess, username, email, displayName, password, location) values (1, false, 'cchambers0', 'cc@gmail.com', 'Crosby', 'AeA60qT1Ms', 'Taranovskoye');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (2, false, 'gjensen1', 'cc@gmail.com', 'Gordon', 'RlsFC2Q', 'Dalmeny');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (3, false, 'hpaish2', 'cc@gmail.com', 'Hewe', 'WGkQiejkPV5', 'Mahendranagar');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (4, true, 'ccasbolt3', 'cc@gmail.com', 'Curr', 'h9oqbCR', 'Souto');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (5, false, 'hcastelin4', 'cc@gmail.com', 'Herman', 'bmumzBKqCW', 'Keruguya');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (6, true, 'cabramchik5', 'cc@gmail.com', 'Clywd', 'FzHd5i5HJpiW', 'Budapest');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (7, false, 'nbedo6', 'cc@gmail.com', 'Niel', 'w6inM9P0', 'Madamba');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (8, true, 'mmoakson7', 'cc@gmail.com', 'Matthias', '7fLi78phE', 'Pasarbaru');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (9, true, 'wbrimm8', 'cc@gmail.com', 'Warde', '4oZ3CK', 'Wakimachi');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (10, false, 'bternent9', 'cc@gmail.com', 'Bealle', 'AtHVgTI3iJw', 'Neftegorsk');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (11, true, 'lfeaka', 'cc@gmail.com', 'Lemmy', 'O7rPKc85', 'Saint-Augustin-de-Desmaures');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (12, true, 'bdonoherb', 'cc@gmail.com', 'Brandon', 'Gfwm36p', 'Batanamang');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (13, true, 'rcutmerec', 'cc@gmail.com', 'Redford', 'TgxEbRa9Si', 'Karangbaru');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (14, true, 'climerickd', 'cc@gmail.com', 'Cullie', '7oIYddL', 'Aguitu');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (15, true, 'esivyere', 'cc@gmail.com', 'Erhart', 'wvFMTuJiK', 'Examília');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (16, true, 'nyeldingf', 'cc@gmail.com', 'Niko', '4Yar7N', 'Usquil');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (17, true, 'bhamillg', 'cc@gmail.com', 'Benny', 'RRY8Bihp5VSJ', 'Shahr-e Qods');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (18, true, 'fturfsh', 'cc@gmail.com', 'Freeman', 'aqXiKMi', 'Bang Nam Priao');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (19, false, 'hbegginii', 'cc@gmail.com', 'Hayes', 'osKhcsLXTFN', 'La Rochelle');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (20, false, 'bonnj', 'cc@gmail.com', 'Brook', '1pClrq', 'Innoshima');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (21, true, 'ggreenroadk', 'cc@gmail.com', 'Giffie', 'uzeSLPlY', 'Bieniewice');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (22, false, 'tyackiminiel', 'cc@gmail.com', 'Torry', 'aDwp3z', 'Plettenberg Bay');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (23, false, 'ndunnettm', 'cc@gmail.com', 'Neel', 'gzR8c6IF6b', 'Venda Nova');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (24, false, 'aliesn', 'cc@gmail.com', 'Alex', 'rnVQADDfTxhq', 'Tunoshna');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (25, false, 'evalentino', 'cc@gmail.com', 'Ebeneser', 'fnU1xzxzt', 'Jiupu');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (26, true, 'tilchukp', 'cc@gmail.com', 'Trstram', '0glnwA6Zs', 'Penhascoso');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (27, true, 'ikiehnltq', 'cc@gmail.com', 'Isacco', 'V9QlVPh', 'Paris La Défense');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (28, true, 'rbrightyr', 'cc@gmail.com', 'Ron', '9mS9RwdQKVb', 'Santo Domingo');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (29, true, 'kwinsers', 'cc@gmail.com', 'Kyle', 'ErakDecIAJo9', 'Yeniköy');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (30, true, 'lzohrert', 'cc@gmail.com', 'Laurie', 'hy18PmskdYZs', 'Candoso');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (31, true, 'wohannayu', 'cc@gmail.com', 'Wallace', 'P3Li6pPU', 'Sano');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (32, false, 'ddunbletonv', 'cc@gmail.com', 'Dylan', 'd34eWrBOhgAn', 'Markivka');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (33, true, 'giwanowiczw', 'cc@gmail.com', 'Gothart', 'dyMl6cbq', 'Chornyanka');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (34, true, 'rbeverstockx', 'cc@gmail.com', 'Ryan', '9y4Ic72G2sgK', 'Lyubech');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (35, false, 'ngoldspinky', 'cc@gmail.com', 'Nicolai', 'Ey52QLzJh', 'Qinshi');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (36, true, 'charnorz', 'cc@gmail.com', 'Cully', 'OauhZG', 'Nedakonice');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (37, true, 'ckerton10', 'cc@gmail.com', 'Corbet', 'W0JdTSAe7SnE', 'Hengxizhen');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (38, true, 'zscrimgeour11', 'cc@gmail.com', 'Zacharias', 'KBvU6g', 'Floriana');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (39, true, 'tgriffoen12', 'cc@gmail.com', 'Travus', 'W7T0ZFQx2E', 'Long Loreh');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (40, true, 'cricardon13', 'cc@gmail.com', 'Calv', 'wevxlg', 'Pajung');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (41, true, 'mdavidescu14', 'cc@gmail.com', 'Mervin', 'NCfrv1zt', 'Poitiers');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (42, true, 'ntabbernor15', 'cc@gmail.com', 'Nikolaus', 'MiIhgz3MJk02', 'Wushi');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (43, true, 'cbrightey16', 'cc@gmail.com', 'Ches', '3SfBdQycn', 'Viana');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (44, true, 'hattow17', 'cc@gmail.com', 'Horace', 'PGAp7Mx4A', 'Bandeirantes');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (45, false, 'rbrandenberg18', 'cc@gmail.com', 'Raimundo', 'gXcpcgPKUs2', 'Birayang');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (46, false, 'lharteley19', 'cc@gmail.com', 'Land', 'SJb0Kfz2', 'La Paz');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (47, true, 'dmoakes1a', 'cc@gmail.com', 'Dirk', 'ZnXEq9JU', 'Gerong');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (48, true, 'sscutter1b', 'cc@gmail.com', 'Sid', 'CQ1A7HW', 'Stoney Ground');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (49, true, 'candrivel1c', 'cc@gmail.com', 'Craig', 'CrRhTP', 'Communal');
insert into user (userId, adminAccess, username, email, displayName, password, location) values (50, false, 'rdhooge1d', 'cc@gmail.com', 'Ronny', 'bLd7PjdXF', 'Xiaozhi');

	call addShop('Plambee', 117, 'Honduran', '6 Grayhawk Terrace', '', 'Italian', 5023);
call addShop('Tagchat', 118, 'Pueblo', '26966 Sachtjen Trail','', 'Japanese', 8282);
call addShop('Skinte', 209, 'Hmong', '09 Sachs Point', '', 'Japanese', 476);
call addShop('Brainbox', 53, 'Alaska Native', '736 Esker Street','', 'Korean', 5656);
call addShop('Zooveo', 74, 'Cambodian', '57 Stoughton Circle', '',  'Korean', 829);
call addShop('Zoonoodle', 241, 'Pakistani', '17 Forest Crossing', '',  'Korean', 3497);
call addShop('Yotz', 138, 'Sri Lankan', '80 Old Shore Terrace', '', 'Japanese', 5521);
call addShop('Riffwire', 95, 'Central American', '6 Stang Parkway', '', 'Filipino Cuisine', 1840);
call addShop('Muxo', 118, 'Lumbee', '4939 Prairieview Place', '', 'Italian',3625);
call addShop('Eazzy', 162, 'Bangladeshi', '8 Kipling Court', '', 'Filipino Cuisine', 2475);
call addShop('Kwideo', 97, 'American Indian and Alaska Native (AIAN)', '5 Merrick Terrace', '', 'Filipino Cuisine', 7984);
call addShop('Realblab', 65, 'Cambodian', '57704 Menomonie Drive', '', 'Filipino Cuisine', 8337);
call addShop('Skipfire', 192, 'Black or African American', '253 Sunbrook Place', '', 'Filipino Cuisine', 8086);
call addShop('Skibox', 114, 'Japanese', '0 Buell Circle', '', 'Filipino Cuisine', 9603);
call addShop('Myworks', 210, 'Peruvian', '8672 Helena Terrace', '', 'Japanese', 6006);
call addShop('Oozz', 239, 'Guatemalan', '028 Prairie Rose Circle', '', 'Filipino Cuisine', 1089);
call addShop('Devshare', 228, 'Asian', '25 Jay Junction', '', 'Filipino Cuisine', 5196);
call addShop('Kimia', 105, 'Alaskan Athabascan', '0 Atwood Alley', '', 'Filipino Cuisine', 1140);
call addShop('Shufflebeat', 131, 'Cambodian', '31 Moland Center', '', 'Filipino Cuisine', 278);
call addShop('Skimia', 194, 'Native Hawaiian', '4013 Texas Alley', '',  'Japanese', 3660);
call addShop('Riffwire', 106, 'Shoshone', '489 Garrison Circle', '', 'Filipino Cuisine', 7820);
call addShop('Thoughtstorm', 159, 'Bangladeshi', '884 Summerview Center', '', 'Filipino Cuisine', 515);
call addShop('Brightbean', 210, 'Tlingit-Haida', '8351 Commercial Point', '', 'Filipino Cuisine', 4545);
call addShop('Kwilith', 173, 'Polynesian', '813 Hanover Hill', '', 'Filipino Cuisine', 8930);
call addShop('Trunyx', 153, 'Ute', '5039 Daystar Drive', '', 'Italian', 9388);
call addShop('Eazzy', 181, 'Costa Rican', '16084 Del Sol Center', '', 'Filipino Cuisine', 9094);
call addShop('Photobug', 239, 'Indonesian', '73 Moulton Road', '', 'Italian', 9398);
call addShop('Flashset', 203, 'Indonesian', '1 Roxbury Avenue', '', 'Filipino Cuisine', 9321);
call addShop('Trunyx', 222, 'White', '181 Brentwood Crossing', '', 'Italian', 2693);
call addShop('Brightdog', 213, 'Comanche', '09 Laurel Court', '', 'Italian', 4581);
call addShop('Linkbridge', 59, 'Blackfeet', '0 Kipling Center', '', 'Korean', 2402);
call addShop('Riffpedia', 219, 'Seminole', '4 Farragut Crossing', '', 'Korean', 926);
call addShop('Kwilith', 58, 'Alaska Native', '71 Erie Place', '', 'Japanese', 8384);
call addShop('Fatz', 61, 'Colville', '3 Ohio Pass', '', 'Filipino Cuisine', 7005);
call addShop('Tagtune', 235, 'Tongan', '80564 Everett Park', '', 'Italian', 3968);
call addShop('Skimia', 147, 'Tlingit-Haida', '68 Fuller Pass', '', 'Filipino Cuisine', 5865);
call addShop('Brainlounge', 104, 'Cuban', '94 Harper Parkway', '', 'Filipino Cuisine', 627);
call addShop('Abatz', 161, 'Choctaw', '9 Pond Court', '', 'Filipino Cuisine', 9548);
call addShop('Zoomzone', 180, 'Tlingit-Haida', '42853 Mesta Plaza', '', 'Italian', 6344);
call addShop('Chatterpoint', 154, 'Paraguayan', '366 Oakridge Lane', '', 'Filipino Cuisine', 7581);
call addShop('Flipopia', 246, 'Seminole', '5 Hanover Alley', '', 'Japanese', 281);
call addShop('Skipstorm', 155, 'Bolivian', '92 Grasskamp Street', '', 'Filipino Cuisine', 3526);
call addShop('Youspan', 163, 'Pueblo', '0 Judy Lane', '', 'Filipino Cuisine', 8287);
call addShop('Mynte', 156, 'Venezuelan', '6 Oakridge Park', '', 'Italian', 3056);
call addShop('Vipe', 64, 'Peruvian', '3 Ohio Pass', '', 'Filipino Cuisine', 9035);
call addShop('Buzzster', 113, 'Houma', '4066 Dorton Crossing', '', 'Filipino Cuisine', 9379);
call addShop('Talane', 202, 'Micronesian', '10002 Rockefeller Way', '', 'Filipino Cuisine', 9443);
call addShop('Youtags', 212, 'Asian', '86133 Mcbride Crossing', '', 'Filipino Cuisine', 5);
call addShop('Mudo', 96, 'Choctaw', '845 Stephen Parkway', '', 'Italian', 6560);
call addShop('Zooxo', 248, 'Comanche', '06644 Dayton Alley', '', 'Italian', 7824);
call addShop('Jollibee', '200-300', 'Fast Food', 'Grove', 'Jolly happy', 'Filipino Food', 0);
call addShop('Mcdo', '100-300', 'Fast Food', 'Grove', 'Clown Happy', 'Filipino Food', 0);