{{
    config (
        schema = "core"
    )
}}

select
    customerid,
    name,
    address,
    citystatezip,
    date(birthdate),
    phone
from {{ source('raw', 'customers') }}