/*
	qWat - QGIS Water Module

	SQL file :: installation sources auxiliary tables
*/

/* source quality */
DROP TABLE IF EXISTS distribution.vl_source_quality CASCADE;
CREATE TABLE distribution.vl_source_quality (id integer not null, CONSTRAINT vl_source_quality_pk PRIMARY KEY (id) );

/* COLUMNS */
ALTER TABLE distribution.vl_source_quality ADD COLUMN vl_active boolean default true;
ALTER TABLE distribution.vl_source_quality ADD COLUMN value_en varchar(30) default '' ;
ALTER TABLE distribution.vl_source_quality ADD COLUMN value_fr varchar(30) default '' ;
ALTER TABLE distribution.vl_source_quality ADD COLUMN code_sire smallint              ;

/* CONTENT */
INSERT INTO distribution.vl_source_quality (id,code_sire,value_fr) VALUES (2601, 0, 'inconnue');
INSERT INTO distribution.vl_source_quality (id,code_sire,value_fr) VALUES (2602, 1, 'bonne');
INSERT INTO distribution.vl_source_quality (id,code_sire,value_fr) VALUES (2603, 2, 'conditionnellement bonne');
INSERT INTO distribution.vl_source_quality (id,code_sire,value_fr) VALUES (2604, 3, 'désinfection obligatoire');
