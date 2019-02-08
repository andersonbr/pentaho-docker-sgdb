CREATE DATABASE IF NOT EXISTS `JCR_DB` DEFAULT CHARACTER SET latin1;

grant all on JCR_DB.* to 'JCR_USER'@'%' identified by 'JCR_PW';

commit;
