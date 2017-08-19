-- Change suffix from tmp to prestg

rename table camdf.parature_account_tmp to parature_account_prestg;
rename table camdf.parature_account_custom_tmp to parature_account_custom_prestg;
rename table srdf.parature_csr_tmp to parature_csr_prestg;
rename table camdf.parature_contact_tmp to parature_contact_prestg;
rename table camdf.parature_contact_custom_tmp to parature_contact_custom_prestg;
rename table srdf.parature_ticket_tmp to parature_ticket_prestg;
rename table srdf.parature_ticket_custom_tmp to parature_ticket_custom_prestg;