CREATE DATABASE appsahDB;

CREATE TABLE appsahdb.contact
(
    ID                          INT NOT NULL,
    CONTENTS                    VARCHAR(256) NOT NULL,
    CATEGORY                    CHAR(5) NOT NULL,
    ADDMEM                      CHAR(10) NOT NULL,
    DELFLAG                     TINYINT,
    date                        VARCHAR(32),
    CONSTRAINT PRIMARY KEY (ID),
    CONSTRAINT contact_ibfk_1 FOREIGN KEY (CATEGORY) REFERENCES null.master_contact_category (ID),
    CONSTRAINT contact_ibfk_2 FOREIGN KEY (ADDMEM) REFERENCES null.member (ID)
);

CREATE TABLE appsahdb.master_contact_category
(
    ID                          CHAR(5) NOT NULL,
    NAME                        VARCHAR(128) NOT NULL,
    DELFLAG                     TINYINT,
    CONSTRAINT PRIMARY KEY (ID)
);

CREATE TABLE appsahdb.master_memcat
(
    ID                          CHAR(5) NOT NULL,
    NAME                        VARCHAR(128) NOT NULL,
    DELFLAG                     TINYINT,
    CONSTRAINT PRIMARY KEY (ID)
);

CREATE TABLE appsahdb.member
(
    ID                          CHAR(10) NOT NULL,
    NAME                        VARCHAR(128) NOT NULL,
    MEMCAT                      CHAR(5) NOT NULL,
    DELFLAG                     TINYINT,
    CONSTRAINT PRIMARY KEY (ID),
    CONSTRAINT member_ibfk_1 FOREIGN KEY (MEMCAT) REFERENCES null.master_memcat (ID)
);

CREATE TABLE appsahdb.top_menu
(
    ID                          CHAR(10) NOT NULL,
    PARENT_ID                   CHAR(10),
    NAME                        VARCHAR(128) NOT NULL,
    URL                         VARCHAR(1024),
    RESTRICTER                  CHAR(5),
    DELFLAG                     TINYINT,
    CONSTRAINT PRIMARY KEY (ID)
);
