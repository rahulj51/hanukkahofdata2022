{{
    config (
        schema = "day4"
    )
}}

-- all bakery products start with BKY
{% set bakery_sku = 'BKY' %}

select
    c.customerid,
    c.name,
    c.phone
from {{ ref('customers') }} c
join {{ ref('orders') }} o on c.customerid =o.customerid
join {{ ref('orders_items') }} oi on o.orderid = oi.orderid
join {{ ref('products') }} p on oi.sku = p.sku

where date_part('hour', o.ordered_at) < 5 --pasteries were bought before 5:00
and oi.sku like '{{ bakery_sku }}%'
group by 1,2,3
order by count(*) desc limit 1 -- max active
