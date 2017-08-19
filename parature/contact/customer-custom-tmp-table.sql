drop table camdf.parature_contact_custom_prestg;

create table camdf.parature_contact_custom_prestg (
	customer_id bigint,
	customer_custom_field_type varchar(20),
	customer_custom_field_name varchar(256),
	customer_custom_field_value vargraphic(16000)	
)
data capture none 
compress no;

CREATE INDEX "CAMDF"."PARATURE_CONTACT_CUSTOM_PRESTG1"
	ON "CAMDF"."PARATURE_CONTACT_CUSTOM_PRESTG"
	("CUSTOMER_ID"		ASC)
	MINPCTUSED 0
	ALLOW REVERSE SCANS
	PAGE SPLIT SYMMETRIC
	COLLECT SAMPLED DETAILED STATISTICS
	COMPRESS NO;

--call util.sp_grant;

-- ----------------------------------------------------------------------------
select count(*) from camdf.parature_contact_custom_prestg with ur;
select * from camdf.parature_contact_custom_prestg with ur;