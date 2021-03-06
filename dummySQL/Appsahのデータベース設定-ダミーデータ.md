# Appsahのデータベース設定

## とりあえずCreateから
* Database Create
	* CREATE DATABASE appsahDB;
* Table Create
	* まずなんのテーブルが必要か
		* 社員テーブル(MEMBER)
			* 社員番号:CHAR(10)
			* 社員名：VARCHAR(128)
			* 種別：CHAR(5)
			* 削除フラグ：BOOLEAN
			* CREATE TABLE MEMBER(ID CHAR(10) NOT NULL, NAME VARCHAR(128) NOT NULL, MEMCAT CHAR(5) NOT NULL, DELFLAG BOOLEAN DEFAULT 0, PRIMARY KEY(ID), FOREIGN KEY(MEMCAT) REFERENCES MASTER_MEMCAT(ID)) ENGINE=INNODB;
		* 連絡テーブル(CONTACT)
			* 一意識別子：INTEGER
			* 連絡内容：VARCHAR(256)
			* カテゴリ：CHAR(5)：FOREIGN KEY(カテゴリ) REFERENCES 連絡カテゴリマスター(カテゴリ番号)
			* 登録した人：CHAR(10)：FOREIGN KEY(登録した人) REFERENCES 社員テーブル(社員番号)
			* 削除フラグ：BOOLEAN
			* CREATE TABLE CONTACT(ID INTEGER AUTO_INCREMENT, CONTENTS VARCHAR(256) NOT NULL, CATEGORY CHAR(5) NOT NULL, ADDMEM CHAR(10) NOT NULL, DELFLAG BOOLEAN DEFAULT 0, PRIMARY KEY(ID), FOREIGN KEY(CATEGORY) REFERENCES MASTER_CONTACT_CATEGORY(ID), FOREIGN KEY(ADDMEM) REFERENCES MEMBER(ID)) ENGINE=INNODB;
			* alter table contact add DATE VARCHAR(32);
        * 社員種別(MASTER_MEMCAT)
        	* カテゴリ番号：CHAR(5)
        	* カテゴリ名：VARCHAR(128)
        	* 削除フラグ：BOOLEAN
        	* CREATE TABLE MASTER_MEMCAT(ID CHAR(5) NOT NULL, NAME VARCHAR(128) NOT NULL, DELFLAG BOOLEAN DEFAULT 0, PRIMARY KEY(ID)) ENGINE=INNODB;
        * 連絡カテゴリマスターテーブル(MASTER_CONTACT_CATEGORY)
        	* カテゴリ番号：CHAR(5)
        	* カテゴリ名；VARCHAR(128)
        	* 削除フラグ：BOOLEAN
        	* CREATE TABLE MASTER_CONTACT_CATEGORY(ID CHAR(5) NOT NULL, NAME VARCHAR(128) NOT NULL, DELFLAG BOOLEAN DEFAULT 0, PRIMARY KEY(ID)) ENGINE=INNODB;
        * メニューテーブル(TOP_MENU)
        	* メニュー番号：CHAR(10)
        	* 親メニュー番号：CHAR(10)
        	* メニュー名：VARCHAR(128)
        	* メニューURL：VARCHAR(1024)
        	* アクセス制限：CHAR(5)
        	* 削除フラグ：BOOLEAN
        	* ※親メニュー番号がNULLだったら、それは親メニューとして扱う
        	* ※RESTRICTが0だったら制限なし
        	* CREATE TABLE TOP_MENU(ID CHAR(10) NOT NULL, PARENT_ID CHAR(10), NAME VARCHAR(128) NOT NULL, URL VARCHAR(1024), RESTRICTER CHAR(5), DELFLAG BOOLEAN DEFAULT 0, PRIMARY KEY(ID)) ENGINE=INNODB;
* Insert table
	* MEMBER
		* INSERT INTO MEMBER VALUES('aa', '多木', '2', 0);
		* INSERT INTO MEMBER VALUES('bb', '黒田', '3', 0);
		* INSERT INTO MEMBER VALUES('vv', '稲田', '1', 0);
		* INSERT INTO MEMBER VALUES('dd', '小林', '1', 0);
		* INSERT INTO MEMBER VALUES('ee', '荒野', '1', 0);
		* INSERT INTO MEMBER VALUES('ff', '牧島', '1', 0);
		* INSERT INTO MEMBER VALUES('gg', '渡部', '1', 0);
	* CONTACT
		* INSERT INTO CONTACT(CONTENTS, CATEGORY, ADDMEM, DELFLAG) VALUES('XXXがお休み', '00001', 'aa', 0);
		* INSERT INTO CONTACT(CONTENTS, CATEGORY, ADDMEM, DELFLAG) VALUES('今日は肉デーです', '00003', 'dd', 0);
		* INSERT INTO CONTACT(CONTENTS, CATEGORY, ADDMEM, DELFLAG) VALUES('XXX線が本日遅延', '00002', 'ff', 0);
		* INSERT INTO CONTACT(CONTENTS, CATEGORY, ADDMEM, DELFLAG) VALUES('XXXは出社しないっす', '00002', 'bb', 0);
		* INSERT INTO CONTACT(CONTENTS, CATEGORY, ADDMEM, DELFLAG) VALUES('本日は部の飲み会', '00003', 'bb', 0);
    * MASTER_MEMCAT
    	* INSERT INTO MASTER_MEMCAT VALUES('1', 'A職', 0);
    	* INSERT INTO MASTER_MEMCAT VALUES('2', 'B職', 0);
    	* INSERT INTO MASTER_MEMCAT VALUES('3', 'C職', 0);
	* MASTER_CONTACT_CATEGORY
		* INSERT INTO MASTER_CONTACT_CATEGORY VALUES('00001', '休暇', 0);
		* INSERT INTO MASTER_CONTACT_CATEGORY VALUES('00002', '遅延', 0);
		* INSERT INTO MASTER_CONTACT_CATEGORY VALUES('00003', '庶務', 0);
	* TOP_MENU
		* INSERT INTO TOP_MENU(ID, NAME, RESTRICT, DELFLAG) VALUES('100', '庶務', '0', 0);
		* INSERT INTO TOP_MENU(ID, NAME, RESTRICT, DELFLAG) VALUES('200', 'xx連絡', '0', 0);
		* INSERT INTO TOP_MENU(ID, NAME, RESTRICT, DELFLAG) VALUES('300', 'xx参画', '0', 0);
		* INSERT INTO TOP_MENU(ID, NAME, RESTRICT, DELFLAG) VALUES('400', 'その他', '0', 0);
		* INSERT INTO TOP_MENU(ID, PARENT_ID, NAME, URL, RESTRICT, DELFLAG) VALUES('101', '100', '庶務A', '', '0', 0);
		* INSERT INTO TOP_MENU(ID, PARENT_ID, NAME, URL, RESTRICT, DELFLAG) VALUES('102', '100', '庶務B', '', '0', 0);
		* INSERT INTO TOP_MENU(ID, PARENT_ID, NAME, URL, RESTRICT, DELFLAG) VALUES('201', '200', 'xx連絡A', '', '0', 0);
		* INSERT INTO TOP_MENU(ID, PARENT_ID, NAME, URL, RESTRICT, DELFLAG) VALUES('202', '200', 'xx連絡B', '', '0', 0);
		* INSERT INTO TOP_MENU(ID, PARENT_ID, NAME, URL, RESTRICT, DELFLAG) VALUES('301', '300', 'xx参画A', '', '0', 0);
		* INSERT INTO TOP_MENU(ID, PARENT_ID, NAME, URL, RESTRICT, DELFLAG) VALUES('401', '400', 'Q AND A', 'http://google.com', '0', 0);