CREATE TABLE Table_settings (
	Table_id NUMBER PRIMARY KEY,
	Table_name VARCHAR(60) NOT NULL,
	Schema_with_tables VARCHAR(60) NOT NULL,
	Count_row NUMBER DEFAULT 0,
	CONSTRAINT Table_name_uniq UNIQUE (Table_name)
);

CREATE TABLE Column_settings (
	Column_name VARCHAR2(60) NOT NULL,
	Type_col VARCHAR2(15) NOT NULL,
	Table_id NUMBER,	
	Min_number NUMBER DEFAULT 0,	
	Max_namber NUMBER DEFAULT 0,	
	Min_date DATE DEFAULT TO_DATE(SYSDATE,'dd.mm.yyyy') ,
	Max_date DATE DEFAULT TO_DATE(SYSDATE,'dd.mm.yyyy') ,	
	Constraint_nnull NUMBER DEFAULT 0,	
	Random_or_order NUMBER DEFAULT 0,	
	Is_pk NUMBER DEFAULT 0,
	CONSTRAINT Table_id_fk FOREIGN KEY (Table_id) REFERENCES Table_settings(Table_id) ON DELETE CASCADE
);

INSERT ALL 
	INTO Table_settings (Table_id, Table_name, Schema_with_tables, Count_row) VALUES (1, 'User_reg', 'Neoflex', 5)
	INTO Table_settings (Table_id, Table_name, Schema_with_tables, Count_row) VALUES (2, 'Session', 'Neoflex', 2000)
SELECT * FROM Dual;

INSERT ALL 
	INTO Column_settings (Column_name, Type_col, Table_id, Min_number, Max_namber, Min_date, Max_date, Constraint_nnull, Random_or_order, Is_pk) 
		VALUES ('User_id', 'number', 1, 1, 0, TO_DATE(SYSDATE,'dd.mm.yyyy'), TO_DATE(SYSDATE,'dd.mm.yyyy'), 1, 0, 1)
	INTO Column_settings (Column_name, Type_col, Table_id, Min_number, Max_namber, Min_date, Max_date, Constraint_nnull, Random_or_order, Is_pk) 
		VALUES ('Name_user', 'varchar', 1, 5, 0, TO_DATE(SYSDATE,'dd.mm.yyyy'), TO_DATE(SYSDATE,'dd.mm.yyyy'), 1, 0, 0)
	INTO Column_settings (Column_name, Type_col, Table_id, Min_number, Max_namber, Min_date, Max_date, Constraint_nnull, Random_or_order, Is_pk) 
		VALUES ('Email', 'varchar', 1, 11, 11, TO_DATE(SYSDATE,'dd.mm.yyyy'), TO_DATE(SYSDATE,'dd.mm.yyyy'), 1, 0, 1)
	INTO Column_settings (Column_name, Type_col, Table_id, Min_number, Max_namber, Min_date, Max_date, Constraint_nnull, Random_or_order, Is_pk) 
		VALUES ('Phone', 'number', 1, 11, 11, TO_DATE(SYSDATE,'dd.mm.yyyy'), TO_DATE(SYSDATE,'dd.mm.yyyy'), 0, 0, 1)
	INTO Column_settings (Column_name, Type_col, Table_id, Min_number, Max_namber, Min_date, Max_date, Constraint_nnull, Random_or_order, Is_pk) 
		VALUES ('Date_registration', 'date', 1, 0, 0, TO_DATE('1/1/2021', 'DD/MM/YYYY'), TO_DATE(SYSDATE,'dd.mm.yyyy'), 1, 0, 0)
	INTO Column_settings (Column_name, Type_col, Table_id, Min_number, Max_namber, Min_date, Max_date, Constraint_nnull, Random_or_order, Is_pk) 
		VALUES ('Session', 'date_interval', 2, 0, 0, TO_DATE('1/1/2021', 'DD/MM/YYYY'), TO_DATE(SYSDATE,'dd.mm.yyyy'), 1, 0, 0)
	INTO Column_settings (Column_name, Type_col, Table_id, Min_number, Max_namber, Min_date, Max_date, Constraint_nnull, Random_or_order, Is_pk) 
		VALUES ('Session_id', 'number', 2, 1, 2000, TO_DATE(SYSDATE,'dd.mm.yyyy'), TO_DATE(SYSDATE,'dd.mm.yyyy'), 1, 1, 0)
	INTO Column_settings (Column_name, Type_col, Table_id, Min_number, Max_namber, Min_date, Max_date, Constraint_nnull, Random_or_order, Is_pk) 
		VALUES ('User_id', 'number', 2, 1, 5, TO_DATE(SYSDATE,'dd.mm.yyyy'), TO_DATE(SYSDATE,'dd.mm.yyyy'), 1, 1, 0)
SELECT * FROM Dual;
	
	
	
	
	
	
	
	
