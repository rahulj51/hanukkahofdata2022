{{
    config (
        schema = "day8"
    )
}}

{% set collectible_sku = 'COL' %}

with all_collectibles as (
    select array_agg(sku) as all_sku from {{ ref('products') }} where sku like '{{collectible_sku}}%'
),

customers_who_bought_collectibles as (
select
    c.customerid,
    c.name,
    c.phone,
    array_agg(oi.sku) as collectibles -- list of all collectibles bought by them
    from {{ ref('customers') }} c
    join {{ ref('orders') }} o on c.customerid = o.customerid
    join {{ ref('orders_items') }} oi on o.orderid = oi.orderid
  where oi.sku like '{{collectible_sku}}%'
  group by 1, 2, 3)

select name, phone
from customers_who_bought_collectibles cc, all_collectibles ac
-- using bird operator to compare 2 arrays as sets for equality
where ac.all_sku <@ cc.collectibles   -- x contains all elements of y
and cc.collectibles <@ ac.all_sku     -- y contains all elements of x
