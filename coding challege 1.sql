
create table crime (
    crimeid int primary key identity,
    incidenttype varchar(255),
    incidentdate date,
    location varchar(255),
    description text,
    status varchar(20)
);


create table victim (
    victimid int primary key identity,
    crimeid int,
    name varchar(255),
    contactinfo varchar(255),
    injuries varchar(255),
    foreign key (crimeid) references crime(crimeid)
);

create table suspect (
    suspectid int primary key identity,
    crimeid int,
    name varchar(255),
    description text,
    criminalhistory text,
    foreign key (crimeid) references crime(crimeid)
);

insert into crime (incidenttype, incidentdate, location, description, status)
values
   ('robbery', '2023-09-01', '123 main st, cityville', 'robbery at store', 'open'),
    ('homicide', '2023-09-02', '456 elm st, townsville', 'investigation into a murder case', 'under investigation'),
    ('theft', '2023-09-03', '789 oak st, villagetown', 'shoplifting incident at a mall', 'closed'),
    ('fraud', '2023-10-04', '101 pine st, cityville', 'bank fraud involving multiple accounts', 'under investigation'),
    ('burglary', '2023-10-05', '202 maple st, townsville', 'theft of valuables', 'open'),
    ('cyber crime', '2023-10-06', '202 pine st, townsville', 'targeting banking customers', 'under investigation'),
    ('assault', '2024-11-07', '303 birch st, villagetown', 'physical altercation leading to serious injuries', 'closed'),
    ('drug trafficking', '2024-12-08', '404 cedar st, cityville', 'illegal drug trade operation uncovered', 'open'),
    ('kidnapping', '2024-11-09', '505 spruce st, townsville', 'missing person reported, suspected kidnapping', 'under investigation'),
    ('arson', '2024-12-10', '606 fir st, villagetown', 'deliberate fire set in a residential area', 'closed');


insert into victim (crimeid, name, contactinfo, injuries)
values
    (1, 'sudha', 'sudha@gmail.com', 'minor injuries'),
    (2, 'selena', 'selena@gmail.com', 'deceased'),
    (3, 'alice', 'alicejohnson@gmail.com', 'none'),
    (4, 'mohan', 'mohan@gmail.com', 'financial loss'),
    (5, 'varsha', 'varsha@gmail.com', 'traumatized'),
    (6, 'max', 'max@gmail.com', 'identity theft impact'),
    (7, 'sudharshana', 'sudharshana@gmail.com', 'head injury'),
    (8, 'elumalai', 'elumalai@gmail.com', 'no physical injury'),
    (9, 'sophie', 'sophie@gmail.com', 'psychological stress'),
    (10, 'daniel', 'daniel@gmail.com', 'burn injuries');


insert into suspect (crimeid, name, description, criminalhistory)
values
    (1, 'robber 1', 'armed and masked robber', 'previous robbery convictions'),
    (2, 'unknown', 'investigation ongoing', null),
    (3, 'suspect 1', 'shoplifting suspect', 'prior shoplifting arrests'),
    (4, 'fraudster', 'financial scam artist', 'multiple fraud charges'),
    (5, 'burglar', 'known for breaking into houses', 'past burglary cases'),
    (6, 'hacker', 'cybersecurity threat', 'previous hacking cases'),
    (7, 'offender', 'physically violent individual', 'history of assaults'),
    (8, 'drug lord', 'leader of illegal drug trade', 'prior drug offenses'),
    (9, 'kidnapper', 'suspected involvement in multiple kidnappings', 'under surveillance'),
    (10, 'arsonist', 'previously convicted for arson', 'repeat offender');

--questions:

--1. Select all open incidents.

select *from  crime 
where status ='open'



2. Find the total number of incidents.

select count(*) as total_number 
from crime 





3. List all unique incident types.

select distinct incidenttype from crime


4. Retrieve incidents that occurred between '2023-09-01' and '2023-09-10'.


select *from crime 
where incidentdate  between '2023-09-01' and '2023-09-10'


5. List persons involved in incidents in descending order of age.

alter table crime 
add age int 


update crime set age = 21 where crimeid = 1;
update crime set age = 22 where crimeid = 2;
update crime set age = 23 where crimeid = 3;
update crime set age = 24 where crimeid = 4;
update crime set age = 26 where crimeid = 5;
update crime set age = 22 where crimeid = 6;
update crime set age = 21 where crimeid = 7;
update crime set age = 23 where crimeid = 8;
update crime set age = 35 where crimeid = 9;
update crime set age = 60 where crimeid = 10;

select  * from crime

select crimeid ,incidenttype ,age from crime 
order by age desc



6. Find the average age of persons involved in incidents.


select incidenttype,avg(age) as avg_age 
from crime 
group by incidenttype


7. List incident types and their counts, only for open cases.


select incidenttype , count(*) as incident_count
from crime 
where status ='open'
group by incidenttype 

8. Find persons with names containing 'Doe'.


select name from suspect 
where name like  '%Doe%'

union all 

select name from victim
where name like '%Doe%'


9. Retrieve the names of persons involved in open cases and closed cases.


select v.name as PersonName, c.status AS CaseStatus 
from victim v
join crime c on v.crimeid = c.crimeid
where  c.status IN ('Open', 'Closed')

union 

select  s.name AS PersonName, c.status AS CaseStatus 
from suspect s
join crime c ON s.crimeid = c.crimeid
where c.status IN ('Open', 'Closed');



10. List incident types where there are persons aged 30 or 35 involved.

select incidenttype from crime 
where age in (30,35)



11. Find persons involved in incidents of the same type as 'Robbery'.


select *from crime 
where incidenttype  ='Robbery'



12. List incident types with more than one open case.

select  incidenttype , count(*) as open_case from crime 
where status ='open'
group by incidenttype 
having count(*)>1



13. List all incidents with suspects whose names also appear as victims in other incidents.



select   c.crimeid, c.incidenttype, c.incidentdate, c.location, s.name AS suspect_name
from crime c
join suspect s ON c.crimeid = s.crimeid
where s.name IN 
(select  v.name 
from victim v
where  v.crimeid = c.crimeid);








14. Retrieve all incidents along with victim and suspect details.


select 
    c.crimeid, 
    c.incidenttype, 
    c.incidentdate, 
    c.location, 
    c.description, 
    c.status,
    v.name AS victim_name, 
    v.contactinfo, 
    v.injuries,
    s.name AS suspect_name, 
    s.description, 
    s.criminalhistory
from crime c
left join victim v ON c.crimeid = v.crimeid
left join  suspect s ON c.crimeid = s.crimeid;





15. Find incidents where the suspect is older than any victim.


alter table suspect  
add age int 

update suspect set age = 22 where suspectid = 1;
update suspect set age = 25 where suspectid = 2;
update suspect set age = 25 where suspectid = 3;
update suspect set age = 24 where suspectid = 4;
update suspect set age = 27 where suspectid = 5;
update suspect set age = 47 where suspectid = 6;
update suspect set age = 50 where suspectid = 7;
update suspect set age = 43 where suspectid = 8;
update suspect set age = 29 where suspectid = 9;
update suspect set age = 60 where suspectid = 10;

alter table victim
add age int 


update victim set age = 30 where victimid = 1;
update victim set age = 32 where victimid = 2;
update victim set age = 23 where victimid = 3;
update victim set age = 25 where victimid = 4;
update victim set age = 48 where victimid = 5;
update victim set age = 50 where victimid = 6;
update victim set age = 45 where victimid = 7;
update victim set age = 20 where victimid = 8;
update victim set age = 69 where victimid = 9;
update victim set age = 60 where victimid = 10;


select c.crimeid, c.incidenttype, c.incidentdate, c.location, s.name AS suspect_name, s.age AS suspect_age
from crime c
join suspect s on c.crimeid = s.crimeid
where s.age > (select  v.age from  victim v where  v.crimeid = c.crimeid);










16. Find suspects involved in multiple incidents:


select name, count(crimeid) as incident_count 
from suspect 
group by name 
having count(crimeid) > 1;









17. List incidents with no suspects involved.



select crimeid, incidenttype, status 
from crime 
where crimeid not in (select distinct crimeid from suspect);








18. List all cases where at least one incident is of type 'Homicide' and all other incidents are of type
'Robbery'.






select crimeid, incidenttype 
from crime 
where incidenttype = 'homicide' 

union 

select crimeid, incidenttype 
from crime 
where incidenttype = 'robbery';

19. Retrieve a list of all incidents and the associated suspects, showing suspects for each incident, or
'No Suspect' if there are none.




select c.crimeid, c.incidenttype, coalesce(s.name, 'No Suspect') as suspect_name 
from crime c 
left join suspect s on c.crimeid = s.crimeid;






20. List all suspects who have been involved in incidents with incident types 'Robbery' or 'Assault'

select distinct s.name 
from suspect s 
join crime c on s.crimeid = c.crimeid 
where c.incidenttype in ('robbery', 'assault');
