-- A query to list all persons with family relationships using joins between person, family and relationship
select
	p.lastName,
    p.firstName,
    r.relationshipType,
    fa.familyType
from person p
inner join family fa on fa.idPerson = p.idPerson
inner join relationship r on r.idrelationship = fa.idrelationship;
    
-- A query to list all persons with friendship relationships using joins between person, friend and relationship
select
	p.lastName,
    p.firstName,
    r.relationshipType,
    fr.friendType
from person p
inner join friend fr on fr.idPerson = p.idPerson
inner join relationship r on r.idrelationship = fr.idrelationship;

-- A query to list all person, with or without a relationship of any kind, and any family relationships (hint: left join)
select
	p.lastName,
    p.firstName,
    fa.familyType
from person p
left join family fa on fa.idPerson = p.idPerson

