{{
    config (
        schema = "day3"
    )
}}

--we know this from day-2
{% set cleaner_id = '4164' %}

--the guy lives in cleaner's neighborhood
with cleaner_neighborhood as (
    select citystatezip
    from {{ ref('customers') }}
    where customerid= '{{ cleaner_id }}'
),

--he is aries
aries_customers as (
    select * from {{ ref('customers') }} c
    where ((date_part('month', c.birthdate) = 3 and date_part('day', c.birthdate) >= 20)
     or (date_part('month', c.birthdate) = 4 and date_part('day', c.birthdate) <= 20))
),

--born in the year of dog
years_of_dog as (
    select yr from generate_series(1922, 2017, 12) as s(yr)
)


select *
from aries_customers c
where date_part('year', c.birthdate) in (select yr from years_of_dog)
and c.citystatezip = (select citystatezip from cleaner_neighborhood)

