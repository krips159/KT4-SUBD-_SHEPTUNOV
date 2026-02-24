-- Пункт 2:

-- DELIMITER $$
-- create procedure Structure_Create()
-- begin

-- end;
-- DELIMITER $$

-- Пункт 3:

-- DELIMITER $$
-- create procedure Structure_Re_Create()
-- begin

-- end;
-- DELIMITER $$

-- Пункт 4:

USE kt4;

CREATE TABLE IF NOT EXISTS Role (
    ID_Role SERIAL PRIMARY KEY,
    Role_Name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Passport (
    ID_Passport SERIAL PRIMARY KEY,
    Series VARCHAR(18),
    Number VARCHAR(28),
    Birth_Date DATE,
    Address VARCHAR(255),
    Issued_By VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `User` (
    ID_User SERIAL PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Middle_Name VARCHAR(50),
    ID_Role BIGINT UNSIGNED NOT NULL,
    Phone VARCHAR(50),
    Login VARCHAR(255) NOT NULL UNIQUE,
    Password_Hash VARCHAR(255) NOT NULL,
    Email VARCHAR(100),
    ID_Passport BIGINT UNSIGNED,
    FOREIGN KEY (ID_Role) REFERENCES Role(ID_Role),
    FOREIGN KEY (ID_Passport) REFERENCES Passport(ID_Passport)
);

CREATE TABLE IF NOT EXISTS Airport (
    ID_Airport SERIAL PRIMARY KEY,
    Airport_Name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Hotel (
    ID_Hotel SERIAL PRIMARY KEY,
    Hotel_Name VARCHAR(100) NOT NULL,
    Stars SMALLINT CHECK (Stars >= 1 AND Stars <= 5)
);

CREATE TABLE IF NOT EXISTS Additional_Service (
    ID_Service SERIAL PRIMARY KEY,
    Service_Name VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) CHECK (Price >= 0)
);

CREATE TABLE IF NOT EXISTS Tour (
    ID_Tour SERIAL PRIMARY KEY,
    Country VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    ID_Airport BIGINT UNSIGNED NOT NULL,
    ID_Hotel BIGINT UNSIGNED NOT NULL,
    ID_User BIGINT UNSIGNED NOT NULL,  
    Tour_Type VARCHAR(50) NOT NULL,   
    Departure_Date DATE,
    Duration_Days INT NOT NULL,
    Contract_Number VARCHAR(20),
    Total_Price DECIMAL(10, 2) CHECK (Total_Price >= 0),
    FOREIGN KEY (ID_Airport) REFERENCES Airport(ID_Airport),
    FOREIGN KEY (ID_Hotel) REFERENCES Hotel(ID_Hotel),
    FOREIGN KEY (ID_User) REFERENCES `User`(ID_User)
);

CREATE TABLE IF NOT EXISTS Contract (
	Contract_Number VARCHAR(20) PRIMARY KEY,
	Contract_Date DATE,
	ID_Tour BIGINT UNSIGNED NOT NULL,
    ID_Service BIGINT UNSIGNED NOT NULL,
    Total_Price DECIMAL(10, 2) CHECK (Total_Price >= 0),
    FOREIGN KEY (ID_Tour) REFERENCES Tour(ID_Tour),
    FOREIGN KEY (ID_Service) REFERENCES Additional_Service(ID_Service)
);

CREATE TABLE IF NOT EXISTS Tour_Additional_Service (
    ID_Tour BIGINT UNSIGNED NOT NULL,
    ID_Service BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (ID_Tour, ID_Service),
    FOREIGN KEY (ID_Tour) REFERENCES Tour(ID_Tour),
    FOREIGN KEY (ID_Service) REFERENCES Additional_Service(ID_Service)
);

CREATE TABLE IF NOT EXISTS Additional_Service_Contract (
    ID_Service BIGINT UNSIGNED NOT NULL,
    Contract_Number VARCHAR(20) NOT NULL,
    PRIMARY KEY (ID_Service, Contract_Number),
    FOREIGN KEY (ID_Service) REFERENCES Additional_Service(ID_Service),
    FOREIGN KEY (Contract_Number) REFERENCES Contract(Contract_Number)
);

-- Пункт 6:

CREATE USER IF NOT EXISTS 'r1_administrator'@'127.0.0.1' IDENTIFIED BY 'password';
CREATE USER IF NOT EXISTS 'r1_manager'@'127.0.0.1' IDENTIFIED BY 'password';
CREATE USER IF NOT EXISTS 'r1_client'@'127.0.0.1' IDENTIFIED BY 'password';
CREATE USER IF NOT EXISTS 'r1_guest'@'127.0.0.1' IDENTIFIED BY 'password';

GRANT SELECT, INSERT, UPDATE, DELETE ON kt4.Role TO 'r1_administrator'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE, DELETE ON kt4.`User` TO 'r1_administrator'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE, DELETE ON kt4.Passport TO 'r1_administrator'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE, DELETE ON kt4.Airport TO 'r1_administrator'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE, DELETE ON kt4.Hotel TO 'r1_administrator'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE, DELETE ON kt4.Additional_Service TO 'r1_administrator'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE, DELETE ON kt4.Tour TO 'r1_administrator'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE, DELETE ON kt4.Contract TO 'r1_administrator'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE, DELETE ON kt4.Tour_Additional_Service TO 'r1_administrator'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE, DELETE ON kt4.Additional_Service_Contract TO 'r1_administrator'@'127.0.0.1';

GRANT SELECT ON kt4.Role TO 'r1_manager'@'127.0.0.1';
GRANT SELECT ON kt4.Passport TO 'r1_manager'@'127.0.0.1';

GRANT SELECT, INSERT, UPDATE ON kt4.`User` TO 'r1_manager'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE ON kt4.Airport TO 'r1_manager'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE ON kt4.Hotel TO 'r1_manager'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE ON kt4.Additional_Service TO 'r1_manager'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE ON kt4.Tour TO 'r1_manager'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE ON kt4.Contract TO 'r1_manager'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE ON kt4.Tour_Additional_Service TO 'r1_manager'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE ON kt4.Additional_Service_Contract TO 'r1_manager'@'127.0.0.1';

GRANT SELECT ON kt4.Tour TO 'r1_client'@'127.0.0.1';
GRANT SELECT ON kt4.Hotel TO 'r1_client'@'127.0.0.1';
GRANT SELECT ON kt4.Airport TO 'r1_client'@'127.0.0.1';
GRANT SELECT ON kt4.Additional_Service TO 'r1_client'@'127.0.0.1';
GRANT SELECT ON kt4.Contract TO 'r1_client'@'127.0.0.1';

GRANT SELECT, UPDATE ON kt4.`User` TO 'r1_client'@'127.0.0.1';

GRANT SELECT ON kt4.Tour TO 'r1_guest'@'127.0.0.1';
GRANT SELECT ON kt4.Hotel TO 'r1_guest'@'127.0.0.1';
GRANT SELECT ON kt4.Airport TO 'r1_guest'@'127.0.0.1';
GRANT SELECT ON kt4.Additional_Service TO 'r1_guest'@'127.0.0.1';

GRANT USAGE ON kt4.* TO 'r1_administrator'@'127.0.0.1';
GRANT USAGE ON kt4.* TO 'r1_manager'@'127.0.0.1';
GRANT USAGE ON kt4.* TO 'r1_client'@'127.0.0.1';
GRANT USAGE ON kt4.* TO 'r1_guest'@'127.0.0.1';

FLUSH PRIVILEGES;

Пункт 7:

DELIMITER $$

CREATE PROCEDURE Structure_Create()
BEGIN

    CREATE TABLE IF NOT EXISTS Department (
        ID_Department INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        Name_Department VARCHAR(100) NOT NULL
    );
    

    CREATE INDEX index_Name_Department ON Department (Name_Department);
    

    CREATE TABLE IF NOT EXISTS Role (
        ID_Role SERIAL PRIMARY KEY,
        Role_Name VARCHAR(50) NOT NULL
    );
    

    CREATE TABLE IF NOT EXISTS Passport (
        ID_Passport SERIAL PRIMARY KEY,
        Series VARCHAR(18),
        Number VARCHAR(28),
        Birth_Date DATE,
        Address VARCHAR(255),
        Issued_By VARCHAR(255)
    );
    

    CREATE TABLE IF NOT EXISTS `User` (
        ID_User SERIAL PRIMARY KEY,
        First_Name VARCHAR(50) NOT NULL,
        Last_Name VARCHAR(50) NOT NULL,
        Middle_Name VARCHAR(50),
        ID_Role BIGINT UNSIGNED NOT NULL,
        Phone VARCHAR(50),
        Login VARCHAR(255) NOT NULL UNIQUE,
        Password_Hash VARCHAR(255) NOT NULL,
        Email VARCHAR(100),
        ID_Passport BIGINT UNSIGNED,
        FOREIGN KEY (ID_Role) REFERENCES Role(ID_Role),
        FOREIGN KEY (ID_Passport) REFERENCES Passport(ID_Passport)
    );
    

    CREATE TABLE IF NOT EXISTS Airport (
        ID_Airport SERIAL PRIMARY KEY,
        Airport_Name VARCHAR(100) NOT NULL
    );
    

    CREATE INDEX index_Airport_Name ON Airport (Airport_Name);
    

    CREATE TABLE IF NOT EXISTS Hotel (
        ID_Hotel SERIAL PRIMARY KEY,
        Hotel_Name VARCHAR(100) NOT NULL,
        Stars SMALLINT CHECK (Stars >= 1 AND Stars <= 5)
    );
    

    CREATE INDEX index_Hotel_Name ON Hotel (Hotel_Name);
    CREATE INDEX index_Hotel_Stars ON Hotel (Stars);
    

    CREATE TABLE IF NOT EXISTS Additional_Service (
        ID_Service SERIAL PRIMARY KEY,
        Service_Name VARCHAR(100) NOT NULL,
        Price DECIMAL(10, 2) CHECK (Price >= 0)
    );
    

    CREATE INDEX index_Service_Name ON Additional_Service (Service_Name);
    CREATE INDEX index_Service_Price ON Additional_Service (Price);
    

    CREATE TABLE IF NOT EXISTS Tour (
        ID_Tour SERIAL PRIMARY KEY,
        Country VARCHAR(50) NOT NULL,
        City VARCHAR(50) NOT NULL,
        ID_Airport BIGINT UNSIGNED NOT NULL,
        ID_Hotel BIGINT UNSIGNED NOT NULL,
        ID_User BIGINT UNSIGNED NOT NULL,  
        Tour_Type VARCHAR(50) NOT NULL,   
        Departure_Date DATE,
        Duration_Days INT NOT NULL,
        Contract_Number VARCHAR(20),
        Total_Price DECIMAL(10, 2) CHECK (Total_Price >= 0),
        FOREIGN KEY (ID_Airport) REFERENCES Airport(ID_Airport),
        FOREIGN KEY (ID_Hotel) REFERENCES Hotel(ID_Hotel),
        FOREIGN KEY (ID_User) REFERENCES `User`(ID_User)
    );
    
    CREATE INDEX index_Tour_Country ON Tour (Country);
    CREATE INDEX index_Tour_City ON Tour (City);
    CREATE INDEX index_Tour_Departure_Date ON Tour (Departure_Date);
    CREATE INDEX index_Tour_Total_Price ON Tour (Total_Price);
    CREATE INDEX index_Tour_ID_Airport ON Tour (ID_Airport);
    CREATE INDEX index_Tour_ID_Hotel ON Tour (ID_Hotel);
    CREATE INDEX index_Tour_ID_User ON Tour (ID_User);
    
    CREATE TABLE IF NOT EXISTS Contract (
        Contract_Number VARCHAR(20) PRIMARY KEY,
        Contract_Date DATE,
        ID_Tour BIGINT UNSIGNED NOT NULL,
        ID_Service BIGINT UNSIGNED NOT NULL,
        Total_Price DECIMAL(10, 2) CHECK (Total_Price >= 0),
        FOREIGN KEY (ID_Tour) REFERENCES Tour(ID_Tour),
        FOREIGN KEY (ID_Service) REFERENCES Additional_Service(ID_Service)
    );
    
    CREATE INDEX index_Contract_Date ON Contract (Contract_Date);
    CREATE INDEX index_Contract_ID_Tour ON Contract (ID_Tour);
    CREATE INDEX index_Contract_ID_Service ON Contract (ID_Service);
    
    CREATE TABLE IF NOT EXISTS Tour_Additional_Service (
        ID_Tour BIGINT UNSIGNED NOT NULL,
        ID_Service BIGINT UNSIGNED NOT NULL,
        PRIMARY KEY (ID_Tour, ID_Service),
        FOREIGN KEY (ID_Tour) REFERENCES Tour(ID_Tour),
        FOREIGN KEY (ID_Service) REFERENCES Additional_Service(ID_Service)
    );
    
    CREATE INDEX index_TAS_ID_Service ON Tour_Additional_Service (ID_Service);
    
    CREATE TABLE IF NOT EXISTS Additional_Service_Contract (
        ID_Service BIGINT UNSIGNED NOT NULL,
        Contract_Number VARCHAR(20) NOT NULL,
        PRIMARY KEY (ID_Service, Contract_Number),
        FOREIGN KEY (ID_Service) REFERENCES Additional_Service(ID_Service),
        FOREIGN KEY (Contract_Number) REFERENCES Contract(Contract_Number)
    );
    
    CREATE INDEX index_ASC_Contract_Number ON Additional_Service_Contract (Contract_Number);
    
END$$

DELIMITER ;


CREATE USER IF NOT EXISTS 'r1_administrator'@'127.0.0.1' IDENTIFIED BY 'password';
CREATE USER IF NOT EXISTS 'r1_manager'@'127.0.0.1' IDENTIFIED BY 'password';
CREATE USER IF NOT EXISTS 'r1_client'@'127.0.0.1' IDENTIFIED BY 'password';
CREATE USER IF NOT EXISTS 'r1_guest'@'127.0.0.1' IDENTIFIED BY 'password';


GRANT SELECT, INSERT, UPDATE, DELETE ON kt4.Role TO 'r1_administrator'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE, DELETE ON kt4.`User` TO 'r1_administrator'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE, DELETE ON kt4.Passport TO 'r1_administrator'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE, DELETE ON kt4.Airport TO 'r1_administrator'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE, DELETE ON kt4.Hotel TO 'r1_administrator'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE, DELETE ON kt4.Additional_Service TO 'r1_administrator'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE, DELETE ON kt4.Tour TO 'r1_administrator'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE, DELETE ON kt4.Contract TO 'r1_administrator'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE, DELETE ON kt4.Tour_Additional_Service TO 'r1_administrator'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE, DELETE ON kt4.Additional_Service_Contract TO 'r1_administrator'@'127.0.0.1';


GRANT SELECT ON kt4.Role TO 'r1_manager'@'127.0.0.1';
GRANT SELECT ON kt4.Passport TO 'r1_manager'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE ON kt4.`User` TO 'r1_manager'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE ON kt4.Airport TO 'r1_manager'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE ON kt4.Hotel TO 'r1_manager'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE ON kt4.Additional_Service TO 'r1_manager'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE ON kt4.Tour TO 'r1_manager'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE ON kt4.Contract TO 'r1_manager'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE ON kt4.Tour_Additional_Service TO 'r1_manager'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE ON kt4.Additional_Service_Contract TO 'r1_manager'@'127.0.0.1';


GRANT SELECT ON kt4.Tour TO 'r1_client'@'127.0.0.1';
GRANT SELECT ON kt4.Hotel TO 'r1_client'@'127.0.0.1';
GRANT SELECT ON kt4.Airport TO 'r1_client'@'127.0.0.1';
GRANT SELECT ON kt4.Additional_Service TO 'r1_client'@'127.0.0.1';
GRANT SELECT ON kt4.Contract TO 'r1_client'@'127.0.0.1';
GRANT SELECT, UPDATE ON kt4.`User` TO 'r1_client'@'127.0.0.1';


GRANT SELECT ON kt4.Tour TO 'r1_guest'@'127.0.0.1';
GRANT SELECT ON kt4.Hotel TO 'r1_guest'@'127.0.0.1';
GRANT SELECT ON kt4.Airport TO 'r1_guest'@'127.0.0.1';
GRANT SELECT ON kt4.Additional_Service TO 'r1_guest'@'127.0.0.1';


GRANT USAGE ON kt4.* TO 'r1_administrator'@'127.0.0.1';
GRANT USAGE ON kt4.* TO 'r1_manager'@'127.0.0.1';
GRANT USAGE ON kt4.* TO 'r1_client'@'127.0.0.1';
GRANT USAGE ON kt4.* TO 'r1_guest'@'127.0.0.1';

FLUSH PRIVILEGES;