# Snowflake S3 File Ingestion

A practice project that loads customer CSV files from AWS S3 into Snowflake using a storage integration, external stage, external table, view and Snowpipe auto-ingest.

## Architecture
AWS S3 → Storage Integration (IAM role) → External Stage → COPY INTO table / External Table → View
                                                 └→ Snowpipe (AUTO_INGEST) → Table

## What I Built
- Created a database and schema with permanent and temporary tables
- Created a storage integration and external stage to connect Snowflake to S3 securely using an IAM role (no access keys in code)
- Loaded CSV files with COPY INTO and CSV file formats
- Created external tables to query files in S3 directly
- Created views on top of the external table to expose columns (CUSTOMER_ID, CUSTOMER_NAME, EMAIL, CITY)
- Configured Snowpipe with AUTO_INGEST = TRUE to load new files automatically
- Monitored loads using SYSTEM$PIPE_STATUS and INFORMATION_SCHEMA.COPY_HISTORY

## Files
| File | Description |
|------|-------------|
| 01_create_db_schema_tables.sql | Database, schema, permanent and temporary tables |
| 02_storage_integration_stage.sql | Storage integration, file format and external stage |
| 03_external_tables.sql | External table and views |
| 04_snowpipe_auto_ingest.sql | Snowpipe setup and load monitoring queries |

## Sample Results
Sample dataset: 27 customer records (CUSTOMER_ID, CUSTOMER_NAME, EMAIL, CITY).

External table output:


<img width="1358" height="412" alt="Screenshot 2026-10-15 140653" src="https://github.com/user-attachments/assets/42ddb7e7-df1f-4810-b11a-adaf7d3d1581" />
<img width="1372" height="421" alt="Screenshot 2026-10-15 135153" src="https://github.com/user-attachments/assets/5edcfefe-2143-4616-bc0a-475c16e058b4" />


## Tools
Snowflake, AWS S3, AWS IAM, SQL

## Notes
AWS account IDs, role ARNs and bucket names are replaced with placeholders. Replace them with your own values to run the scripts.
