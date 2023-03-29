--1 
select title, retail from books where retail > (select AVG(retail) from books);

--2
SELECT a.title, b.category, a.cost 
FROM books a, (select category , avg(cost) averagecost 
from books group by category) b 
where a.category = b.category
and a.cost < b.averagecost ;

--3
select order# 
from orders
where shipstate = (select shipstate
from orders where order# = 1014);

--4
select sum(paideach*quantity) from orderitems where order# =1007;

select order#, sum(paideach*quantity) from orderitems group by order#;

select order#, b.Total_amount 
from (select  order#, sum(quantity* paideach) Total_amount 
from orderitems group by order#) b
where (b.total_amount)> (select SUM(paideach*quantity) 
from orderitems where order# = 1001);

--5
 select sum(quantity), isbn from orderitems group by isbn order by sum(quantity) DESC;
 
 select a.Frequency, b.isbn, author.lname, author.fname from bookauthor b , (select sum(quantity) Frequency, isbn 
 from orderitems group by isbn order by sum(quantity) DESC
 ) a, author  where b.isbn = a.isbn AND author.authorid= b.authorid;
 
--6
select * from orderitems where order# =1007;

select customer#, o1.order#, o2.quantity, b1.title, b1.isbn, b1.category 
from orders o1, orderitems o2, books b1 
where customer# =1007 and o1.order#= o2.order# and b1.isbn = o2.isbn;
 
 
select b2.category, b2.title from books b2 
where b2.title NOT IN (select b1.title
from orders o1, orderitems o2, books b1 
where customer# =1007 and o1.order#= o2.order# and b1.isbn = o2.isbn)
and b2.category IN (select b1.category
from orders o1, orderitems o2, books b1 
where customer# =1007 and o1.order#= o2.order# and b1.isbn = o2.isbn)


