/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(20),
    date_of_birth DATE,
    escape_attempts SMALLINT, 
    neutered BOOLEAN,
    weight_kg FLOAT
);

ALTER TABLE animals
ADD species varchar(20);

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY, 
    full_name varchar(20),
    age smallint
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY, 
    name varchar(20)

);

ALTER TABLE species
ADD PRIMARY KEY (id);

ALTER TABLE animals 
ADD PRIMARY KEY (id);

ALTER TABLE animals 
DROP COLUMN species;

ALTER TABLE animals 
ADD COLUMN species_id INT;

ALTER TABLE animals
    ADD CONSTRAINT fk_species FOREIGN KEY (species_id)
    REFERENCES species (id);

ALTER TABLE owners 
ADD PRIMARY KEY (id);

ALTER TABLE animals 
ADD COLUMN owner_id INT;

ALTER TABLE animals
    ADD CONSTRAINT fk_owners FOREIGN KEY (owner_id)
    REFERENCES owners (id);

-- Join table (many-to-many)

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(20), 
    age SMALLINT, 
    date_of_gratuation DATE, 
    PRIMARY KEY (id)
);

CREATE TABLE specializations (
    vet_id INT,
    species_id INT,
    FOREIGN KEY (vet_id) REFERENCES vets (id), 
    FOREIGN KEY (species_id) REFERENCES species (id)
);

CREATE TABLE visits (
    vet_id INT, 
    animal_id INT,
    date_of_visit DATE, 
    FOREIGN KEY (vet_id) REFERENCES vets (id),
    FOREIGN KEY (animal_id) REFERENCES animals (id)
);