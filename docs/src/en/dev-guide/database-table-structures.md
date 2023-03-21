# Database table structures
We use [flyway](https://flywaydb.org/) to manage our database table structures.
When deploying HoloInsight to a new environment, flyway helps to create all tables for us.
When we make a database structures change in dev environment, and upgrade existing HoloInsight in an existing prod environment, flyway helps to upgrade the database structures too.

When you want to make a database structure change, you need to add the DDLs as a file under the directory `./server/extension/extension-common-flyway/src/main/resources/db/migration`.
The sql file name must match the format: `V${n}__${date}_${comment}.sql` .  
For example: `V3__230321_AlarmRule_COLUMN_workspace.sql`.  
Once the sql file is officially released, it cannot be modified or deleted.  
If you find some errors in the previous sql file, then you need to add another sql file to fix it.
