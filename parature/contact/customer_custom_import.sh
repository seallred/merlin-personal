#gzip -dS .gzip customer_custom.csv.gzip

db2 connect to etl2sf
db2 -v truncate table camdf.parature_contact_custom_tmp immediate;
db2 commit work;

echo Processing $f
rm customer_custom.msg 2>/dev/null

db2 import from customer_custom.csv of del modified by delprioritychar timestampformat=\"YYYY-MM-DD HH:MM:SS.UUUUUU\" commitcount 5000 skipcount 1 messages customer_custom.msg insert into camdf.parature_contact_custom_tmp

