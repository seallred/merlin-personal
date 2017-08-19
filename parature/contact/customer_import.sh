echo "Loading data to CAMDF.PARATURE_CONTACT..."
gzip -d CAMDF.PARATURE_CONTACT_PRESTG.IXF.gz

db2 connect to etl2sf
db2 "IMPORT FROM CAMDF.PARATURE_CONTACT_PRESTG.IXF OF IXF COMMITCOUNT 50000 
INSERT INTO CAMDF.PARATURE_CONTACT(
   customer_id, email, first_name, last_name, role, status, 
   phone_number, alternate_phone_number, contact_country,
   preferred_language, timezone, account_id, 
   date_created, date_modified, date_last_visited)" >> IMPORT_PARATURE_CONTACT_PRESTG.ERR
gzip CAMDF.PARATURE_CONTACT_PRESTG.IXF
