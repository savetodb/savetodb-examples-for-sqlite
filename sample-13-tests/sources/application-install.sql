-- =============================================
-- Application: Sample 13 - Tests
-- Version 10.8, January 9, 2023
--
-- Copyright 2021-2023 Gartle LLC
--
-- License: MIT
-- =============================================

CREATE TABLE [quotes] (
      ['] text NOT NULL
    , [''] text NOT NULL
    , [,] text NOT NULL
    , [-] text NOT NULL
    , [@] text NOT NULL
    , [@@] text NOT NULL
    , [`] text NULL
    , [``] text NULL
    , ["] text NULL
    , [""] text NULL
    , "]" text NULL
    , "[" text NULL
    , "[]" text NULL
    , [+] text NULL
    , [*] text NULL
    , [%] text NULL
    , [%%] text NULL
    , [=] text NULL
    , [;] text NULL
    , [:] text NULL
    , [<>] text NULL
    , [&] text NULL
    , [.] text NULL
    , [..] text NULL
    , CONSTRAINT [PK_quotes] PRIMARY KEY (['], [''], [,], [-], [@], [@@])
);

CREATE TABLE [datatypes_sqlite] (
    id integer PRIMARY KEY AUTOINCREMENT NOT NULL
    , [bigint] bigint NULL
    , [binary] binary(8) NULL
    , [binary16] binary(16) NULL
    , [boolean] boolean NULL
    , [blob] blob NULL
    , [char] char(10) NULL
    , [char36] char(36) NULL
    , [clob] clob NULL
    , [date] date NULL
    , [datetime] datetime NULL
    , [datetimeoffset] text NULL
    , [decimal] decimal(15,2) NULL
    , [double] double NULL
    , [float] float NULL
    , [guid] guid NULL
    , [int] int NULL
    , [json] text NULL
    , [nchar] nchar(10) NULL
    , [ntext] ntext NULL
    , [numeric] numeric(15,2) NULL
    , [nvarchar] nvarchar(255) NULL
    , [real] real NULL
    , [smallint] smallint NULL
    , [text] text NULL
    , [time] text NULL
    , [timestamp] timestamp NULL
    , [timestamptz] text NULL
    , [tinyint] tinyint NULL
    , [varbinary] varbinary(1024) NULL
    , [varchar] varchar(255) NULL
    , [xml] text NULL
);

CREATE TABLE [datatypes_mssql] (
    id integer PRIMARY KEY AUTOINCREMENT NOT NULL
    , [bigint] bigint NULL
    , [binary] binary(8) NULL
    , [binary16] binary(16) NULL
    , [bit] bit NULL
    , [char] char(10) NULL
    , [char36] char(36) NULL
    , [date] date NULL
    , [datetime] datetime NULL
    , [datetime20] datetime NULL
    , [datetime23] datetime NULL
    , [datetime27] text NULL
    , [datetimeoffset0] text NULL
    , [datetimeoffset3] text NULL
    , [datetimeoffset7] text NULL
    , [decimal] bigint NULL
    , [decimal92] decimal(9,2) NULL
    , [decimal150] decimal(15,0) NULL
    , [decimal152] decimal(15,2) NULL
    , [decimal192] text NULL
    , [decimal282] text NULL
    , [decimal382] text NULL
    , [float] float NULL
    , [geography] text NULL
    , [geometry] text NULL
    , [hierarchyid] text NULL
    , [image] image NULL
    , [int] int NULL
    , [money] money NULL
    , [nchar] nchar(10) NULL
    , [ntext] ntext NULL
    , [numeric] bigint NULL
    , [numeric92] numeric(9,2) NULL
    , [numeric150] numeric(15,0) NULL
    , [numeric152] numeric(15,2) NULL
    , [numeric192] text NULL
    , [numeric282] text NULL
    , [numeric382] text NULL
    , [nvarchar] nvarchar(255) NULL
    , [nvarcharmax] text NULL
    , [real] real NULL
    , [smalldatetime] datetime NULL
    , [smallint] smallint NULL
    , [smallmoney] decimal(10,4) NULL
    , [sql_variant] any NULL
    , [sysname] text NULL
    , [text] text NULL
    , [time0] text NULL
    , [time3] text NULL
    , [time7] text NULL
    , [timestamp] binary(8) NULL
    , [tinyint] tinyint NULL
    , [uniqueidentifier] uniqueidentifier NULL
    , [varbinary] varbinary(1024) NULL
    , [varchar] varchar(255) NULL
    , [varcharmax] text NULL
    , [xml] text NULL
);

CREATE TABLE [datatypes_sqlce] (
    id integer PRIMARY KEY AUTOINCREMENT NOT NULL
    , [bigint] bigint NULL
    , [binary] binary(8) NULL
    , [binary16] binary(16) NULL
    , [bit] bit NULL
    , [datetime] datetime NULL
    , [float] float NULL
    , [image] image NULL
    , [integer] int NULL
    , [money] money NULL
    , [nchar] nchar(10) NULL
    , [ntext] ntext NULL
    , [numeric] numeric NULL
    , [numeric152] numeric(15,2) NULL
    , [nvarchar] nvarchar(255) NULL
    , [real] real NULL
    , [smallint] smallint NULL
    , [timestamp] binary(8) NULL
    , [tinyint] tinyint NULL
    , [uniqueidentifier] uniqueidentifier NULL
    , [varbinary] varbinary(50) NULL
);

CREATE TABLE [datatypes_pgsql] (
    id integer PRIMARY KEY AUTOINCREMENT NOT NULL
    , "bigint" bigint NULL
    , "bit3" text NULL
    , "boolean" boolean NULL
    , "box" text NULL
    , "bytea" blob NULL
    , "char" char(10) NULL
    , "char36" char(36) NULL
    , "cidr" text NULL
    , "circle" text NULL
    , "date" date NULL
    , "double_precision" double NULL
    , "inet" text NULL
    , "integer" int NULL
    , "interval" text NULL
    , "json" text NULL
    , "jsonb" text NULL
    , "line" text NULL
    , "lseg" text NULL
    , "macaddr" text NULL
    , "money" text NULL
    , "money15" money NULL
    , "numeric" text NULL
    , "numeric152" numeric(15,2) NULL
    , "real" real NULL
    , "path" text NULL
    , "point" text NULL
    , "polygon" text NULL
    , "text" text NULL
    , "time" text NULL
    , "time0" text NULL
    , "time3" text NULL
    , "timetz" text NULL
    , "timetz0" text NULL
    , "timetz3" text NULL
    , "timestamp" text NULL
    , "timestamp0" timestamp(0) NULL
    , "timestamp3" timestamp(3) NULL
    , "timestamptz" text NULL
    , "timestamptz0" text NULL
    , "timestamptz3" text NULL
    , "uuid" guid NULL
    , "varbit" text NULL
    , "varchar" varchar(255) NULL
    , "xml" text NULL
);

CREATE TABLE [datatypes_mysql] (
    id integer PRIMARY KEY AUTOINCREMENT NOT NULL
    , `bigint` BIGINT NULL
    , `binary` BINARY(8) NULL
    , `binary16` BINARY(16) NULL
    , `bit1` BOOLEAN NULL
    , `bit3` TEXT NULL
    , `blob` BLOB NULL
    , `char` CHAR(10) NULL
    , `char36` CHAR(36) NULL
    , `date` DATE NULL
    , `datetime` DATETIME NULL
    , `datetime3` DATETIME(3) NULL
    , `datetime6` TEXT NULL
    , `decimal152` DECIMAL(15,2) NULL
    , `decimal194` TEXT NULL
    , `double` DOUBLE NULL
    , `enum` TEXT NULL
    , `float` FLOAT NULL
    , `geometry` TEXT NULL
    , `geometrycollection` TEXT NULL
    , `int` INT NULL
    , `json` TEXT NULL
    , `linestring` TEXT NULL
    , `longblob` BLOB NULL
    , `longtext` TEXT NULL
    , `mediumblob` BLOB NULL
    , `mediumint` MEDIUMINT NULL
    , `mediumtext` TEXT NULL
    , `multilinestring` TEXT NULL
    , `multipoint` TEXT NULL
    , `multipolygon` TEXT NULL
    , `point` TEXT NULL
    , `polygon` TEXT NULL
    , `set` TEXT NULL
    , `smallint` SMALLINT NULL
    , `text` TEXT NULL
    , `time` TEXT NULL
    , `time3` TEXT NULL
    , `time6` TEXT NULL
    , `timestamp` TIMESTAMP NULL
    , `timestamp3` TIMESTAMP(3) NULL
    , `timestamp6` TEXT NULL
    , `tinyblob` BLOB NULL
    , `tinyint` TINYINT NULL
    , `tinytext` TEXT NULL
    , `varbinary` VARBINARY(1024) NULL
    , `varchar` VARCHAR(255) NULL
    , `year` SMALLINT NULL
);

CREATE TABLE [datatypes_oracle] (
    ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
    , "BINARY_DOUBLE" DOUBLE NULL
    , "BINARY_FLOAT" FLOAT NULL
    , "BLOB" BLOB NULL
    , "CHAR" CHAR(10) NULL
    , "CHAR36" CHAR(36) NULL
    , "CLOB" CLOB NULL
    , "DATE" DATE NULL
    , "FLOAT" TEXT NULL
    , "FLOAT1" FLOAT(1) NULL
    , "FLOAT23" FLOAT(23) NULL
    , "FLOAT49" FLOAT(49) NULL
    , "FLOAT63" TEXT NULL
    , "INTERVAL_DS" TEXT NULL
    , "INTERVAL_YM" TEXT NULL
    , "LONG" TEXT NULL
    , "NCHAR" NCHAR(10) NULL
    , "NCLOB" CLOB NULL
    , "NUMBER" NUMBER NULL
    , "NUMBER1" NUMBER(1) NULL
    , "NUMBER2" NUMBER(2) NULL
    , "NUMBER3" NUMBER(3) NULL
    , "NUMBER4" NUMBER(4) NULL
    , "NUMBER5" SMALLINT NULL
    , "NUMBER9" INT NULL
    , "NUMBER10" INT NULL
    , "NUMBER18" BIGINT NULL
    , "NUMBER19" BIGINT NULL
    , "NUMBER104" NUMBER(10,4) NULL
    , "NUMBER152" NUMBER(15,2) NULL
    , "NUMBER194" TEXT NULL
    , "NVARCHAR2" TEXT NULL
    , "RAW" RAW(1024) NULL
    , "TIMESTAMP" TEXT NULL
    , "TIMESTAMP0" TIMESTAMP(0) NULL
    , "TIMESTAMP3" TIMESTAMP(3) NULL
    , "TIMESTAMP_LTZ" TEXT NULL
    , "TIMESTAMP_LTZ0" TIMESTAMP(0) NULL
    , "TIMESTAMP_LTZ3" TIMESTAMP(3) NULL
    , "TIMESTAMP_TZ" TEXT NULL
    , "TIMESTAMP_TZ0" TEXT NULL
    , "TIMESTAMP_TZ3" TEXT NULL
    , "VARCHAR2" VARCHAR2(255) NULL
    , "XML" TEXT NULL
);

CREATE TABLE [datatypes_db2] (
    ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
    , "BIGINT" BIGINT NULL
    , "BINARY" BINARY(8) NULL
    , "BINARY16" BINARY(16) NULL
    , "BLOB" BLOB NULL
    , "CHAR" CHAR(10) NULL
    , "CHAR36" CHAR(36) NULL
    , "CLOB" CLOB NULL
    , "DATE" DATE NULL
    , "DBCLOB" CLOB NULL
    , "DECFLOAT" DECIMAL NULL
    , "DECIMAL152" DECIMAL(15,2) NULL
    , "DECIMAL154" DECIMAL(15,4) NULL
    , "DECIMAL310" TEXT NULL
    , "DECIMAL314" TEXT NULL
    , "DOUBLE" DOUBLE NULL
    , "GRAPHIC" CHAR(10) NULL
    , "INTEGER" INT NULL
    , "REAL" REAL NULL
    , "SMALLINT" SMALLINT NULL
    , "TIME" TEXT NULL
    , "TIMESTAMP" TEXT NULL
    , "TIMESTAMP0" TIMESTAMP(0) NULL
    , "TIMESTAMP3" TIMESTAMP(3) NULL
    , "VARBINARY" VARBINARY(1024) NULL
    , "VARCHAR" VARCHAR(255) NULL
    , "VARGRAPHIC" VARCHAR(1024) NULL
    , "XML" TEXT NULL
);

CREATE TABLE [datatypes_nuodb] (
    ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
    , "BIGINT" BIGINT NULL
    , "BINARY" BINARY(8) NULL
    , "BLOB" BLOB NULL
    , "BOOLEAN" BOOLEAN NULL
    , "CLOB" CLOB NULL
    , "VARCHAR" VARCHAR(255) NULL
    , "CHAR" CHAR(10) NULL
    , "CHAR36" CHAR(36) NULL
    , "DATE" DATE NULL
    , "DOUBLE" DOUBLE NULL
    , "INTEGER" INT NULL
    , "NUMBER" NUMBER NULL
    , "NUMERIC" NUMERIC(15,2) NULL
    , "SMALLINT" SMALLINT NULL
    , "STRING" STRING NULL
    , "TEXT" TEXT NULL
    , "TIME" TEXT NULL
    , "TIME0" TEXT NULL
    , "TIME3" TEXT NULL
    , "TIMESTAMP" TEXT NULL
    , "TIMESTAMP0" TIMESTAMP(0) NULL
    , "TIMESTAMP3" TIMESTAMP(3) NULL
    , "VARBINARY" VARBINARY(1024) NULL
);

INSERT INTO [datatypes_db2] ([BIGINT],[BINARY],[BINARY16],[BLOB],[CHAR],[CHAR36],[CLOB],[DATE],[DBCLOB],[DECFLOAT],[DECIMAL152],[DECIMAL154],[DECIMAL310],[DECIMAL314],[DOUBLE],[GRAPHIC],[INTEGER],[REAL],[SMALLINT],[TIME],[TIMESTAMP],[TIMESTAMP0],[TIMESTAMP3],[VARBINARY],[VARCHAR],[VARGRAPHIC],[XML]) VALUES (123456789012345,X'0A0B0C0000000000',X'000102030405060708090A0B0C0D0E0F',X'0A0B0C','char      ','00010203-0405-0607-0809-0a0b0c0d0e0f','clob1','2021-12-10','DBCLOB',123456789012.12,123456789012.12,1234567890.1234,'1234567890123456789','1234567890123456789.1234',123456789012.12,'graphic   ',2147483647,1234567,32767,'15:20:10','2021-12-10T15:20:10.1234560','2021-12-10 15:20:10','2021-12-10 15:20:10.123',X'0A0B0C','varchar','vargraphic','<root/>');
INSERT INTO [datatypes_db2] ([BIGINT],[BINARY],[BINARY16],[BLOB],[CHAR],[CHAR36],[CLOB],[DATE],[DBCLOB],[DECFLOAT],[DECIMAL152],[DECIMAL154],[DECIMAL310],[DECIMAL314],[DOUBLE],[GRAPHIC],[INTEGER],[REAL],[SMALLINT],[TIME],[TIMESTAMP],[TIMESTAMP0],[TIMESTAMP3],[VARBINARY],[VARCHAR],[VARGRAPHIC],[XML]) VALUES (123456789012345,X'0A0B0C0000000000',X'000102030405060708090A0B0C0D0E0F',X'0A0B0C','char      ','00010203-0405-0607-0809-0a0b0c0d0e0f','clob1','2021-12-10','DBCLOB',123456789012.12,123456789012.12,1234567890.1234,'1234567890123456789','1234567890123456789.1234',123456789012.12,'graphic   ',2147483647,1234567,32767,'15:20:10','2021-12-10T15:20:10.1234560','2021-12-10 15:20:10','2021-12-10 15:20:10.123',X'0A0B0C','varchar','vargraphic','<root/>');

INSERT INTO [datatypes_mssql] ([bigint],[binary],[binary16],[bit],[char],[char36],[date],[datetime],[datetime20],[datetime23],[datetime27],[datetimeoffset0],[datetimeoffset3],[datetimeoffset7],[decimal],[decimal92],[decimal150],[decimal152],[decimal192],[decimal282],[decimal382],[float],[geography],[geometry],[hierarchyid],[image],[int],[money],[nchar],[ntext],[numeric],[numeric92],[numeric150],[numeric152],[numeric192],[numeric282],[numeric382],[nvarchar],[nvarcharmax],[real],[smalldatetime],[smallint],[smallmoney],[sql_variant],[sysname],[text],[time0],[time3],[time7],[timestamp],[tinyint],[uniqueidentifier],[varbinary],[varchar],[varcharmax],[xml]) VALUES (123456789012345,X'0A0B0C0000000000',X'030201000504070608090A0B0C0D0E0F',1,'char      ','00010203-0405-0607-0809-0a0b0c0d0e0f','2021-12-10','2021-12-10 15:20:10.123','2021-12-10 15:20:10','2021-12-10 15:20:10.123','2021-12-10T15:20:10.1234567','2021-12-10T15:20:10.0000000+00:00','2021-12-10T15:20:10.1230000+00:00','2021-12-10T15:20:10.1234567+00:00',123456789012345678,1234567.12,123456789012345,123456789012.12,'12345678901234567.12','12345678901234567890123456.12','12345678901234567890123456.12',1234567890123.45,'LINESTRING (-122.36 47.656, -122.343 47.656)','LINESTRING (100 100, 20 180, 180 180)','/',X'0A0B0C',1234567890,123456789012.12,'nchar     ','ntext',123456789012345678,1234567.12,123456789012345,123456789012.12,'12345678901234567.12','12345678901234567.12','12345678901234567890123456.12','nvarchar','nvarcharmax',1234567,'2021-12-10 15:20:00',32767,214748.36,'sql_variant','sysname','text','15:20:10','15:20:10.1230000','15:20:10.1234567',X'0000000000008576',255,'00010203-0405-0607-0809-0a0b0c0d0e0f',X'0A0B0C','varchar','varchar(max)','<root />');
INSERT INTO [datatypes_mssql] ([bigint],[binary],[binary16],[bit],[char],[char36],[date],[datetime],[datetime20],[datetime23],[datetime27],[datetimeoffset0],[datetimeoffset3],[datetimeoffset7],[decimal],[decimal92],[decimal150],[decimal152],[decimal192],[decimal282],[decimal382],[float],[geography],[geometry],[hierarchyid],[image],[int],[money],[nchar],[ntext],[numeric],[numeric92],[numeric150],[numeric152],[numeric192],[numeric282],[numeric382],[nvarchar],[nvarcharmax],[real],[smalldatetime],[smallint],[smallmoney],[sql_variant],[sysname],[text],[time0],[time3],[time7],[timestamp],[tinyint],[uniqueidentifier],[varbinary],[varchar],[varcharmax],[xml]) VALUES (123456789012345,X'0A0B0C0000000000',X'030201000504070608090A0B0C0D0E0F',1,'char      ','00010203-0405-0607-0809-0a0b0c0d0e0f','2021-12-10','2021-12-10 15:20:10.123','2021-12-10 15:20:10','2021-12-10 15:20:10.123','2021-12-10T15:20:10.1234567','2021-12-10T15:20:10.0000000+00:00','2021-12-10T15:20:10.1230000+00:00','2021-12-10T15:20:10.1234567+00:00',123456789012345678,1234567.12,123456789012345,123456789012.12,'12345678901234567.12','12345678901234567890123456.12','12345678901234567890123456.12',1234567890123.45,'LINESTRING (-122.36 47.656, -122.343 47.656)','LINESTRING (100 100, 20 180, 180 180)','/',X'0A0B0C',1234567890,123456789012.12,'nchar     ','ntext',123456789012345678,1234567.12,123456789012345,123456789012.12,'12345678901234567.12','12345678901234567.12','12345678901234567890123456.12','nvarchar','nvarcharmax',1234567,'2021-12-10 15:20:00',32767,214748.36,'sql_variant','sysname','text','15:20:10','15:20:10.1230000','15:20:10.1234567',X'0000000000008576',255,'00010203-0405-0607-0809-0a0b0c0d0e0f',X'0A0B0C','varchar','varchar(max)','<root />');

INSERT INTO [datatypes_mysql] ([bigint],[binary],[binary16],[bit1],[bit3],[blob],[char],[char36],[date],[datetime],[datetime3],[datetime6],[decimal152],[decimal194],[double],[enum],[float],[geometry],[geometrycollection],[int],[json],[linestring],[longblob],[longtext],[mediumblob],[mediumint],[mediumtext],[multilinestring],[multipoint],[multipolygon],[point],[polygon],[set],[smallint],[text],[time],[time3],[time6],[timestamp],[timestamp3],[timestamp6],[tinyblob],[tinyint],[tinytext],[varbinary],[varchar],[year]) VALUES (123456789012345,X'0A0B0C0000000000',X'030201000504070608090A0B0C0D0E0F',1,'7',X'0A0B0C','char','00010203-0405-0607-0809-0a0b0c0d0e0f','2021-12-10','2021-12-10 15:12:11','2021-12-10 15:20:10.123','10.12.2021 15:20:10.123456',123456789012.12,'123456789012345.1234',123456789012.12,'x-large',123456,'POINT(10 10)','GEOMETRYCOLLECTION(POINT(10 10),POINT(30 30),LINESTRING(15 15,20 20))',1234567890,'[1, 2, 3]','LINESTRING(0 0,10 10,20 25,50 60)',X'0A0B0C','long text',X'0A0B0C',8388607,'medium text','MULTILINESTRING((10 10,11 11),(9 9,10 10))','MULTIPOINT((0 0),(20 20),(60 60))','MULTIPOLYGON(((0 0,10 0,10 10,0 10,0 0)),((5 5,7 5,7 7,5 7,5 5)))','POINT(15 20)','POLYGON((0 0,10 0,10 10,0 10,0 0),(5 5,7 5,7 7,5 7,5 5))','a,d',32767,'text','15:20:10','15:20:10.1230000','15:20:10.1234560','2021-12-10 15:12:11','2021-12-10 15:12:11.123','2021-12-10T15:12:11.1234560',X'0A0B0C',127,'tiny text',X'0A0B0C','varchar',2021);
INSERT INTO [datatypes_mysql] ([bigint],[binary],[binary16],[bit1],[bit3],[blob],[char],[char36],[date],[datetime],[datetime3],[datetime6],[decimal152],[decimal194],[double],[enum],[float],[geometry],[geometrycollection],[int],[json],[linestring],[longblob],[longtext],[mediumblob],[mediumint],[mediumtext],[multilinestring],[multipoint],[multipolygon],[point],[polygon],[set],[smallint],[text],[time],[time3],[time6],[timestamp],[timestamp3],[timestamp6],[tinyblob],[tinyint],[tinytext],[varbinary],[varchar],[year]) VALUES (123456789012345,X'0A0B0C0000000000',X'030201000504070608090A0B0C0D0E0F',1,'7',X'0A0B0C','char','00010203-0405-0607-0809-0a0b0c0d0e0f','2021-12-10','2021-12-10 15:12:11','2021-12-10 15:20:10.123','10.12.2021 15:20:10.123456',123456789012.12,'123456789012345.1234',123456789012.12,'x-large',123456,'POINT(10 10)','GEOMETRYCOLLECTION(POINT(10 10),POINT(30 30),LINESTRING(15 15,20 20))',1234567890,'[1, 2, 3]','LINESTRING(0 0,10 10,20 25,50 60)',X'0A0B0C','long text',X'0A0B0C',8388607,'medium text','MULTILINESTRING((10 10,11 11),(9 9,10 10))','MULTIPOINT((0 0),(20 20),(60 60))','MULTIPOLYGON(((0 0,10 0,10 10,0 10,0 0)),((5 5,7 5,7 7,5 7,5 5)))','POINT(15 20)','POLYGON((0 0,10 0,10 10,0 10,0 0),(5 5,7 5,7 7,5 7,5 5))','a,d',32767,'text','15:20:10','15:20:10.1230000','15:20:10.1234560','2021-12-10 15:12:11','2021-12-10 15:12:11.123','2021-12-10T15:12:11.1234560',X'0A0B0C',127,'tiny text',X'0A0B0C','varchar',2021);

INSERT INTO [datatypes_nuodb] ([BIGINT],[BINARY],[BLOB],[BOOLEAN],[CLOB],[VARCHAR],[CHAR],[CHAR36],[DATE],[DOUBLE],[INTEGER],[NUMBER],[NUMERIC],[SMALLINT],[STRING],[TEXT],[TIME],[TIME0],[TIME3],[TIMESTAMP],[TIMESTAMP0],[TIMESTAMP3],[VARBINARY]) VALUES (123456789012345,X'0A0B0C',X'0A0B0C',1,'char','varchar','char','00010203-0405-0607-0809-0a0b0c0d0e0f','2021-12-10',123456789012.12,2147483647,123456789012.12,123456789012.12,32767,'string','text','15:20:10.1234567','15:20:10','15:20:10.123','2021-12-10T15:20:10.1234567','2021-12-10 15:20:10','2021-12-10 15:20:10.123',X'0A0B0C');
INSERT INTO [datatypes_nuodb] ([BIGINT],[BINARY],[BLOB],[BOOLEAN],[CLOB],[VARCHAR],[CHAR],[CHAR36],[DATE],[DOUBLE],[INTEGER],[NUMBER],[NUMERIC],[SMALLINT],[STRING],[TEXT],[TIME],[TIME0],[TIME3],[TIMESTAMP],[TIMESTAMP0],[TIMESTAMP3],[VARBINARY]) VALUES (123456789012345,X'0A0B0C',X'0A0B0C',1,'char','varchar','char','00010203-0405-0607-0809-0a0b0c0d0e0f','2021-12-10',123456789012.12,2147483647,123456789012.12,123456789012.12,32767,'string','text','15:20:10.1234567','15:20:10','15:20:10.123','2021-12-10T15:20:10.1234567','2021-12-10 15:20:10','2021-12-10 15:20:10.123',X'0A0B0C');

INSERT INTO [datatypes_oracle] ([BINARY_DOUBLE],[BINARY_FLOAT],[BLOB],[CHAR],[CHAR36],[CLOB],[DATE],[FLOAT],[FLOAT1],[FLOAT23],[FLOAT49],[FLOAT63],[INTERVAL_DS],[INTERVAL_YM],[LONG],[NCHAR],[NCLOB],[NUMBER],[NUMBER1],[NUMBER2],[NUMBER3],[NUMBER4],[NUMBER5],[NUMBER9],[NUMBER10],[NUMBER18],[NUMBER19],[NUMBER104],[NUMBER152],[NUMBER194],[NVARCHAR2],[RAW],[TIMESTAMP],[TIMESTAMP0],[TIMESTAMP3],[TIMESTAMP_LTZ],[TIMESTAMP_LTZ0],[TIMESTAMP_LTZ3],[TIMESTAMP_TZ],[TIMESTAMP_TZ0],[TIMESTAMP_TZ3],[VARCHAR2],[XML]) VALUES (1234545678901.12,12345.12,X'0A0B0C','char      ','00010203-0405-0607-0809-0a0b0c0d0e0f','clob','2021-12-10','1234567890123456789.12',1,12345.12,1234545678901.12,'12345456789012345.12','2.10:30:00','+02-01','long','nchar     ','nclob',1234567890123460000,9,12,999,1234,12345,123456789,1234567890,123456789012345678,1234567890123456789,123456.1234,1234567890123.12,'123456789012345.1234','nvarchar2',X'0A0B0C','2021-12-10T15:20:10.1234560','2021-12-10 15:20:10','2021-12-10 15:20:10.123','2021-12-10T15:20:10.1234560','2021-12-10 15:20:10','2021-12-10 15:20:10.123','2021-10-12T15:20:10.1234560+00:00','2021-10-12T15:20:10+00:00','2021-10-12T15:20:10.123+00:00','varchar','<root/>');
INSERT INTO [datatypes_oracle] ([BINARY_DOUBLE],[BINARY_FLOAT],[BLOB],[CHAR],[CHAR36],[CLOB],[DATE],[FLOAT],[FLOAT1],[FLOAT23],[FLOAT49],[FLOAT63],[INTERVAL_DS],[INTERVAL_YM],[LONG],[NCHAR],[NCLOB],[NUMBER],[NUMBER1],[NUMBER2],[NUMBER3],[NUMBER4],[NUMBER5],[NUMBER9],[NUMBER10],[NUMBER18],[NUMBER19],[NUMBER104],[NUMBER152],[NUMBER194],[NVARCHAR2],[RAW],[TIMESTAMP],[TIMESTAMP0],[TIMESTAMP3],[TIMESTAMP_LTZ],[TIMESTAMP_LTZ0],[TIMESTAMP_LTZ3],[TIMESTAMP_TZ],[TIMESTAMP_TZ0],[TIMESTAMP_TZ3],[VARCHAR2],[XML]) VALUES (1234545678901.12,12345.12,X'0A0B0C','char      ','00010203-0405-0607-0809-0a0b0c0d0e0f','clob','2021-12-10','1234567890123456789.12',1,12345.12,1234545678901.12,'12345456789012345.12','2.10:30:00','+02-01','long','nchar     ','nclob',1234567890123460000,9,12,999,1234,12345,123456789,1234567890,123456789012345678,1234567890123456789,123456.1234,1234567890123.12,'123456789012345.1234','nvarchar2',X'0A0B0C','2021-12-10T15:20:10.1234560','2021-12-10 15:20:10','2021-12-10 15:20:10.123','2021-12-10T15:20:10.1234560','2021-12-10 15:20:10','2021-12-10 15:20:10.123','2021-10-12T15:20:10.1234560+00:00','2021-10-12T15:20:10+00:00','2021-10-12T15:20:10.123+00:00','varchar','<root/>');

INSERT INTO [datatypes_pgsql] ([bigint],[bit3],[boolean],[box],[bytea],[char],[char36],[cidr],[circle],[date],[double_precision],[inet],[integer],[interval],[json],[jsonb],[line],[lseg],[macaddr],[money],[money15],[numeric],[numeric152],[real],[path],[point],[polygon],[text],[time],[time0],[time3],[timetz],[timetz0],[timetz3],[timestamp],[timestamp0],[timestamp3],[timestamptz],[timestamptz0],[timestamptz3],[uuid],[varbit],[varchar],[xml]) VALUES (123456789012345,'101',1,'(1,1),(0,0)',X'0A0B0C','char      ','00010203-0405-0607-0809-0a0b0c0d0e0f','192.168.100.128/32','<(0,0),2>','2021-12-10',123456789012.12,'192.168.100.128',1234567890,'3 days','[1,2,3]','[1, 2, 3]','{0,-1,0}','[(-1,0),(1,0)]','08:00:2b:01:02:03','12345678901234567.12',1234567890123.12,'12345678901234567.12',1234567890123.12,1234567,'((0,0),(1,1),(2,0))','(0,0)','((0,0),(1,1),(2,0))','text','15:20:10.1234560','15:20:10','15:20:10.1230000','15:20:10.1234560','15:20:10','15:20:10.1230000','2021-12-10T15:20:10.1234560','2018-10-29 15:20:10','2018-10-29 15:20:10.123','2021-12-10T15:20:10.1234560','10.12.2021 15:20:10','2021-12-10T15:20:10.1230000','00010203-0405-0607-0809-0a0b0c0d0e0f','00000101','varchar','<xml />');
INSERT INTO [datatypes_pgsql] ([bigint],[bit3],[boolean],[box],[bytea],[char],[char36],[cidr],[circle],[date],[double_precision],[inet],[integer],[interval],[json],[jsonb],[line],[lseg],[macaddr],[money],[money15],[numeric],[numeric152],[real],[path],[point],[polygon],[text],[time],[time0],[time3],[timetz],[timetz0],[timetz3],[timestamp],[timestamp0],[timestamp3],[timestamptz],[timestamptz0],[timestamptz3],[uuid],[varbit],[varchar],[xml]) VALUES (123456789012345,'101',1,'(1,1),(0,0)',X'0A0B0C','char      ','00010203-0405-0607-0809-0a0b0c0d0e0f','192.168.100.128/32','<(0,0),2>','2021-12-10',123456789012.12,'192.168.100.128',1234567890,'3 days','[1,2,3]','[1, 2, 3]','{0,-1,0}','[(-1,0),(1,0)]','08:00:2b:01:02:03','12345678901234567.12',1234567890123.12,'12345678901234567.12',1234567890123.12,1234567,'((0,0),(1,1),(2,0))','(0,0)','((0,0),(1,1),(2,0))','text','15:20:10.1234560','15:20:10','15:20:10.1230000','15:20:10.1234560','15:20:10','15:20:10.1230000','2021-12-10T15:20:10.1234560','2018-10-29 15:20:10','2018-10-29 15:20:10.123','2021-12-10T15:20:10.1234560','10.12.2021 15:20:10','2021-12-10T15:20:10.1230000','00010203-0405-0607-0809-0a0b0c0d0e0f','00000101','varchar','<xml />');

INSERT INTO [datatypes_sqlce] ([bigint],[binary],[binary16],[bit],[datetime],[float],[image],[integer],[money],[nchar],[ntext],[numeric],[numeric152],[nvarchar],[real],[smallint],[timestamp],[tinyint],[uniqueidentifier],[varbinary]) VALUES (123456789012345,X'0A0B0C0000000000',X'030201000504070608090A0B0C0D0E0F',1,'2021-12-10 15:20:10',1234567,X'0A0B0C',1234567890,123456789012.12,'nchar     ','ntext',123456789012345,123456789012.45,'nvarchar',12345680,32767,X'000000000000007C',255,'00010203-0405-0607-0809-0a0b0c0d0e0f',X'0A0B0C');
INSERT INTO [datatypes_sqlce] ([bigint],[binary],[binary16],[bit],[datetime],[float],[image],[integer],[money],[nchar],[ntext],[numeric],[numeric152],[nvarchar],[real],[smallint],[timestamp],[tinyint],[uniqueidentifier],[varbinary]) VALUES (123456789012345,X'0A0B0C0000000000',X'030201000504070608090A0B0C0D0E0F',1,'2021-12-10 15:20:10',1234567,X'0A0B0C',1234567890,123456789012.12,'nchar     ','ntext',123456789012345,123456789012.45,'nvarchar',12345680,32767,X'000000000000007C',255,'00010203-0405-0607-0809-0a0b0c0d0e0f',X'0A0B0C');

INSERT INTO [datatypes_sqlite] ([bigint],[binary],[binary16],[boolean],[blob],[char],[char36],[clob],[date],[datetime],[datetimeoffset],[decimal],[double],[float],[guid],[int],[json],[nchar],[ntext],[numeric],[nvarchar],[real],[smallint],[text],[time],[timestamp],[timestamptz],[tinyint],[varbinary],[varchar],[xml]) VALUES (123456789012345,X'0A0B0C0000000000',X'030201000504070608090A0B0C0D0E0F',1,X'0A0B0C','char','00010203-0405-0607-0809-0a0b0c0d0e0f','clob','2021-12-10','2021-12-10 15:20:10.123','2021-12-10 15:20:10+00:00',123456789012.12,123456789012.12,123456789012.12,'00010203-0405-0607-0809-0a0b0c0d0e0f',1234567890,'[1,2,3]','nchar','ntext',123456789012.12,'nvarchar',123456789012.12,32767,'text','15:20:10','2021-12-10 15:20:10.123','2021-12-10 15:20:10.123',255,X'0A0B0C','varchar','<root />');
INSERT INTO [datatypes_sqlite] ([bigint],[binary],[binary16],[boolean],[blob],[char],[char36],[clob],[date],[datetime],[datetimeoffset],[decimal],[double],[float],[guid],[int],[json],[nchar],[ntext],[numeric],[nvarchar],[real],[smallint],[text],[time],[timestamp],[timestamptz],[tinyint],[varbinary],[varchar],[xml]) VALUES (123456789012345,X'0A0B0C0000000000',X'030201000504070608090A0B0C0D0E0F',1,X'0A0B0C','char','00010203-0405-0607-0809-0a0b0c0d0e0f','clob','2021-12-10','2021-12-10 15:20:10.123','2021-12-10 15:20:10+00:00',123456789012.12,123456789012.12,123456789012.12,'00010203-0405-0607-0809-0a0b0c0d0e0f',1234567890,'[1,2,3]','nchar','ntext',123456789012.12,'nvarchar',123456789012.12,32767,'text','15:20:10','2021-12-10 15:20:10.123','2021-12-10 15:20:10.123',255,X'0A0B0C','varchar','<root />');

INSERT INTO [quotes] (['], [''], [,], [-], [@], [@@], [`], [``], ["], [""], "]", "[", "[]", [+], [*], [%], [%%], [=], [;], [:], [<>], [&], [.], [..]) VALUES ('''', '''''', ',', '-', '@', '@@', '`', '``', '"', '""', ']', '[', '[]', '+', '*', '%', '%%', '=', ';', ':', '<>', '&', '.', '..');
INSERT INTO [quotes] (['], [''], [,], [-], [@], [@@], [`], [``], ["], [""], "]", "[", "[]", [+], [*], [%], [%%], [=], [;], [:], [<>], [&], [.], [..]) VALUES ('1', '2', '3', '4', '5', '6', '`', '``', '"', '""', ']', '[', '[]', '+', '*', '%', '%%', '=', ';', ':', '<>', '&', '.', '..');

-- print Application installed
