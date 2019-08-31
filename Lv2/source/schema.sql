CREATE TABLE IF NOT EXISTS location(
    country varchar(2) NOT NULL,
    city varchar(52) NOT NULL,
    active ENUM('True', 'False') NOT NULL,
    PRIMARY KEY (country, city)
) ENGINE=innodb DEFAULT CHARSET=utf8 DEFAULT COLLATE utf8_unicode_ci;

INSERT INTO location (country, city, active) values ('AF', 'Kabul', 'False');
INSERT INTO location (country, city, active) values ('ZA', 'Pretoria', 'False');
INSERT INTO location (country, city, active) values ('AL', 'Tirana', 'False');
INSERT INTO location (country, city, active) values ('DE', 'Berlin', 'False');
INSERT INTO location (country, city, active) values ('AD', 'Andorra', 'False');
INSERT INTO location (country, city, active) values ('AO', 'Luanda', 'False');
INSERT INTO location (country, city, active) values ('AG', 'San Juan', 'False');
INSERT INTO location (country, city, active) values ('SA', 'Riad', 'False');
INSERT INTO location (country, city, active) values ('DZ', 'Argel', 'False');
INSERT INTO location (country, city, active) values ('AR', 'Buenos Aires', 'False');
INSERT INTO location (country, city, active) values ('AM', 'Ereva', 'False');
INSERT INTO location (country, city, active) values ('AU', 'Canberra', 'False');
INSERT INTO location (country, city, active) values ('AT', 'Viena', 'False');
INSERT INTO location (country, city, active) values ('AZ', 'Baku', 'False');
INSERT INTO location (country, city, active) values ('BS', 'Nassau', 'False');
INSERT INTO location (country, city, active) values ('BD', 'Dhaka', 'False');
INSERT INTO location (country, city, active) values ('BB', 'Bridgetown', 'False');
INSERT INTO location (country, city, active) values ('BH', 'Manama', 'False');
INSERT INTO location (country, city, active) values ('BE', 'Bruselas', 'False');
INSERT INTO location (country, city, active) values ('BZ', 'Belmopa', 'False');
INSERT INTO location (country, city, active) values ('BJ', 'Porto Novo', 'False');
INSERT INTO location (country, city, active) values ('BY', 'Minsque', 'False');
INSERT INTO location (country, city, active) values ('BO', 'Sucre', 'False');
INSERT INTO location (country, city, active) values ('BA', 'Sarajevo', 'False');
INSERT INTO location (country, city, active) values ('BW', 'Gaborone', 'False');
INSERT INTO location (country, city, active) values ('BR', 'Brasilia', 'False');
INSERT INTO location (country, city, active) values ('BN', 'Bandar Seri Begaua', 'False');
INSERT INTO location (country, city, active) values ('BG', 'Sofia', 'False');
INSERT INTO location (country, city, active) values ('BF', 'Uagadugu', 'False');
INSERT INTO location (country, city, active) values ('BI', 'Bujumbura', 'False');
INSERT INTO location (country, city, active) values ('BT', 'Timbu', 'False');
INSERT INTO location (country, city, active) values ('CV', 'Playa', 'False');
INSERT INTO location (country, city, active) values ('CM', 'Yaunde', 'False');
INSERT INTO location (country, city, active) values ('KH', 'Pene Pene', 'False');
INSERT INTO location (country, city, active) values ('CA', 'Ottawa', 'False');
INSERT INTO location (country, city, active) values ('QA', 'Donar', 'False');
INSERT INTO location (country, city, active) values ('KZ', 'Astana', 'False');
INSERT INTO location (country, city, active) values ('TD', 'Jamena', 'False');
INSERT INTO location (country, city, active) values ('CL', 'Santiago', 'False');
INSERT INTO location (country, city, active) values ('CN', 'Beijing', 'False');
INSERT INTO location (country, city, active) values ('CY', 'Nicosia', 'False');
INSERT INTO location (country, city, active) values ('CO', 'Bogota', 'False');
INSERT INTO location (country, city, active) values ('KM', 'Moroni', 'False');
INSERT INTO location (country, city, active) values ('CG', 'Brazavile', 'False');
INSERT INTO location (country, city, active) values ('KP', 'Pionguiangue', 'False');
INSERT INTO location (country, city, active) values ('KR', 'Seul', 'False');
INSERT INTO location (country, city, active) values ('CI', 'Yamussucro', 'False');
INSERT INTO location (country, city, active) values ('CR', 'San Jose', 'False');
INSERT INTO location (country, city, active) values ('HR', 'Zagreb', 'False');
INSERT INTO location (country, city, active) values ('KW', 'Ciudad De Cuaite', 'False');
INSERT INTO location (country, city, active) values ('CU', 'La Habana', 'False');
INSERT INTO location (country, city, active) values ('DK', 'Copenhague', 'False');
INSERT INTO location (country, city, active) values ('DM', 'Roseau', 'False');
INSERT INTO location (country, city, active) values ('EG', 'El Cairo', 'False');
INSERT INTO location (country, city, active) values ('AE', 'Abu Dhabi', 'False');
INSERT INTO location (country, city, active) values ('EC', 'Quito', 'False');
INSERT INTO location (country, city, active) values ('ER', 'Asmara', 'False');
INSERT INTO location (country, city, active) values ('SK', 'Bratislava', 'False');
INSERT INTO location (country, city, active) values ('SI', 'Liubliana', 'False');
INSERT INTO location (country, city, active) values ('ES', 'Madrid', 'True');
INSERT INTO location (country, city, active) values ('ES', 'Barcelona', 'True');
INSERT INTO location (country, city, active) values ('ES', 'Valencia', 'True');
INSERT INTO location (country, city, active) values ('ES', 'Leon', 'True');
INSERT INTO location (country, city, active) values ('ES', 'Alcala de Henares', 'True');
INSERT INTO location (country, city, active) values ('PS', 'Jerusalen Este', 'False');
INSERT INTO location (country, city, active) values ('US', 'Washington Dc', 'False');
INSERT INTO location (country, city, active) values ('EE', 'Talim', 'False');
INSERT INTO location (country, city, active) values ('ET', 'Addis Ababa', 'False');
INSERT INTO location (country, city, active) values ('FJ', 'Suva', 'False');
INSERT INTO location (country, city, active) values ('PH', 'Manila', 'False');
INSERT INTO location (country, city, active) values ('FI', 'Helsinki', 'False');
INSERT INTO location (country, city, active) values ('FR', 'Paris', 'False');
INSERT INTO location (country, city, active) values ('GA', 'Libreville', 'False');
INSERT INTO location (country, city, active) values ('GM', 'Banjul', 'False');
INSERT INTO location (country, city, active) values ('GH', 'Accra', 'False');
INSERT INTO location (country, city, active) values ('GE', 'Tebilissi', 'False');
INSERT INTO location (country, city, active) values ('GD', 'San Jorge', 'False');
INSERT INTO location (country, city, active) values ('GR', 'Atenas', 'False');
INSERT INTO location (country, city, active) values ('GT', 'Ciudad De Guatemala', 'False');
INSERT INTO location (country, city, active) values ('GY', 'Georgetown', 'False');
INSERT INTO location (country, city, active) values ('GN', 'Conakry', 'False');
INSERT INTO location (country, city, active) values ('GQ', 'Malabo', 'False');
INSERT INTO location (country, city, active) values ('GW', 'Bissau', 'False');
INSERT INTO location (country, city, active) values ('HT', 'Porto Principe', 'False');
INSERT INTO location (country, city, active) values ('HN', 'Tegucigalpa', 'False');
INSERT INTO location (country, city, active) values ('HU', 'Budapest', 'False');
INSERT INTO location (country, city, active) values ('YE', 'Sana', 'False');
INSERT INTO location (country, city, active) values ('MH', 'Majuro', 'False');
INSERT INTO location (country, city, active) values ('IN', 'Nueva Delhi', 'False');
INSERT INTO location (country, city, active) values ('ID', 'Jakarta', 'False');
INSERT INTO location (country, city, active) values ('IR', 'Teerao', 'False');
INSERT INTO location (country, city, active) values ('IQ', 'Bagdad', 'False');
INSERT INTO location (country, city, active) values ('IE', 'Dublin', 'False');
INSERT INTO location (country, city, active) values ('IS', 'Reykjavik', 'False');
INSERT INTO location (country, city, active) values ('IL', 'Jerusalen', 'False');
INSERT INTO location (country, city, active) values ('IT', 'Roma', 'False');
INSERT INTO location (country, city, active) values ('JM', 'Kingston', 'False');
INSERT INTO location (country, city, active) values ('JP', 'Toyo', 'False');
INSERT INTO location (country, city, active) values ('DJ', 'Djibouti', 'False');
INSERT INTO location (country, city, active) values ('JO', 'Ama', 'False');
INSERT INTO location (country, city, active) values ('LA', 'Vientiane', 'False');
INSERT INTO location (country, city, active) values ('LS', 'Maseru', 'False');
INSERT INTO location (country, city, active) values ('LV', 'Riga', 'False');
INSERT INTO location (country, city, active) values ('LB', 'Beirut', 'False');
INSERT INTO location (country, city, active) values ('LR', 'Monrovia', 'False');
INSERT INTO location (country, city, active) values ('LY', 'Tripoli', 'False');
INSERT INTO location (country, city, active) values ('LI', 'Vaduz', 'False');
INSERT INTO location (country, city, active) values ('LT', 'Vilna', 'False');
INSERT INTO location (country, city, active) values ('LU', 'Luxemburgo', 'False');
INSERT INTO location (country, city, active) values ('MK', 'Scopy', 'False');
INSERT INTO location (country, city, active) values ('MG', 'Antananarivo', 'False');
INSERT INTO location (country, city, active) values ('MY', 'Kuala Lumpur', 'False');
INSERT INTO location (country, city, active) values ('MW', 'Lilong', 'False');
INSERT INTO location (country, city, active) values ('MV', 'Hombre', 'False');
INSERT INTO location (country, city, active) values ('ML', 'Bamako', 'False');
INSERT INTO location (country, city, active) values ('MT', 'Valletta', 'False');
INSERT INTO location (country, city, active) values ('MA', 'Descuento', 'False');
INSERT INTO location (country, city, active) values ('MU', 'Porto Luis', 'False');
INSERT INTO location (country, city, active) values ('MR', 'Puta', 'False');
INSERT INTO location (country, city, active) values ('MX', 'Ciudad De Mexico', 'False');
INSERT INTO location (country, city, active) values ('MM', 'Nepiedo', 'False');
INSERT INTO location (country, city, active) values ('FM', 'Paliquir', 'False');
INSERT INTO location (country, city, active) values ('MZ', 'Maputo', 'False');
INSERT INTO location (country, city, active) values ('MD', 'Quixinau', 'False');
INSERT INTO location (country, city, active) values ('MC', 'Monaco', 'False');
INSERT INTO location (country, city, active) values ('MN', 'Ula Bator', 'False');
INSERT INTO location (country, city, active) values ('ME', 'Podgoritsa', 'False');
INSERT INTO location (country, city, active) values ('NA', 'Vinduk', 'False');
INSERT INTO location (country, city, active) values ('NR', 'Iria', 'False');
INSERT INTO location (country, city, active) values ('NP', 'Katmandu', 'False');
INSERT INTO location (country, city, active) values ('NI', 'Managua', 'True');
INSERT INTO location (country, city, active) values ('NI', 'Leon', 'True');
INSERT INTO location (country, city, active) values ('NI', 'Rivas', 'True');
INSERT INTO location (country, city, active) values ('NI', 'Jinotega', 'True');
INSERT INTO location (country, city, active) values ('NI', 'Corn Island', 'True');
INSERT INTO location (country, city, active) values ('NI', 'Nueva Guinea', 'True');
INSERT INTO location (country, city, active) values ('NE', 'Niamey', 'False');
INSERT INTO location (country, city, active) values ('NG', 'Abuja', 'False');
INSERT INTO location (country, city, active) values ('NO', 'Oslo', 'False');
INSERT INTO location (country, city, active) values ('NZ', 'Wellington', 'False');
INSERT INTO location (country, city, active) values ('OM', 'Muscat', 'False');
INSERT INTO location (country, city, active) values ('NL', 'Amsterdam', 'False');
INSERT INTO location (country, city, active) values ('PW', 'Ngerulmud', 'False');
INSERT INTO location (country, city, active) values ('PA', 'Ciudad De Panama', 'False');
INSERT INTO location (country, city, active) values ('PG', 'Puerto De Moresby', 'False');
INSERT INTO location (country, city, active) values ('PK', 'Islamabad', 'False');
INSERT INTO location (country, city, active) values ('PY', 'Asuncion', 'False');
INSERT INTO location (country, city, active) values ('PE', 'Lima', 'False');
INSERT INTO location (country, city, active) values ('PL', 'Varsovia', 'False');
INSERT INTO location (country, city, active) values ('PT', 'Lisboa', 'False');
INSERT INTO location (country, city, active) values ('KE', 'Nairobi', 'False');
INSERT INTO location (country, city, active) values ('KG', 'Bisque', 'False');
INSERT INTO location (country, city, active) values ('KI', 'Taraua Meridional', 'False');
INSERT INTO location (country, city, active) values ('GB', 'Londres', 'False');
INSERT INTO location (country, city, active) values ('CF', 'Bangui', 'False');
INSERT INTO location (country, city, active) values ('CZ', 'Praga', 'False');
INSERT INTO location (country, city, active) values ('CD', 'Kinshasa', 'False');
INSERT INTO location (country, city, active) values ('DO', 'San Domingos', 'False');
INSERT INTO location (country, city, active) values ('RO', 'Bucarest', 'False');
INSERT INTO location (country, city, active) values ('RW', 'Kigali', 'False');
INSERT INTO location (country, city, active) values ('RU', 'Moscu', 'False');
INSERT INTO location (country, city, active) values ('SB', 'Honiara', 'False');
INSERT INTO location (country, city, active) values ('SV', 'San Salvador', 'False');
INSERT INTO location (country, city, active) values ('WS', 'Apia', 'False');
INSERT INTO location (country, city, active) values ('LC', 'Castries', 'False');
INSERT INTO location (country, city, active) values ('KN', 'Basseterre', 'False');
INSERT INTO location (country, city, active) values ('SM', 'San Marino', 'False');
INSERT INTO location (country, city, active) values ('ST', 'San Tome', 'False');
INSERT INTO location (country, city, active) values ('VC', 'Kingstown', 'False');
INSERT INTO location (country, city, active) values ('SC', 'Victoria', 'False');
INSERT INTO location (country, city, active) values ('SN', 'Dakar', 'False');
INSERT INTO location (country, city, active) values ('SL', 'Freetown', 'False');
INSERT INTO location (country, city, active) values ('RS', 'Belgrado', 'False');
INSERT INTO location (country, city, active) values ('SG', 'Singapur', 'False');
INSERT INTO location (country, city, active) values ('SY', 'Albaricoque', 'False');
INSERT INTO location (country, city, active) values ('SO', 'Mogadiscio', 'False');
INSERT INTO location (country, city, active) values ('LK', 'Sri Jaiavardenapura-Cota', 'False');
INSERT INTO location (country, city, active) values ('SZ', 'Lobamba', 'False');
INSERT INTO location (country, city, active) values ('SD', 'Caricatura', 'False');
INSERT INTO location (country, city, active) values ('SS', 'Mane', 'False');
INSERT INTO location (country, city, active) values ('SE', 'Estocolmo', 'False');
INSERT INTO location (country, city, active) values ('CH', 'Berna', 'False');
INSERT INTO location (country, city, active) values ('SR', 'Paramaribo', 'False');
INSERT INTO location (country, city, active) values ('TH', 'Bangkok', 'False');
INSERT INTO location (country, city, active) values ('TW', 'Taipe', 'False');
INSERT INTO location (country, city, active) values ('TJ', 'Ducha', 'False');
INSERT INTO location (country, city, active) values ('TZ', 'Dodoma', 'False');
INSERT INTO location (country, city, active) values ('TL', 'Dili', 'False');
INSERT INTO location (country, city, active) values ('TG', 'Lome', 'False');
INSERT INTO location (country, city, active) values ('TO', 'Nucualofa', 'False');
INSERT INTO location (country, city, active) values ('TT', 'Puerto De España', 'False');
INSERT INTO location (country, city, active) values ('TN', 'Melodias', 'False');
INSERT INTO location (country, city, active) values ('TM', 'Ashgabat', 'False');
INSERT INTO location (country, city, active) values ('TR', 'Ankara', 'False');
INSERT INTO location (country, city, active) values ('TV', 'Funafuti', 'False');
INSERT INTO location (country, city, active) values ('UA', 'Quieve', 'False');
INSERT INTO location (country, city, active) values ('UG', 'Kampala', 'False');
INSERT INTO location (country, city, active) values ('UY', 'Montevideo', 'False');
INSERT INTO location (country, city, active) values ('UZ', 'Tasquente', 'False');
INSERT INTO location (country, city, active) values ('VU', 'Porto Vila', 'False');
INSERT INTO location (country, city, active) values ('VA', 'Vaticano', 'False');
INSERT INTO location (country, city, active) values ('VE', 'Caracas', 'False');
INSERT INTO location (country, city, active) values ('VN', 'Hanoi', 'False');
INSERT INTO location (country, city, active) values ('ZM', 'Lusaka', 'False');
INSERT INTO location (country, city, active) values ('ZW', 'Harare', 'False');