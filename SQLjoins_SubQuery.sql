-- 1. List all customers who live in Texas (use JOINs) 
select * from customer
select * from address

select customer_id, first_name, last_name
from customer
join address
on customer.address_id = address.address_id
where address.district = 'Texas';

-- 1. Answer: Jennifer Davis, Kim Cruz, Richard Mccrary, Bryan Hardison, and Ian Still all live in Texas.

-- 2. Get all payments above $6.99 with the Customer's Full Name 
select * from payment

select payment_id, first_name, last_name
from payment
join customer
on customer.customer_id = payment.customer_id
where amount > 6.99;
-- 2. Answer: Run SQL above

-- 3. Show all customers names who have made payments over $175(use subqueries)
select * from payment

SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	where payment.amount >= 175
	)
group by first_name, last_name;

-- 3. Answer: The only customer who has made a single payment over $175 Peter Menard.
-- 3. Continued to get the sum(amount)
select first_name, last_name
from customer
where customer_id in (
	select customer_id
	from payment
	group by customer_id
	having sum(amount) >= 175
	order by sum(amount) desc
	)
group by first_name, last_name;
-- 3. continued answer: there are a total of 135 customers who paid over a sum amount of $175

-- 4. List all customers that live in Nepal (use the city table) 
select * from customer

select first_name, last_name
from customer
join address
on customer.address_id = address.address_id 
join city
on city.city_id = address.city_id 
join country
on country.country_id = city.country_id 
where country.country = 'Nepal';
-- 4. Answer: There is only one customer named Kevin Schuler that lives in Nepal

-- 5. Which staff member had the most transactions? 
select * from payment

select first_name, last_name, count(amount)
from staff
-- left join returns all data from staff, and only matching data from payment
left join payment
on payment.staff_id = staff.staff_id 
group by staff.staff_id
order by staff.staff_id desc;
-- 5. Answer: John Stephens has has the most transactions with 7,304. 
-- Mike Hillyer is a close second and the only other employee

-- 6. How many movies of each rating are there?
select * from film 

SELECT rating, COUNT(film_id) 
FROM film
GROUP BY rating
-- 6. Answer: NC-17 = 209, G = 178, PG-13 = 223, PG = 194, R = 196

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	where payment.amount >= 6.99
	)
group by first_name, last_name;
-- 7. Answer: There are 599 customers who made a payment over $6.99

-- 8. How many free rentals did our stores giveaway?
SELECT COUNT(payment_id)
from payment
where payment_id IN (
	select payment_id
	from payment
	where amount = 0
	);
-- Answer: There were no free rentals given away.