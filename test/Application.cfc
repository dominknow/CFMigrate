<cfcomponent>
	<cfset this.basePath = replaceNoCase(replace(getCurrentTemplatePath(), "\", "/", "all"), "test/Application.cfc", "") />
	<cfset this.mappings["/migrations"] = this.basePath />
</cfcomponent>
