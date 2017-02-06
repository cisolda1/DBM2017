-- Christian Isolda --
-- February 6, 2017 --
-- Lab 3 --


SELECT ordNumber, totalUSD FROM Orders;
SELECT city, name FROM Agents WHERE name='Smith';
SELECT pid, name, priceUSD FROM Products WHERE quantity>200100;
SELECT name, city FROM Customers WHERE city='Duluth';
SELECT name FROM Agents WHERE city<>'New York' AND city<>'Duluth';
SELECT * FROM Products WHERE city<>'Dallas' AND city<>'Duluth' AND priceUSD>=1.00;
SELECT * FROM Orders WHERE month='Feb' OR month='May';
SELECT * FROM Orders WHERE month='Feb' AND totalUSD>=600.00;
SELECT * FROM Orders WHERE cid='C005';