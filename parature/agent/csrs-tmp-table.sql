drop table srdf.parature_csr_tmp;

create table srdf.parature_csr_tmp (
	csr_id bigint,
	date_created timestamp,
	email vargraphic(128),
	fax varchar(40),
	full_name vargraphic(256),
	phone_1 varchar(40),
	phone_2 varchar(40),
	screen_name varchar(40),
	timezone varchar(64),
	last_updated timestamp
)
data capture none 
compress no;

--call util.sp_grant;

-- ----------------------------------------------------------------------------
select count(*) from srdf.parature_csr_tmp with ur;
select * from srdf.parature_csr_tmp with ur;