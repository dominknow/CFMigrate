<cfcomponent output="true">

	<cfproperty name="datasource" type="string" />
	<cfproperty name="dbUsername" type="string" />
	<cfproperty name="dbPassword" type="string" />

	<cffunction name="init" access="public" output="false" returntype="any" hint="Constructor">
		<cfargument name="datasource" type="string" required="true" />
		<cfargument name="dbUsername" type="string" default="" />
		<cfargument name="dbPassword" type="string" default="" />

		<cfset variables.datasource = arguments.datasource />
		<cfset variables.dbUsername = arguments.dbUsername />
		<cfset variables.dbPassword = arguments.dbPassword />

		<cfreturn this />
	</cffunction>

	<cffunction name="migrate_up" access="public" output="true" returntype="void">
		<!--- Add you database change here
		<cfquery name="migrate_up" datasource="#variables.datasource#" username="#variables.dbUsername#" password="#variables.dbPassword#">
		</cfquery>	
		 --->

		 <!--- Remove from your working code --->
		 <cfthrow type="cfmigrate.not_implemented" />
	</cffunction>

	<cffunction name="migrate_down" access="public" output="true" returntype="void">
		<!--- add your down database change here 
		<cfquery name="migrate_up" datasource="#variables.datasource#" username="#variables.dbUsername#" password="#variables.dbPassword#">
		</cfquery>	
		--->

		 <!--- Remove from your working code --->
		 <cfthrow type="cfmigrate.not_implemented" />
	</cffunction>
</cfcomponent>