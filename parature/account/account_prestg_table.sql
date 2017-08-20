drop table camdf.parature_account_prestg;

create table camdf.parature_account_prestg (
	account_id bigint,
	account_name vargraphic(256),
	date_created timestamp,
	date_updated timestamp
)
data capture none 
compress no;

CREATE INDEX "CAMDF"."PARATURE_ACCOUNT_PRESTG1"
	ON "CAMDF"."PARATURE_ACCOUNT_PRESTG"
	("ACCOUNT_ID"		ASC)
	MINPCTUSED 0
	ALLOW REVERSE SCANS
	PAGE SPLIT SYMMETRIC
	COLLECT SAMPLED DETAILED STATISTICS
	COMPRESS NO;

--call util.sp_grant;

-- ----------------------------------------------------------------------------
select count(*) from camdf.parature_account_prestg with ur;
select * from camdf.parature_account_prestg with ur;