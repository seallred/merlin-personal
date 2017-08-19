echo "Exporting data from CAMDF.PARATURE_CONTACT_PRESTG..."

db2 connect to etl2sf
db2 "EXPORT TO CAMDF.PARATURE_CONTACT_PRESTG.IXF OF IXF 
select distinct 
   c.customer_id, email, first_name, last_name, customer_role, status, 
   (select substr(customer_custom_field_value,1,50) from camdf.parature_contact_custom_prestg cc where cc.customer_id = c.customer_id and customer_custom_field_name = 'PHONE_NUMBER' and customer_custom_field_value is not null fetch first row only) as phone_number,
   (select substr(customer_custom_field_value,1,40) from camdf.parature_contact_custom_prestg cc where cc.customer_id = c.customer_id and customer_custom_field_name = 'ALTERNATE_PHONE_NUMBER' and customer_custom_field_value is not null fetch first row only) as alternate_phone_number,
   (select substr(customer_custom_field_value,1,256) from camdf.parature_contact_custom_prestg cc where cc.customer_id = c.customer_id and customer_custom_field_name = 'CONTACT_COUNTRY' and customer_custom_field_value is not null fetch first row only) as contact_country,
   (select substr(customer_custom_field_value,1,64) from camdf.parature_contact_custom_prestg cc where cc.customer_id = c.customer_id and customer_custom_field_name = 'PREFERRED_LANGUAGE' and customer_custom_field_value is not null fetch first row only) as preferred_language,
   (select substr(customer_custom_field_value,1,64) from camdf.parature_contact_custom_prestg cc where cc.customer_id = c.customer_id and customer_custom_field_name = 'TIMEZONE' and customer_custom_field_value is not null) as timezone,
   account_id, 
   date_created, date_updated, date_visited
FROM CAMDF.PARATURE_CONTACT_PRESTG C" >> EXPORT_PARATURE_CONTACT_PRESTG.ERR
gzip CAMDF.PARATURE_CONTACT_PRESTG.IXF


