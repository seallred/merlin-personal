#gzip -dS .gzip customer.csv.gzip

db2 connect to etl2sf
db2 -v truncate table camdf.parature_contact_prestg immediate;
db2 commit work;

echo Processing $f
rm customer.msg 2>/dev/null
#db2 import from customer.csv of del modified by delprioritychar timestampformat=\"M/D/YYYY H:MM:SS TT\" commitcount 5000 skipcount 1 messages customer.msg insert into camdf.parature_contact_prestg

db2 import from customer.csv of del modified by delprioritychar timestampformat=\"YYYY-MM-DD HH:MM:SS.UUUUUU\" commitcount 5000 skipcount 1 messages customer.msg insert into camdf.parature_contact_prestg

