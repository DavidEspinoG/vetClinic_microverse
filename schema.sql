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