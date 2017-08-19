db2 connect to etl2sf
db2 -v truncate table camdf.parature_contact_tmp immediate;
for f in $(ls *.csv1); do
  echo Processing $f
  rm ${f}.msg 2>/dev/null
  db2 import from $f of del modified by delprioritychar timestampformat=\"M/D/YYYY H:MM:SS TT\" commitcount 5000 skipcount 1 messages ${f}.msg insert into camdf.parature_contact_tmp
  if [ $? -gt 2 ]; then
    echo ERROR!!!!!!!
    break
  fi
done

