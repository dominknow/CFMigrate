# CFMigrate - Database Migrations in ColdFusion

The purpose of this project is to provide a framework for database migrations in ColdFusion, similar
to the Rails framework.

The original project can be found at http://cfmigrate.svn.sourceforge.net/viewvc/cfmigrate/.  The code is written in tag based syntax and should work 
with versions 7 or 8 of ColdFusion, but I've only tested on CF 9.  The associated unit tests require mxUnit and utilize pure cfscript and nested transactions, so will
require a CFML engine supporting those features.


