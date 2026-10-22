CREATE SCHEMA netflix;

CREATE TABLE netflix_cleaned LIKE netflix_titles;

INSERT INTO netflix_cleaned 
SELECT * FROM netflix_titles;

SELECT * FROM netflix_cleaned;

-- DATA CLEANING
-- DELETE DUPLICATES
-- STANDARDIZE DATA
-- NULL OR BLANK VALUES
-- REMOVE ADDED COLUMNS

-- ALLOCATE ROW NUMBERS TO UNIQUE INFO TO POINT OUT THE DUPLICATES

SELECT show_id, COUNT(*)
FROM netflix_cleaned
GROUP BY show_id
HAVING COUNT(*) > 1;

SELECT * FROM netflix_cleaned 
WHERE director IS NULL OR country IS NULL;

SELECT *,
ROW_NUMBER() OVER(PARTITION BY show_id, `type`, title, director, `cast`, country, date_added, release_year, rating, duration, listed_in, description) 
AS row_num
FROM netflix_titles;

SELECT * FROM netflix_cleaned;

-- DATA IS ALREADY FREE OF DUPLICATES
-- NEXT STEP I WANT TO STANDARDIZE DATA

SELECT show_id FROM netflix_cleaned;

UPDATE netflix_cleaned
SET show_id = REPLACE(show_id, 's', 'Season');

SELECT * FROM netflix_cleaned;

-- DATE

SELECT `date_added`, STR_TO_DATE(`date_added`, '%M %d, %Y') 
FROM netflix_cleaned;

ALTER TABLE netflix_cleaned ADD COLUMN date_added_clean DATE;

SELECT * FROM netflix_cleaned;

UPDATE netflix_cleaned
SET date_added_clean = STR_TO_DATE(date_added, '%M %d, %Y');

ALTER TABLE netflix_cleaned DROP COLUMN date_added;

ALTER TABLE netflix_cleaned RENAME COLUMN date_added_clean TO date_added;

ALTER TABLE netflix_cleaned MODIFY COLUMN date_added DATE AFTER country;

SELECT * FROM netflix_cleaned
ORDER BY `type`  ;

SELECT cast FROM netflix_cleaned;


SELECT *FROM netflix_cleaned;

UPDATE netflix_cleaned
SET `cast` = 'Not Specified'
WHERE `cast` IS NULL OR `cast` = '';

UPDATE netflix_cleaned
SET `director` = 'Not Specified'
WHERE `director` IS NULL OR `director` = '';

UPDATE netflix_cleaned
SET `country` = 'Not Specified'
WHERE `country` IS NULL OR `country` = '';

-- I THINK IM GOING TO SEARCH ONLINE AND FILL IN THE DATA WHEREVER POSSIBLE 

UPDATE netflix_cleaned
SET `cast` = 'Chad Knorr: Construction worker, Kevin Loreque: Buster Keaton, Ana Hoffman: Backup Singer, Vasthy Mompoint: Backup Singer, 
Mary Page Nance: Katie Jo, Nicole Tio: Backup Singer, Michael Fatica: Dick Johnson double, Ira Sachs: Himself'
WHERE show_id = 'Season1';

SELECT cast FROM netflix_cleaned;

SELECT * FROM netflix_cleaned;

UPDATE netflix_cleaned
SET show_id = REPLACE(show_id, 's', 'Season');


UPDATE netflix_cleaned
SET show_id = REPLACE(show_id, 'Season', 'S');

UPDATE netflix_cleaned
SET `director` = 'Nosipho Dumisa'
WHERE show_id = 'S2';

UPDATE netflix_cleaned
SET `director` = 'Justin Simien'
WHERE show_id = 'S16';

SELECT * FROM netflix_cleaned;

SELECT * FROM netflix_titles;

UPDATE netflix_cleaned
SET `director` = 'Not Specified'
WHERE show_id = 'S16';

UPDATE netflix_cleaned
SET `director` = 'Robert Cullen and José Luis Ucha'
WHERE show_id = 'S7';

UPDATE netflix_cleaned
SET `director` = 'Carlos Sedes, Jacobo Martínez'
WHERE show_id = 'S20';

SELECT * FROM netflix_cleaned;


UPDATE netflix_cleaned
SET `director` = 'Cédric Jimenez'
WHERE show_id = 'S37';

UPDATE netflix_cleaned
SET `director` = 'Cian O`Clery'
WHERE show_id = 'S26';

UPDATE netflix_cleaned
SET `director` = 'Hwang Dong-hyuk'
WHERE show_id = 'S34';

UPDATE netflix_cleaned
SET `director` = 'Rajiv Chilaka, Binayak Das'
WHERE show_id = 'S40';

SELECT * FROM netflix_cleaned;


UPDATE netflix_cleaned
SET `director` = 'Niyi Akinmolayan, Tope Oshin, Kenneth Gyang'
WHERE show_id = 'S50';

SELECT * FROM netflix_cleaned;

UPDATE netflix_cleaned
SET `director` = 'Simon Taylor'
WHERE show_id = 'S66';

UPDATE netflix_cleaned
SET `director` = 'Hanns-Bruno Kammertöns, Vanessa Nöcker, Michael Wech.'
WHERE show_id = 'S69';

UPDATE netflix_cleaned
SET `director` = 'Alexis Almström'
WHERE show_id = 'S94';

SELECT * FROM netflix_cleaned;

UPDATE netflix_cleaned
SET `director` = 'Justin Nichols, Dave Thomas'
WHERE show_id = 'S98';

UPDATE netflix_cleaned
SET `director` = 'Patrice Bérubé'
WHERE show_id = 'S99';

UPDATE netflix_cleaned
SET `director` = 'Julie Delpy, Mathieu Demy, David Petrarca'
WHERE show_id = 'S100';

-- DIRECTOR VALUES FILLED 

SELECT * FROM netflix_cleaned;

UPDATE netflix_cleaned
SET `cast` = 'Harley Himber, Jamie Evans, Magen Hall, Timanisha Taylor, Heather Tredick, Julie Raffray'
WHERE show_id = 'S4';


UPDATE netflix_cleaned
SET `cast` = 'Pino Maniaci, Silvana Saguto, Mauro Terranova, Bartolomeo Parrino, Patrizia Marchione, Letizia Maniaci, Lorenzo Caramma, Antonio Ingroia, Gioacchino De Luca, Amelia Luise, Giovanni Maniaci'
WHERE show_id = 'S11';

UPDATE netflix_cleaned
SET `cast` = 'N. Shashi Kumar, Roopa K.S., Gopala Nayak, V. Dhananjaya, B.N. Lohith, Latha Mahesh'
WHERE show_id = 'S15';

SELECT * FROM netflix_cleaned;


UPDATE netflix_cleaned
SET `cast` = 'Luna Wedler, Jannis Niewöhner, Milan Peschel, Edin Hasanović, Anna Fialová, Marlon Boess, Victor Boccard, Fleur Geffrier, Aziz Dyab, Mélanie Fouché, Elizaveta Maximová'
WHERE show_id = 'S13';

UPDATE netflix_cleaned
SET `cast` = 'Blanca Suárez, Iván Marcos, Óscar Casas, Adrián Lastra, Francesc Garrido, Stefan Weinert, Julia Möller, Alicia Chojnowski'
WHERE show_id = 'S20';

SELECT * FROM netflix_cleaned;

UPDATE netflix_cleaned
SET `cast` = 'Luis Ernesto Franco, Camila Sodi, Sergio Goyri, Samadhi Zendejas, Eduardo Yáñez, Sonya Smith, Alejandro Camacho, Azela Robinson, Uriel del Toro, Géraldine Bazán, Gabriela Roel, Marcus Ornellas'
WHERE show_id = 'S18';

UPDATE netflix_cleaned
SET `cast` = 'Engin Altan Düzyatan, Serdar Gökhan, Hülya Darcan, Kaan Taşaner, Esra Bilgiç, Osman Soykut, Serdar Deniz, Cengiz Coşkun, Reshad Strik, Hande Subaşı'
WHERE show_id = 'S22';

UPDATE netflix_cleaned
SET `cast` = 'Antti Pääkkönen, Heljä Heikkinen, Lynne Guaglione, Pasi Ruohonen, Rauno Ahonen'
WHERE show_id ='S38';

SELECT * FROM netflix_cleaned;

UPDATE netflix_cleaned 
SET `cast` = 'Adrian Titieni, Elena Purea, Judith State, Valeriu Andriuță, Tudor Smoleanu, Virgil Aioanei, Radu Botar, Petronela Grigorescu, Bogdan Nechifor, Cristian Bota'
WHERE show_id = 'S36';


UPDATE netflix_cleaned
SET `cast` = 'Gilles Lellouche, Karim Leklou, François Civil, Adèle Exarchopoulos, Kenza Fortas, Cyril Lecomte, Michaël Abiteboul, Idir Azougli, Vincent Darmuzey, Jean-Yves Berteloot'
WHERE show_id = 'S37';

SELECT * FROM netflix_cleaned;
-- s 58 - 64 review

SELECT * FROM netflix_cleaned WHERE title LIKE 'Naruto%';

UPDATE netflix_cleaned 
SET `title` = 'Naruto Shippûden the Movie: Bonds'
WHERE show_id = 'S58';

SELECT * FROM netflix_cleaned;

UPDATE netflix_cleaned 
SET `title` = 'Naruto Shippûden the Movie: Blood Prison'
WHERE show_id = 'S57';

UPDATE netflix_cleaned
SET title = 'Naruto Shippûden the Movie: The Will of Fire'
WHERE show_id = 'S59';

UPDATE netflix_cleaned 
SET `title` = 'Naruto Shippûden: the Movie'
WHERE show_id = 'S60';

UPDATE netflix_cleaned 
SET `title` = 'Naruto Shippûden the Movie: The Lost Tower'
WHERE show_id = 'S61';

UPDATE netflix_cleaned
SET `cast` = 'Itatí Cantoral'
WHERE show_id ='S71';

SELECT * FROM netflix_cleaned;

UPDATE netflix_cleaned
SET `title` = 'Pokémon Master Journeys: The Series'
WHERE show_id ='S86';

SELECT * FROM netflix_cleaned;

SELECT listed_in FROM netflix_cleaned;

SELECT description FROM netflix_cleaned;

UPDATE netflix_cleaned
SET `cast` = 'Elsa Öhrn, Mustapha Aarab, Jonay Pineda Skallak, Magnus Krepper, Loreen, Albin Grenholm, Simon Mezher, Elsa Bergström Terent, Josef Kadim, Yohannes Frezgi'
WHERE show_id = 'S94';	

UPDATE netflix_cleaned
SET `description` = 'In a city of coaching centers known to train India’s finest collegiate minds, an earnest but unexceptional student and his friends navigate campus life.'
WHERE show_id = 'S5';

UPDATE netflix_cleaned
SET `description` = 'Equestria''s divided. But a bright-eyed hero believes Earth Ponies, Pegasi and Unicorns should be pals — and, hoof to heart, she''s determined to prove it.'
WHERE show_id = 'S7';

SELECT * FROM netflix_cleaned;

UPDATE netflix_cleaned
SET `description` = 'A woman adjusting to life after a loss contends with a feisty bird that’s taken over her garden — and a husband who’s struggling to find a way forward.'
WHERE show_id = 'S10';


UPDATE netflix_cleaned
SET `description` = 'Sicily boasts a bold "Anti-Mafia" coalition. But what happens when those trying to bring down organized crime are accused of being criminals themselves?'
WHERE show_id = 'S11';

UPDATE netflix_cleaned
SET `description` = 'When the clever but socially awkward Tetê joins a new school, she\'ll do anything to fit in. But the queen bee among her classmates has other ideas.'
WHERE show_id = 'S14';

UPDATE netflix_cleaned
SET `description` = 'Students of color navigate the daily slights and slippery politics of life at an Ivy League college that\'s not nearly as "post-racial" as it thinks.'
WHERE show_id = 'S16';


SELECT * FROM netflix_cleaned;

UPDATE netflix_cleaned
SET `description` = 'From arcade games to sled days and hiccup cures, Cory Carson’s curious little sister Chrissy speeds off on her own for fun and adventure all over town!'
WHERE show_id = 'S24';




UPDATE netflix_cleaned
SET `description` = 'After a deadly home invasion at a couple’s new dream house, the traumatized wife searches for answers — and learns the real danger is just beginning.'
WHERE show_id = 'S19';


UPDATE netflix_cleaned
SET `description` = 'A family’s idyllic suburban life shatters when an alien force invades their home, and they struggle to convince others of the deadly threat.'
WHERE show_id = 'S29';

SELECT * FROM netflix_cleaned;

UPDATE netflix_cleaned
SET `description` = 'Chicago Party Aunt Diane is an idolized troublemaker with a talent for avoiding adulthood and a soft spot for her soul-searching nephew.'
WHERE show_id = 'S32';

UPDATE netflix_cleaned
SET `description` = 'A tangled love triangle ensues when a man falls for a woman studying to become a nun — and she falls for the friend he enlists to help him pursue her.'
WHERE show_id = 'S27';

SELECT * FROM netflix_cleaned;

UPDATE netflix_cleaned
SET `description` = 'When his son goes missing during a snowy hike in the mountains, a retired intelligence officer will stop at nothing — and risk everything — to find him.'
WHERE show_id = 'S36';

-- any remaining true nulls/blanks anywhere?
SELECT * FROM netflix_cleaned 
WHERE `cast` IS NULL OR `cast` = '' 
   OR director IS NULL OR director = ''
   OR country IS NULL OR country = '';

-- did date parsing leave any NULLs (failed conversions)?
SELECT * FROM netflix_cleaned WHERE date_added IS NULL;

-- total row count still matches original?
SELECT COUNT(*) FROM netflix_cleaned;
SELECT COUNT(*) FROM netflix_titles;

-- ==========================================
-- EXPLORATORY DATA ANALYSIS
-- ==========================================

-- Movies vs TV Shows

SELECT type,
       COUNT(*) AS total_titles
FROM netflix_cleaned
GROUP BY type;



-- Top 10 countries

SELECT country,
       COUNT(*) AS total_titles
FROM netflix_cleaned
GROUP BY country
ORDER BY total_titles DESC;

-- Most common ratings

SELECT rating,
       COUNT(*) AS total_titles
FROM netflix_cleaned
GROUP BY rating
ORDER BY total_titles DESC;


-- Titles added each year

SELECT YEAR(date_added) AS added_year,
       COUNT(*) AS total_titles
FROM netflix_cleaned
GROUP BY YEAR(date_added)
ORDER BY added_year;


-- Movies vs TV Shows by percentage

SELECT type,
       ROUND(COUNT(*) * 100.0 /
             (SELECT COUNT(*) FROM netflix_cleaned),2)
       AS percentage
FROM netflix_cleaned
GROUP BY type;

























