*****************
Developer's guide
*****************

How to develop QWAT, add custom model fields, etc


Prerequisites
=============

In order to develop for QWAT, the following skills may be required :

* Good general knowledge of GIS
* Good general knowledge of QGIS
* Skills in relational databases and PostgreSQL/PostGIS specifically
* Skills in Python


Environment
===========

* You will need to [[install and configure Git and GitHub|qDG_git_github]]
* Have python 3 installed and as your default python. In case it is not, use a `virtual environment<https://docs.python.org/3/library/venv.html>`_
* have a bash shell
* have admin rights to create and drop PostgreSQL databases

QWAT architecture
=================

* Describe here various parts of QWAT
* Describe relation to other projects ( plugins, qgis core)

Roles
=====

* *Commiters* have access to QWAT code repositories and can push to them. It means they control the evolution of the software
* *contributors* can provide information, code, documentation to the project. They do not have direct access for modifications and must go through the *commiters* to get their modifications applied. See the [[Contributors_guide]] for more information and processes.
* The *release manager* is in charge of deciding when a new version of the software is published, and to actually publish the release. Current release manager for QWAT is [Denis Rouzaud](https://github.com/3nids)

Release cycles and versioning
=============================

New releases for QWAT are published on a regular basis, but non-fixed frequency. The *release manager* decides when a new version is published.

Version numbers follow as much as possible the [semantic versioning approach](http://semver.org)

You can find the installed version number in the data model, in the `qwat_sys.info` table :

* model.core : model version

Release process
===============

The release process for QWAT is the following :

* Issues are triaged with milestones for next versions
* The *release manager* decides when the next release will be made, in accordance with the community needs
* He announces the estimated release date in advance ( at least 1 week)
* Issues are re-triaged and the date can be moved according to how the work progresses
* CHANGES.md is checked to be sure that it contains a description of changes for this version
* When ready (all due tickets closed), the *release manager* add version metadata to the project and tags the project(s) to release (data model, QWAT project) with the new version,
* The *release manager* announces the new version ( mailing lists, IRC, twitter…)

Additional dependencies
=======================

QWAT Project has several dependencies on different submodules
* Fetching their content is achieved with a specific git command

Customizing the data model
==========================

This part concerns the modification of the data model to add specific objects, on top on QWAT core data model.
While there is full freedom for using PostGIS and PostgreSQL capabilities, here are the conventions and good practices for the QWAT project.

Allowed customization for QWAT are : 
* Adding a custom field
* Adding a custom table

No change of the core data model is allowed ( field names, types, constraints...), or you should [[ask for the QWAT data model to be modified centrally|Contributors_guide#data-model-changes]].

Adding a field
==============

If you want to add a field to one of the core data model tables, follow these steps

* Do the modifications on your data model
* The added field **must** have the prefix `usr_`
* You **should** write corresponding diff code against the core data model ( see example below )
* You **could** write corresponding delete diff code against the core data model ( see example below )

Example : adding a paint color information to hydrants

* 1 : add the attribute with pgadmin ( you could also directly type SQL to modify the model)
* 2 : add the following SQL equivalent instruction to a `usr_model.sql` file

.. code-block:: sql
   :linenos:

   ALTER TABLE qwat_od.hydrant ADD COLUMN usr_color integer;

* 3 : add the following SQL instruction to a `usr_model_drop.sql` file

.. code-block:: sql
   :linenos:

    ALTER TABLE qwat_od.hydrant DROP COLUMN usr_color ;


Adding a table
==============

Custom tables go to specific schemas prefixed with `usr_` . If you want to have additional custom tables, you should first ensure that such a custom schema exists.

If you want to add a table follow these steps

* Create a custom schema prefixed with `usr_`
* Add your table in this schema ( table name is free)
* You **should** write corresponding diff code against the core data model ( see example below )
* You **could** write corresponding delete diff code against the core data model ( see example below )

Example : adding color informations to hydrants

* 1 : add the `usr_cityservices` schema, and the `hydrant_paint` table with pgadmin ( you could also directly type SQL to modify the model)
* 2 : add the following SQL equivalent instruction to a `usr_model.sql` file

.. code-block:: sql
   :linenos:

    CREATE SCHEMA usr_cityservices;
    CREATE TABLE usr_cityservices.hydrant_paint (
    id serial
    , fk_hydrant integer
    , color varchar
    , paint_date timestamp
    );
    ALTER TABLE usr_cityservices.hydrant_paint ADD CONSTRAINT hydrant_fk FOREIGN KEY (fk_hydrant) REFERENCES qwat_od.hydrant(id) MATCH FULL;


* 3 : add the following SQL instruction to a `usr_model_drop.sql` file

.. code-block:: sql
   :linenos:

    ALTER TABLE usr_cityservices.hydrant_paint DROP CONSTRAINT hydrant_fk;
    DROP TABLE usr_cityservices.hydrant_paint;
    DROP SCHEMA usr_cityservices;


Versioning your extensions
==========================

Before QWAT 1.3.0 data model, version was tracked in the qwat_sys.versions that contributors had to maintain manually.
After that PUM module is taking care of raising and keeping track of versions automatically using core delta file naming convention.
However, we recommend using only one customization SQL script, with no version in its name. You can version it in a separate git or SVN repository, but mixing local and core version might lead to a very complex system.


Developing the core data model
==============================

To keep a controlled process over versioning, we have the following system :

* The SQL files corresponding to the creation of the core data model
* SQL files corresponding to the modifications from version X to version X+1 ( "diff SQL" )

Diff files are located in the repository in the "delta" directory. Their name has this convention, which is used by PUM module :

* `delta_1.3.2.sql`

Deploying a model for a specific version and applying the diff files successively to reach another version should lead to the exact same model as deploying this latter version. The QWAT project will have tools to test for this compliance.

It is advised to write the diff files at the same time as the model modification, but this is not mandatory. Diff files *must* be complete and uptodate when a new model version is released.
Before releasing a new model version, the diff files should therefore be analyzed and completed. Some code can also be refactored to simplify the diff files ( e.g. multiple modification to the same field between two version)

Some delta file are simple, like new tables and views. Some are more more complex since they are exposed via views. Most views in QWAT are autogenerated by the meta-project module.
That means that adding user fields (in elements or pipes for instance), will require additional instructions to drop and recreate the views before / after applying you delta file.
PUM allows to add pre and post files, either in python or sql for each update, see delta.1.2.8 for exemples. 

As a consequence, when developing the core data model, you should : 

* Put your modifications to the core model SQL files
* Add your modifications to the correct diff file.


Your pull request should be complete with these elements, or you have to be ready to review the diff SQL files before the release to ensure that the diff are uptodate.

Developing a QGIS project
=========================

* How to modify default project or create a new one
* How to share these modifications

Adding new features to QWAT
===========================

* see contributor's guide for discussion process & issue management
* creating a specific plugin
* contributing to QGIS core
