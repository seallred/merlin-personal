#gzip -dS .gzip ticket_custom2015.csv.gzip

db2 connect to etl2sf
db2 -v truncate table srdf.parature_ticket_custom_tmp immediate;
db2 commit work;

echo Processing... 
rm tickets_custom.msg 2>/dev/null

db2 import from ticket_custom2015.csv of del modified by delprioritychar timestampformat=\"YYYY-MM-DD HH:MM:SS.UUUUUU\" commitcount 5000 skipcount 1 messages tickets_custom.msg insert into srdf.parature_ticket_custom_tmp

