-- Map and load parature_contact_prestg to parature_contact

select count(*) from camdf.parature_contact with ur;
select * from camdf.parature_contact fetch first 100 rows only;
select count(*) from camdf.parature_contact_prestg;
select * from camdf.parature_contact_prestg fetch first 100 rows only;

select distinct customer_custom_field_name, customer_custom_field_type from camdf.parature_contact_custom_prestg with ur;

-- Issue 1. Customer fields that are too long
select 'phone_number',count(*) from camdf.parature_contact_custom_prestg cc where customer_custom_field_name = 'PHONE_NUMBER' and length(rtrim(customer_custom_field_value)) > 50 union
select 'alternate_phone_number',count(*) from camdf.parature_contact_custom_prestg cc where customer_custom_field_name = 'ALTERNATE_PHONE_NUMBER' and length(rtrim(customer_custom_field_value)) > 40 union
select 'contact_country',count(*) from camdf.parature_contact_custom_prestg cc where customer_custom_field_name = 'CONTACT_COUNTRY' and length(rtrim(customer_custom_field_value)) > 256 union
select 'preferred_language',count(*) from camdf.parature_contact_custom_prestg cc where customer_custom_field_name = 'PREFERRED_LANGUAGE' and length(rtrim(customer_custom_field_value)) > 64 union
select 'timezone',count(*) from camdf.parature_contact_custom_prestg cc where customer_custom_field_name = 'TIMEZONE' and length(rtrim(customer_custom_field_value)) > 64 

--alternate_phone_number	0
--contact_country	0
--preferred_language	0
--timezone	0
--phone_number	29

select substr(customer_custom_field_value,1,50), rtrim(customer_custom_field_value) from camdf.parature_contact_custom_prestg cc where customer_custom_field_name = 'PHONE_NUMBER' and length(rtrim(customer_custom_field_value)) > 50 with ur; 

-- Issue 2. Some contacts had more than one custom phone number field for a given value
select customer_id, count(*) from camdf.parature_contact_custom_prestg cc where customer_custom_field_name = 'PHONE_NUMBER' and customer_custom_field_value is not null group by customer_id having count(*) > 1;
select customer_id, count(*) from camdf.parature_contact_custom_prestg cc where customer_custom_field_name = 'ALTERNATE_PHONE_NUMBER'  and customer_custom_field_value is not null group by customer_id having count(*) > 1;
select customer_id, count(*) from camdf.parature_contact_custom_prestg cc where customer_custom_field_name = 'CONTACT_COUNTRY'  and customer_custom_field_value is not null group by customer_id having count(*) > 1;
select customer_id, count(*) from camdf.parature_contact_custom_prestg cc where customer_custom_field_name = 'PREFERRED_LANGUAGE'  and customer_custom_field_value is not null group by customer_id having count(*) > 1;
select customer_id, count(*) from camdf.parature_contact_custom_prestg cc where customer_custom_field_name = 'TIMEZONE'  and customer_custom_field_value is not null group by customer_id having count(*) > 1;

select * from camdf.parature_contact_custom_prestg where CUSTOMER_ID IN (7839171,7839174,7839175);

-- Issue 3. Bad character in this causing issue with insert.  Truncated.
select * from camdf.parature_contact_custom_prestg where CUSTOMER_CUSTOM_FIELD_VALUE like '900 906 076%' with ur;  -- had to update this one

select * from camdf.parature_contact where CUSTOMER_ID IN (7839171,7839174,7839175);


--truncate table camdf.parature_contact immediate;

insert into camdf.parature_contact (
   customer_id, email, first_name, last_name, role, status, 
   phone_number, alternate_phone_number, contact_country,
   preferred_language, timezone, account_id, 
   date_created, date_modified, date_last_visited)
select distinct 
   c.customer_id, email, first_name, last_name, customer_role, status, 
   (select substr(customer_custom_field_value,1,45) from camdf.parature_contact_custom_prestg cc where cc.customer_id = c.customer_id and customer_custom_field_name = 'PHONE_NUMBER' and customer_custom_field_value is not null fetch first row only) as phone_number,
   (select substr(customer_custom_field_value,1,40) from camdf.parature_contact_custom_prestg cc where cc.customer_id = c.customer_id and customer_custom_field_name = 'ALTERNATE_PHONE_NUMBER' and customer_custom_field_value is not null) as alternate_phone_number,
   (select substr(customer_custom_field_value,1,256) from camdf.parature_contact_custom_prestg cc where cc.customer_id = c.customer_id and customer_custom_field_name = 'CONTACT_COUNTRY' and customer_custom_field_value is not null) as contact_country,
   (select substr(customer_custom_field_value,1,64) from camdf.parature_contact_custom_prestg cc where cc.customer_id = c.customer_id and customer_custom_field_name = 'PREFERRED_LANGUAGE' and customer_custom_field_value is not null) as preferred_language,
   (select substr(customer_custom_field_value,1,64) from camdf.parature_contact_custom_prestg cc where cc.customer_id = c.customer_id and customer_custom_field_name = 'TIMEZONE' and customer_custom_field_value is not null) as timezone,
   account_id, 
   date_created, date_updated, date_visited
from camdf.parature_contact_prestg c
where not exists (select 1 from camdf.parature_contact t where c.customer_id = t.customer_id)
fetch first 250000 rows only;