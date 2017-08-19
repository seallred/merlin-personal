#gzip -dS .gzip accounts.csv.gzip

db2 connect to etl2sf
db2 -v truncate table camdf.parature_account_tmp immediate;

echo Processing... 
rm accounts.msg 2>/dev/null

db2 import from accounts.csv of del modified by delprioritychar timestampformat=\"YYYY-MM-DD HH:MM:SS.UUUUUU\" commitcount 5000 skipcount 1 messages accounts.msg insert into camdf.parature_account_tmp

