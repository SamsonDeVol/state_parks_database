-- ER Diagram Entity: PARK
DROP TABLE IF EXISTS PARK;
CREATE TABLE PARK
(
    [name] VARCHAR(100) NOT NULL PRIMARY KEY,
    size INT, -- acres
    established DATE, -- YYYY-MM-DD
    [open] BIT -- 1 for True, 0 for False
);

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

-- ER Diagram Multi-Valued Attribute: PARK(state)
DROP TABLE IF EXISTS [STATE];
CREATE TABLE [STATE]
(
    [state] CHAR(2) NOT NULL,
    pname VARCHAR(100) NOT NULL,
    PRIMARY KEY ([state], pname),
    FOREIGN KEY (pname) REFERENCES PARK([name])
);

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

-- ER Diagram Entity: EMPLOYEE
DROP TABLE IF EXISTS EMPLOYEE;
CREATE TABLE EMPLOYEE
(
    ssn INT NOT NULL PRIMARY KEY,
    fname VARCHAR(30),
    lname VARCHAR(30),
    title VARCHAR(30),
    [type] VARCHAR(30) -- make type be of the domain ("center", "lodging", "other")
);

INSERT INTO "EMPLOYEE"
("ssn", "fname", "lname", "title", "type")
VALUES
(111222333, "Jerry", "Tolkien", "ranger", "other"),
(222333444, "Will", "Shakespeare", "park manager", "other"),
(333444555, "Gabriel", "Trahan", "custodian", "center"),
(444555666, "Agnes", "Hemmingway", "maintenance worker", "other"),
(555666777, "Katy", "Perry", "biologist", "other"),
(666777888, "Johnny", "Depp", "hotel manager", "lodging"),
(777888999, "Taylor", "Swift", "waitress", "center"),
(888999000, "Bilbo", "Baggins", "clerk", "center"),
(999000111, "Frodo", "Baggins", "center manager", "center"),
(000111222, "Adele", "Adele", "guide", "center"),
(111999888, "Shimano", "Trek", "front desk assistant", "lodging"),
(222111000, "Ryan", "Reynolds", "maid", "lodging"),
(333222111, "Scooby", "Doo", "pool cleaner", "lodging"),
(444333222, "Hermione", "Granger", "shuttle driver", "lodging");

-- ER Diagram Relationship: WORKS_FOR
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

-- ER Diagram Entity: LODGING
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

INSERT INTO "LODGING"
("pname", "lname", "open_date", "close_date", "rate")
VALUES
("Yosemite", "Yosemite View Lodge", "2022-01-01", "2022-12-31", 283),
("Crater Lake", "Crater Lake Lodge", "2022-05-15", "2022-10-05", 250),
("Death Valley", "The Ranch at Death Valley", "2022-01-01", "2022-12-31", 239),
("Olympic", "Lake Crescent Lodge", "2022-04-29", "2022-12-31", 300),
("Sequoia", "Wuksachi Lodge", "2022-04-29", "2022-12-31", 250);

-- ER Diagram Entity: ATTRACTION
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

INSERT INTO "ATTRACTION"
("pname", "aname", "description", "open", "restroom")
VALUES
("apname", "aaname", "adescription", "aopen", "arestroom")
-- include a yosemite visitor center
;

-- ER Diagram Sub-Entity: VISITOR_CENTER
DROP TABLE IF EXISTS VISITOR_CENTER;
CREATE TABLE VISITOR_CENTER
(
    att_id INT PRIMARY KEY NOT NULL,
    food BIT,
    FOREIGN KEY (att_id) REFERENCES ATTRACTION(att_id)
        ON DELETE CASCADE       ON UPDATE CASCADE
);

INSERT INTO "VISITOR_CENTER"
("att_id", "food")
VALUES
("aatt_id", "afood");

-- ER Diagram Sub-Entity: TRAIL
DROP TABLE IF EXISTS TRAIL;
CREATE TABLE TRAIL
(
    att_id INT PRIMARY KEY NOT NULL,
    [length] FLOAT,
    [loop] BIT,
    difficulty TEXT CHECK(difficulty IN ('easy', 'moderate', 'difficult', 'impossible')),
    vert_gain INT,
    FOREIGN KEY (att_id) REFERENCES ATTRACTION(att_id)
        ON DELETE CASCADE       ON UPDATE CASCADE
);

INSERT INTO "TRAIL"
("att_id", "length", "loop", "difficulty", "vert_gain")
VALUES
("att_id", "alength", "aloop", "easy", "avert_gain")
;

-- ER Diagram Relationship: WORKS_IN_CENTER
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

INSERT INTO "CENTER_EMPLOYMENT"
("essn", "vc_id")
VALUES
("aessn", "avc_id")
-- include the essns of yosemite employees with type = center
;

-- ER Diagram Relationship: WORKS_IN_LODGE
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

INSERT INTO "LODGE_EMPLOYMENT"
("essn", "l_id")
VALUES
(1, 2)
-- include the essns of yosemite employees with type = lodging
;

-- ER Diagram Entity: POPULAR_WILDLIFE
DROP TABLE IF EXISTS POPULAR_WILDLIFE;
CREATE TABLE POPULAR_WILDLIFE
(
    species VARCHAR(30) PRIMARY KEY NOT NULL,
    class VARCHAR (20),
    threat_level TEXT CHECK(threat_level IN ('low risk', 'moderate risk', 'dead on sight'))
);

INSERT INTO "POPULAR_WILDLIFE"
("species", "class", "threat_level")
VALUES
("aspecies", "aclass", "dead on sight")
;

-- ER Diagram Relationship: INHABITS
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

INSERT INTO "INHABITATION"
("species", "pname", "quantity")
VALUES
("aspecies", "apname", "aquantity")
;

-- ER Diagram Entity: ACTIVITY
DROP TABLE IF EXISTS ACTIVITY;
CREATE TABLE ACTIVITY
(
    act_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    [type] VARCHAR(10),
    [description] VARCHAR(255)
);

INSERT INTO "ACTIVITY"
("type", "description")
VALUES
(5, "adescription"),
(1, "anotherdescription")
;

-- ER Diagram Relationship: AVAILABLE_IN
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

INSERT INTO "ACT_AVAILABILITY"
("act_id", "pname")
VALUES
(5, "Yosemite")
;

-- ER Diagram Relationship: REQUIRES
DROP TABLE IF EXISTS PERMIT_REQUIREMENT;
CREATE TABLE PERMIT_REQUIREMENT
(
    permit_type VARCHAR(20) NOT NULL,
    act_id INT NOT NULL,
    price FLOAT,
    PRIMARY KEY (permit_type, act_id),
    FOREIGN KEY (act_id) REFERENCES ACTIVITY(act_id)
        ON DELETE CASCADE       ON UPDATE CASCADE
);

INSERT INTO "PERMIT_REQUIREMENT"
("permit_type", "act_id", "price")
VALUES
("apermit_type", "aact_id", "aprice")
;
