## Table
There are two tables (Manufacturers and Products)

## Creation Code for table
CREATE TABLE Manufacturers (
	Code INTEGER PRIMARY KEY NOT NULL,  
	Name TEXT NOT NULL   
);

CREATE TABLE Products (
	Code INTEGER PRIMARY KEY NOT NULL,  
	Name TEXT NOT NULL ,  
	Price REAL NOT NULL ,  
	Manufacturer INTEGER NOT NULL   
		CONSTRAINT fk_Manufacturers_Code REFERENCES MANUFACTURERS(Code)   
);
