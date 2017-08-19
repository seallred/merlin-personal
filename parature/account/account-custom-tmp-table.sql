drop table camdf.parature_account_custom_tmp;

create table camdf.parature_account_custom_tmp (
	account_id bigint,
	account_custom_field_type varchar(20),
	account_custom_field_name varchar(256),
	account_custom_field_value vargraphic(16000)
)
data capture none 
compress no;

--call util.sp_grant;

-- ----------------------------------------------------------------------------
select count(*) from camdf.parature_account_custom_tmp with ur;
select * from camdf.parature_account_custom_tmp with ur;
