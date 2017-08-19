-- ----------------------------------------------------------------------------
-- SQL used to generate export and import statments for tables in a schema
--
-- Syntax of generated SQL will follow the examples below:
--
-- export to local.ixf of ixf select * from eem.locale
-- import from locale.ixf of ixf insert into eem.locale
--
-- ----------------------------------------------------------------------------

-- Generate export statements
SELECT 'echo "Exporting data from ' CONCAT
RTRIM(tabschema) CONCAT
'.' CONCAT
RTRIM(tabname) CONCAT
'..."' CONCAT
X'0A' CONCAT
'db2 "EXPORT TO ' CONCAT
RTRIM(tabschema) CONCAT
'.' CONCAT
RTRIM(tabname) CONCAT
'.IXF OF IXF SELECT * FROM ' CONCAT
RTRIM(tabschema) CONCAT
'.' CONCAT
RTRIM(tabname) CONCAT
'" >> ' CONCAT
RTRIM(lower(tabschema)) CONCAT
'_export.err' CONCAT
X'0A' CONCAT
'gzip ' CONCAT
RTRIM(tabschema) CONCAT
'.' CONCAT
RTRIM(tabname) CONCAT
'.IXF'
FROM syscat.tables
WHERE tabschema in ('XSR','CAM','CAMDF', 'SRDF')
AND tabname LIKE 'PARATURE%'
--AND tabname = 'CFG_PROPERTIES'
--AND tabname in ('CUSTOMER_CNTRY_LIST_XREF','CUSTOMER_LOCATION', 'CUSTOMER_PROFILE', 'CUSTOMER_PROFILE_MACHINE_TYPE_XREF')
ORDER BY tabschema, tabname;

-- Generate import statements
SELECT 'echo "Loading data from ' CONCAT
RTRIM(tabschema) CONCAT
'.' CONCAT
RTRIM(tabname) CONCAT
'..."' CONCAT
X'0A' CONCAT
'gzip -d ' CONCAT
RTRIM(tabschema) CONCAT
'.' CONCAT
RTRIM(tabname) CONCAT
'.IXF.gz' CONCAT
X'0A' CONCAT
'db2 "IMPORT FROM ' CONCAT
RTRIM(tabschema) CONCAT
'.' CONCAT
RTRIM(tabname) CONCAT
'.IXF OF IXF COMMITCOUNT 4000 INSERT INTO ' CONCAT
RTRIM(tabschema) CONCAT
'.' CONCAT
RTRIM(tabname) CONCAT
'" >> ' CONCAT
RTRIM(lower(tabschema)) CONCAT
'_import.err' CONCAT
X'0A' CONCAT
'gzip ' CONCAT
RTRIM(tabschema) CONCAT
'.' CONCAT
RTRIM(tabname) CONCAT
'.IXF'
FROM syscat.tables
WHERE tabschema in ('XSR','CAM','CAMDF', 'SRDF')
AND tabname LIKE 'PARATURE%'
--AND tabname = 'CFG_PROPERTIES'
--AND tabname in ('CUSTOMER_CNTRY_LIST_XREF','CUSTOMER_LOCATION', 'CUSTOMER_PROFILE', 'CUSTOMER_PROFILE_MACHINE_TYPE_XREF')
ORDER BY tabschema, tabname;

