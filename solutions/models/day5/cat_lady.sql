{{
    config (
        schema = "day5"
    )
}}

{% set pet_sku = 'PET' %}

select
    c.customerid,
    c.name,
    c.phone
from {{ ref('customers') }} c
join {{ ref('orders') }} o on c.customerid =o.customerid
join {{ ref('orders_items') }} oi on o.orderid = oi.orderid
join {{ ref('products') }} p on oi.sku = p.sku

where lower(citystatezip) like '%queens village%' -- lives in queens village
and oi.sku like '{{ pet_sku }}%' --has cats so buys cat food
group by 1,2,3
order by count(*) desc limit 1 -- max active
