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

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX animal_index ON visits(animal_id);
CREATE INDEX vet_index ON visits(vet_id);
CREATE INDEX email_index ON owners(email);

-- Indexes
CREATE INDEX patient_index ON medical_histories(patient_id);
CREATE INDEX medical_history_index ON invoices(medical_history_id);
CREATE INDEX invoice_index ON invoice_items(invoice_id);
CREATE INDEX treatment_index ON invoice_items(treatment_id);
CREATE INDEX medical_history_index ON medial_treatments(medical_history_id);
CREATE INDEX treatment_index ON medial_treatments(treatment_id);
