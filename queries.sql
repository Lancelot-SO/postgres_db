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

--project three --
select  owners.full_name as owners_full_name , animals.name as animal_name from animals 
inner join owners on animals.owner_id=owners.id
inner join species on animals.species_id=species.id
where owners.full_name ='Melody Pond';

select  animals.name as animal_name, species.name as species_name  from animals 
inner join owners on animals.owner_id=owners.id
inner join species on animals.species_id=species.id
where species.name ='Pokemon';


select  owners.full_name as owners_full_name , animals.name as animal_name from animals 
full join owners on animals.owner_id=owners.id;

select species.name as species_name, count(animals.name) as number_of_animals from animals 
inner join species on animals.species_id=species.id
group by species.name;

select  owners.full_name as owners_full_name , animals.name as animal_name, species.name as species_name from animals 
inner join owners on animals.owner_id=owners.id
inner join species on animals.species_id=species.id
where owners.full_name ='Jennifer Orwell' and species.name='Digimon';

select  owners.full_name as owners_full_name , animals.name as animal_name, animals.escape_attempts from animals 
inner join owners on animals.owner_id=owners.id
where owners.full_name ='Dean Winchester'and animals.escape_attempts =0;

select owners.full_name as owners_full_name, count(animals.name) as number_of_animals from animals 
full join owners on animals.owner_id=owners.id
group by owners.full_name
order by number_of_animals desc;


--project four--

select  *  from animals 
inner join visits on visits.animals_id=animals.id
inner join vets on vets.id=visits.vets_id
where  vets.name ='William Tatcher'
order by date_of_visit desc
limit 1


select DISTINCT   *  from animals 
inner join visits on visits.animals_id=animals.id
inner join vets on vets.id=visits.vets_id
where  vets.name ='Stephanie Mendez';


select  *  from vets 
left join specializations on specializations.vets_id=vets.id
left join species on species.id =specializations.species_id;

select  *  from animals 
inner join visits on visits.animals_id=animals.id
inner join vets on vets.id=visits.vets_id
where  vets.name ='Stephanie Mendez' and date_of_visit between '2020-04-01' and '2020-04-30'


select  animals.name as animal_name, count( animals.name) as number_of_visited from animals 
inner join visits on visits.animals_id=animals.id
inner join vets on vets.id=visits.vets_id
group by animals.name 
order by  number_of_visited desc

select  *  from animals 
inner join visits on visits.animals_id=animals.id
inner join vets on vets.id=visits.vets_id
where  vets.name ='Maisy Smith'
order by date_of_visit asc
limit 1

select  *  from animals 
inner join visits on visits.animals_id=animals.id
inner join vets on vets.id=visits.vets_id
order by date_of_visit desc
limit 1



select  count(visits.id) as number_of_vists  from animals
inner join visits on visits.animals_id =animals.id
inner join vets on vets.id=visits.vets_id
left join specializations on specializations.vets_id=vets.id
where specializations.species_id is  null;


select species.name, count(species.name)  as number_vists_by_Maisy_Smith from animals
inner join visits on visits.animals_id =animals.id
inner join species on species.id =animals.species_id 
inner join vets on vets.id=visits.vets_id
left join specializations on specializations.vets_id=vets.id
where vets.name ='Maisy Smith'
group by species.name;
