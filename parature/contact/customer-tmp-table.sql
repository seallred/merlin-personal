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

CREATE INDEX "CAMDF"."PARATURE_CONTACT_PRESTG1"
	ON "CAMDF"."PARATURE_CONTACT_PRESTG"
	("CUSTOMER_ID"		ASC)
	MINPCTUSED 0
	ALLOW REVERSE SCANS
	PAGE SPLIT SYMMETRIC
	COLLECT SAMPLED DETAILED STATISTICS
	COMPRESS NO;

CREATE INDEX "CAMDF"."PARATURE_CONTACT_PRESTG2"
	ON "CAMDF"."PARATURE_CONTACT_PRESTG"
	("ACCOUNT_ID"		ASC)
	MINPCTUSED 0
	ALLOW REVERSE SCANS
	PAGE SPLIT SYMMETRIC
	COLLECT SAMPLED DETAILED STATISTICS
	COMPRESS NO;

--call util.sp_grant;

-- ----------------------------------------------------------------------------
select count(*) from camdf.parature_contact_prestg with ur;
select * from camdf.parature_contact_prestg with ur;