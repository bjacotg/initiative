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
	Password char(128),
        Salt char(64),
        CONSTRAINT PKVoter PRIMARY KEY(Id)
);

CREATE TABLE Comitee(
	Id char(40),
	Password char(128),
        Salt char(64),
        CONSTRAINT PKComitee PRIMARY KEY(Id)
);


CREATE TABLE Initiative(
    InitID integer AUTO_INCREMENT,
    ComiteeId char(40),
    CONSTRAINT PKInit PRIMARY KEY(InitID),
    CONSTRAINT FKInitCom FOREIGN KEY(ComiteeId) REFERENCES Comitee (Id)
);

CREATE TABLE Vote(
    Initiative integer,
    Id char(40),
    CONSTRAINT PKVote PRIMARY KEY(Initiative, Id),
    CONSTRAINT FKVoteVoter FOREIGN KEY(Id) REFERENCES Voter (Id),
    CONSTRAINT FKVoteInit FOREIGN KEY(Initiative) REFERENCES Initiative (InitID)
);



SET AUTOCOMMIT = 0;