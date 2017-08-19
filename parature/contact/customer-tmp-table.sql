drop table camdf.parature_contact_prestg;

create table camdf.parature_contact_prestg (
	customer_id bigint,
	account_id bigint,
	customer_role varchar(50),
	email vargraphic(128),
	first_name vargraphic(128),
	last_name vargraphic(128),
	status varchar(20),
	date_created timestamp,
	date_updated timestamp,
	date_visited timestamp
)
data capture none 
compress no;

--call util.sp_grant;

-- ----------------------------------------------------------------------------
select count(*) from camdf.parature_contact_prestg with ur;
select * from camdf.parature_contact_prestg with ur;