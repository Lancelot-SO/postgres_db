/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  date_of_birth DATE NOT NULL,
  escape_attempts INT NOT NULL,
  neutered BOOLEAN NOT NULL,
  weight_kg DECIMAL(5, 2) NOT NULL,
  PRIMARY KEY (id)
);

SELECT * FROM animals;

-- project  two --
ALTER TABLE animals ADD species VARCHAR(255);

-- project three --
CREATE TABLE owners
(
    id SERIAL  primary key,
    full_name VARCHAR(250) ,
    age  INT
);

CREATE TABLE species
(
    id SERIAL primary key,
    name VARCHAR(250)
);

create sequence animal_id_seq;
alter table animals alter column id set default nextval('animal_id_seq');
ALTER TABLE animals drop column species;
ALTER TABLE animals ADD COLUMN species_id INTEGER REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id INTEGER REFERENCES owners(id);



