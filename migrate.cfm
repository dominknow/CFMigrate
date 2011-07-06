<cfif not IsDefined("url.action")>
	<p>No action was provided. You must include an action in the form of "migrate.cfm?action=run". Allowable actions are (run, setup, create)</p>
<cfelseif URL.action eq "run">
	<cfset migrate_cfc = createObject("component", "migrations.migrate")>
	<cfif isdefined("url.version")>
		<cfset answer = migrate_cfc.run_migrations(url.version) >
	<cfelse>
		<cfset answer = migrate_cfc.run_migrations() >
	</cfif>
<cfelseif url.action eq "setup">
	<cfset migrate_cfc = createObject("component", "migrations.migrate")>
	<cfset answer = migrate_cfc.setup_migrations() >
<cfelseif url.action eq "create">
	<cfset migrate_cfc = createObject("component", "migrations.migrate")>
	<cfif isdefined("url.name")>
		<cfset answer = migrate_cfc.create_migration(url.name) >
	<cfelse>
		<p>You must supply a migration name (i.e. "migrate.cfm?action=create&name=addindextousertable") when using the create action</p>
	</cfif>
<cfelse>
	<p>An incorrect action was sent, so no action was performed. You must include an action in the form of "migrate.cfm?action=run". Allowable actions are (run, setup, create)</p>
</cfif>

