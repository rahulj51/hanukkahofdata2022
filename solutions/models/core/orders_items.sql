{{
    config (
        schema = "core"
    )
}}

select
    orderid,
    sku,
    qty::int as quantity,
    unit_price::float
from {{ source('raw', 'orders_items') }}