select category_name, description
from categories

select contact_name, address, city
from customers
where country not in ('Germany', 'Mexico', 'Spain')

select order_date, shipped_date, customer_id, freight
from orders
where year(order_date) = 2018 and day(order_date) = 26 and month(order_date) = 2

select employee_id, order_id, customer_id, required_date, shipped_date
from orders
where shipped_date > required_date

select order_id
from orders
where order_id % 2 == 0

select city, company_name, contact_name
from customers
where city like '%l%'
order by contact_name asc

select company_name, contact_name, fax 
from customers
where fax is not null

select first_name, last_name, hire_date
from employees
order by hire_date desc
limit 1

select round(avg(unit_price),2) as average_price,
sum(units_in_stock) as total_stock,
sum(discontinued) as total_discontinued
from products

select products.product_name, suppliers.company_name, categories.category_name
from categories
join products on categories.category_id = products.category_id
join suppliers on products.supplier_id = suppliers.supplier_id


select categories.category_name, 
round(avg(products.unit_price),2) as average_unit_price
from categories
join products on categories.category_id = products.category_id
group by category_name


select city, company_name, contact_name, 'customers' as relationship
from customers

union

select city, company_name, contact_name, 'suppliers' as relationship
from suppliers


select year(order_date) as order_year,
month(order_date) as order_month,
count(*) as no_of_orders
from orders
group by year(order_date), month(order_date)

select employees.first_name, employees.last_name,
count(orders.order_date) as num_orders,
(
  case when shipped_date <= required_date then 'On Time'
       when shipped_date > required_date then 'Late'
       when shipped_date is null then 'Not Shipped'
  end) as shipped
from employees
join orders on employees.employee_id = orders.employee_id
group by employees.first_name, employees.last_name, shipped
order by employees.last_name, employees.first_name, num_orders desc

select year(order_date) as order_year,
round(sum(products.unit_price * order_details.quantity * order_details.discount),2) as discount_amount
from orders
join order_details on orders.order_id = order_details.order_id
join products on order_details.product_id = products.product_id
group by year(order_date)
order by order_year desc