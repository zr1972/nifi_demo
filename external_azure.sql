create or replace table raw_credits(
    person_id int,
    id	varchar(255),
    name varchar(255),
    movie_character varchar(16777216),
    movie_role varchar(255)
);

create or replace file format csv_blob1
type = 'CSV'
skip_header = 1
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
field_delimiter = ',';


-- external stage: storage in S3/container/...
-- storage integration: 
--      stores a generated indentity and IAM entity for external storage in SF
--      without providing security credentials 

select system$get_snowflake_platform_info();

desc storage integration azure_blob1;
-- consent url: https://login.microsoftonline.com/115b0525-267d-4e41-a7f9-b7237061980b/oauth2/authorize?client_id=eebb1e02-ff16-45cc-9566-09e0cee95d20&response_type=code

-- app name: 6nbsrnsnowflakepacint_1683818698111


-- sas token: ?sv=2022-11-02&ss=b&srt=co&sp=rwdlacytfx&se=2023-05-14T01:49:23Z&st=2023-05-11T17:49:23Z&spr=https,http&sig=9IVgnrY0hYENsUcatyKTldrWnTpzvtZqDnN26sVBFmo%3D
-- creating external stage
create or replace stage azure_blob1_sas_stage
    url='azure://demosfazuref4.blob.core.windows.net/blob1/'
    credentials=(AZURE_SAS_TOKEN='?sv=2022-11-02&ss=b&srt=co&sp=rwdlacytfx&se=2023-05-14T01:49:23Z&st=2023-05-11T17:49:23Z&spr=https,http&sig=9IVgnrY0hYENsUcatyKTldrWnTpzvtZqDnN26sVBFmo%3D')
    file_format = csv_blob1;

list @azure_blob1_sas_stage;

describe stage azure_blob1_sas_stage;

copy into raw_credits
from @azure_blob1_sas_stage;

select * from raw_credits;
