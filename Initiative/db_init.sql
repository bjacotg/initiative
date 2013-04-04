SET AUTOCOMMIT = 1;
SET storage_engine = INNODB;

-- GRANT ALL ON *.* TO 'user_G002'@'%' IDENTIFIED BY 'user_G002' WITH GRANT OPTION;

--FLUSH PRIVILEGES;
--DELETE FROM mysql.user WHERE user LIKE 'ECEG2-%';
--DELETE FROM mysql.db WHERE user LIKE 'ECEG2-%';
--FLUSH PRIVILEGES;
DROP TABLE IF EXISTS Vote;
DROP TABLE IF EXISTS Initiative;
DROP TABLE IF EXISTS Voter;
DROP TABLE IF EXISTS Comitee;

CREATE TABLE Voter(
	Id char(40),
	Password char(32),
        Salt char(16),
        CONSTRAINT PKVoter PRIMARY KEY(Id)
);

CREATE TABLE Comitee(
	Id char(40),
	Password char(32),
        Salt char(16),
        CONSTRAINT PKComitee PRIMARY KEY(Id)
);


CREATE TABLE Initiative(
    InitID integer AUTO_INCREMENT,
    InitName varchar(255),
    ComiteeId char(40),
    Salt char(16),
    CONSTRAINT PKInit PRIMARY KEY(InitID),
    CONSTRAINT FKInitCom FOREIGN KEY(ComiteeId) REFERENCES Comitee (Id)
);

CREATE TABLE Vote(
    Initiative integer,
    HashId char(32),
    CONSTRAINT PKVote PRIMARY KEY(Initiative, HashId),
    CONSTRAINT FKVoteInit FOREIGN KEY(Initiative) REFERENCES Initiative (InitID)
);


INSERT INTO Comitee (Id, Password, Salt) VALUES ('SVP', 'SVP', 'SVP');
INSERT INTO Comitee (Id, Password, Salt) VALUES ('Green', '', '');
INSERT INTO Comitee (Id, Password, Salt) VALUES ('Jacqueline Pitre', '', '');

SET AUTOCOMMIT = 0;
