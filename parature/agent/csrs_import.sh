#gzip -dS .gzip csrs.csv.gzip

db2 connect to etl2sf
db2 -v truncate table srdf.parature_csr_tmp immediate;
db2 commit work;

echo Processing... 
rm csrs.msg 2>/dev/null

db2 import from csrs.csv of del modified by delprioritychar timestampformat=\"YYYY-MM-DD HH:MM:SS.UUUUUU\" commitcount 5000 skipcount 1 messages csrs.msg insert into srdf.parature_csr_tmp

