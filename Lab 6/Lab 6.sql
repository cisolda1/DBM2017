-- Christian Isolda
-- Lab 6

--1: Display	the	name	and	city	of	customers	who	live	in	any	city	that makes	the	most
--different	kinds	of	products.	(There	are	two	cities	that	make	the	most	different	
--products.	Return	the	name	and	city	of	customers	from	either	one	of	those.)

SELECT name, city
FROM customers
WHERE city IN(SELECT city FROM products GROUP BY city ORDER BY count(*) DESC LIMIT  1);

--2: Display	the	names	of	products	whose	priceUSD	is	strictly	above	the	average	priceUSD,	
--in	reverse-alphabetical	order.

SELECT name
FROM products
WHERE priceUSD > (SELECT AVG(priceUSD) FROM products) 
ORDER BY name Desc;

--3: Display	the	customer	name,	pid	ordered,	and	the	total	for	all	orders,	sorted	by	total	
--from	low	to	high.

SELECT customers.name, orders.pid, orders.totalUSD
FROM orders inner join customers on orders.cid = customers.cid
ORDER BY totalUSD ASC;

--4: Display	all	customer	names	(in	alphabetical	order)	and	their	total	ordered,	and	
--nothing	more.	Use	coalesce	to	avoid	showing	NULLs.

SELECT customers.name, COALESCE(sum(totalUSD)) AS sumUSD
FROM customers LEFT OUTER JOIN orders ON customers.cid = orders.cid
GROUP BY orders.cid, customers.name
ORDER BY customers.name ASC;

--5: Display	the	names	of	all	customers	who	bought	products	from	agents	based	in	
--Newark	along	with	the	names	of	the	products	they	ordered,	and	the	names	of	the	
--agents	who	sold	it	to	them.

SELECT customers.name, products.name, agents.name
FROM customers, products, agents, orders
WHERE agents.city = 'Newark'
AND orders.cid = customers.cid
AND orders.aid = agents.aid
AND orders.pid = products.pid;

--6: Write	a	query	to	check	the	accuracy	of	the	totalUSD	column	in	the	Orders	table.	This	
--means	calculating	Orders.totalUSD	from	data	in	other	tables	and	comparing	those	
--values	to	the	values	in	Orders.totalUSD.	Display	all	rows	in	Orders	where	
--Orders.totalUSD	is	incorrect,	if	any.
SELECT orders.ordnumber, orders.totalUSD, products.priceusd
FROM orders, products
WHERE orders.totalUSD != ((products.priceusd)*(orders.qty));

/* 7:     
      A LEFT OUTER JOIN will show all the rows from the table listed on the left side of the function. A RIGHT OUTER
      JOIN will show all the rows from the table listed on the right side of the function. OUTER JOINS show all
      information in the tables listed regardless if there are any matching columns. A great way to use this function effectively 
      is similar to a project I am working on. Where a board member is not assigned a project we could check which of the members
      has been assigned what and what member has been assigned nothing which would come up null.
*/
