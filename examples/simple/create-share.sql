CREATE DATABASE sample_shared_db;

CREATE SCHEMA sample_shared_db.shared_schema;

CREATE TABLE sample_shared_db.shared_schema.sample_table (
    ID NUMBER,
    VALUE TEXT
);

INSERT INTO sample_shared_db.shared_schema.sample_table 
    VALUES
    (1, 'TEST VALUE'),
    (2, 'ANOTHER TEST VALUE');

CREATE SHARE sample_share COMMENT = 'Test Share';

GRANT USAGE ON DATABASE sample_shared_db TO SHARE sample_share;

GRANT USAGE ON SCHEMA sample_shared_db.shared_schema TO SHARE sample_share;

GRANT SELECT ON ALL TABLES IN SCHEMA sample_shared_db.shared_schema TO SHARE sample_share;

ALTER SHARE sample_share ADD ACCOUNT="<orgname.accountname>";
