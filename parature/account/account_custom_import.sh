#gzip -dS .gzip account_custom-test.csv.gzip

db2 connect to etl2sf
db2 -v truncate table camdf.parature_account_custom_tmp immediate;
db2 commit work;

echo Processing... 
rm account_custom.msg 2>/dev/null

db2 import from account_custom-test.csv of del modified by delprioritychar timestampformat=\"YYYY-MM-DD HH:MM:SS.UUUUUU\" commitcount 5000 skipcount 1 messages account_custom.msg insert into camdf.parature_account_custom_tmp

