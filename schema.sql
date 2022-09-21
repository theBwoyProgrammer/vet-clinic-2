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
