
CREATE OR REPLACE STAGE CUSTOMER_SNOWPIPE
URL = 's3://snowflake-snowpipe18/customer/'
STORAGE_INTEGRATION = S3_INT_EXTERNAL
FILE_FORMAT = CSV_FORMAT;


LIST @CUSTOMER_SNOWPIPE;


CREATE OR REPLACE PIPE CUSTOMER_PIPE
AUTO_INGEST = TRUE
AS
COPY INTO CUSTOMER_RAW_1  FROM @CUSTOMER_SNOWPIPE;


SELECT * FROM CUSTOMER_RAW_1  ORDER BY CUSTOMER_ID;


--MONITORING PIPES

DESC PIPE CUSTOMER_PIPE;

ALTER PIPE CUSTOMER_PIPE REFRESH; --BEFORE CREATING PIPE IF SOME FILES ARE THIS WILL LOAD

SELECT SYSTEM$PIPE_STATUS('CUSTOMER_PIPE');   -- pendingFileCount should drop to 0

SHOW PIPES;   --LIST ALL PIPES


-- what Snowflake actually loaded into the table &  Did my file load, or is it still waiting?
-- Did a file fail, and why? & How many rows came from each file? & When was it loaded?
SELECT * FROM TABLE (
 INFORMATION_SCHEMA.COPY_HISTORY(
   TABLE_NAME => 'CUSTOMER_RAW_1',
   START_TIME => DATEADD(DAY,-1,CURRENT_TIMESTAMP())
 )
);


--to check loading failed files 

SELECT * FROM TABLE (
 INFORMATION_SCHEMA.COPY_HISTORY(
   TABLE_NAME => 'CUSTOMER_RAW_1',
   START_TIME => DATEADD(DAY,-1,CURRENT_TIMESTAMP())
 )
) WHERE STATUS <> 'Loaded';

-- This query shows the actual error rows from a previous COPY INTO load. 
-- COPY_HISTORY tells you that a file had errors, and VALIDATE shows you which rows failed and why.
-- THIS WORKS ONLY FOR MANUAL COPY INTO


