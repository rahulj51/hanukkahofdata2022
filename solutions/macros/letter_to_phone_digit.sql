{% macro create_letter_to_phone_digit_function() %}

CREATE OR REPLACE FUNCTION {{target.schema}}.lookup_phone_code(c char) RETURNS integer AS $$
    select
        case
        when c in ('a', 'b', 'c') then 2
        when c in ('d','e','f') then 3
        when c in ('g','h','i') then 4
        when c in ('j','k','l') then 5
        when c in ('m','n','o') then 6
        when c in ('p','q','r', 's') then 7
        when c in ('t','u','v') then 8
        when c in ('w','x','y', 'z') then 9
        end
$$ LANGUAGE SQL;


{% endmacro %}