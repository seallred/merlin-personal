drop table camdf.parature_account_tmp;

create table camdf.parature_account_tmp (
	account_id bigint,
	account_name vargraphic(256),
	date_created timestamp,
	date_updated timestamp
)
data capture none 
compress no;

--call util.sp_grant;

-- ----------------------------------------------------------------------------
select count(*) from camdf.parature_account_tmp with ur;
select * from camdf.parature_account_tmp with ur;