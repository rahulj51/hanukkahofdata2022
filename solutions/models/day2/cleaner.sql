{{
    config (
        schema = "day2"
    )
}}

--split name into an array of strings separated by whitespace
with name_array as (
    select
        customerid,
        name,
        phone,
        string_to_array(name, ' ') as name_as_array
    from {{ ref('customers') }}
),

--get the initials
initials as (
    select
        customerid,
        name,
        phone,
        array_agg(substring(str, 1,1)) as initials

    from (select *, unnest(name_as_array) as str from name_array) as a

    group by customerid, name, phone

),

--filter those that have 'JD' as their initials
candidates as (
    select
        customerid,
        name,
        phone
    from initials
    where array_to_string(initials, '') = 'JD'
)

-- filter those that purchased coffee or bagel in 2017
select
    c.customerid,
    c.name,
    c.phone,
    o.orderid,
    array_agg(p.description) as items
from {{ ref('orders') }} o
    join candidates c on o.customerid = c.customerid
    join {{ ref('orders_items') }} oi on o.orderid = oi.orderid
    join {{ ref('products') }} p on oi.sku = p.sku
where date_part('year', ordered_at) = 2017
and lower(description) ~* 'coffee|bagel'
group by c.customerid, c.name, c.phone, o.orderid


--manually inspect to find the specific customer. Some product names can be ambigious