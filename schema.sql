/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    name varchar(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL,
    PRIMARY KEY(id)
);

-- Added new column called species of type string
ALTER TABLE animals
ADD Species varchar(150);

--Creating table owners
CREATE TABLE owners (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    full_name varchar(100) NOT NULL,
    age INT,
    PRIMARY KEY(id)
);

--Creating table species
CREATE TABLE species (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    name varchar(100) NOT NULL,
    PRIMARY KEY(id)
);

-- Create a table named vets
CREATE TABLE vets (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    name varchar(100) NOT NULL,
    age INT,
    date_of_graduation date,
    PRIMARY KEY(id)
);

-- create specialization join table (JOIN)
CREATE TABLE specialization (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    species_id INT REFERENCES species(id),
    vet_id INT REFERENCES vets(id)
);

-- Create visits join table (JOIN)
CREATE TABLE visits (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    animals_id INT REFERENCES animals(id),
    vet_id INT REFERENCES vets(id) 
    date_of_visit DATE NOT NULL
);
