-- 1. Run to drop schema
-- DROP USER northwind CASCADE;

-- 2. Run to create user and schema 
CREATE USER northwind IDENTIFIED BY northwind
  DEFAULT TABLESPACE users
  TEMPORARY TABLESPACE temp
  QUOTA UNLIMITED ON users;

-- 3. Run to grant permissions
GRANT "CONNECT" TO northwind
/
GRANT DBA TO northwind
/
GRANT "RESOURCE" TO northwind
/
ALTER USER northwind DEFAULT ROLE "CONNECT", DBA,"RESOURCE"
/
