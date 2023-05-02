/*Queries that provide answers to the questions from all projects.*/


SELECT * FROM animals
WHERE name LIKE '%___mon';

SELECT * FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';

SELECT * FROM animals
WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals
WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts FROM animals
WHERE weight_kg > 10.5;

SELECT * FROM animals
WHERE neutered = true;

SELECT * FROM animals
WHERE name NOT LIKE 'Gabumon';

SELECT * FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;

UPDATE animals
SET species = 'unspecified';

ROLLBACK;

BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%___mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

COMMIT;

BEGIN; 

DELETE FROM animals; 

ROLLBACK;

-- +++++++++++++++

BEGIN;

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT sp1;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK TO sp1;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

COMMIT;

-- +++++++++++++++

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT AVG(escape_attempts), neutered FROM animals
GROUP BY neutered;

SELECT MIN(weight_kg), MAX(weight_kg), species FROM animals
GROUP BY species;

SELECT AVG(escape_attempts), species FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01'
GROUP BY species;

-- Queries with JOIN

-- What animals belong to Melody Pond?
SELECT name, full_name 
FROM animals
INNER JOIN owners 
ON animals.owner_id = owners.id
WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).

SELECT animals.name, species.name
FROM animals 
INNER JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, 
-- remember to include those that don't own any animal.

SELECT owners.full_name, animals.name
FROM owners
LEFT JOIN animals
ON owners.id = animals.owner_id;

-- How many animals are there per species?

SELECT COUNT(*), species.name 
FROM animals
JOIN species
ON animals.species_id = species.id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.

SELECT animals.name, owners.full_name
FROM animals
JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that 
-- haven't tried to escape.

SELECT animals.name, animals.escape_attempts, owners.full_name
FROM animals
JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?

SELECT COUNT(*) AS owned_animals, owners.full_name
FROM animals
JOIN owners
ON animals.owner_id = owners.id
GROUP BY owners.full_name;