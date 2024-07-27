select *
from covid_deaths_portfolio
where continent is not null
order by 3,4;

select *
from covid_vaccination_portfolio

select country,dates,new_cases,total_cases,total_deaths,population
from covid_deaths_portfolio
where continent is not null
order by 1,2

alter table covid_deaths_portfolio
ALTER COLUMN population TYPE float8 USING population::float8;

alter table  covid_deaths_portfolio
alter column new_deaths set data type int using new_deaths::int;
	
alter table covid_deaths_portfolio
add column percent_population_infected  float;

alter table covid_deaths_portfolio
drop column death_population
	
update covid_deaths_portfolio
set percent_population_infected = (total_cases/population)*100

select country,dates,total_cases,total_deaths,death_percentage
from covid_deaths_portfolio
where country like 'United States%'
order by 1,2;

--total cases vs population
--percentage that got covid

select country,dates,total_cases,population,percent_population_infected
from covid_deaths_portfolio
where country like 'United States%' and continent is not null
order by 1,2;

--countries with highest infections compared to population
select continent,country,population,max(percent_population_infected),max(total_cases)
from covid_deaths_portfolio
where continent is not null
group by population,country,continent
order by 1,2;

--highest death by continent
select continent,max(total_deaths) as total_deaths_count
from covid_deaths_portfolio
where continent is not null 
group by continent
order by total_deaths_count asc;

--highest death count per population
select country,max(total_deaths) as total_deaths_count
from covid_deaths_portfolio as cdcontinent
where continent is null 
group by country
order by total_deaths_count asc;

select country,max(total_deaths) as total_deaths_count
from covid_deaths_portfolio cdeaths
where continent is not null 
group by country


--global numbers
select country,sum(new_cases),sum (new_deaths),death_percentage
from covid_deaths_portfolio as cd
where continent is not null
group by country,death_percentage
order by 1,2;

--creating view for later visualization

create view cd as 
(
select country,sum(new_cases) as nc,sum (new_deaths) as nd,death_percentage
from covid_deaths_portfolio
where continent is not null
group by country,death_percentage
)

create view cdeaths as
(
select country,max(total_deaths) as total_deaths_count
from covid_deaths_portfolio cdeaths
where continent is not null 
group by country
)

create view cdcontinent as
(
select country,max(total_deaths) as total_deaths_count
from covid_deaths_portfolio as cdcontinent
where continent is not null 
group by country
)