echo "Exporting data from CAMDF.PARATURE_ACCOUNT..."

db2 connect to etl2sf
db2 "EXPORT TO CAMDF.PARATURE_ACCOUNT.IXF OF IXF 
select distinct 
ap.account_id, account_name,
cast((select substr(account_custom_field_value,1,7) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'ICN_' and account_custom_field_value is not null) as varchar(7)) as ICN,
cast((select substr(account_custom_field_value,1,40) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'TYPE' and account_custom_field_value is not null) as varchar(40)) as TYPE,
cast((select substr(account_custom_field_value,1,255) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'CUSTOMER_HUB_ID' and account_custom_field_value is not null) as varchar(256)) as CUSTOMER_HUB_ID,
cast((select substr(account_custom_field_value,1,255) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'CUSTOMER_HUB_KEY' and account_custom_field_value is not null) as varchar(256)) as CUSTOMER_HUB_KEY,
cast((select substr(account_custom_field_value,1,120) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'CLIENT_STREET' and account_custom_field_value is not null)  as vargraphic(120)) as CLIENT_STREET,   
cast((select substr(account_custom_field_value,1,64) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'CLIENT_STATE_REGION' and account_custom_field_value is not null) as vargraphic(64)) as CLIENT_STATE_REGION,
cast((select substr(account_custom_field_value,1,256) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'CLIENT_COUNTRY' and account_custom_field_value is not null) as varchar(256)) as CLIENT_COUNTRY,
cast((select substr(account_custom_field_value,1,10) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'PREMIUM_ACCOUNT' and account_custom_field_value is not null) as varchar(10)) as PREMIUM_ACCOUNT,
cast((select substr(account_custom_field_value,1,10) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'ALERT_INDICATOR' and account_custom_field_value is not null) as varchar(10)) as ALERT_INDICATOR,      
cast((select substr(account_custom_field_value,1,5119) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'ALERT_COMMENTS' and account_custom_field_value is not null) as vargraphic(5120)) as ALERT_COMMENTS,
date_created, date_updated
from camdf.parature_account_prestg ap
fetch first 100 rows only" >> EXPORT_PARATURE_CONTACT.ERR

#gzip CAMDF.PARATURE_CONTACT_PRESTG.IXF


