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
    date(birthdate) as birthdate,
    phone
from {{ source('raw', 'customers') }}