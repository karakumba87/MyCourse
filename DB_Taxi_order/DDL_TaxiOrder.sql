CREATE TABLE Bonus {
  Bonus_id NUMBER PRIMARY KEY, 
  Bonus_name VARCHAR2 (60) NOT NULL
};

CREATE TABLE Users {
  User_id NUMBER PRIMARY KEY, 
  User_name VARCHAR2 (60) NOT NULL,
  User_phone NUMBER NOT NULL,
  Bonus_id NUMBER,
  CONSTRAINT FK_bonus_id FOREIGN KEY (Bonus_id) REFERENCES Bonus(Bonus_id)
};

CREATE INDEX Users_name_idx ON Users (User_name);
CREATE INDEX Users_phone_idx ON Users (User_phone);

CREATE TABLE Users {
  Street_id NUMBER PRIMARY KEY, 
  Street_name VARCHAR2 (60) NOT NULL
};

CREATE INDEX Street_name_idx ON Street (Street_name);

CREATE TABLE Address {
  Address_id NUMBER PRIMARY KEY, 
  City VARCHAR2 (60) NOT NULL,
  Street_id NUMBER,
  House NUMBER,
  CONSTRAINT FK_Street_id FOREIGN KEY (Street_id) REFERENCES Address(Street_id)
};

CREATE INDEX Address_city_idx ON Address (City);
CREATE INDEX Address_street_id_idx ON Address (Street_id);

CREATE TABLE Driver {
  Driver_id NUMBER PRIMARY KEY, 
  Driver_name VARCHAR2 (60) NOT NULL,
  Driver_phone NUMBER NOT NULL
};

CREATE INDEX Driver_phone_idx ON Driver (Driver_phone);
CREATE INDEX Driver_name_idx ON Driver (Driver_name);

CREATE TABLE Model {
  Model_id NUMBER PRIMARY KEY, 
  Model VARCHAR2 (60) NOT NULL,
  Color VARCHAR2 (60) NOT NULL
};

CREATE INDEX Model_idx ON Model (Model);

CREATE TABLE Cars {
  Car_id NUMBER PRIMARY KEY, 
  Model_id NUMBER,
  Number_reg NUMBER NOT NULL
  Driver_id NUMBER,
  CONSTRAINT FK_Model_id FOREIGN KEY (Model_id) REFERENCES Model(Model_id),
  CONSTRAINT FK_Driver_id FOREIGN KEY (Driver_id) REFERENCES Driver(Driver_id)
};

CREATE INDEX Cars_model_id_idx ON Cars (Model_id);
CREATE INDEX Cars_number_reg_idx ON Cars (Number_reg);
CREATE INDEX Cars_driver_id_idx ON Cars (Driver_id);

CREATE TABLE Order_taxi {
	Order_id NUMBER PRIMARY KEY, 
	User_id NUMBER,
	Address_source_id NUMBER,
	Address_dist_id NUMBER,
	Car_id NUMBER,
	Price DOUBLE NOT NULL,
	Distance DOUBLE NOT NULL,
	Date_time_from DATE NOT NULL,
	Date_time_to DATE,
	CONSTRAINT FK_user_id FOREIGN KEY (User_id) REFERENCES Users(User_id),
	CONSTRAINT FK_address_source_id FOREIGN KEY (Address_source_id) REFERENCES Address(Address_id),
	CONSTRAINT FK_address_dist_id FOREIGN KEY (Address_dist_id) REFERENCES Address(Address_id),
	CONSTRAINT FK_Car_id FOREIGN KEY (Car_id) REFERENCES Cars(Model_id)
};

CREATE INDEX Order_user_id_idx ON Order_taxi (User_id);
CREATE INDEX Order_address_source_idx ON Order_taxi (Address_source);
CREATE INDEX Order_address_dist_idx ON Order_taxi (Address_dist);
CREATE INDEX Order_date_time_from_id_idx ON Order_taxi (Date_time_from_id);
