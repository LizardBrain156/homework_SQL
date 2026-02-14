-- Какова общая сумма всех завершённых заказов?
select sum(quantity * unit_price) as total_amount
from order_items
join orders
on order_items.order_id = orders.order_id 
where orders.status = 'completed';

-- Какие клиенты сделали более одного заказа? Выведите их имя и количество заказов.
select customers.first_name, customers.last_name, count(orders.order_id) as orders_total
from customers
join orders
on customers.customer_id = orders.customer_id
group by customers.customer_id, customers.first_name, customers.last_name
having count(orders.order_id) > 1;

-- Какие товары имеют остаток на складе меньше 5 единиц?
select product_name, stock_quantity
from products
where stock_quantity < 5
order by stock_quantity desc;

-- Найдите самый популярный товар по количеству проданных единиц.
select products.product_name, sum(order_items.quantity) as ordered
from order_items
join products
on order_items.product_id = products.product_id
group by order_items.product_id
order by ordered desc
limit 1;

-- Выведите список клиентов, зарегистрировавшихся в последний месяц.
select * 
from customers
where registration_date >= now() - interval 30 day;

-- Напишите запрос, который выводит все заказы с общей стоимостью свыше 10 000 рублей.
select order_id, sum(quantity * unit_price) as total_sum
from order_items
group by order_id
having sum(quantity * unit_price) > 10000;

--  Какие категории товаров приносят наибольшую выручку?
select products.category, sum(order_items.quantity * order_items.unit_price) as revenue
from order_items
join products 
on order_items.product_id = products.product_id
group by products.category
order by revenue desc;
