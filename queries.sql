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

-- Thursday 

-- Who was the last animal seen by William Tatcher?

SELECT animals.name AS animal_name, vets.name AS vet, date_of_visit
FROM visits
JOIN vets 
ON visits.vet_id = vets.id
JOIN animals 
ON visits.animal_id = animals.id
WHERE vets.name = 'William Tatcher'
ORDER BY date_of_visit DESC
LIMIT 1; 

-- How many different animals did Stephanie Mendez see?

SELECT animal_id
FROM visits
WHERE vet_id = 6;

-- List all vets and their specialties, including vets with no specialties.

SELECT vets.id, vets.name, species.name
FROM vets
LEFT JOIN specializations
ON specializations.vet_id = vets.id
LEFT JOIN species
ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT animals.name AS animal, vets.name AS doctor, visits.date_of_visit
FROM visits
JOIN vets
ON visits.vet_id = vets.id
JOIN animals
ON visits.animal_id = animals.id
WHERE vets.name = 'Stephanie Mendez' 
AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?

SELECT  animals.name, COUNT(animal_id) as total_visits
FROM visits
JOIN animals
ON visits.animal_id = animals.id
GROUP BY animal_id, animals.name
ORDER BY total_visits DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?

SELECT animals.name AS animal, vets.name AS doctor, visits.date_of_visit
FROM visits
JOIN animals
ON visits.animal_id = animals.id
JOIN vets
ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_of_visit
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.

SELECT animals.name, visits.date_of_visit, vets.name AS doctor 
FROM visits
JOIN animals
ON visits.animal_id = animals.id
JOIN vets
ON visits.vet_id = vets.id
ORDER BY date_of_visit DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?

SELECT COUNT(*) 
FROM (
  SELECT specializations.species_id AS vet_specialization, animals.species_id
  FROM visits
  JOIN specializations
  ON visits.vet_id = specializations.vet_id
  JOIN animals
  ON visits.animal_id = animals.id
) AS comparative
WHERE vet_specialization <> species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT  species.name, COUNT(animals.id) 
FROM visits
JOIN animals
ON visits.animal_id = animals.id 
JOIN species
ON animals.species_id = species.id
WHERE visits.vet_id = 5
GROUP BY species.name;