SELECT * FROM animals
WHERE name LIKE '%mon';

SELECT name FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animals
WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals
WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts FROM animals
WHERE weight_kg > 10.5;

SELECT * FROM animals
WHERE neutered = true;

SELECT * FROM animals
WHERE name != 'Gabumon';

SELECT * FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals
SET species = 'unspecified';
ROLLBACK;
BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT delete_by_birth_of_date;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO delete_by_birth_of_date;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;


SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) as average_weight
FROM animals;

SELECT neutered, COUNT(*) as escape_count
FROM animals
WHERE escape_attempts > 0
GROUP BY neutered
ORDER BY escape_count DESC;

SELECT species,
MIN(weight_kg) as min_weight,
MAx(weight_kg) as max_weight
FROM animals
GROUP BY species;

SELECT species,
AVG(escape_attempts) as average_escape_attempts
FROM animals
WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000
GROUP BY species;

--What animals belong to Melody Pond?
SELECT a.*
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT a.*
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

-- List all owners and their animals, including those that don't own any animals.
SELECT O.full_name, a.name
FROM owners O
-- How many animals are there per species?
SELECT s.name, COUNT(*) as num_animals
FROM animals a
JOIN species s ON a.species_id = s.id
GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT a.*
FROM animals a
JOIN owners o ON a.owner_id = o.id
JOIN species s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.*
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

-- Who owns the most animals?
SELECT o.full_name, COUNT(a.id) as num_animals
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY num_animals DESC
LIMIT 1;
