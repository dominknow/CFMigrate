<cfcomponent output="true" hint="The sample component used to create new migrations CFCs">

	<cfproperty name="datasource" type="string" />
	<cfproperty name="dbUsername" type="string" />
	<cfproperty name="dbPassword" type="string" />

	<cffunction 
		name="init" 
		access="public" 
		output="false" 
		returntype="any" 
		hint="Ths public Constructor">

		<cfargument 
			name="datasource" 
			type="string" 
			required="true"
			hint="The datasource to operate on.  Passed in my run_migration." />
		<cfargument 
			name="dbUsername" 
			type="string" 
			default=""
			hint="The database user name, if required." />
		<cfargument 
			name="dbPassword" 
			type="string" 
			default=""
			hint="The database password, if required." />

		<cfset variables.datasource = arguments.datasource />
		<cfset variables.dbUsername = arguments.dbUsername />
		<cfset variables.dbPassword = arguments.dbPassword />

		<cfreturn this />
	</cffunction>

	<cffunction 
		name="migrate_up" 
		access="public" 
		output="true" 
		returntype="void"
		hint="Method called to run the migration and update the database.">
		<!--- Add you database change here
		<cfquery name="migrate_up" datasource="#variables.datasource#" username="#variables.dbUsername#" password="#variables.dbPassword#">
		</cfquery>	
		 --->

		 <!--- Remove from your working code --->
		 <cfthrow type="cfmigrate.not_implemented" />
	</cffunction>

	<cffunction 
		name="migrate_down" 
		access="public" 
		output="true" 
		returntype="void"
		hint="Method called to rollback the migration. Should throw an exception if rolling back from this migration is not possible.">
		<!--- add your down database change here 
		<cfquery name="migrate_up" datasource="#variables.datasource#" username="#variables.dbUsername#" password="#variables.dbPassword#">
		</cfquery>	
		--->

		 <!--- Remove from your working code --->
		 <cfthrow type="cfmigrate.not_implemented" />
	</cffunction>
</cfcomponent>
