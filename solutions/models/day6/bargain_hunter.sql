{{
    config (
        schema = "day6"
    )
}}


with discounted_orders as (
    select
        c.customerid,
        c.name,
        c.phone
    from {{ ref('customers') }} c
    join {{ ref('orders') }} o on c.customerid =o.customerid
    join {{ ref('orders_items') }} oi on o.orderid = oi.orderid
    join {{ ref('products') }} p on oi.sku = p.sku

    where oi.unit_price <= p.wholesale_cost  -- unit price is less or equal to cost price

)

select name, phone from discounted_orders group by name, phone order by count(*) desc limit 1