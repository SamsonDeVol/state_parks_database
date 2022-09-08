
---------------------- PART 3: SQL SCHEMA ----------------------



-- Part 3: ER Diagram Entity - PARK
DROP TABLE IF EXISTS PARK;
CREATE TABLE PARK
(
    [name] VARCHAR(100) NOT NULL PRIMARY KEY,
    size INT, -- acres
    established DATE, -- YYYY-MM-DD
    [open] BIT -- 1 for True, 0 for False
);

-- Part 4: Sample Data for PARK
INSERT INTO "PARK" 
("name", "size", "established", "open") 
VALUES 
("Crater Lake", 183224, "1902-05-22", 1),
("Yosemite", 759620, "1890-10-01", 1),
("Channel Islands", 249561, "1980-03-05", 1),
("Death Valley", 3408395, "1994-10-31", 1),
("Joshua Tree", 795155, "1994-10-31", 1),
("Kings Canyon", 461901, "1940-03-04", 1),
("Lassen Volcanic", 106589, "1916-08-09", 1),
("Mount Rainier", 236381, "1899-03-02", 1),
("North Cascades", 504780, "1968-10-02", 1),
("Olympic", 922649, "1938-06-29", 1),
("Pinnacles", 26685, "2013-01-10", 1),
("Redwood", 138999, "1968-10-02", 1),
("Sequoia", 404062, "1890-09-25", 1);



-- Part 3: ER Diagram Multi-Valued Attribute - PARK(state)
DROP TABLE IF EXISTS [STATE];
CREATE TABLE [STATE]
(
    [state] CHAR(2) NOT NULL,
    pname VARCHAR(100) NOT NULL,
    PRIMARY KEY ([state], pname),
    FOREIGN KEY (pname) REFERENCES PARK([name])
);

-- Part 4: Sample Data for STATE
INSERT INTO "STATE"
("state", "pname")
VALUES
("OR", "Crater Lake"),
("CA", "Yosemite"),
("CA", "Channel Islands"),
("CA", "Death Valley"),
("NV", "Death Valley"),
("CA", "Joshua Tree"),
("CA", "Kings Canyon"),
("CA", "Lassen Volcanic"),
("WA", "Mount Rainier"),
("WA", "North Cascades"),
("WA", "Olympic"),
("CA", "Pinnacles"),
("CA", "Redwood"),
("CA", "Sequoia");



-- Part 3: ER Diagram Entity - EMPLOYEE
DROP TABLE IF EXISTS EMPLOYEE;
CREATE TABLE EMPLOYEE
(
    ssn INT NOT NULL PRIMARY KEY,
    fname VARCHAR(30),
    lname VARCHAR(30),
    title VARCHAR(30),
    center_emp BIT,
    lodge_emp BIT
);

-- Part 4: Sample Data for EMPLOYEE
INSERT INTO "EMPLOYEE"
("ssn", "fname", "lname", "title", "center_emp", "lodge_emp")
VALUES
(111222333, "Jerry", "Tolkien", "ranger", 0, 0),
(222333444, "Will", "Shakespeare", "park manager", 0, 0),
(333444555, "Gabriel", "Trahan", "custodian", 1, 0),
(444555666, "Agnes", "Hemmingway", "maintenance worker", 1, 1),
(555666777, "Katy", "Perry", "biologist", 0, 0),
(666777888, "Johnny", "Depp", "hotel manager", 0, 1),
(777888999, "Taylor", "Swift", "waitress", 1, 1),
(888999000, "Bilbo", "Baggins", "clerk", 1, 0),
(999000111, "Frodo", "Baggins", "center manager", 1, 0),
(000111222, "Adele", "Adele", "guide", 1, 0),
(111999888, "Shimano", "Trek", "front desk assistant", 0, 1),
(222111000, "Ryan", "Reynolds", "maid", 0, 1),
(333222111, "Scooby", "Doo", "pool cleaner", 0, 1),
(444333222, "Hermione", "Granger", "shuttle driver", 0, 1);



-- Part 3: ER Diagram Relationship - WORKS_FOR
DROP TABLE IF EXISTS PARK_EMPLOYMENT;
CREATE TABLE PARK_EMPLOYMENT
(
    essn INT NOT NULL,
    pname VARCHAR(100) NOT NULL,
    PRIMARY KEY (essn, pname),
    FOREIGN KEY(essn) REFERENCES EMPLOYEE(ssn)
        ON DELETE CASCADE       ON UPDATE CASCADE,
    FOREIGN KEY(pname) REFERENCES PARK([name])
        ON DELETE CASCADE       ON UPDATE CASCADE
);

-- Part 4: Sample Data for PARK_EMPLOYMENT
INSERT INTO "PARK_EMPLOYMENT"
("essn", "pname")
VALUES
(111222333, "Yosemite"),
(222333444, "Yosemite"),
(333444555, "Yosemite"),
(444555666, "Yosemite"),
(555666777, "Yosemite"),
(666777888, "Yosemite"),
(777888999, "Yosemite"),
(888999000, "Yosemite"),
(999000111, "Yosemite"),
(000111222, "Yosemite"),
(111999888, "Yosemite"),
(222111000, "Yosemite"),
(333222111, "Yosemite"),
(444333222, "Yosemite");



-- Part 3: ER Diagram Entity - LODGING
DROP TABLE IF EXISTS LODGING;
CREATE TABLE LODGING
(
    l_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    pname VARCHAR(100),
    lname VARCHAR(30),
    open_date DATE,
    close_date DATE,
    rate INT,
    FOREIGN KEY (pname) REFERENCES PARK([name])
        ON DELETE CASCADE       ON UPDATE CASCADE
);

-- Part 4: Sample Data for LODGING
INSERT INTO "LODGING"
("pname", "lname", "open_date", "close_date", "rate")
VALUES
("Yosemite", "Yosemite View Lodge", "2022-01-01", "2022-12-31", 283),
("Crater Lake", "Crater Lake Lodge", "2022-05-15", "2022-10-05", 250),
("Death Valley", "The Ranch at Death Valley", "2022-01-01", "2022-12-31", 239),
("Olympic", "Lake Crescent Lodge", "2022-04-29", "2022-12-31", 300),
("Sequoia", "Wuksachi Lodge", "2022-04-29", "2022-12-31", 250),
("Mount Rainier", "National Park Lodge", "2022-01-01", "2022-12-31", 231),
("Mount Rainier", "Paradise Inn", "2022-05-15", "2022-10-10", 249),
("Pinnacles", "Pinnacles Campground", "2022-01-01", "2022-12-31", 150);



-- Part 3: ER Diagram Entity - ATTRACTION
DROP TABLE IF EXISTS ATTRACTION;
CREATE TABLE ATTRACTION
(
    att_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    pname VARCHAR(100),
    aname VARCHAR(50),
    [description] VARCHAR(255),
    [open] BIT,
    restroom BIT,
    FOREIGN KEY (pname) REFERENCES PARK([name])
        ON DELETE CASCADE       ON UPDATE CASCADE
);

-- Part 4: Sample Data for ATTRACTION
INSERT INTO "ATTRACTION"
("pname", "aname", "description", "open", "restroom")
VALUES
("Crater Lake", "Rim Drive", "33-mile scenic drive around the caldera", 0, 0),
("Crater Lake", "Rim Village Visitor Center", "visitor center in Rim Village, with lodge and gift shop", 1, 1),
("Crater Lake", "Cleetwood Cove Trail", "trail down to lake", 0, 0),
("Crater Lake", "Wizard Island", "island in the center of the lake", 0, 1),
("Crater Lake", "Phantom Rock", "rock formation in the lake", 0, 0),
("Yosemite", "Wawona Visitor Center", "visitor center open summer only", 0, 1),
("Yosemite", "Yosemite Valley", "impressive waterfalls, meadows, cliffs, and unusual rock formations; accessible by car year-round", 1, 0),
("Yosemite", "Glacier Point", "an overlook with a commanding view of Yosemite Valley, Half Dome, Yosemite Falls, and Yosemite\'s high country", 0, 0),
("Yosemite", "Half Dome", "rock formation most recognized symbol of Yosemite, 5,000 feet above valley floor", 0, 0),
("Yosemite", "El Capitan", "famous rock climbing formation", 1, 0),
("Yosemite", "Yosemite Falls", "2,425 ft waterfall with an ice cone fall through winter", 1, 1),
("Yosemite", "Half Dome Trail", "trail to the top of Half Dome rock formation", 1, 0),
("Yosemite", "Valley Loop Trail", "trail around Yosemite Valley", 1, 0),
("Yosemite", "Lower Yosemite Falls Trail", "trail showcasing the lower part of Yosemite Falls", 1, 1),
("Yosemite", "Yosemite Valley Visitor Center and Theater", "visitor center with theater near Glacier Point and Half Dome", 1, 0),
("Death Valley", "Artists Palette", "scenic vista that offers a stunning glimpse into Death Valley’s colorful volcanic past", 1, 0),
("Death Valley", "Zabriskie Point", "vista overlooking badlands and salt flats", 1, 0),
("Death Valley", "Badwater Basin", "lowest point in North America, vast salt flats, 282 feet below sea level", 1, 0),
("Death Valley", "Badwater Salt Flat Trail", "easy hike in Badwater Basin", 1, 0),
("Death Valley", "Desolation Canyon Trail", "hike around Desolation Canyon", 1, 0),
("Death Valley", "Telescope Peak Trail", "hike to the summit of Telescope peak", 1, 0),
("Death Valley", "Furnace Creek Visitor Center", "visitor center hub for Death Valley", 1, 1),
("Mount Rainier", "Henry M. Jackson Memorial Visitor Center", "visitor center with seasonally limited services", 1, 1),
("Mount Rainier", "Sunrise Visitor Center", "visitor center near Yakima Park", 1, 1),
("Mount Rainier", "Reflection Lakes", "beautiful view of reflection of Mt Rainier", 1, 0),
("Mount Rainier", "Pinnacle Peak Trail", "hike showcasing beautiful views of Rainier and Adams", 1, 0),
("Mount Rainier", "Wonderland Trail", "trail encircling the base of Mt Rainier", 0, 0),
("Pinnacles", "Bear Gulch Cave", "bat cave", 0, 0),
("Pinnacles", "Balconies Cave", "cave in Pinnacles", 1, 0),
("Pinnacles", "Pinnacles Visitor Center to Balconies Cave Trail", "hike along the Chalone Creek to the Balcony Cliffs Trail", 1, 0),
("Pinnacles", "Chalone Peak Trail to South Chalone Peak", "hike to the highest point in the monument, North Chalone Peak, where you can continue to South Chalone Peak", 1, 1),
("Pinnacles", "Pinnacles Visitor Center", "visitor center near Pinnacles Campground", 1, 1)
;



-- Part 3: ER Diagram Sub-Entity - VISITOR_CENTER
DROP TABLE IF EXISTS VISITOR_CENTER;
CREATE TABLE VISITOR_CENTER
(
    att_id INT PRIMARY KEY NOT NULL,
    food BIT,
    FOREIGN KEY (att_id) REFERENCES ATTRACTION(att_id)
        ON DELETE CASCADE       ON UPDATE CASCADE
);

-- Part 4: Sample Data for VISITOR_CENTER
INSERT INTO "VISITOR_CENTER"
("att_id", "food")
VALUES
(1, 1),
(6, 1),
(15, 0),
(22, 1),
(23, 1),
(24, 1),
(32, 1);



-- Part 3: ER Diagram Sub-Entity - TRAIL
DROP TABLE IF EXISTS TRAIL;
CREATE TABLE TRAIL
(
    att_id INT PRIMARY KEY NOT NULL,
    [length] FLOAT, -- miles
    [loop] BIT, -- 0 if one-way, 1 if round trip or loop
    difficulty TEXT CHECK(difficulty IN ('easy', 'moderate', 'difficult', 'impossible')),
    vert_gain INT, -- feet
    FOREIGN KEY (att_id) REFERENCES ATTRACTION(att_id)
        ON DELETE CASCADE       ON UPDATE CASCADE
);

-- Part 4: Sample Data for TRAIL
INSERT INTO "TRAIL"
("att_id", "length", "loop", "difficulty", "vert_gain")
VALUES
(3, 1.1, 0, "moderate", 700),
(12, 16.4, 1, "difficult", 4800),
(13, 13, 1, "moderate", 0),
(14, 1, 0, "easy", 50),
(19, 1, 1, "easy", 0),
(20, 3.6, 1, "moderate", 600),
(21, 14, 1, "impossible", 3000),
(26, 2.5, 1, "moderate", 1050),
(27, 93, 1, "impossible", 3000),
(30, 9.4, 1, "moderate", 300),
(31, 10.3, 1, "difficult", 2040);



-- Part 3: ER Diagram Relationship - WORKS_IN_CENTER
DROP TABLE IF EXISTS CENTER_EMPLOYMENT;
CREATE TABLE CENTER_EMPLOYMENT
(
    essn INT NOT NULL,
    vc_id INT NOT NULL,
    PRIMARY KEY (essn, vc_id),
    FOREIGN KEY (essn) REFERENCES EMPLOYEE(ssn)
        ON DELETE CASCADE       ON UPDATE CASCADE,
    FOREIGN KEY (vc_id) REFERENCES VISITOR_CENTER(att_id)
        ON DELETE CASCADE       ON UPDATE CASCADE
);

-- Part 4: Sample Data for CENTER_EMPLOYMENT
INSERT INTO "CENTER_EMPLOYMENT"
("essn", "vc_id")
VALUES
(333444555, 6),
(444555666, 6),
(777888999, 6),
(888999000, 6),
(999000111, 15),
(000111222, 15);



-- Part 3: ER Diagram Relationship - WORKS_IN_LODGE
DROP TABLE IF EXISTS LODGE_EMPLOYMENT;
CREATE TABLE LODGE_EMPLOYMENT
(
    essn INT NOT NULL,
    l_id INT NOT NULL,
    PRIMARY KEY (essn, l_id),
    FOREIGN KEY (essn) REFERENCES EMPLOYEE(ssn)
        ON DELETE CASCADE       ON UPDATE CASCADE,
    FOREIGN KEY (l_id) REFERENCES LODGING(l_id)
        ON DELETE CASCADE       ON UPDATE CASCADE
);

-- Part 4: Sample Data for LODGE_EMPLOYMENT
INSERT INTO "LODGE_EMPLOYMENT"
("essn", "l_id")
VALUES
(444555666, 1),
(666777888, 1),
(777888999, 1),
(111999888, 1),
(222111000, 1),
(333222111, 1),
(444333222, 1);



-- Part 3: ER Diagram Entity - POPULAR_WILDLIFE
DROP TABLE IF EXISTS POPULAR_WILDLIFE;
CREATE TABLE POPULAR_WILDLIFE
(
    species VARCHAR(30) PRIMARY KEY NOT NULL,
    class VARCHAR (20),
    threat_level TEXT CHECK(threat_level IN ('low_risk', 'moderate_risk', 'dead_on_sight'))
);

-- Part 4: Sample Data for POPULAR_WILDLIFE
INSERT INTO "POPULAR_WILDLIFE"
("species", "class", "threat_level")
VALUES
("bat", "---", "moderate_risk"),
("mountain lion", "---", "dead_on_sight"),
("black bear", "---", "moderate_risk"),
("pika", "---", "dead_on_sight"),
("deer", "---", "low_risk"),
("grizzly bear", "---", "dead_on_sight"),
("bighorn sheep", "---", "moderate_risk"),
("pacific fisher", "---", "low_risk"),
("kangaroo rat", "---", "low_risk"),
("desert tortoise", "---", "dead_on_sight"),
("coyote", "---", "low_risk"),
("jackrabbit", "---", "dead_on_sight"),
("raven", "---", "low_risk"),
("elk", "---", "moderate_risk"),
("mountain goat", "---", "moderate_risk"),
("bobcat", "---", "moderate_risk"),
("wild pig", "---", "dead_on_sight"),
("badger", "---", "low_risk");



-- Part 3: ER Diagram Relationship - INHABITS
DROP TABLE IF EXISTS INHABITATION;
CREATE TABLE INHABITATION
(
    species VARCHAR(30) NOT NULL,
    pname VARCHAR(100) NOT NULL,
    quantity INT,
    PRIMARY KEY (species, pname)
    FOREIGN KEY (species) REFERENCES POPULAR_WILDLIFE(species)
        ON DELETE CASCADE       ON UPDATE CASCADE, -- might be a problem, might delete wildlife record that disappeared from one park but not every park
    FOREIGN KEY (pname) REFERENCES PARK([name])
        ON DELETE CASCADE       ON UPDATE CASCADE
);

-- Part 4: Sample Data for INHABITATION
INSERT INTO "INHABITATION"
("species", "pname", "quantity")
VALUES
("bat", "Crater Lake", 300), -- quantities are made up
("mountain lion", "Crater Lake", 7),
("black bear", "Crater Lake", 41),
("deer", "Crater Lake", 250),
("grizzly bear", "Yosemite", 25),
("bighorn sheep", "Yosemite", 156),
("black bear", "Yosemite", 100),
("pacific fisher", "Yosemite", 280),
("mountain lion", "Yosemite", 29),
("bat", "Yosemite", 1500),
("deer", "Yosemite", 1300),
("bighorn sheep", "Death Valley", 720),
("kangaroo rat", "Death Valley", 15000),
("desert tortoise", "Death Valley", 250),
("coyote", "Death Valley", 300),
("jackrabbit", "Death Valley", 8000),
("pacific fisher", "Mount Rainier", 400),
("raven", "Mount Rainier", 500),
("black bear", "Mount Rainier", 50),
("elk", "Mount Rainier", 380),
("mountain goat", "Mount Rainier", 260),
("bat", "Pinnacles", 4000),
("mountain lion", "Pinnacles", 5),
("kangaroo rat", "Pinnacles", 2000),
("bobcat", "Pinnacles", 50),
("jackrabbit", "Pinnacles", 1500),
("wild pig", "Pinnacles", 370),
("badger", "Pinnacles", 100);



-- Part 3: ER Diagram Entity - ACTIVITY
DROP TABLE IF EXISTS ACTIVITY;
CREATE TABLE ACTIVITY
(
    act_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    [type] VARCHAR(10),
    [description] VARCHAR(255)
);

-- Part 4: Sample Data for ACTIVITY
INSERT INTO "ACTIVITY"
("type", "description")
VALUES
("backpacking", "hiking and overnight camping"),
("photography and filming", "professional / large scale, to the extent that might interfere with other visitors"),
("biking", "road biking"),
("fishing", "fishing"),
("auto touring", "driving around the park"),
("horseback riding", "horseback riding"),
("climbing", "fair weather climbing"),
("birdwatching", "birdwatching"),
("biking", "mountain biking"),
("climbing", "alpine climbing"),
("caving", "otherwise known as spelunking");



-- Part 3: ER Diagram Relationship - AVAILABLE_IN
DROP TABLE IF EXISTS ACT_AVAILABILITY;
CREATE TABLE ACT_AVAILABILITY
(
    act_id INT NOT NULL,
    pname VARCHAR(100) NOT NULL,
    PRIMARY KEY (act_id, pname),
    FOREIGN KEY (act_id) REFERENCES ACTIVITY(act_id)
        ON DELETE CASCADE       ON UPDATE CASCADE,
    FOREIGN KEY (pname) REFERENCES PARK([name])
        ON DELETE CASCADE       ON UPDATE CASCADE
);

-- Part 4: Sample Data for ACT_AVAILABILITY
INSERT INTO "ACT_AVAILABILITY"
("act_id", "pname")
VALUES
(1, "Crater Lake"),
(2, "Crater Lake"),
(3, "Crater Lake"),
(4, "Crater Lake"), -- no fishing license required for Crater Lake
(1, "Yosemite"),
(2, "Yosemite"),
(4, "Yosemite"),
(5, "Yosemite"),
(6, "Yosemite"),
(7, "Yosemite"),
(8, "Death Valley"),
(9, "Death Valley"),
(6, "Death Valley"),
(1, "Death Valley"),
(3, "Death Valley"),
(3, "Mount Rainier"),
(4, "Mount Rainier"),
(9, "Mount Rainier"),
(10, "Mount Rainier"),
(2, "Pinnacles"),
(11, "Pinnacles"),
(7, "Pinnacles"),
(8, "Pinnacles");



-- Part 3: ER Diagram Relationship - REQUIRES
DROP TABLE IF EXISTS PERMIT_REQUIREMENT;
CREATE TABLE PERMIT_REQUIREMENT
(
    permit_type VARCHAR(20) NOT NULL,
    act_id INT NOT NULL,
    price INT,
    PRIMARY KEY (permit_type, act_id),
    FOREIGN KEY (act_id) REFERENCES ACTIVITY(act_id)
        ON DELETE CASCADE       ON UPDATE CASCADE
);

-- Part 4: Sample Data for PERMIT_REQUIREMENT
INSERT INTO "PERMIT_REQUIREMENT"
("permit_type", "act_id", "price")
VALUES
("backcountry", 1, 30), -- prices are made up
("filming/photography", 2, 45),
("peak hours reservation", 5, 0),
("climbing", 10, 53),
("fishing", 4, 38);



---------------------- PART 4: SAMPLE DATA FOR EACH TABLE ----------------------

-- NOTE: Data used in this file is a combination of real and synthetic data. The real data
--       comes from the following sources:






---------------------- PART 4: TEST QUERIES FOR EACH TABLE ----------------------



-- -- Part 4: Test Query for PARK - 5 biggest parks in the database
-- SELECT *
-- FROM PARK
-- ORDER BY size DESC
-- LIMIT 5;


-- -- Part 4: Test Query for STATE - 5 parks found in California
-- SELECT *
-- FROM STATE
-- WHERE [state] = "CA"
-- LIMIT 5;


-- -- Part 4: Test Query for EMPLOYEE - 5 employees that work at a lodge but not at a visitor center
-- SELECT *
-- FROM EMPLOYEE
-- WHERE center_emp = 0 AND lodge_emp = 1
-- LIMIT 5;


-- -- Part 4: Test Query for PARK_EMPLOYMENT - 5 employees that work at Yosemite
-- SELECT *
-- FROM PARK_EMPLOYMENT
-- WHERE pname = "Yosemite"
-- LIMIT 5;


-- -- Part 4: Test Query for LODGING - 5 lodges (at any park) with a reference rate of less than $250 a night
-- SELECT *
-- FROM LODGING
-- WHERE rate <= 250
-- LIMIT 5;


-- -- Part 4: Test Query for ATTRACTION - 5 open attractions (in any park)
-- SELECT *
-- FROM ATTRACTION
-- WHERE [open] = 1
-- LIMIT 5;


-- -- Part 4: Test Query for VISITOR_CENTER - 5 visitor centers with food (in any park)
-- SELECT *
-- FROM VISITOR_CENTER
-- WHERE [food] = 1
-- LIMIT 5;


-- -- Part 4: Test Query for TRAIL - 5 trails that are loops (from any park)
-- SELECT *
-- FROM TRAIL
-- WHERE [loop] = 1
-- LIMIT 5;


-- -- Part 4: Test Query for CENTER_EMPLOYMENT - 5 records of visitor center employment for any national park visitor center
-- SELECT *
-- FROM CENTER_EMPLOYMENT
-- LIMIT 5;


-- -- Part 4: Test Query for LODGE_EMPLOYMENT - 5 records of lodge employment for any national park lodge
-- SELECT *
-- FROM LODGE_EMPLOYMENT
-- LIMIT 5;


-- -- Part 4: Test Query for POPULAR_WILDLIFE - 5 animals you can find in national parks that are low risk to humans
-- SELECT *
-- FROM POPULAR_WILDLIFE
-- WHERE threat_level = "low_risk"
-- LIMIT 5;


-- -- Part 4: Test Query for INHABITATION - 5 animals popularly seen in Yosemite
-- SELECT *
-- FROM INHABITATION
-- WHERE pname = "Yosemite"
-- LIMIT 5;


-- -- Part 4: Test Query for ACTIVITY - 5 popular activities to do in national parks
-- SELECT *
-- FROM ACTIVITY
-- LIMIT 5;


-- -- Part 4: Test Query for ACT_AVAILABILITY - activity ids of 5 activities available in Death Valley
-- SELECT *
-- FROM ACT_AVAILABILITY
-- WHERE pname = "Death Valley"
-- ORDER BY act_id ASC
-- LIMIT 5;


-- -- Part 4: Test Query for PERMIT_REQUIREMENT - 5 records of activity id and permit required for that activity
-- SELECT *
-- FROM PERMIT_REQUIREMENT
-- LIMIT 5;