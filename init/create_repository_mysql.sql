CREATE DATABASE IF NOT EXISTS `HIB_DB` DEFAULT CHARACTER SET latin1;

USE HIB_DB;

GRANT ALL ON HIB_DB.* TO 'HIB_USER'@'%' identified by 'HIB_PW'; 

commit;
