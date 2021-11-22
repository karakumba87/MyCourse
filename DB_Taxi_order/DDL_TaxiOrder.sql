CREATE TABLE Bonus (
  Bonus_id NUMBER PRIMARY KEY, 
  Bonus_name VARCHAR2 (60) NOT NULL
);

CREATE TABLE Client (
  Client_id NUMBER PRIMARY KEY, 
  Client_name VARCHAR2 (60) NOT NULL,
  Client_phone NUMBER NOT NULL,
  Bonus_id NUMBER,
  CONSTRAINT FK_bonus_id FOREIGN KEY (Bonus_id) REFERENCES Bonus(Bonus_id) ON DELETE SET NULL
);

CREATE INDEX Client_name_idx ON Client (Client_name);
CREATE INDEX Client_phone_idx ON Client (Client_phone);

CREATE TABLE Street (
  Street_id NUMBER PRIMARY KEY, 
  Street_name VARCHAR2 (60) NOT NULL
);

CREATE INDEX Street_name_idx ON Street (Street_name);

CREATE TABLE Address (
  Address_id NUMBER PRIMARY KEY, 
  City VARCHAR2 (60) NOT NULL,
  Street_id NUMBER,
  House NUMBER,
  CONSTRAINT FK_Street_id FOREIGN KEY (Street_id) REFERENCES Street(Street_id)
);

CREATE INDEX Address_city_idx ON Address (City);
CREATE INDEX Address_street_id_idx ON Address (Street_id);

CREATE TABLE Driver (
  Driver_id NUMBER PRIMARY KEY, 
  Driver_name VARCHAR2 (60) NOT NULL,
  Driver_phone NUMBER NOT NULL
);

CREATE INDEX Driver_phone_idx ON Driver (Driver_phone);
CREATE INDEX Driver_name_idx ON Driver (Driver_name);

CREATE TABLE Cars (
  Car_id NUMBER PRIMARY KEY, 
  Model VARCHAR (60),
  Color VARCHAR (60),
  Number_reg NUMBER NOT NULL,
  Driver_id NUMBER,
  CONSTRAINT FK_Driver_id FOREIGN KEY (Driver_id) REFERENCES Driver(Driver_id) ON DELETE CASCADE
);

CREATE INDEX Cars_model_id_idx ON Cars (Model);
CREATE INDEX Cars_number_reg_idx ON Cars (Number_reg);
CREATE INDEX Cars_driver_id_idx ON Cars (Driver_id);

CREATE TABLE Order_taxi (
	Order_id NUMBER PRIMARY KEY, 
	Client_id NUMBER,
	Address_source_id NUMBER,
	Address_dist_id NUMBER,
	Car_id NUMBER,
	Price DEC (4,2) NOT NULL,
	Distance DEC (4,2) NOT NULL,
	Date_time_from DATE NOT NULL,
	Date_time_to DATE,
	CONSTRAINT FK_Client_id FOREIGN KEY (Client_id) REFERENCES Client(Client_id) ON DELETE SET NULL,
	CONSTRAINT FK_address_source_id FOREIGN KEY (Address_source_id) REFERENCES Address(Address_id) ON DELETE SET NULL,
	CONSTRAINT FK_address_dist_id FOREIGN KEY (Address_dist_id) REFERENCES Address(Address_id) ON DELETE SET NULL,
	CONSTRAINT FK_Car_id FOREIGN KEY (Car_id) REFERENCES Cars(Car_id) ON DELETE SET NULL
);

CREATE INDEX Order_Client_id_idx ON Order_taxi (Client_id);
CREATE INDEX Order_address_source_idx ON Order_taxi (Address_source_id);
CREATE INDEX Order_address_dist_idx ON Order_taxi (Address_dist_id);
CREATE INDEX Order_date_time_from_id_idx ON Order_taxi (Date_time_from);