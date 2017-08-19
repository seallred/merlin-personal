#gzip -dS .gzip tickets2015.csv.gzip

db2 connect to etl2sf
db2 -v truncate table srdf.parature_ticket_tmp immediate;
db2 commit work;

echo Processing... 
rm tickets.msg 2>/dev/null

db2 import from tickets2015.csv of del modified by delprioritychar timestampformat=\"YYYY-MM-DD HH:MM:SS.UUUUUU\" commitcount 5000 skipcount 1 messages tickets.msg insert into srdf.parature_ticket_tmp

