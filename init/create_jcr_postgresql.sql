--
-- note: this script assumes pg_hba.conf is configured correctly
--

-- \connect postgres postgres

drop database if exists "JCR_DB";
drop user if exists "JCR_USER";

CREATE USER "JCR_USER" PASSWORD 'JCR_PW';

CREATE DATABASE "JCR_DB" WITH OWNER = "JCR_USER" ENCODING = 'UTF8' TABLESPACE = pg_default;

GRANT ALL PRIVILEGES ON DATABASE "JCR_DB" to "JCR_USER";
