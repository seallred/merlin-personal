drop table srdf.parature_ticket_tmp;

create table srdf.parature_ticket_tmp (
	ticket_id bigint,
	ticket_number varchar(32),
	department_id bigint,
	ticket_status varchar(40),
	ticket_origin varchar(64),
	summary vargraphic(15360),
	assigned_to_csr_id bigint,
	hide_from_customer varchar(10),
	parent_ticket_id bigint,
	service_offering varchar(512),
	severity varchar(20),
	priority varchar(20),
	date_created timestamp,
	date_updated timestamp
)
data capture none 
compress no;

--call util.sp_grant;

-- ----------------------------------------------------------------------------
select count(*) from srdf.parature_ticket_tmp with ur;
select * from srdf.parature_ticket_tmp with ur;