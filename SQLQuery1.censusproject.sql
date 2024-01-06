select * from censusproject.dbo.data1
select * from censusproject.dbo.data2

-- number of rows in our datasets

select COUNT(*)
from data1

select COUNT(*)
from data2

-- get data for JHARKHAND AND BIHAR

select * from data1 
where State in  ('jharkhand' , 'bihar')

-- total population of india 

select sum(population) as totalpopulation
from data2

-- average growth of india round it for 3 value

select round(AVG(growth),3) * 100 as 'avg growth'
from data1

-- average growth of each state round it for 3 value

select state, round(AVG(growth),3) * 100 'avg growth'
from data1
group by State ;

-- average sex ratio of each state round it for 3 value and get the state having highest sex ratio

select state, round(AVG(sex_ratio),0) as 'avg sex_ratio'
from data1
group by State
order by 'avg sex_ratio' desc

-- average literacy rate of each state having greater than 90 in ascending order

select state, ROUND(avg(literacy),0) as avg_literacy
from data1
group by State 
having  ROUND(avg(literacy),0) > 90
order by avg_literacy asc

-- top 3 state having highest avg growth rate

select  top 3 state,round(avg(growth),3) * 100 as avg_growth
from data1
group by State
order by avg_growth desc ;

-- top 3 state having lowest average sex ratio rate

select  top 3 state,round(avg(Sex_Ratio),3) * 100 as avg_sexratio
from data1
group by State
order by avg_sexratio asc ;


-- what is top 3 and bottom 3 states in literacy

drop table if exists topstates

create table topstates
( state varchar(255),
topstates float)

insert into topstates

select state, ROUND(avg(literacy),0) as avg_literacy
from data1
group by State 
order by avg_literacy desc;

select top  3 * from topstates 
order by topstates desc

drop table if exists bottomstates

create table bottomstates
( state varchar(255),
bottomstates float)

insert into bottomstates

select state, ROUND(avg(literacy),0) as avg_literacy
from data1
group by State 
order by avg_literacy asc;

select top 3 * from bottomstates
order by bottomstates asc

--union operator
select * from (
select top  3 * from topstates 
order by topstates desc) a -- name to subquery

union 

select * from (
select top 3 * from bottomstates
order by bottomstates asc) b -- name to subquery

-- states name starting with letter A

select distinct state
from data1
where State like 'a%'

-- states name starting with letter A and ending with letter h


select distinct state
from data1
where State like 'a%' and  State like '%h' 

-- get the total number of males and females where formulas (males =population/(sex_ratio+1) ,female= population*sex_ratio/(sex_ratio+1)

select d.state, sum (d . males) as total_males, sum(d.females) as total_females 
from (select c.district, c.state , round((c.population)/(c.sex_ratio+1),0)  males, round((c.population*c.sex_ratio)/(c.sex_ratio+1),0) females 
from (select data1.district, data1.state, data1.sex_ratio, data2.Population
from data1
inner join data2
on data1.District = data2.District) c)d 
group by d.State ;


