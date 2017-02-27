-- Christian Isolda
-- Lab 6

-- 1:
SELECT name, city
FROM customers
WHERE city IN (SELECT city
                FROM products
                GROUP BY city
                ORDER BY count(*) DESC
                LIMIT 1);

-- 2:
SELECT name
FROM products
WHERE priceUSD < ( SELECT AVG(priceUSD)
                   FROM products)
				ORDER BY name DESC ;

-- 3:
select c.name, o.pid, o.totalUSD
  from orders o inner join customers c on o.cid = c.cid
 order by totalUSD ASC;

-- 4:
SELECT c.name, COALESCE(sum(totalUSD), '0.00') AS sumTotalUSD
FROM Customers c LEFT OUTER JOIN Orders o ON c.cid = o.cid
GROUP BY o.cid, c.name
ORDER BY c.name ASC;

-- 5:
SELECT c.name AS "Customer", p.name AS "Product", a.name AS "Agent"
FROM Customers c, Agents a, Products p, Orders o
WHERE a.city = 'New York'
  AND o.cid  = c.cid
  AND o.aid  = a.aid
  AND o.pid  = p.pid ;

-- 6:
select q.totalUSD, correctBill.realBill
  from orders q inner join (select o.ordnum, (o.qty * p.priceUSD) as realBill
			      from orders o inner join products p on o.pid = p.pid) correctBill on correctBill.ordnum = q.ordnum 
  where q.totalUSD != correctBill.realBill
  
  

/* 7:     
      A LEFT OUTER JOIN will show all the rows from the table listed on the left side of the function. A RIGHT OUTER
      JOIN will show all the rows from the table listed on the right side of the function. OUTER JOINS show all
      information in the tables listed regardless if there are any matching columns. A great way to use this function effectively 
      is similar to a project I am working on. Where a board member is not assigned a project we could check which of the members
      has been assigned what and what member has been assigned nothing which would come up null.
*/
