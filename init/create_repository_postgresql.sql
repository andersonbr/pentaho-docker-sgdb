--
-- note: this script assumes pg_hba.conf is configured correctly
--

-- \connect postgres postgres

drop database if exists "HIB_DB";
drop user if exists "HIB_USER";

CREATE USER "HIB_USER" PASSWORD 'HIB_PW';

CREATE DATABASE "HIB_DB" WITH OWNER = "HIB_USER" ENCODING = 'UTF8' TABLESPACE = pg_default;

GRANT ALL PRIVILEGES ON DATABASE "HIB_DB" to "HIB_USER";
