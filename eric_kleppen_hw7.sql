-- 1a
use sakila;

-- 1a
select first_name
		,last_name
from actor;

-- 1b
select first_name
		,last_name
		,upper(concat(first_name,' ', last_name)) as Actor_Name
from actor;
 
 -- 2a
 select first_name
		,last_name
		,actor_ID 
from actor 
where first_name = 'Joe';

-- 2b
select * 
from actor
where last_name like '%gen%';

-- 2c
select * 
from actor
where last_name like '%li%' 
order by last_name, first_name;

-- 2d
select country_id 
,country 
 from country 
 where country IN ('Afghanistan', 'Bangladesh', 'China');

 -- 3a
alter table actor
add description blob;

-- 3b
alter table actor
drop description;

-- 4a
select last_name
		, count(last_name) as record_count
from actor
group by last_name;

-- 4b
select last_name
		, count(last_name) as record_count
from actor
group by last_name
having record_count >= 2; -- 2 or 3?

-- 4c
update actor a set first_name = 'HARPO'
where a.last_name = 'WILLIAMS' and a.first_name = 'GROUCHO';

-- 4d
update actor a set first_name = 'GROUCHO'
where a.last_name = 'WILLIAMS' and a.first_name = 'HARPO';

-- 5a
SHOW CREATE TABLE address;

-- 6a
select first_name
		,last_name
		,address
from staff as s
inner join address as a on a.address_id = s.address_id;

-- 6b select * from payment
select first_name
		,last_name
		,sum(amount) as Total_amount
from staff  s
join payment p on p.staff_id = s.staff_id
where 1=1 
and payment_date between  '2005-08-01 00:00:00' and  '2005-09-01 00:00:00'
group by first_name, last_name;

-- 6c
select title
		,count(actor_ID) as actor_count
from film f
inner join film_actor fa on fa.film_id = f.film_id
group by title;

-- 6d
select count(i.film_id) as film_inventory_count
from inventory i 
inner join film f on f.film_id = i.film_id
where f.title = 'Hunchback Impossible'
group by title;

-- 6e
select first_name
		,last_name
		,sum(amount) as Total_Amount_Paid
from customer c 
inner join payment p on p.customer_id = c.customer_id
group by first_name, last_name
order by last_name asc;

-- 7a
select title 
from film
where title like 'K%' 
or title like 'Q%'
and language_id = (
	select language_id from language where name = 'English'
);

-- 7b
SELECT first_name, last_name 
FROM actor a
WHERE a.actor_id IN (
	SELECT actor_id FROM film_actor fa WHERE fa.film_id IN 
	(
		SELECT film_id FROM film WHERE title = "Alone Trip"
        )
	);

 -- 7c
select first_name
		, last_name
		, email
from customer c
inner join address a on a.address_id = c.address_id
inner join city ci on ci.city_ID = a.city_id
inner join country co on co.country_ID = ci.country_ID;

-- 7d
select title
-- ,c.name as category
from film f
inner join film_category fc on fc.film_id = f.film_id
inner join category c on c.category_id = fc.category_id
where c.name = 'family';

-- 7e
select count(rental_id) as rental_count
		, title
from rental r
inner join inventory i on i.inventory_id = r.inventory_id
inner join film f on f.film_id = i.film_id
group by title
order by rental_count desc;

-- 7f
select s.store_id
		,sum(p.amount) as Business_in_dollars 
from store s
inner join customer c on c.store_ID = s.store_ID
inner join payment p on p.customer_id = c.customer_id
group by s.store_id;
 
 -- 7g
 select s.store_id 
		,c.city
		,co.country
 from store s
 inner join address a on a.address_id = s.address_id
 inner join city c on c.city_id = a.city_id
 inner join country co on co.country_id = c.country_id;
 
-- 7h
select c.name as category_name
		,sum(amount) as Gross_revenue
from payment p
inner join rental r on  r.rental_id = p.rental_id
inner join inventory i on i.inventory_id = r.inventory_id
inner join film_category fc on fc.film_id = i.film_id
inner join category c on c.category_id = fc.category_id
group by name
order by Gross_revenue desc
limit 5;

-- 8a
create view top_five_genres as (
	select name as category_name
	,sum(amount) as Gross_revenue
	from payment p
	inner join rental r on  r.rental_id = p.rental_id
	inner join inventory i on i.inventory_id = r.inventory_id
	inner join film_category fc on fc.film_id = i.film_id
	inner join category c on c.category_id = fc.category_id
	group by name
	order by Gross_revenue desc
	limit 5
);

-- 8b
select * from top_five_genres;

-- 8c
drop view top_five_genres;
 