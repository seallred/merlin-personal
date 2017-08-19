echo "Exporting data from CAMDF.PARATURE_ACCOUNT..."
db2 "EXPORT TO CAMDF.PARATURE_ACCOUNT.IXF OF IXF SELECT * FROM CAMDF.PARATURE_ACCOUNT" >> camdf_export.err
gzip CAMDF.PARATURE_ACCOUNT.IXF
echo "Exporting data from CAMDF.PARATURE_ACCOUNT_CUSTOM_PRESTG..."
db2 "EXPORT TO CAMDF.PARATURE_ACCOUNT_CUSTOM_PRESTG.IXF OF IXF SELECT * FROM CAMDF.PARATURE_ACCOUNT_CUSTOM_PRESTG" >> camdf_export.err
gzip CAMDF.PARATURE_ACCOUNT_CUSTOM_PRESTG.IXF
echo "Exporting data from CAMDF.PARATURE_ACCOUNT_PRESTG..."
db2 "EXPORT TO CAMDF.PARATURE_ACCOUNT_PRESTG.IXF OF IXF SELECT * FROM CAMDF.PARATURE_ACCOUNT_PRESTG" >> camdf_export.err
gzip CAMDF.PARATURE_ACCOUNT_PRESTG.IXF
echo "Exporting data from CAMDF.PARATURE_ASSET..."
db2 "EXPORT TO CAMDF.PARATURE_ASSET.IXF OF IXF SELECT * FROM CAMDF.PARATURE_ASSET" >> camdf_export.err
gzip CAMDF.PARATURE_ASSET.IXF
echo "Exporting data from CAMDF.PARATURE_CONTACT..."
db2 "EXPORT TO CAMDF.PARATURE_CONTACT.IXF OF IXF SELECT * FROM CAMDF.PARATURE_CONTACT" >> camdf_export.err
gzip CAMDF.PARATURE_CONTACT.IXF
echo "Exporting data from CAMDF.PARATURE_CONTACT_CUSTOM_PRESTG..."
db2 "EXPORT TO CAMDF.PARATURE_CONTACT_CUSTOM_PRESTG.IXF OF IXF SELECT * FROM CAMDF.PARATURE_CONTACT_CUSTOM_PRESTG" >> camdf_export.err
gzip CAMDF.PARATURE_CONTACT_CUSTOM_PRESTG.IXF
echo "Exporting data from CAMDF.PARATURE_CONTACT_PRESTG..."
db2 "EXPORT TO CAMDF.PARATURE_CONTACT_PRESTG.IXF OF IXF SELECT * FROM CAMDF.PARATURE_CONTACT_PRESTG" >> camdf_export.err
gzip CAMDF.PARATURE_CONTACT_PRESTG.IXF
echo "Exporting data from CAMDF.PARATURE_PRODUCT..."
db2 "EXPORT TO CAMDF.PARATURE_PRODUCT.IXF OF IXF SELECT * FROM CAMDF.PARATURE_PRODUCT" >> camdf_export.err
gzip CAMDF.PARATURE_PRODUCT.IXF
echo "Exporting data from SRDF.PARATURE_CSR..."
db2 "EXPORT TO SRDF.PARATURE_CSR.IXF OF IXF SELECT * FROM SRDF.PARATURE_CSR" >> srdf_export.err
gzip SRDF.PARATURE_CSR.IXF
echo "Exporting data from SRDF.PARATURE_CSR_PRESTG..."
db2 "EXPORT TO SRDF.PARATURE_CSR_PRESTG.IXF OF IXF SELECT * FROM SRDF.PARATURE_CSR_PRESTG" >> srdf_export.err
gzip SRDF.PARATURE_CSR_PRESTG.IXF
echo "Exporting data from SRDF.PARATURE_TICKET..."
db2 "EXPORT TO SRDF.PARATURE_TICKET.IXF OF IXF SELECT * FROM SRDF.PARATURE_TICKET" >> srdf_export.err
gzip SRDF.PARATURE_TICKET.IXF
echo "Exporting data from SRDF.PARATURE_TICKET_CUSTOM_PRESTG..."
db2 "EXPORT TO SRDF.PARATURE_TICKET_CUSTOM_PRESTG.IXF OF IXF SELECT * FROM SRDF.PARATURE_TICKET_CUSTOM_PRESTG" >> srdf_export.err
gzip SRDF.PARATURE_TICKET_CUSTOM_PRESTG.IXF
echo "Exporting data from SRDF.PARATURE_TICKET_HISTORY..."
db2 "EXPORT TO SRDF.PARATURE_TICKET_HISTORY.IXF OF IXF SELECT * FROM SRDF.PARATURE_TICKET_HISTORY" >> srdf_export.err
gzip SRDF.PARATURE_TICKET_HISTORY.IXF
echo "Exporting data from SRDF.PARATURE_TICKET_PRESTG..."
db2 "EXPORT TO SRDF.PARATURE_TICKET_PRESTG.IXF OF IXF SELECT * FROM SRDF.PARATURE_TICKET_PRESTG" >> srdf_export.err
gzip SRDF.PARATURE_TICKET_PRESTG.IXF