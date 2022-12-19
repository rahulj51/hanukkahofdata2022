{{
    config (
        schema = "core"
    )
}}

select
    orderid,
    customerid,
    to_timestamp(ordered,'YYYY-MM-DD hh24:mi:ss') as ordered_at,
    to_timestamp(shipped,'YYYY-MM-DD hh24:mi:ss') as shipped_at,
    items,
    total::float as total
from {{ source('raw', 'orders') }}