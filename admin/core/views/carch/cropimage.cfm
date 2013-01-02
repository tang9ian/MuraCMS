<!---<cfcontent type="application/json">--->
<cfoutput>#createObject("component","com.mura.json").encode(application.serviceFactory.getBean('fileManager').cropAndScale(argumentCollection=rc))#</cfoutput>
<cfabort>