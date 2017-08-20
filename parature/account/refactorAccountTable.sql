-- Just renamed previous table for now
-- rename table camdf.parature_account to parature_account_old;

--"SAP_ACCOUNT_NAME" VARGRAPHIC(256), 
--"SAP_SITE_ID" VARCHAR(40), 
--"PREMIUM_ACCOUNT_REP" VARGRAPHIC(256), 
--"PA_PRIMARY_CONTACT" VARGRAPHIC(256), 
--"PA_PRIMARY_CONTACT_EMAIL" VARGRAPHIC(128), 
--"CREATED_BY" VARGRAPHIC(128), 
--"LAST_MODIFIED_BY" VARGRAPHIC(128), 

--select distinct account_custom_field_name, account_custom_field_type from camdf.parature_account_custom_prestg with ur;

select max(length(account_custom_field_value)) from camdf.parature_account_custom_prestg where account_custom_field_name = 'ALERT_COMMENTS' with ur;
select max(length(account_custom_field_value)) from camdf.parature_account_custom_prestg where account_custom_field_name = 'ALERT_INDICATOR' with ur;

DROP TABLE "CAMDF"."PARATURE_ACCOUNT";

CREATE TABLE "CAMDF"."PARATURE_ACCOUNT" (
   "ACCOUNT_ID" BIGINT NOT NULL, 
   "ACCOUNT_NAME" VARGRAPHIC(256),    
   "IBM_CUST_NUM" VARCHAR(7), 
   "TYPE" VARCHAR(40), 
   "CUSTOMER_HUB_ID" VARCHAR(256), 
   "CUSTOMER_HUB_KEY" VARCHAR(256),    
   "CLIENT_STREET" VARGRAPHIC(120), 
   "CLIENT_CITY" VARGRAPHIC(40), 
   "CLIENT_STATE_REGION" VARGRAPHIC(64), 
   "CLIENT_POSTAL_CODE" VARCHAR(20), 
   "CLIENT_COUNTRY" VARCHAR(256), 
   "PREMIUM_ACCOUNT" VARCHAR(10), 
   "ALERT_INDICATOR" VARCHAR(10),
   "ALERT_COMMENTS" VARCHAR(5120),
   "DATE_CREATED" TIMESTAMP, 
   "DATE_LAST_MODIFIED" TIMESTAMP,    
   "SOURCE_ID" VARCHAR(40), 
   "CREATE_USER" VARGRAPHIC(127), 
   "CREATE_DATETIME" TIMESTAMP NOT NULL DEFAULT CURRENT TIMESTAMP, 
   "UPDATE_USER" VARGRAPHIC(127), 
   "UPDATE_DATETIME" TIMESTAMP NOT NULL DEFAULT CURRENT TIMESTAMP, 
   "CREATE_SRC_APPL" VARCHAR(127) NOT NULL DEFAULT 'INTSYS', 
   "UPDATE_SRC_APPL" VARCHAR(127) NOT NULL DEFAULT 'INTSYS',
   "MIGRATION_ENABLED" SMALLINT, 
   "MIGRATION_DATETIME" TIMESTAMP,
   "MIGRATION_NOTES" VARCHAR(1024)		
	)
	DATA CAPTURE NONE 
	COMPRESS NO;

CREATE INDEX "CAMDF"."PARATURE_ACCOUNT_PK"
	ON "CAMDF"."PARATURE_ACCOUNT"
	("ACCOUNT_ID"		ASC)
	MINPCTUSED 0
	ALLOW REVERSE SCANS
	PAGE SPLIT SYMMETRIC
	COLLECT SAMPLED DETAILED STATISTICS
	COMPRESS NO;

--ALTER TABLE "CAMDF"."PARATURE_ACCOUNT" DROP CONSTRAINT "PARATURE_ACCOUNT_PK";

ALTER TABLE "CAMDF"."PARATURE_ACCOUNT" ADD CONSTRAINT "PARATURE_ACCOUNT_PK" PRIMARY KEY
	("ACCOUNT_ID");

DROP TRIGGER "CAMDF"."T_IB_PARATURE_ACCOUNT"; 
CREATE TRIGGER "CAMDF"."T_IB_PARATURE_ACCOUNT" 
	BEFORE INSERT ON "CAMDF"."PARATURE_ACCOUNT"
	REFERENCING  NEW AS N
	FOR EACH ROW
	NOT SECURED
BEGIN ATOMIC
   SET N.CREATE_DATETIME = CURRENT TIMESTAMP;--
   SET N.UPDATE_DATETIME = CURRENT TIMESTAMP;--
   SET N.UPDATE_USER = N.CREATE_USER;--
   IF (N.CREATE_USER IS NULL OR RTRIM(N.CREATE_USER) = '') THEN
      SET N.CREATE_USER = USER;--
      SET N.UPDATE_USER = USER;--
   END IF;--
END;

DROP TRIGGER "CAMDF"."T_UB_PARATURE_ACCOUNT";
CREATE TRIGGER "CAMDF"."T_UB_PARATURE_ACCOUNT" 
	BEFORE UPDATE ON "CAMDF"."PARATURE_ACCOUNT"
	REFERENCING  NEW AS N
	FOR EACH ROW
	NOT SECURED
begin atomic
  set n.update_datetime = current timestamp;--
  if nvl(rtrim(n.update_user), '') = '' then
    set n.update_user = user;  --
  end if; --
  if nvl(rtrim(n.update_src_appl), '') = '' then
    set n.update_src_appl = 'INTSYS';  --
  end if; --
end;