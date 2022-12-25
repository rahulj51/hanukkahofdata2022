{{
    config (
        schema = "day7"
    )
}}

{% set emily_id = '8342' %} -- from day6


with emily_orders as (
    select
        o.orderid,
        o.ordered_at,
        oi.sku,
        p.description
    from {{ ref('orders') }} o
    join {{ ref('orders_items') }} oi on o.orderid = oi.orderid
    join {{ ref('products') }} p on oi.sku = p.sku
    where o.customerid='{{ emily_id }}'
)

select c.customerid,
       c.name,
       c.phone

from {{ ref('customers') }} c
join {{ ref('orders') }} o on c.customerid = o.customerid
join {{ ref('orders_items') }} oi on o.orderid = oi.orderid
join {{ ref('products') }} p on oi.sku = p.sku
join emily_orders eo on date_trunc('hour', o.ordered_at) = date_trunc('hour', eo.ordered_at) --on the same day/hour as emily
    and trim(split_part(p.description, '(', 1)) = trim(split_part(eo.description, '(', 1)) -- matching product
    and trim(split_part(p.description, '(', 2)) != trim(split_part(eo.description, '(', 2)) -- but diff color
where p.description like '%(%' -- products that have a color in description