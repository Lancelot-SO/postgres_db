/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- project two --
BEGIN;
update animals  set species='unspecified';
ROLLBACK;
Begin;
 update animals set species='digimon' where name like '%mon';
 update animals set species= 'pokemon' where species is null; 
commit;
begin;
     delete from animals;
rollback;
begin;
  delete from animals where date_of_birth > '2022-01-01';
  SAVEPOINT animal_save_one;
  update animals set weight_kg =weight_kg * -1;
  Rollback to savepoint animal_save_one;
  update animals set weight_kg =weight_kg * -1 where weight_kg <0;
commit;

-- aggregation queries --
select  count(*) num_of_animals from animals;
select  count(*) never_escape_animals from animals where escape_attempts=0;
select avg(weight_kg) from animals;
select neutered as neutered_animal ,
sum(escape_attempts) as total_escape_attempt 
from animals group by neutered order by total_escape_attempt  desc ;
select species,MIN(weight_kg) as min_weight_kg, max(weight_kg) as max_weight_kg from animals  group by species;
select species, avg(escape_attempts) from animals 
where date_of_birth between '1990-01-01' and '2000-01-01' 
group by species;