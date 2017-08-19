drop table srdf.parature_ticket_custom_tmp;

create table srdf.parature_ticket_custom_tmp (
	ticket_id bigint,
	ticket_custom_field_type varchar(20),
	ticket_custom_field_name varchar(256),
	ticket_custom_field_value vargraphic(16000)
)
data capture none 
compress no;

--call util.sp_grant;

-- ----------------------------------------------------------------------------
select count(*) from srdf.parature_ticket_custom_tmp with ur;
select * from srdf.parature_ticket_custom_tmp with ur;
