drop table camdf.parature_account_custom_prestg;

create table camdf.parature_account_custom_prestg (
	account_id bigint,
	account_custom_field_type varchar(20),
	account_custom_field_name varchar(256),
	account_custom_field_value vargraphic(16000)
)
data capture none 
compress no;

CREATE INDEX "CAMDF"."PARATURE_ACCOUNT_CUSTOM_PRESTG1"
	ON "CAMDF"."PARATURE_ACCOUNT_CUSTOM_PRESTG"
	("ACCOUNT_ID"		ASC)
	MINPCTUSED 0
	ALLOW REVERSE SCANS
	PAGE SPLIT SYMMETRIC
	COLLECT SAMPLED DETAILED STATISTICS
	COMPRESS NO;

--call util.sp_grant;

-- ----------------------------------------------------------------------------
select count(*) from camdf.parature_account_custom_prestg with ur;
select * from camdf.parature_account_custom_prestg with ur;
