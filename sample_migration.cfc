<cfcomponent output="true">

	<cffunction name="migrate_up" access="package" output="true" returntype="boolean">
		<cfset var return_value = true >
		<cfquery name="migrate_up" datasource="#application.isdatasource#" username="#application.isusername#" password="#application.ispassword#">
				<!--- Add you database change here --->
		</cfquery>	
		<cfreturn return_value />
	</cffunction>

	<cffunction name="migrate_down" access="package" output="true" returntype="boolean">
		<cfset var return_value = true >
		<cfquery name="migrate_up" datasource="#application.isdatasource#" username="#application.isusername#" password="#application.ispassword#">
				<!--- add your down database change here --->
		</cfquery>	
		<cfreturn return_value />
	</cffunction>
</cfcomponent>