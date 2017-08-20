-- Map and load parature_account_prestg to parature_account

select count(*) from camdf.parature_account with ur;
select * from camdf.parature_account fetch first 100 rows only;
select count(*) from camdf.parature_account_prestg;
select * from camdf.parature_account_prestg fetch first 100 rows only;

select distinct account_custom_field_name, account_custom_field_type from camdf.parature_account_custom_prestg with ur;

-- Issue 1. Customer fields that are too long
select 'ALERT_COMMENTS',count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'ALERT_COMMENTS' and length(rtrim(account_custom_field_value)) > 5120 union
select 'ALERT_INDICATOR',count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'ALERT_INDICATOR' and length(rtrim(account_custom_field_value)) > 10 union
select 'CLIENT_COUNTRY',count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CLIENT_COUNTRY' and length(rtrim(account_custom_field_value)) > 256 union
select 'CLIENT_STATE_REGION',count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CLIENT_STATE_REGION' and length(rtrim(account_custom_field_value)) > 64 union
select 'CLIENT_STREET',count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CLIENT_STREET' and length(rtrim(account_custom_field_value)) > 120  union
select 'CUSTOMER_HUB_ID',count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CUSTOMER_HUB_ID' and length(rtrim(account_custom_field_value)) > 256  union
select 'CUSTOMER_HUB_KEY',count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CUSTOMER_HUB_KEY' and length(rtrim(account_custom_field_value)) > 256  union
select 'ICN_',count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'ICN_' and length(rtrim(account_custom_field_value)) > 10 union
select 'PREMIUM_ACCOUNT',count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'PREMIUM_ACCOUNT' and length(rtrim(account_custom_field_value)) > 10  union
select 'TYPE',count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'TYPE' and length(rtrim(account_custom_field_value)) > 64 

--ALERT_COMMENTS	0
--ALERT_INDICATOR	0
--CLIENT_COUNTRY	0
--CLIENT_STREET	0
--PREMIUM_ACCOUNT	0
--TYPE	0
--CLIENT_STATE_REGION	1
select * from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CLIENT_STATE_REGION' and length(rtrim(account_custom_field_value)) > 64 with ur;
--CUSTOMER_HUB_KEY	16
select * from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CUSTOMER_HUB_KEY' and length(rtrim(account_custom_field_value)) > 256 with ur;
--CUSTOMER_HUB_ID	20
select * from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CUSTOMER_HUB_ID' and length(rtrim(account_custom_field_value)) > 256 with ur;
--ICN_	822
select * from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'ICN_' and length(rtrim(account_custom_field_value)) > 10 with ur;

select substr(account_custom_field_value,1,50), rtrim(account_custom_field_value) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'PHONE_NUMBER' and length(rtrim(account_custom_field_value)) > 50 with ur; 

-- Issue 2. Some contacts had more than one custom phone number field for a given value
select 'ALERT_COMMENTS',account_id, count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'ALERT_COMMENTS' and account_custom_field_value is not null group by account_id having count(*) > 1;
select 'ALERT_INDICATOR',account_id, count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'ALERT_INDICATOR' and account_custom_field_value is not null group by account_id having count(*) > 1;
select 'CLIENT_COUNTRY',account_id, count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CLIENT_COUNTRY' and account_custom_field_value is not null group by account_id having count(*) > 1;
select 'CLIENT_STATE_REGION',account_id, count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CLIENT_STATE_REGION' and account_custom_field_value is not null group by account_id having count(*) > 1;
select 'CLIENT_STREET',account_id, count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CLIENT_STREET' and account_custom_field_value is not null group by account_id having count(*) > 1;
select 'CUSTOMER_HUB_ID',account_id, count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CUSTOMER_HUB_ID' and account_custom_field_value is not null group by account_id having count(*) > 1;
select 'CUSTOMER_HUB_KEY',account_id, count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CUSTOMER_HUB_KEY' and account_custom_field_value is not null group by account_id having count(*) > 1;
select 'ICN_',account_id, count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'ICN_' and account_custom_field_value is not null group by account_id having count(*) > 1;
select 'PREMIUM_ACCOUNT',account_id, count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'PREMIUM_ACCOUNT' and account_custom_field_value is not null group by account_id having count(*) > 1;
select 'TYPE',account_id, count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'TYPE' and account_custom_field_value is not null group by account_id having count(*) > 1;


--truncate table camdf.parature_account immediate;

insert into camdf.parature_account (
   account_id, account_name, ibm_cust_num, type, customer_hub_id, customer_hub_key,
   client_street, client_city, client_state_region, client_postal_code, client_country,
   premium_account, alert_indicator, alert_comments, 
   date_created, date_last_modified)
select distinct 
   ap.account_id, account_name,
   (select substr(account_custom_field_value,1,64) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'ICN_' and account_custom_field_value is not null) as ICN_,
   (select substr(account_custom_field_value,1,64) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'TYPE' and account_custom_field_value is not null) as TYPE,
   (select substr(account_custom_field_value,1,64) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'CUSTOMER_HUB_ID' and account_custom_field_value is not null) as CUSTOMER_HUB_ID,
   (select substr(account_custom_field_value,1,64) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'CUSTOMER_HUB_KEY' and account_custom_field_value is not null) as CUSTOMER_HUB_KEY,
   (select substr(account_custom_field_value,1,64) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'CLIENT_STREET' and account_custom_field_value is not null) as CLIENT_STREET,   
   -- client_city
   (select substr(account_custom_field_value,1,64) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'CLIENT_STATE_REGION' and account_custom_field_value is not null) as CLIENT_STATE_REGION,
   -- client_postal_code
   (select substr(account_custom_field_value,1,256) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'CLIENT_COUNTRY' and account_custom_field_value is not null) as CLIENT_COUNTRY,
   (select substr(account_custom_field_value,1,64) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'PREMIUM_ACCOUNT' and account_custom_field_value is not null) as PREMIUM_ACCOUNT,
   (select substr(account_custom_field_value,1,40) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'ALERT_INDICATOR' and account_custom_field_value is not null) as ALERT_INDICATOR,      
   (select substr(account_custom_field_value,1,45) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'ALERT_COMMENTS' and account_custom_field_value is not null) as ALERT_COMMENTS,
   date_created, date_updated
from camdf.parature_account_prestg ap
--where not exists (select 1 from camdf.parature_account a where a.account_id = ap.account_id)
fetch first 100 rows only;