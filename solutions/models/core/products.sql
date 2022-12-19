{{
    config (
        schema = "core"
    )
}}

select
    sku,
    "desc" as description,
    wholesale_cost::float
from {{ source('raw', 'products') }}