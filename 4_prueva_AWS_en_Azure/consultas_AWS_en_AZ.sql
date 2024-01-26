-- tables
SELECT * from category;
SELECT * FROM date;
select top 20 * from events;
select top 20 * from listings;
select top 20 * from sales;
select top 20 * from users;
select top 20 * from venue;

select dateid from events where dateid=1851;
select dateid from sales where dateid=1851;
select dateid from dbo.date where dateid=1851;


-- corrigiendo los tipos de las tablas para que coincidan entre las Fk
-- ALTER TABLE table_name
-- MODIFY column_name data_type;

ALTER TABLE "events"
ALTER COLUMN "catid" SMALLINT;

ALTER TABLE "listings"
ALTER COLUMN "eventid" SMALLINT;

ALTER TABLE "sales"
ALTER COLUMN "eventid" SMALLINT;

-- CONSTRAINTs:
-- ALTER TABLE table_name
-- ADD CONSTRAINT constraint_name FOREIGN KEY (column_name) REFERENCES table_name_ref (column_name_ref);

ALTER TABLE events
ADD CONSTRAINT catid FOREIGN KEY (catid) REFERENCES category (catid);

-- venue -> event:::
-- ALTER TABLE events
-- ADD CONSTRAINT venueid FOREIGN KEY (venueid) REFERENCES dbo.venue (venueid);

ALTER TABLE events
ADD CONSTRAINT catid FOREIGN KEY (catid) REFERENCES category (catid);

-- event -> sales
ALTER TABLE sales
ADD CONSTRAINT eventid FOREIGN KEY (eventid) REFERENCES events (eventid);

-- listings -> sales:
ALTER TABLE sales
ADD CONSTRAINT listid FOREIGN KEY (listid) REFERENCES listings (listid);

-- users -> sales:
ALTER TABLE sales
ADD CONSTRAINT sellerid FOREIGN KEY (sellerid) REFERENCES users (userid);

-- users -> sales:
ALTER TABLE sales
ADD CONSTRAINT buyerid FOREIGN KEY (buyerid) REFERENCES users (userid);

--Consultas ejercicio:
-- ¿Cuántos Usuarios gustan del Jazz?
SELECT COUNT(DISTINCT u.userid) as usuariosjazz
FROM users AS u
INNER JOIN sales AS s ON u.userid=s.buyerid
INNER JOIN events AS e ON e.eventid=s.eventid
INNER JOIN category AS c ON c.catid=e.catid
where c.catname='Jazz';

select dateid as eventos
from events as e 
LEFT JOIN sales AS s ON e.eventid=s.eventid;

-- ¿Cuántos Usuarios gustan de la ópera y del rock al mismo tiempo?
SELECT COUNT(DISTINCT u.userid) as "opera y rock"
FROM users AS u
INNER JOIN sales AS s ON u.userid=s.buyerid
INNER JOIN events AS e ON e.eventid=s.eventid
INNER JOIN category AS c ON c.catid=e.catid
where c.catid=8 AND c.catid=9;
-- ¿Cuál es el promedio, moda y mediana del total de Ventas?
-- ¿Cuál el promedio de ventas de usuarios que gustan del rock, pero NO del Jazz?



