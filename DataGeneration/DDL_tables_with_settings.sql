CREATE TABLE Table_settings (
	Table_id NUMBER PRIMARY KEY,
	Table_name VARCHAR(60) NOT NULL,
	Schema_with_tables VARCHAR(60) NOT NULL
	CONSTRAINT Table_name_uniq UNIQUE (Table_name)
);

CREATE TABLE Column_settings (
	Column_name VARCHAR(60) NOT NULL,
	Type_col VARCHAR(15) NOT NULL,
	Table_id NUMBER,	
	Min_number NUMBER NOT NULL DEFAULT 0,	
	Max_namber NUMBER NOT NULL DEFAULT 0,	
	Min_date DATE NOT NULL DEFAULT TO_DATE(SYSDATE,'dd.mm.yyyy') ,
	Max_date DATE NOT NULL DEFAULT TO_DATE(SYSDATE,'dd.mm.yyyy') ,	
	Constraint_nnull BOOLEAN NOT NULL DEFAULT 0,	
	Random_or_order BOOLEAN NOT NULL DEFAULT 0,	
	Is_pk BOOLEAN NOT NULL DEFAULT 0,
	CONSTRAINT Table_id_fk FOREIGN KEY (Table_id) REFERENCES Table_settings(Table_id) DELETE ON CASCADE
);




