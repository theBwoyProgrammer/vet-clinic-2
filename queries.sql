/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';
SELECT name, date_of_birth from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name, neutered, escape_attempts from animals WHERE neutered= true AND escape_attempts < 3;
SELECT date_of_birth from animals WHERE name= 'Agumon' OR name= 'Pikachu';
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered = true;
SELECT * from animals WHERE NOT name = 'Gabumon';
SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
SELECT * FROM animals;
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

-- delete all records in the animals table, then roll back the transaction.
-- delete
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
-- ROLLBACK
ROLLBACK;
SELECT * FROM animals;

-- Delete all animals born after Jan 1st, 2022
BEGIN;
DELETE FROM animals WHERE date_of_birth > '01-01-2022';
SELECT * FROM animals;

-- Create a save point for the transaction
BEGIN;
SAVEPOINT savePointOne;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM owners;

-- Rolling back to the SAVEPOINT
ROLLBACK To savePointOne;
SELECT * FROM animals;

-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT species,  MAX(escape_attempts) FROM animals WHERE neutered = true OR false GROUP BY species;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990 01-01' AND '2000-12-31' GROUP BY species;

-- Dropping a column
ALTER TABLE animals
  DROP COLUMN species;

  -- add column species_id
  ALTER TABLE animals ADD COLUMN species_id INT;

  -- species_id foreign key
  ALTER TABLE animals ADD CONSTRAINT fk_animals_species FOREIGN KEY( species_id) REFERENCES species(id);

  -- add column owners_id
  ALTER TABLE animals ADD COLUMN owner_id INT;

  -- owners_id foreign key
  ALTER TABLE animals ADD CONSTRAINT fk_animals_owners FOREIGN KEY( owner_id) REFERENCES owners(id);

  -- query using join 
SELECT name FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

SELECT animals.name FROM animals INNER JOIN species ON animals.species_id= species.id WHERE species.name = 'Pokemon';

SELECT owners.full_name, name FROM owners LEFT JOIN animals ON animals.owner_id = owners.id;
SELECT species.name, COUNT(animals.name) FROM animals INNER JOIN species ON animals.species_id = species_id GROUP BY species.name;

SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Jennifer Orwell'; 

SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0; 

SELECT owners.full_name, COUNT(animals.name) FROM owners LEFT JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY COUNT(animals.name) DESC;

-- Who was the last animal seen by William Tatcher?
SELECT animals.name, visits.date_of_visit
FROM animals 
JOIN visits ON visits.animals_id = animals.id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(animals.name), animals.name FROM animals
JOIN visits ON visits.animals_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez'
GROUP BY animals.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name AS specialise_on FROM vets
LEFT JOIN specialization ON vets.id = specialization.vet_id
LEFT JOIN species ON species.id = specialization.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, visits.date_of_visit AS visiting_date FROM animals 
JOIN visits ON visits.animals_id = animals.id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(visits.date_of_visit) AS visit_count
FROM animals
JOIN visits ON visits.animals_id = animals.id
GROUP BY animals.name
ORDER BY visit_count DESC LIMIT 1; 

-- Who was Maisy Smith's first visit?
 SELECT animals.name, visits.date_of_visit AS visit_date
 FROM animals 
 JOIN visits ON visits.animals_id = animals.id
 JOIN vets ON vets.id = visits.vet_id
 WHERE vets.name = 'Maisy Smith' 
 ORDER BY visit_date ASC LIMIT 1;

 -- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name, animals.date_of_birth, animals.neutered, animals.weight_kg,
vets.name, vets.age, vets.date_of_graduation, visits.date_of_visit AS recent_visit FROM animals
JOIN visits ON visits.animals_id = animals.id
JOIN vets ON vets.id = visits.vet_id
ORDER BY recent_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name, COUNT(visits.animals_id) FROM visits
JOIN vets ON vets.id = visits.vet_id
JOIN animals ON animals.id = visits.animals_id
JOIN specialization ON specialization.species_id = vets.id
WHERE specialization.species_id != animals.species_id
GROUP BY vets.name;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT(visits.animals_id) AS species_with_most_visits FROM visits
JOIN vets ON vets.id = visits.vet_id
JOIN animals ON animals.id = visits.animals_id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY species_with_most_visits DESC LIMIT 1;

-- Explain analyse
explain analyze SELECT COUNT(*) FROM visits where animals_id = 4;
explain analyze SELECT * FROM visits where vet_id = 2;
explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';