CREATE TABLE Genre (
	Genre_id NUMBER PRIMARY KEY, 
	Name_genre VARCHAR2 (60) NOT NULL,
	CONSTRAINT Uniq_genre UNIQUE(Name_genre)
);

CREATE TABLE Acthor (
	Acthor_id NUMBER  PRIMARY KEY, 
	Name_acthor VARCHAR2 (60) NOT NULL,
	CONSTRAINT Uniq_acthor UNIQUE(Name_acthor)
);

CREATE TABLE Director (
	Director_id NUMBER  PRIMARY KEY, 
	Name_director VARCHAR2 (60) NOT NULL,
	CONSTRAINT Uniq_director UNIQUE(Name_director)
);

CREATE TABLE Country (
	Country_id NUMBER  PRIMARY KEY, 
	Name_country VARCHAR2 (60) NOT NULL,
	CONSTRAINT Uniq_country UNIQUE(Name_country)
);

CREATE TABLE Adv_partner (
	Adv_partner_id NUMBER  PRIMARY KEY, 
	Partner_name VARCHAR2 (60) NOT NULL,
	CONSTRAINT Uniq_adv_partner UNIQUE(Partner_name)
);

CREATE TABLE Users_reg (
	User_id NUMBER  PRIMARY KEY, 
	Name_user VARCHAR2 (60) NOT NULL, 
	Email VARCHAR2 (60) NOT NULL, 
	Country_id NUMBER, 
	Date_registration DATE NOT NULL,
	CONSTRAINT Uniq_email UNIQUE(Email),
	CONSTRAINT FK_country FOREIGN KEY (Country_id) REFERENCES Country(Country_id) ON DELETE SET NULL
);

CREATE INDEX Users_reg_name_idx ON Users_reg (Name_user);
CREATE INDEX Users_reg_country_id_idx ON Users_reg (Country_id);

CREATE TABLE Film_cards (
	Film_id NUMBER  PRIMARY KEY, 
	Name_film VARCHAR2 (60) NOT NULL, 
	Type_film VARCHAR2 (60) NOT NULL, 
	Season NUMBER, 
	Series NUMBER, 
	Link VARCHAR2 (200),
	Premier DATE,
	Description VARCHAR2 (300),
	Rating DECIMAL (2, 1),
	Duration NUMBER,
	CONSTRAINT Type_check CHECK (Type_film IN ('Сериал', 'Фильм'))
);

CREATE INDEX Film_name_idx ON Film_cards (Name_film);
CREATE INDEX Film_type_idx ON Film_cards (Type_film);
CREATE INDEX Film_premier_idx ON Film_cards (Premier);
CREATE INDEX Film_rating_idx ON Film_cards (Rating);
CREATE INDEX Film_serials_idx ON Film_cards (Name_film, Season, Series);

CREATE TABLE Genre_from_film (
	Film_id NUMBER,
	Genre_id NUMBER,
	CONSTRAINT FK_genre FOREIGN KEY (Genre_id) REFERENCES Genre(Genre_id) ON DELETE CASCADE,
	CONSTRAINT FK_film_genres FOREIGN KEY (Film_id) REFERENCES Film_cards(Film_id) ON DELETE CASCADE
);

CREATE INDEX Genre_from_film_f_idx ON Genre_from_film (Film_id);
CREATE INDEX Genre_from_film_g_idx ON Genre_from_film (Genre_id);

CREATE TABLE Acthor_from_film (
	Film_id NUMBER,
	Acthor_id NUMBER,
	CONSTRAINT FK_acthor FOREIGN KEY (Acthor_id) REFERENCES Acthor(Acthor_id) ON DELETE CASCADE,
	CONSTRAINT FK_film_acthors FOREIGN KEY (Film_id) REFERENCES Film_cards(Film_id) ON DELETE CASCADE
);

CREATE INDEX Acthor_from_film_f_idx ON Acthor_from_film (Film_id);
CREATE INDEX Acthor_from_film_a_idx ON Acthor_from_film (Acthor_id);

CREATE TABLE Director_from_film (
	Film_id NUMBER,
	Director_id NUMBER,
	CONSTRAINT FK_director FOREIGN KEY (Director_id) REFERENCES Director(Director_id) ON DELETE CASCADE,
	CONSTRAINT FK_film_directors FOREIGN KEY (Film_id) REFERENCES Film_cards(Film_id) ON DELETE CASCADE
);

CREATE INDEX Director_from_film_f_idx ON Director_from_film (Film_id);
CREATE INDEX Director_from_film_g_idx ON Director_from_film (Director_id);

CREATE TABLE Country_from_film (
	Film_id NUMBER,
	Country_id NUMBER,
	CONSTRAINT FK_country_from_film_c FOREIGN KEY (Country_id) REFERENCES Country(Country_id) ON DELETE CASCADE,
	CONSTRAINT FK_country_from_film_f FOREIGN KEY (Film_id) REFERENCES Film_cards(Film_id) ON DELETE CASCADE
);

CREATE INDEX Country_from_film_f_idx ON Country_from_film (Film_id);
CREATE INDEX Country_from_film_g_idx ON Country_from_film (Country_id);

CREATE TABLE Adv_partner_history (
	Partner_id NUMBER,
	Date_contract DATE NOT NULL,
	Price_for_click DECIMAL (3, 2) NOT NULL,
	CONSTRAINT FK_adv_parthner_h FOREIGN KEY (Partner_id) REFERENCES Adv_partner(Adv_partner_id) ON DELETE SET NULL
);

CREATE INDEX Adv_partner_history_id_idx ON Adv_partner_history (Partner_id);
CREATE INDEX Adv_partner_history_date_idx ON Adv_partner_history (Date_contract);

CREATE TABLE Sessions (
	Session_id NUMBER  PRIMARY KEY,
	User_id NUMBER,
	Log_in DATE NOT NULL,
	Log_out DATE,
	CONSTRAINT FK_user FOREIGN KEY (User_id) REFERENCES Users_reg(User_id) ON DELETE SET NULL
);

CREATE INDEX Sessions_user_idx ON Sessions (User_id);

CREATE TABLE Views (
	View_id NUMBER  PRIMARY KEY,
	Session_id NUMBER,
	Film_id NUMBER,
	Adv_partner_id NUMBER,
	Count_adv NUMBER,
	Count_click_adv NUMBER,
	CONSTRAINT FK_session FOREIGN KEY (Session_id) REFERENCES Sessions(Session_id) ON DELETE SET NULL,
	CONSTRAINT FK_film_view FOREIGN KEY (Film_id) REFERENCES Film_cards(Film_id) ON DELETE SET NULL,
	CONSTRAINT FK_adv_parthner FOREIGN KEY (Adv_partner_id) REFERENCES Adv_partner(Adv_partner_id) ON DELETE SET NULL
);

CREATE INDEX Views_film_idx ON Views (Film_id);
CREATE INDEX Views_partner_idx ON Views (Adv_partner_id);



INSERT ALL
	INTO Acthor (Acthor_id, Name_acthor) VALUES (1, 'Роберт Дауни - младший') 
	INTO Acthor (Acthor_id, Name_acthor) VALUES (2, 'Джон Фавро')
	INTO Acthor (Acthor_id, Name_acthor) VALUES (3, 'Гвинет Пэлтроу') 
	INTO Acthor (Acthor_id, Name_acthor) VALUES (4, 'Крис Хемсворт')
	INTO Acthor (Acthor_id, Name_acthor) VALUES (5, 'Натали Портман') 
	INTO Acthor (Acthor_id, Name_acthor) VALUES (6, 'Том Хиддлстон') 
	INTO Acthor (Acthor_id, Name_acthor) VALUES (7, 'Энтони Хопкинс') 
	INTO Acthor (Acthor_id, Name_acthor) VALUES (8, 'Крис Эванс')
	INTO Acthor (Acthor_id, Name_acthor) VALUES (9, 'Марк Руффало') 
	INTO Acthor (Acthor_id, Name_acthor) VALUES (10, 'Скарлетт Йоханссон')
	INTO Acthor (Acthor_id, Name_acthor) VALUES (11, 'Джоди Фостер') 
	INTO Acthor (Acthor_id, Name_acthor) VALUES (12, 'Брайан Крэнстон')
	INTO Acthor (Acthor_id, Name_acthor) VALUES (13, 'Аарон Пол') 
	INTO Acthor (Acthor_id, Name_acthor) VALUES (14, 'Анна Ганн')
	INTO Acthor (Acthor_id, Name_acthor) VALUES (15, 'Дин Норрис') 
	INTO Acthor (Acthor_id, Name_acthor) VALUES (16, 'Джонни Галэки')
	INTO Acthor (Acthor_id, Name_acthor) VALUES (17, 'Джим Парсонс') 
	INTO Acthor (Acthor_id, Name_acthor) VALUES (18, 'Кейли Куоко')
	INTO Acthor (Acthor_id, Name_acthor) VALUES (19, 'Саймон Хелберг') 
	INTO Acthor (Acthor_id, Name_acthor) VALUES (20, 'Кунал Найяр')
SELECT * FROM Dual;

INSERT ALL 
	INTO Genre (Genre_id, Name_genre) VALUES (1, 'Фантастика') 
	INTO Genre (Genre_id, Name_genre) VALUES (2, 'Боевик')
	INTO Genre (Genre_id, Name_genre) VALUES (3, 'Фэнтези') 
	INTO Genre (Genre_id, Name_genre) VALUES (4, 'Приключения')
	INTO Genre (Genre_id, Name_genre) VALUES (5, 'Триллер') 
	INTO Genre (Genre_id, Name_genre) VALUES (6, 'Детектив')
	INTO Genre (Genre_id, Name_genre) VALUES (7, 'Драма') 
	INTO Genre (Genre_id, Name_genre) VALUES (8, 'Комедия')
	INTO Genre (Genre_id, Name_genre) VALUES (9, 'Ситком')
SELECT * FROM Dual;

INSERT ALL 
	INTO Director (Director_id, Name_director) VALUES (1, 'Джон Фавро') 
	INTO Director (Director_id, Name_director) VALUES (2, 'Кеннет Брана')
	INTO Director (Director_id, Name_director) VALUES (3, 'Джосс Уидон') 
	INTO Director (Director_id, Name_director) VALUES (4, 'Джонатан Демми')
	INTO Director (Director_id, Name_director) VALUES (5, 'Винс Гиллиган') 
	INTO Director (Director_id, Name_director) VALUES (6, 'Марк Сендроуски')
SELECT * FROM Dual;

INSERT ALL 
	INTO Country (Country_id, Name_country) VALUES (1, 'США')
	INTO Country (Country_id, Name_country) VALUES (2, 'Канада')
	INTO Country (Country_id, Name_country) VALUES (3, 'Россия')
	INTO Country (Country_id, Name_country) VALUES (4, 'Украина')
SELECT * FROM Dual;

INSERT ALL 
	INTO Adv_partner (Adv_partner_id, Partner_name) VALUES (1, 'Yandex')
	INTO Adv_partner (Adv_partner_id, Partner_name) VALUES (2, 'Google')
SELECT * FROM Dual;

INSERT ALL
	INTO Users_reg (User_id, Name_user, Email, Country_id, Date_registration) 
		VALUES (1, 'Иванов Руслан', 'ivanov.ro@yandex.ru', 2, TO_DATE('01/01/21', 'DD/MM/YYYY'))
	INTO Users_reg (User_id, Name_user, Email, Country_id, Date_registration) 
		VALUES (2, 'Петров Кирилл', 'petrov.kv@mail.ru', 3, TO_DATE('01/01/21', 'DD/MM/YYYY'))
	INTO Users_reg (User_id, Name_user, Email, Country_id, Date_registration) 
		VALUES (3, 'Сидоров Сергей', 'sidorov.sv@gmail.com', 3, TO_DATE('01/01/21', 'DD/MM/YYYY'))
	INTO Users_reg (User_id, Name_user, Email, Country_id, Date_registration) 
		VALUES (4, 'Смирнов Дмитрий', 'smirnov.diu@rambler.ru', 4, TO_DATE('01/01/21', 'DD/MM/YYYY'))
SELECT * FROM Dual;

INSERT ALL
	INTO Film_cards (Film_id, Name_film, Type_film, Season, Series, Link, Premier, Description, Rating, Duration) 
		VALUES (1,	'Железный человек', 'Фильм', NULL, NULL, 'http:/www.google.rcom/1', TO_DATE('01/01/2008', 'DD/MM/YYYY'), 'dwdfverer', 7.9, 126)
	INTO Film_cards (Film_id, Name_film, Type_film, Season, Series, Link, Premier, Description, Rating, Duration) 
		VALUES (2,	'Теория большого взрыва', 'Сериал', 1, 1, 'http:/www.google.rcom/2', TO_DATE('01/01/2007', 'DD/MM/YYYY'), 'qweqweqwe', 8.1, 22)
	INTO Film_cards (Film_id, Name_film, Type_film, Season, Series, Link, Premier, Description, Rating, Duration) 
		VALUES (3,	'Тор', 'Фильм', NULL, NULL, 'http:/www.google.rcom/3', TO_DATE('01/01/2011', 'DD/MM/YYYY'), 'sdfvvbrtbvrd', 7.0, 115)
	INTO Film_cards (Film_id, Name_film, Type_film, Season, Series, Link, Premier, Description, Rating, Duration) 
		VALUES (4,	'Мстители', 'Фильм', NULL, NULL, 'http:/www.google.rcom/4', TO_DATE('01/01/2012', 'DD/MM/YYYY'), 'gkhtfkjjdgxkdf', 8.0, 143)
	INTO Film_cards (Film_id, Name_film, Type_film, Season, Series, Link, Premier, Description, Rating, Duration) 
		VALUES (5,	'Во все тяжкие', 'Сериал', 1, 1, 'http:/www.google.rcom/5', TO_DATE('01/01/2008', 'DD/MM/YYYY'), 'zvsbklodouuurei', 9.4, 49)
	INTO Film_cards (Film_id, Name_film, Type_film, Season, Series, Link, Premier, Description, Rating, Duration) 
		VALUES (6,	'Молчание ягнят', 'Фильм', NULL, NULL, 'http:/www.google.rcom/6', TO_DATE('01/01/1991', 'DD/MM/YYYY'), 'zdvjjkyuwetrtewrty', 8.6, 118)
	INTO Film_cards (Film_id, Name_film, Type_film, Season, Series, Link, Premier, Description, Rating, Duration) 
		VALUES (7,	'Теория большого взрыва', 'Сериал', 1, 2, 'http:/www.google.rcom/7', TO_DATE('01/01/2007', 'DD/MM/YYYY'), 'qweqweqwe', 8.1, 22)
	INTO Film_cards (Film_id, Name_film, Type_film, Season, Series, Link, Premier, Description, Rating, Duration) 
		VALUES (8,	'Теория большого взрыва', 'Сериал', 1, 3, 'http:/www.google.rcom/8', TO_DATE('01/01/2007', 'DD/MM/YYYY'), 'qweqweqwe', 8.1, 22)
	INTO Film_cards (Film_id, Name_film, Type_film, Season, Series, Link, Premier, Description, Rating, Duration) 
		VALUES (9,	'Теория большого взрыва', 'Сериал', 1, 4, 'http:/www.google.rcom/9', TO_DATE('01/01/2007', 'DD/MM/YYYY'), 'qweqweqwe', 8.1, 22)
	INTO Film_cards (Film_id, Name_film, Type_film, Season, Series, Link, Premier, Description, Rating, Duration) 
		VALUES (10,	'Теория большого взрыва', 'Сериал', 1, 5, 'http:/www.google.rcom/10', TO_DATE('01/01/2007', 'DD/MM/YYYY'), 'qweqweqwe', 8.1, 22)
	INTO Film_cards (Film_id, Name_film, Type_film, Season, Series, Link, Premier, Description, Rating, Duration) 
		VALUES (11,	'Теория большого взрыва', 'Сериал', 2, 1, 'http:/www.google.rcom/11', TO_DATE('01/01/2007', 'DD/MM/YYYY'), 'qweqweqwe', 8.1, 22)
	INTO Film_cards (Film_id, Name_film, Type_film, Season, Series, Link, Premier, Description, Rating, Duration) 
		VALUES (12,	'Теория большого взрыва', 'Сериал', 2, 2, 'http:/www.google.rcom/12', TO_DATE('01/01/2007', 'DD/MM/YYYY'), 'qweqweqwe', 8.1, 22)
	INTO Film_cards (Film_id, Name_film, Type_film, Season, Series, Link, Premier, Description, Rating, Duration) 
		VALUES (13,	'Теория большого взрыва', 'Сериал', 2, 3, 'http:/www.google.rcom/13', TO_DATE('01/01/2007', 'DD/MM/YYYY'), 'qweqweqwe', 8.1, 22)
	INTO Film_cards (Film_id, Name_film, Type_film, Season, Series, Link, Premier, Description, Rating, Duration) 
		VALUES (14,	'Теория большого взрыва', 'Сериал', 2, 4, 'http:/www.google.rcom/14', TO_DATE('01/01/2007', 'DD/MM/YYYY'), 'qweqweqwe', 8.1, 22)
	INTO Film_cards (Film_id, Name_film, Type_film, Season, Series, Link, Premier, Description, Rating, Duration) 
		VALUES (15,	'Во все тяжкие', 'Сериал', 1, 2, 'http:/www.google.rcom/15', TO_DATE('01/01/2008', 'DD/MM/YYYY'), 'zvsbklodouuurei', 9.4, 49)
	INTO Film_cards (Film_id, Name_film, Type_film, Season, Series, Link, Premier, Description, Rating, Duration) 
		VALUES (16,	'Во все тяжкие', 'Сериал', 2, 1, 'http:/www.google.rcom/16', TO_DATE('01/01/2008', 'DD/MM/YYYY'), 'zvsbklodouuurei', 9.4, 49)
	INTO Film_cards (Film_id, Name_film, Type_film, Season, Series, Link, Premier, Description, Rating, Duration) 
		VALUES (17,	'Во все тяжкие', 'Сериал', 2, 2, 'http:/www.google.rcom/17', TO_DATE('01/01/2008', 'DD/MM/YYYY'), 'zvsbklodouuurei', 9.4, 49)
	INTO Film_cards (Film_id, Name_film, Type_film, Season, Series, Link, Premier, Description, Rating, Duration) 
		VALUES (18,	'Во все тяжкие', 'Сериал', 3, 1, 'http:/www.google.rcom/18', TO_DATE('01/01/2008', 'DD/MM/YYYY'), 'zvsbklodouuurei', 9.4, 49)
	INTO Film_cards (Film_id, Name_film, Type_film, Season, Series, Link, Premier, Description, Rating, Duration) 
		VALUES (19,	'Во все тяжкие', 'Сериал', 3, 2, 'http:/www.google.rcom/19', TO_DATE('01/01/2008', 'DD/MM/YYYY'), 'zvsbklodouuurei', 9.4, 49)
	INTO Film_cards (Film_id, Name_film, Type_film, Season, Series, Link, Premier, Description, Rating, Duration) 
		VALUES (20,	'Во все тяжкие', 'Сериал', 3, 3, 'http:/www.google.rcom/20', TO_DATE('01/01/2008', 'DD/MM/YYYY'), 'zvsbklodouuurei', 9.4, 49)
SELECT * FROM Dual;

INSERT  ALL 
	INTO Genre_from_film (Film_id, Genre_id) VALUES (1, 1) INTO Genre_from_film (Film_id, Genre_id) VALUES (1, 2)
	INTO Genre_from_film (Film_id, Genre_id) VALUES (3, 1) INTO Genre_from_film (Film_id, Genre_id) VALUES (3, 2)
	INTO Genre_from_film (Film_id, Genre_id) VALUES (3, 3) INTO Genre_from_film (Film_id, Genre_id) VALUES (4, 1)
	INTO Genre_from_film (Film_id, Genre_id) VALUES (4, 2) INTO Genre_from_film (Film_id, Genre_id) VALUES (4, 4)
	INTO Genre_from_film (Film_id, Genre_id) VALUES (6, 5) INTO Genre_from_film (Film_id, Genre_id) VALUES (6, 6)
	INTO Genre_from_film (Film_id, Genre_id) VALUES (5, 5) INTO Genre_from_film (Film_id, Genre_id) VALUES (5, 7)
	INTO Genre_from_film (Film_id, Genre_id) VALUES (5, 8) INTO Genre_from_film (Film_id, Genre_id) VALUES (2 ,9)
	INTO Genre_from_film (Film_id, Genre_id) VALUES (1, 7) INTO Genre_from_film (Film_id, Genre_id) VALUES (3, 7)
	INTO Genre_from_film (Film_id, Genre_id) VALUES (4, 7) INTO Genre_from_film (Film_id, Genre_id) VALUES (1, 8)
	INTO Genre_from_film (Film_id, Genre_id) VALUES (3, 8) INTO Genre_from_film (Film_id, Genre_id) VALUES (4, 8)
	INTO Genre_from_film (Film_id, Genre_id) VALUES (1, 9) INTO Genre_from_film (Film_id, Genre_id) VALUES (3, 9)
	INTO Genre_from_film (Film_id, Genre_id) VALUES (4, 9) INTO Genre_from_film (Film_id, Genre_id) VALUES (10, 9)
	INTO Genre_from_film (Film_id, Genre_id) VALUES (11, 9) INTO Genre_from_film (Film_id, Genre_id) VALUES (12, 9)
	INTO Genre_from_film (Film_id, Genre_id) VALUES (13, 9) INTO Genre_from_film (Film_id, Genre_id) VALUES (14, 9)
	INTO Genre_from_film (Film_id, Genre_id) VALUES (15, 5) INTO Genre_from_film (Film_id, Genre_id) VALUES (15, 7)
	INTO Genre_from_film (Film_id, Genre_id) VALUES (15, 8) INTO Genre_from_film (Film_id, Genre_id) VALUES (16, 5)
	INTO Genre_from_film (Film_id, Genre_id) VALUES (16, 7) INTO Genre_from_film (Film_id, Genre_id) VALUES (16, 8)
	INTO Genre_from_film (Film_id, Genre_id) VALUES (17, 5) INTO Genre_from_film (Film_id, Genre_id) VALUES (17, 7)
	INTO Genre_from_film (Film_id, Genre_id) VALUES (17, 8) INTO Genre_from_film (Film_id, Genre_id) VALUES (18, 5)
	INTO Genre_from_film (Film_id, Genre_id) VALUES (18, 7) INTO Genre_from_film (Film_id, Genre_id) VALUES (18, 8)
	INTO Genre_from_film (Film_id, Genre_id) VALUES (19, 5) INTO Genre_from_film (Film_id, Genre_id) VALUES (19, 7)
	INTO Genre_from_film (Film_id, Genre_id) VALUES (19, 8) INTO Genre_from_film (Film_id, Genre_id) VALUES (20, 5)
	INTO Genre_from_film (Film_id, Genre_id) VALUES (20, 7) INTO Genre_from_film (Film_id, Genre_id) VALUES (20, 8)
SELECT * FROM Dual;

INSERT  ALL 
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (1, 1) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (1, 2)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (1, 3) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (3, 4)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (3, 5) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (3, 6)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (3, 7) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (4, 1)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (4, 4) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (4, 8)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (4, 9) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (4, 10)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (4, 6) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (6, 7)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (6, 11) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (5, 12)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (5, 13) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (5, 14)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (5, 15) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (2, 16)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (2, 17) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (2, 18)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (2, 19) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (2, 20)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (10, 16) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (10, 17) 
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (10, 18) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (10, 19)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (10, 20) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (11, 16)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (11, 17) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (11, 18)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (11, 19) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (11, 20)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (12, 16) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (12, 17)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (12, 18) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (12, 19)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (12, 20) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (13, 16)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (13, 17) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (13, 18)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (13, 19) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (13, 20)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (14, 16) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (14, 17)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (14, 18) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (14, 19) 
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (14, 20) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (15, 12)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (15, 13) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (15, 14)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (15, 15) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (16, 12)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (16, 13) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (16, 14)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (16, 15) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (17, 12)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (17, 13) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (17, 14)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (17, 15) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (18, 12)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (18, 13) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (18, 14)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (18, 15) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (19, 12)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (19, 13) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (19, 14)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (19, 15) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (20, 12) 
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (20, 13) INTO Acthor_from_film (Film_id, Acthor_id) VALUES (20, 14)
	INTO Acthor_from_film (Film_id, Acthor_id) VALUES (20, 15)
SELECT * FROM Dual;

INSERT  ALL 
	INTO Director_from_film (Film_id, Director_id) VALUES (1, 1) INTO Director_from_film (Film_id, Director_id) VALUES (3, 2)
	INTO Director_from_film (Film_id, Director_id) VALUES (4, 3) INTO Director_from_film (Film_id, Director_id) VALUES (6, 4)
	INTO Director_from_film (Film_id, Director_id) VALUES (5, 5) INTO Director_from_film (Film_id, Director_id) VALUES (2, 6)
	INTO Director_from_film (Film_id, Director_id) VALUES (10, 6) INTO Director_from_film (Film_id, Director_id) VALUES (11, 6)
	INTO Director_from_film (Film_id, Director_id) VALUES (12, 6) INTO Director_from_film (Film_id, Director_id) VALUES (13, 6)
	INTO Director_from_film (Film_id, Director_id) VALUES (14, 6) INTO Director_from_film (Film_id, Director_id) VALUES (15, 5)
	INTO Director_from_film (Film_id, Director_id) VALUES (16, 5) INTO Director_from_film (Film_id, Director_id) VALUES (17, 5)
	INTO Director_from_film (Film_id, Director_id) VALUES (19, 5) INTO Director_from_film (Film_id, Director_id) VALUES (20, 5)
SELECT * FROM Dual;

INSERT  ALL 
	INTO Country_from_film (Film_id, Country_id) VALUES (1, 1) INTO Country_from_film (Film_id, Country_id) VALUES (1, 2)
	INTO Country_from_film (Film_id, Country_id) VALUES (3, 1) INTO Country_from_film (Film_id, Country_id) VALUES (4, 1)
	INTO Country_from_film (Film_id, Country_id) VALUES (6, 1) INTO Country_from_film (Film_id, Country_id) VALUES (5, 1)
	INTO Country_from_film (Film_id, Country_id) VALUES (2, 1) INTO Country_from_film (Film_id, Country_id) VALUES (10, 1)
	INTO Country_from_film (Film_id, Country_id) VALUES (11, 1) INTO Country_from_film (Film_id, Country_id) VALUES (12, 1)
	INTO Country_from_film (Film_id, Country_id) VALUES (13, 1) INTO Country_from_film (Film_id, Country_id) VALUES (14, 1)
	INTO Country_from_film (Film_id, Country_id) VALUES (15, 1) INTO Country_from_film (Film_id, Country_id) VALUES (16, 1)
	INTO Country_from_film (Film_id, Country_id) VALUES (17, 1) INTO Country_from_film (Film_id, Country_id) VALUES (18, 1)
	INTO Country_from_film (Film_id, Country_id) VALUES (19, 1) INTO Country_from_film (Film_id, Country_id) VALUES (20, 1)
SELECT * FROM Dual;

INSERT ALL
	INTO Adv_partner_history (Partner_id, Date_contract, Price_for_click) 
        VALUES (1, TO_DATE('01/01/21' , 'DD/MM/YYYY'), 0.08)
    INTO Adv_partner_history (Partner_id, Date_contract, Price_for_click)
        VALUES (2, TO_DATE('01/02/21' , 'DD/MM/YYYY'), 0.1)
    INTO Adv_partner_history (Partner_id, Date_contract, Price_for_click)
        VALUES (2, TO_DATE('01/05/21' , 'DD/MM/YYYY'), 0.5)
	INTO Adv_partner_history (Partner_id, Date_contract, Price_for_click) 
        VALUES (1, TO_DATE('01/08/21' , 'DD/MM/YYYY'), 0.4)
    INTO Adv_partner_history (Partner_id, Date_contract, Price_for_click)
        VALUES (2, TO_DATE('01/09/21' , 'DD/MM/YYYY'), 0.45)
    INTO Adv_partner_history (Partner_id, Date_contract, Price_for_click)
        VALUES (1, TO_DATE('01/10/21' , 'DD/MM/YYYY'), 0.53)
SELECT * FROM Dual;

INSERT ALL 
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (1, 2, TO_DATE('01/01/2021 16:00:04', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('01/03/2021 05:51:47', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (2, 4, TO_DATE('01/04/2021 08:24:24', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('01/05/2021 02:13:03', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (3, 4, TO_DATE('01/05/2021 22:40:53', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('01/06/2021 12:29:49', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (4, 2, TO_DATE('01/08/2021 03:43:47', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('01/08/2021 12:54:00', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (5, 3, TO_DATE('01/09/2021 22:52:42', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('01/11/2021 03:34:19', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (6, 4, TO_DATE('01/12/2021 06:24:44', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('01/12/2021 15:37:17', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (7, 4, TO_DATE('01/13/2021 22:45:37', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('01/15/2021 01:18:14', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (8, 4, TO_DATE('01/15/2021 18:53:31', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('01/16/2021 09:37:29', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (9, 3, TO_DATE('01/18/2021 03:26:49', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('01/18/2021 13:04:53', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (10, 1, TO_DATE('01/19/2021 15:38:09', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('01/20/2021 10:32:47', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (11, 2, TO_DATE('01/21/2021 11:52:48', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('01/22/2021 11:18:00', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (12, 1, TO_DATE('01/23/2021 18:22:43', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('01/25/2021 00:57:42', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (13, 1, TO_DATE('01/26/2021 00:29:08', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('01/27/2021 02:26:09', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (14, 3, TO_DATE('01/27/2021 20:51:25', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('01/29/2021 04:55:14', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (15, 1, TO_DATE('01/29/2021 14:04:18', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('01/30/2021 19:00:51', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (16, 3, TO_DATE('01/31/2021 10:36:46', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('02/01/2021 23:13:06', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (17, 2, TO_DATE('02/03/2021 08:52:50', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('02/03/2021 22:31:45', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (18, 2, TO_DATE('02/04/2021 16:06:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('02/05/2021 10:24:00', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (19, 1, TO_DATE('02/06/2021 21:28:26', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('02/07/2021 19:15:52', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (20, 4, TO_DATE('02/08/2021 11:46:29', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('02/09/2021 13:23:52', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (21, 2, TO_DATE('02/10/2021 23:50:08', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('02/11/2021 16:46:33', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (22, 4, TO_DATE('02/13/2021 03:19:47', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('02/14/2021 05:19:11', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (23, 2, TO_DATE('02/14/2021 15:19:30', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('02/15/2021 14:23:48', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (24, 4, TO_DATE('02/16/2021 19:47:35', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('02/18/2021 04:21:19', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (25, 4, TO_DATE('02/18/2021 19:11:17', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('02/19/2021 14:40:51', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (26, 1, TO_DATE('02/20/2021 21:04:14', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('02/21/2021 14:16:14', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (27, 4, TO_DATE('02/22/2021 13:01:59', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('02/23/2021 16:34:11', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (28, 3, TO_DATE('02/24/2021 12:21:59', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('02/26/2021 08:03:50', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (29, 4, TO_DATE('02/27/2021 05:41:37', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('02/28/2021 07:59:26', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (30, 4, TO_DATE('03/01/2021 03:22:21', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('03/02/2021 03:28:07', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (31, 3, TO_DATE('03/02/2021 14:30:24', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('03/03/2021 21:00:44', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (32, 4, TO_DATE('03/04/2021 14:35:57', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('03/06/2021 08:32:02', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (33, 4, TO_DATE('03/07/2021 02:12:54', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('03/08/2021 05:39:06', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (34, 3, TO_DATE('03/09/2021 07:00:30', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('03/10/2021 07:06:29', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (35, 3, TO_DATE('03/10/2021 13:18:43', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('03/11/2021 16:10:37', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (36, 4, TO_DATE('03/12/2021 18:09:04', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('03/14/2021 00:03:53', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (37, 3, TO_DATE('03/15/2021 02:36:24', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('03/15/2021 18:34:45', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (38, 1, TO_DATE('03/16/2021 20:21:07', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('03/18/2021 08:08:24', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (39, 1, TO_DATE('03/18/2021 09:15:04', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('03/20/2021 08:05:59', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (40, 3, TO_DATE('03/20/2021 16:04:50', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('03/21/2021 13:52:57', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (41, 3, TO_DATE('03/23/2021 02:38:19', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('03/23/2021 12:27:53', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (42, 1, TO_DATE('03/24/2021 09:42:40', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('03/25/2021 21:04:59', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (43, 3, TO_DATE('03/26/2021 19:49:40', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('03/28/2021 04:56:37', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (44, 4, TO_DATE('03/29/2021 07:18:51', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('03/29/2021 22:31:10', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (45, 4, TO_DATE('03/31/2021 02:38:34', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('03/31/2021 22:45:08', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (46, 4, TO_DATE('04/02/2021 05:33:59', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('04/02/2021 11:43:48', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (47, 1, TO_DATE('04/04/2021 08:26:28', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('04/05/2021 01:17:43', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (48, 1, TO_DATE('04/06/2021 03:36:49', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('04/07/2021 03:49:46', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (49, 2, TO_DATE('04/07/2021 14:23:35', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('04/08/2021 21:34:46', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (50, 3, TO_DATE('04/09/2021 18:36:39', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('04/10/2021 21:57:35', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (51, 4, TO_DATE('04/11/2021 23:16:29', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('04/12/2021 19:51:29', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (52, 1, TO_DATE('04/14/2021 08:30:15', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('04/14/2021 12:28:28', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (53, 2, TO_DATE('04/16/2021 04:51:02', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('04/16/2021 12:17:53', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (54, 3, TO_DATE('04/17/2021 15:56:27', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('04/18/2021 20:06:41', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (55, 3, TO_DATE('04/19/2021 14:28:51', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('04/20/2021 10:16:38', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (56, 4, TO_DATE('04/21/2021 16:13:37', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('04/22/2021 22:34:42', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (57, 3, TO_DATE('04/24/2021 05:11:34', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('04/24/2021 14:15:19', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (58, 3, TO_DATE('04/25/2021 20:54:40', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('04/26/2021 23:53:02', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (59, 2, TO_DATE('04/28/2021 00:05:11', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('04/28/2021 16:12:45', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (60, 4, TO_DATE('04/29/2021 18:16:41', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('04/30/2021 23:10:54', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (61, 3, TO_DATE('05/01/2021 23:33:48', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('05/02/2021 09:16:16', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (62, 4, TO_DATE('05/03/2021 15:10:22', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('05/04/2021 14:02:50', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (63, 4, TO_DATE('05/05/2021 11:22:44', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('05/06/2021 20:13:28', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (64, 2, TO_DATE('05/08/2021 05:45:29', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('05/09/2021 08:28:53', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (65, 3, TO_DATE('05/10/2021 07:09:24', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('05/11/2021 00:17:22', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (66, 3, TO_DATE('05/11/2021 15:19:41', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('05/12/2021 12:45:49', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (67, 4, TO_DATE('05/13/2021 23:28:11', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('05/15/2021 08:55:23', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (68, 4, TO_DATE('05/15/2021 22:36:51', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('05/16/2021 14:36:16', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (69, 3, TO_DATE('05/18/2021 06:37:48', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('05/19/2021 04:32:08', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (70, 3, TO_DATE('05/20/2021 02:11:03', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('05/20/2021 20:48:10', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (71, 1, TO_DATE('05/21/2021 16:44:43', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('05/22/2021 15:53:57', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (72, 3, TO_DATE('05/23/2021 21:50:58', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('05/25/2021 07:30:49', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (73, 4, TO_DATE('05/25/2021 10:08:15', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('05/27/2021 05:04:44', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (74, 3, TO_DATE('05/27/2021 13:37:48', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('05/29/2021 05:31:01', 'MM/DD/YYYY HH24:MI:SS'))
	INTO Sessions (Session_id, User_id, Log_in, Log_out)
		VALUES (75, 1, TO_DATE('05/29/2021 15:08:45', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('05/30/2021 22:23:29', 'MM/DD/YYYY HH24:MI:SS'))
SELECT * FROM Dual;

INSERT ALL 
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (1, 28, 19, 1, 4, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (2, 14, 11, 2, 4, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (3, 15, 11, 1, 6, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (4, 41, 8, 1, 6, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (5, 72, 14, 1, 6, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (6, 19, 13, 2, 4, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (7, 29, 19, 2, 6, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (8, 19, 17, 1, 5, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (9, 72, 16, 1, 4, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (10, 6, 4, 2, 5, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (11, 16, 4, 2, 4, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (12, 4, 16, 1, 4, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (13, 29, 12, 2, 5, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (14, 34, 11, 1, 4, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (15, 18, 17, 1, 5, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (16, 55, 11, 1, 4, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (17, 35, 8, 1, 4, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (18, 20, 19, 1, 4, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (19, 23, 10, 1, 6, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (20, 23, 19, 2, 5, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (21, 46, 19, 1, 4, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (22, 8, 1, 2, 5, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (23, 39, 6, 1, 4, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (24, 55, 14, 1, 6, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (25, 44, 13, 1, 5, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (26, 51, 12, 2, 4, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (27, 75, 20, 1, 6, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (28, 65, 14, 2, 5, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (29, 35, 10, 1, 4, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (30, 57, 5, 1, 5, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (31, 19, 17, 2, 4, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (32, 49, 9, 2, 5, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (33, 2, 19, 2, 5, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (34, 74, 11, 2, 4, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (35, 10, 2, 2, 5, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (36, 21, 19, 2, 6, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (37, 10, 9, 1, 6, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (38, 5, 8, 1, 5, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (39, 16, 7, 1, 4, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (40, 17, 4, 2, 5, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (41, 30, 18, 2, 5, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (42, 30, 10, 2, 6, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (43, 18, 10, 2, 5, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (44, 54, 18, 2, 6, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (45, 15, 6, 1, 6, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (46, 19, 14, 2, 6, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (47, 5, 16, 1, 5, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (48, 3, 14, 2, 5, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (49, 36, 7, 1, 5, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (50, 15, 11, 2, 4, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (51, 40, 10, 1, 4, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (52, 17, 11, 2, 4, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (53, 75, 2, 1, 4, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (54, 36, 12, 2, 6, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (55, 59, 4, 1, 5, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (56, 60, 14, 2, 6, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (57, 39, 9, 2, 6, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (58, 41, 15, 1, 4, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (59, 20, 19, 1, 5, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (60, 15, 6, 2, 6, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (61, 11, 13, 2, 6, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (62, 50, 19, 2, 6, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (63, 30, 7, 2, 5, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (64, 43, 8, 2, 6, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (65, 68, 17, 2, 4, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (66, 21, 15, 1, 4, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (67, 37, 2, 2, 5, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (68, 56, 7, 1, 5, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (69, 18, 10, 1, 6, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (70, 43, 18, 2, 6, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (71, 65, 18, 1, 6, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (72, 54, 14, 1, 5, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (73, 73, 9, 2, 4, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (74, 19, 8, 2, 4, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (75, 39, 15, 2, 6, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (76, 15, 15, 2, 5, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (77, 63, 6, 1, 5, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (78, 36, 1, 2, 4, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (79, 29, 8, 2, 5, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (80, 15, 20, 2, 5, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (81, 59, 6, 2, 4, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (82, 60, 7, 1, 5, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (83, 45, 1, 1, 6, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (84, 7, 4, 2, 4, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (85, 67, 13, 1, 4, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (86, 28, 14, 2, 5, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (87, 25, 17, 2, 4, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (88, 38, 15, 2, 5, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (89, 56, 6, 2, 4, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (90, 44, 12, 1, 5, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (91, 69, 18, 2, 6, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (92, 45, 2, 2, 5, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (93, 10, 12, 1, 6, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (94, 3, 6, 2, 5, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (95, 25, 19, 1, 5, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (96, 62, 6, 1, 5, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (97, 66, 11, 2, 6, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (98, 71, 10, 1, 6, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (99, 22, 2, 2, 6, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (100, 70, 9, 1, 5, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (101, 46, 5, 1, 4, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (102, 71, 19, 1, 4, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (103, 9, 8, 2, 4, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (104, 15, 11, 2, 6, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (105, 61, 11, 1, 5, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (106, 69, 5, 1, 4, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (107, 21, 13, 1, 4, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (108, 22, 3, 1, 6, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (109, 4, 17, 1, 4, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (110, 56, 4, 2, 4, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (111, 22, 13, 2, 5, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (112, 75, 15, 2, 5, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (113, 52, 1, 1, 5, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (114, 50, 11, 2, 6, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (115, 46, 8, 1, 6, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (116, 21, 1, 2, 5, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (117, 67, 3, 1, 6, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (118, 33, 10, 1, 6, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (119, 13, 3, 1, 6, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (120, 8, 5, 2, 5, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (121, 3, 20, 1, 4, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (122, 66, 19, 1, 5, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (123, 40, 20, 2, 6, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (124, 63, 17, 1, 4, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (125, 31, 5, 2, 5, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (126, 68, 14, 2, 4, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (127, 12, 4, 1, 6, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (128, 26, 17, 1, 5, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (129, 20, 19, 1, 4, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (130, 75, 8, 1, 6, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (131, 45, 17, 2, 4, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (132, 22, 15, 1, 6, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (133, 71, 8, 2, 6, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (134, 39, 2, 2, 5, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (135, 64, 8, 2, 4, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (136, 9, 19, 1, 4, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (137, 20, 15, 2, 5, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (138, 48, 7, 2, 5, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (139, 19, 4, 2, 5, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (140, 21, 20, 2, 5, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (141, 72, 19, 2, 4, 0)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (142, 13, 16, 2, 6, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (143, 65, 16, 1, 4, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (144, 10, 17, 1, 6, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (145, 20, 16, 1, 6, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (146, 14, 1, 2, 5, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (147, 9, 2, 2, 6, 1)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (148, 15, 9, 2, 4, 3)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (149, 58, 19, 2, 6, 2)
	INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES (150, 29, 5, 2, 5, 2)
SELECT * FROM Dual;