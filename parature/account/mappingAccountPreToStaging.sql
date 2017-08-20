-- Map and load parature_account_prestg to parature_account

select count(*) from camdf.parature_account with ur; -- 2494773
select * from camdf.parature_account fetch first 100 rows only;
select count(*) from camdf.parature_account_prestg; -- 2494780
select * from camdf.parature_account_prestg fetch first 100 rows only;

select distinct account_custom_field_name, account_custom_field_type from camdf.parature_account_custom_prestg with ur;

-- Issue 1. Customer fields that are too long
select 'ALERT_COMMENTS',count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'ALERT_COMMENTS' and length(rtrim(account_custom_field_value)) > 5120 union
select 'ALERT_INDICATOR',count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'ALERT_INDICATOR' and length(rtrim(account_custom_field_value)) > 10 union
select 'CLIENT_COUNTRY',count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CLIENT_COUNTRY' and length(rtrim(account_custom_field_value)) > 256 union
select 'CLIENT_STATE_REGION',count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CLIENT_STATE_REGION' and length(rtrim(account_custom_field_value)) > 64 union
select 'CLIENT_STREET',count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CLIENT_STREET' and length(rtrim(account_custom_field_value)) > 120  union
select 'CUSTOMER_HUB_ID',count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CUSTOMER_HUB_ID' and length(rtrim(account_custom_field_value)) > 256  union
select 'CUSTOMER_HUB_KEY',count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CUSTOMER_HUB_KEY' and length(rtrim(account_custom_field_value)) > 256  union
select 'ICN_',count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'ICN_' and length(rtrim(account_custom_field_value)) > 10 union
select 'PREMIUM_ACCOUNT',count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'PREMIUM_ACCOUNT' and length(rtrim(account_custom_field_value)) > 10  union
select 'TYPE',count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'TYPE' and length(rtrim(account_custom_field_value)) > 64 

--ALERT_COMMENTS	0
--ALERT_INDICATOR	0
--CLIENT_COUNTRY	0
--CLIENT_STREET	0
--PREMIUM_ACCOUNT	0
--TYPE	0
--CLIENT_STATE_REGION	1
select * from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CLIENT_STATE_REGION' and length(rtrim(account_custom_field_value)) > 64 with ur;
--CUSTOMER_HUB_KEY	16
select * from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CUSTOMER_HUB_KEY' and length(rtrim(account_custom_field_value)) > 256 with ur;
--CUSTOMER_HUB_ID	20
select * from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CUSTOMER_HUB_ID' and length(rtrim(account_custom_field_value)) > 256 with ur;
--ICN_	822
select * from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'ICN_' and length(rtrim(account_custom_field_value)) > 10 with ur;

select substr(account_custom_field_value,1,50), rtrim(account_custom_field_value) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'PHONE_NUMBER' and length(rtrim(account_custom_field_value)) > 50 with ur; 

-- Issue 2. Some contacts had more than one custom phone number field for a given value
select 'ALERT_COMMENTS',account_id, count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'ALERT_COMMENTS' and account_custom_field_value is not null group by account_id having count(*) > 1;
select 'ALERT_INDICATOR',account_id, count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'ALERT_INDICATOR' and account_custom_field_value is not null group by account_id having count(*) > 1;
select 'CLIENT_COUNTRY',account_id, count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CLIENT_COUNTRY' and account_custom_field_value is not null group by account_id having count(*) > 1;
select 'CLIENT_STATE_REGION',account_id, count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CLIENT_STATE_REGION' and account_custom_field_value is not null group by account_id having count(*) > 1;
select 'CLIENT_STREET',account_id, count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CLIENT_STREET' and account_custom_field_value is not null group by account_id having count(*) > 1;
select 'CUSTOMER_HUB_ID',account_id, count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CUSTOMER_HUB_ID' and account_custom_field_value is not null group by account_id having count(*) > 1;
select 'CUSTOMER_HUB_KEY',account_id, count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'CUSTOMER_HUB_KEY' and account_custom_field_value is not null group by account_id having count(*) > 1;
select 'ICN_',account_id, count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'ICN_' and account_custom_field_value is not null group by account_id having count(*) > 1;
select 'PREMIUM_ACCOUNT',account_id, count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'PREMIUM_ACCOUNT' and account_custom_field_value is not null group by account_id having count(*) > 1;
select 'TYPE',account_id, count(*) from camdf.parature_account_custom_prestg cc where account_custom_field_name = 'TYPE' and account_custom_field_value is not null group by account_id having count(*) > 1;


--truncate table camdf.parature_account immediate;

insert into camdf.parature_account (
   account_id, account_name, ibm_cust_num, type, customer_hub_id, customer_hub_key,
   client_street, client_state_region, client_country,
   premium_account, alert_indicator, alert_comments, 
   date_created, date_last_modified)
select distinct 
   ap.account_id, account_name,
   (select substr(account_custom_field_value,1,7) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'ICN_' and account_custom_field_value is not null) as ICN_,
   (select substr(account_custom_field_value,1,64) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'TYPE' and account_custom_field_value is not null) as TYPE,
   (select substr(account_custom_field_value,1,255) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'CUSTOMER_HUB_ID' and account_custom_field_value is not null) as CUSTOMER_HUB_ID,
   (select substr(account_custom_field_value,1,255) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'CUSTOMER_HUB_KEY' and account_custom_field_value is not null) as CUSTOMER_HUB_KEY,
   (select substr(account_custom_field_value,1,120) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'CLIENT_STREET' and account_custom_field_value is not null) as CLIENT_STREET,   
   -- client_city
   (select substr(account_custom_field_value,1,64) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'CLIENT_STATE_REGION' and account_custom_field_value is not null) as CLIENT_STATE_REGION,
   -- client_postal_code
   (select substr(account_custom_field_value,1,256) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'CLIENT_COUNTRY' and account_custom_field_value is not null) as CLIENT_COUNTRY,
   (select substr(account_custom_field_value,1,64) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'PREMIUM_ACCOUNT' and account_custom_field_value is not null) as PREMIUM_ACCOUNT,
   (select substr(account_custom_field_value,1,40) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'ALERT_INDICATOR' and account_custom_field_value is not null) as ALERT_INDICATOR,      
   (select substr(account_custom_field_value,1,45) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'ALERT_COMMENTS' and account_custom_field_value is not null) as ALERT_COMMENTS,
   date_created, date_updated
from camdf.parature_account_prestg ap
where not exists (select 1 from camdf.parature_account a where a.account_id = ap.account_id)
fetch first 250000 rows only;


select distinct 
   ap.account_id, account_name,
   cast((select substr(account_custom_field_value,1,7) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'ICN_' and account_custom_field_value is not null) as varchar(7)) as ICN,
   cast((select substr(account_custom_field_value,1,40) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'TYPE' and account_custom_field_value is not null) as varchar(40)) as TYPE,
   cast((select substr(account_custom_field_value,1,255) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'CUSTOMER_HUB_ID' and account_custom_field_value is not null) as varchar(256)) as CUSTOMER_HUB_ID,
   cast((select substr(account_custom_field_value,1,255) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'CUSTOMER_HUB_KEY' and account_custom_field_value is not null) as varchar(256)) as CUSTOMER_HUB_KEY,
   cast((select substr(account_custom_field_value,1,120) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'CLIENT_STREET' and account_custom_field_value is not null)  as vargraphic(120)) as CLIENT_STREET,   
   -- client_city
   cast((select substr(account_custom_field_value,1,64) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'CLIENT_STATE_REGION' and account_custom_field_value is not null) as vargraphic(64)) as CLIENT_STATE_REGION,
   -- client_postal_code
   cast((select substr(account_custom_field_value,1,256) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'CLIENT_COUNTRY' and account_custom_field_value is not null) as varchar(256)) as CLIENT_COUNTRY,
   cast((select substr(account_custom_field_value,1,10) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'PREMIUM_ACCOUNT' and account_custom_field_value is not null) as varchar(10)) as PREMIUM_ACCOUNT,
   cast((select substr(account_custom_field_value,1,10) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'ALERT_INDICATOR' and account_custom_field_value is not null) as varchar(10)) as ALERT_INDICATOR,      
   cast((select substr(account_custom_field_value,1,5119) from camdf.parature_account_custom_prestg ac where ac.account_id = ap.account_id and account_custom_field_name = 'ALERT_COMMENTS' and account_custom_field_value is not null) as vargraphic(5120)) as ALERT_COMMENTS,
   date_created, date_updated
from camdf.parature_account_prestg ap
where ACCOUNT_ID IN (196165,196166,196167,196168,196169,196170,196171,196172,196173,196174,196175,196176,196177,196178,196179,196180,196181,196182,196183,196184,196185,196186,196187,196188,196189,196190,196191,196192,196193,196194,196195,196196,196197,196198,196199,196200,196201,196202,196203,196204,196205,196206,196207,196209,196210,196211,196212,196213,196214,196215,196216,196217,196218,196219,196220,196221,196222,196223,196224,196225,196226,196227,196229,196230,196231,196232,196233,196234,196235,196236,196237,196238,196239,196240,196241,196242,196243,196244,196245,196246,196247,196248,196249,196250,196251,196252,196253,196254,196255,196256,196257,196258,196259,196261,196262,196263,196264,196265,196266,196267,196268,196269,196270,196271,196272,196273,196274,196275,196276,196283,196284,196285,196286,196287,196288,196289,196290,196291,196292,196293,196294,196295,196296,196297,196298,196299,196300,196301,196302,196303,196304,196305,196306,196307,196308,196309,196310,196311,196312,196313,196314,196315,196316,196317,196318,196319,196320,196321,196322,196323,196324,196325,196326,196327,196328,196329,196330,196331,196332,196333,196334,196335,196336,196337,196338,196339,196340,196341,196342,196343,196344,196345,196346,196347,196348,196349,196350,196351,196352,196353,196354,196355,196356,196360,196361,196362,196363,196364,196365,196366,196367,196368,196369,196370,196371,196372,196373,196374,196375,196376,196377,196378,196379,196382,196383,196384,196385,196386,196387,196390,196391,196394,196395,196396,196397,196398,196399,196400,196401,196402,196403,196404,196405,196406,196407,196408,196409,196410,196411,196412,196413,196414,196415,196416,196417,196418,196419,196420,196421,196422,196423,196424,196425,196426,196427,196428,196429,196430,196431,196432,196433,196434,196435,196436,196437,196438,196439,196440,196441,196442,196443,196444,196445,196446,196447,196448,196449,196450,196459,196460,196461,196462,196463,196464,196465,196466,196467,196468,196469,196470,196471,196472,196473,196474,196475,196476,196477,196480,196481,196483,196484,196488,196489,196490,196491,196492,196493,196494,196495,196496,196497,196498,196499,196500,196501,196502,196503,196504,196505,196506,196507,196508,196509,196510,196511,196512,196513,196514,196515,196516,196517,196518,196519,196520,196521,196522,196523,196524,196525,196526,196527,196528,196529,196531,196532,196533,196536,196537,196538,196541,196542,196543,196544,196545,196546,196547,196549,196550,196551,196552,196557,196558,196559,196560,196561,196562,196563,196564,196565,196566,196567,196568,196569,196570,196571,196572,196573,196575,196576,196577,196578,196579,196580,196581,196582,196583,196584,196585,196586,196587,196588,196589,196590,196591,196592,196593,196594,196595,196596,196597,196598,196599,196600,196601,196602,196603,196604,196605,196606,196607,196608,196609,196610,196611,196612,196613,196615,196616,196617,196618,196619,196620,196621,196622,196623,196624,196625,196626,196627,196628,196629,196630,196631,196632,196633,196634,196635,196636,196637,196638,196639,196640,196641,196642,196643,196645,196646,196647,196648,196649,196650,196651,196652,196653,196654,196655,196656,196657,196658,196659,196660,196661,196662,196663,196664,196665,196666,196667,196668,196669,196670,196671,196672,196673,196675,196676,196677,196678,196680,196683,196684,196686,196688,196690,196691,196692,196693,196694,196695,196696,196697,196698,196699,196700,196701,196702,196703,196704,196705,196706,196707,196708,196709,196710,196711,196713,196714,196715,196717)
fetch first 100 rows only;


with temp (account_id, icn, type, customer_hub_id, customer_hub_key, client_street, 
            client_state_region, client_country, premium_account, alert_indicator, alert_comments) as (

   select account_id, max(icn) as icn, max(type) as type, max(customer_hub_id) as customer_hub_id, max(customer_hub_key) as customer_hub_key, max(client_street) as client_street, 
            max(client_state_region) as client_state_region, max(client_country) as client_country, max(premium_account) as premium_account, max(alert_indicator) as alert_indicator, max(alert_comments) as alert_comments
   from (
      select account_id, cast(substr(account_custom_field_value,1,7) as varchar(7)) as icn, '' as type, '' as customer_hub_id, '' as customer_hub_key, '' as client_street,
            '' as client_state_region, '' as client_country, '' as premium_account, '' as alert_indicator, '' as alert_comments
         from camdf.parature_account_custom_prestg ac where account_custom_field_name = 'ICN_' 
      union            
      select account_id, '', cast(substr(account_custom_field_value,1,40) as varchar(40)), '', '', '',
            '', '', '', '', ''   
         from camdf.parature_account_custom_prestg ac where account_custom_field_name = 'TYPE'  
      union            
      select account_id, '', '', cast(substr(account_custom_field_value,1,255) as varchar(256)), '', '',
            '', '', '', '', ''   
         from camdf.parature_account_custom_prestg ac where account_custom_field_name = 'CUSTOMER_HUB_ID' 
      union            
      select account_id, '', '', '', cast(substr(account_custom_field_value,1,255) as varchar(256)), '',
            '', '', '', '', ''   
         from camdf.parature_account_custom_prestg ac where account_custom_field_name = 'CUSTOMER_HUB_KEY'
      union            
      select account_id, '', '', '', '', cast(substr(account_custom_field_value,1,120) as vargraphic(120)), 
            '', '', '', '', ''   
         from camdf.parature_account_custom_prestg ac where account_custom_field_name = 'CLIENT_STREET'
      union            
      select account_id, '', '', '', '', '', 
            cast(substr(account_custom_field_value,1,64) as vargraphic(64)), '', '', '', ''
         from camdf.parature_account_custom_prestg ac where account_custom_field_name = 'CLIENT_STATE_REGION'
      union            
      select account_id, '', '', '', '', '',
            '', cast(substr(account_custom_field_value,1,256) as varchar(256)), '', '', ''   
         from camdf.parature_account_custom_prestg ac where account_custom_field_name = 'CLIENT_COUNTRY'  
      union            
      select account_id, '', '', '', '', '',
            '', '', cast(substr(account_custom_field_value,1,10) as varchar(10)), '', ''   
         from camdf.parature_account_custom_prestg ac where account_custom_field_name = 'PREMIUM_ACCOUNT'  
      union            
      select account_id, '', '', '', '', '',
            '', '', '', cast(substr(account_custom_field_value,1,10) as varchar(10)), ''   
         from camdf.parature_account_custom_prestg ac where account_custom_field_name = 'ALERT_INDICATOR'  
      union            
      select account_id, '', '', '', '', '',
            '', '', '', '', cast(substr(account_custom_field_value,1,5119) as vargraphic(5120))   
         from camdf.parature_account_custom_prestg ac where account_custom_field_name = 'ALERT_COMMENTS'  
) group by account_id
fetch first 500 rows only


