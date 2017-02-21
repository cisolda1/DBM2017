--Christian Isolda--
--February 15, 2017--
--Lab 4--

--1--
select city
from agents
where aid in (
   	select aid
	from orders
	where cid = 'c006')
	order by aid ASC;

--2--
select distinct pid 
from orders
where aid in(
    select aid
	from orders
	where cid in (
    	select cid
		from customers
		where city = 'Kyoto'));
		

--3--
select cid 
from customers
where cid in(
    select distinct cid
	from orders
	where aid not in (
    	select distinct aid
		from orders
		where aid = 'a01'));
		
--4--
select distinct cid
from orders
where cid in((
    	select distinct cid
		from orders
		where pid = 'p01')
        intersect 
        (select distinct cid
        from orders
        where pid = 'p07' ));

--5--
select pid 
from orders
where pid in(
    select distinct pid
	from orders
	where cid in (
    	select cid
		from orders
		where aid = 'a08'));

--6--
select name, discount, city
from customers
where cid in(
    select distinct cid
	from orders
	where aid in (
    	select aid
		from agents
		where city = 'New York'
		   or city = 'Tokyo'))
		   
--7--
select name 
from customers
where cid in(
    select distinct cid
	from orders
	where cid in (
    	select cid
		from customers
		where city = 'Dallas'
		   or city = 'Duluth'));
		   
--8--
--Constraints are vital to the structure of a database. They are parameters set on
columns, tables, schemas that have a setting that needs to be followed when entering
data into those fields. They are used to make sure data is entered correctly into the
fields. The advantage of using constraints is mainly for structure and functionality.
If there were no constraints on data fields a user can input any piece of information or
not input any information. Databases that have no constraints make collecting data
impossible. A great constraint that pretty much every database has is NotNUll. This makes
sure the data field is filled in. If a user tries to make an account on a website without
inputting a password it will give an error. On the other hand, this can be also break a
database. If notnull is use incorrectly, it can cause a fatal error. For example, if a 
form requires an occupation input but the user does not have one it can cause an error
because the field is labeled not null and wont let the user proceed until filled in. 
If constraints are used incorrectly, it can make a database very confusing and hard to
use.--
		