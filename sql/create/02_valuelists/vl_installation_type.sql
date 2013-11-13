/*
	qWat - QGIS Water Module
	
	SQL file :: installation_type table
*/

/* CREATE */
DROP TABLE IF EXISTS distribution.vl_installation_type CASCADE;
CREATE TABLE distribution.vl_installation_type ( id integer not null, CONSTRAINT "vl_installation_type_pk" PRIMARY KEY (id) );
COMMENT ON TABLE distribution.vl_installation_type IS 'type for installation.';

/* COLUMNS*/
ALTER TABLE distribution.vl_installation_type ADD COLUMN vl_active boolean defaut true;
ALTER TABLE distribution.vl_installation_type ADD COLUMN short_en varchar(5);
ALTER TABLE distribution.vl_installation_type ADD COLUMN short_fr varchar(5);
ALTER TABLE distribution.vl_installation_type ADD COLUMN value_en varchar(30);
ALTER TABLE distribution.vl_installation_type ADD COLUMN value_fr varchar(30);
ALTER TABLE distribution.vl_installation_type ADD COLUMN schema_visible boolean default true;

/* VALUES */
INSERT INTO distribution.vl_installation_type (id,short_fr,value_fr) VALUES (2001,'R'  ,'Réservoir'               );
INSERT INTO distribution.vl_installation_type (id,short_fr,value_fr) VALUES (2002,'S'  ,'Source'                  );
INSERT INTO distribution.vl_installation_type (id,short_fr,value_fr) VALUES (2003,'P'  ,'Pompage'                 );
INSERT INTO distribution.vl_installation_type (id,short_fr,value_fr) VALUES (2004,'CV' ,'Chambres de vannes'      );
INSERT INTO distribution.vl_installation_type (id,short_fr,value_fr) VALUES (2005,'CC' ,'Chambre compteur'        );
INSERT INTO distribution.vl_installation_type (id,short_fr,value_fr) VALUES (2006,'CT' ,'Chambre de traitement'   );
INSERT INTO distribution.vl_installation_type (id,short_fr,value_fr) VALUES (2007,'CR' ,'Chambre réducteur'       );
INSERT INTO distribution.vl_installation_type (id,short_fr,value_fr) VALUES (2008,'CCP','Chambre coupe pression'  );
INSERT INTO distribution.vl_installation_type (id,short_fr,value_fr) VALUES (2009,'CRA','Chambre de rassemblement');




