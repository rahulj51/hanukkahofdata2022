{{
    config (
        schema = "day1"
    )
}}

with name_array as (
    select string_to_array(name, ' ') as name_as_array,
    name,
    phone
    from {{ ref('customers') }}
),

candidates as (
    select
        regexp_split_to_array(lower(name_as_array[array_upper(name_as_array, 1)]), '') as last_name_chars,
        name,
        phone
  from name_array
  where length(name_as_array[array_upper(name_as_array, 1)]) = 10 -- only those where last name has enough digits for a phone no.
),

last_name_as_digits as (

    select
        a.name,
        a.phone,
        array_agg((lookup_phone_code(a.ch))) as codes from (
            select *, unnest(last_name_chars) as ch from candidates
        ) as a

    group by a.name, a.phone
)

select name, phone
from last_name_as_digits
where array_to_string(codes,'') = replace(phone,'-','')