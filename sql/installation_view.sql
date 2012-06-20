/*
	qWat - QGIS Water Module
	
	SQL file :: installation view
*/

BEGIN;


DROP VIEW IF EXISTS distribution.installation_view ;
CREATE VIEW distribution.installation_view AS 
	SELECT
		installation.id                                ,
		installation.name                              ,
		installation.id_type                           ,
		installation.id_distributor                    ,
		installation.id_status                         ,
		installation.remarks                           ,
		installation.geometry::geometry(Point,21781)   ,
		installation_type.name       AS _type          ,
		installation_type.short_name AS _type_shortname,
		status.status                 AS _status        ,
		status.active                 AS _status_active ,
		distributor.name              AS _distributor   ,
		CASE 
			WHEN installation.schema_force_view IS NULL THEN installation_type.schema_view
			ELSE installation.schema_force_view
		END AS _schema_view
	FROM distribution.installation 
	INNER      JOIN distribution.installation_type  ON installation.id_type        = installation_type.id 
	INNER      JOIN distribution.status             ON installation.id_status      = status.id 
	LEFT OUTER JOIN distribution.distributor        ON installation.id_distributor = distributor.id ;


/* TODO: rules */


COMMIT;