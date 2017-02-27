-- Christian Isolda
-- Lab 5

-- 1:
SELECT a.city
FROM  agents a,
      orders o
WHERE o.aid = a.aid
  AND o.cid = 'c006' ;
  
-- 2:
select distinct p.pid
  from customers c inner join orders o on c.cid = o.cid and c.city = 'Kyoto' 
              left outer join orders p on p.aid = o.aid 
 order by p.pid ASC;
 
-- 3:
SELECT name
FROM customers
WHERE cid NOT IN (SELECT cid FROM orders );

-- 4:
SELECT c.name
FROM customers c LEFT OUTER JOIN orders o ON c.cid = o.cid
WHERE o.cid is null ;

-- 5:
SELECT DISTINCT c.name AS "CustomerName" , a.name AS "AgentName"
FROM customers c, 
     agents a, 
     orders o
WHERE o.cid = c.cid 
  AND o.aid = a.aid
  AND c.city = a.city;

-- 6:
SELECT c.name AS "CustomerName" , a.name AS "AgentName" , a.city AS "SharedCity"
FROM customers c INNER JOIN agents a ON a.city = c.city ;

-- 7:
SELECT name, city
FROM customers
WHERE city IN 
				(SELECT city
                FROM products
                GROUP BY city
                ORDER BY COUNT(*) ASC 
                LIMIT 1);