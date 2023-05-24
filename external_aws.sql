-- 1. use a storage integration: S3-enabled-role -> storage integration -> desc integration>+iam user<+role -> external stage -> COPY INTO
create or replace table raw_credits_aws(
    person_id int,
    id	varchar(255),
    name varchar(255),
    movie_character varchar(16777216),
    movie_role varchar(255)
);
create or replace storage integration s3_inter
type = external_stage
storage_provider = S3
enabled = TRUE
storage_aws_role_arn = 'arn:aws:iam::282485216722:role/snowflake_stage_role'
storage_allowed_locations = ('s3://awsex5121014');

desc integration s3_inter;

create or replace stage s3_external_stage
storage_integration = s3_inter
url = 's3://awsex5121014'
file_format = csv_blob1;

describe stage s3_external_stage;

copy into raw_credits_aws
from @s3_external_stage;

select * from raw_credits_aws;

-- 2. use an IAM user<+policy (access id and key) -> external stage -> COPY INTO
create or replace stage s3_user_stage
url = 's3://nifi-demo516948'
credentials = (aws_key_id='AKIAYT26JHHZML42RPNO' aws_secret_key='/1Te0NbB+k+m1340zJ7xusHSHjpnxafLisxka52K');

show stages;

create or replace table raw_credits_aws4(
    person_id int,
    id	varchar(255),
    name varchar(255),
    movie_character varchar(16777216),
    movie_role varchar(255)
);

create or replace pipe nifi_pipe 
  auto_ingest=true 
  as
      copy into raw_credits_aws4
      from @s3_user_stage
      file_format = csv_blob1;

show pipes;

select * from raw_credits_aws4;
truncate raw_credits_aws4;
