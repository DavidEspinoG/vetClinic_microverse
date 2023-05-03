/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Agumon', '2020-02-03', 10.23, true, 0),
('Gabumon', '2018-11-15', 8, true, 2),
('Pikachu', '2021-01-07', 15.04, false, 1),
('Devimon', '2017-05-12', 11, true, 5);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Charmander', '2020-02-08', -11, false, 0),
('Plantmon', '2021-01-15', -5.7, true, 2),
('Squirtle', '1993-04-02', -12.13, false, 3),
('Angemon', '2005-06-12', -45, true, 1),
('Boarmon', '2005-06-07', 20.4, true, 7),
('Blossom', '1998-08-13', 17, true, 3),
('Ditto', '2022-05-14', 22, true, 4);

-- ++++++++++++++++

INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34), 
('Jennifer Orwell', 19), 
('Bob', 45), 
('Melody Pond', 77), 
('Dean Winchester', 14), 
('Jodie Whittaker', 38); 

INSERT INTO species (name)
VALUES ('Pokemon'),
('Digimon');


-- +++++++++++++++++

UPDATE animals
SET species_id = 2
WHERE name LIKE '%___mon';

UPDATE animals
SET species_id = 1
WHERE species_id IS NULL;

-- Add owners

UPDATE animals
SET owner_id = 1
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = 2
WHERE name IN('Pikachu', 'Gabumon');

UPDATE animals
SET owner_id = 3
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = 4
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = 5
WHERE name IN ('Angemon', 'Boarmon');

-- Vets 

INSERT INTO vets (name, age, date_of_gratuation)
VALUES ('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-01-08');

-- specialization 

INSERT INTO specializations (vet_id, species_id)
VALUES (4, 1),
(6, 2),
(6, 1),
(7, 2);

-- visits

INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES (4, 7, '2020-05-24'),
(6, 7, '2020-07-22'),
(7, 8, '2021-02-02'),
(5, 9, '2020-01-05'),
(5, 9, '2020-03-08'),
(5, 9, '2020-05-14'),
(6, 10, '2021-05-04'),
(7, 12, '2021-02-24'),
(5, 13, '2019-12-21'),
(4, 13, '2020-08-10'),
(5, 13, '2021-04-07'),
(6, 14, '2019-09-29'),
(7, 15, '2020-10-03'),
(7, 15, '2020-11-04'),
(5, 16, '2019-06-24'),
(5, 16, '2019-05-15'),
(5, 16, '2020-02-27'),
(5, 16, '2020-08-03'),
(6, 17, '2020-05-24'),
(4, 17, '2021-01-11');

