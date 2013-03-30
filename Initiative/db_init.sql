SET AUTOCOMMIT = 1;
SET storage_engine = INNODB;

-- GRANT ALL ON *.* TO 'user_G002'@'%' IDENTIFIED BY 'user_G002' WITH GRANT OPTION;

--FLUSH PRIVILEGES;
--DELETE FROM mysql.user WHERE user LIKE 'ECEG2-%';
--DELETE FROM mysql.db WHERE user LIKE 'ECEG2-%';
--FLUSH PRIVILEGES;

DROP TABLE IF EXISTS Voter;

CREATE TABLE Voter(
	HashId char(40),
	Password varchar(10));

SET AUTOCOMMIT = 0;