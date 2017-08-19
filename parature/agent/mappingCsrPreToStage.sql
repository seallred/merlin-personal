-- Map and load parature_csr_prestg to parature_csr

select count(*) from srdf.parature_csr;
select * from srdf.parature_csr fetch first 100 rows only;

--truncate table srdf.parature_csr immediate;

insert into srdf.parature_csr (
   csr_id, email, screen_name, full_name, 
   phone_number1, phone_number2, fax, 
   timezone, date_created, date_updated )
select 
   csr_id, email, screen_name, full_name, 
   phone_1, phone_2, fax, timezone, date_created, last_updated
from srdf.parature_csr_prestg
;