<!--- This file is part of Mura CMS.

Mura CMS is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, Version 2 of the License.

Mura CMS is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Mura CMS. If not, see <http://www.gnu.org/licenses/>.

Linking Mura CMS statically or dynamically with other modules constitutes the preparation of a derivative work based on 
Mura CMS. Thus, the terms and conditions of the GNU General Public License version 2 ("GPL") cover the entire combined work.

However, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with programs
or libraries that are released under the GNU Lesser General Public License version 2.1.

In addition, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with 
independent software modules (plugins, themes and bundles), and to distribute these plugins, themes and bundles without 
Mura CMS under the license of your choice, provided that you follow these specific guidelines: 

Your custom code 

• Must not alter any default objects in the Mura CMS database and
• May not alter the default display of the Mura CMS logo within Mura CMS and
• Must not alter any files in the following directories.

 /admin/
 /tasks/
 /config/
 /requirements/mura/
 /Application.cfc
 /index.cfm
 /MuraProxy.cfc

You may copy and distribute Mura CMS with a plug-in, theme or bundle that meets the above guidelines as a combined work 
under the terms of GPL for Mura CMS, provided that you include the source code of that other code when and as the GNU GPL 
requires distribution of source code.

For clarity, if you create a modified version of Mura CMS, you are not obligated to grant this special exception for your 
modified version; it is your choice whether to do so, or to make such modified version available under the GNU General Public License 
version 2 without this exception.  You may, if you choose, apply this exception to your own modified versions of Mura CMS.
--->
<cfset $=application.serviceFactory.getBean('$').init(feedBean.getSiteID())>
<cfheader name="content-type" value="text/xml"><cfcontent reset="yes"><cfoutput><?xml version="1.0" ?>
<rss version="0.92"
	xmlns:dc="http://purl.org/dc/elements/1.1/">
	<channel>
		<title>#XMLFormat(feedBean.renderName())#</title> 
		<link>http://#listFirst(cgi.http_host,":")#</link> 
		<description>#XMLFormat(feedBean.getDescription())#</description> 
		<webMaster>#application.settingsManager.getSite(feedBean.getSiteID()).getContact()#</webMaster> 
		<language>#feedBean.getLang()#</language>
<cfloop condition="feedIt.hasNext()"><cfsilent>
<cfset item=feedIt.next()>
<cfset itemdescription=item.getValue('summary')>
<cfif feedBean.getallowhtml() eq 0>
	<cfif not len(itemdescription)>
		<cfset itemdescription=item.getValue('body')>
	</cfif>	
	<cfset itemdescription = $.stripHTML($.setDynamicContent(itemdescription))>
	<cfset itemdescription=left(itemdescription,200) & "...">
<cfelse>
	<cfset itemdescription = $.addCompletePath($.setDynamicContent(itemdescription),feedBean.getSiteID())>
</cfif>
<cfif isDate(item.getValue('releaseDate'))>
	<cfset thePubDate=item.getValue('releaseDate')>
<cfelse>
	<cfset thePubDate=item.getValue('lastUpdate')>
</cfif>
<cfset rsCats=application.contentManager.getCategoriesByHistID(item.getValue('contentHistID'))>

<cfset theLink=XMLFormat(item.getURL(complete=true)) />
</cfsilent>
		<item>
			<title>#XMLFormat(item.getMenuTitle())#</title>
			<description><![CDATA[#itemdescription# ]]></description> 
			<link>#theLink#</link>
			<guid isPermaLink="true">#theLink#</guid>
			<dc:date>#GetHttpTimeString(thePubDate)#</dc:date>
			<cfif item.getValue('type') eq "File"><cfset fileMeta=application.serviceFactory.getBean("fileManager").readMeta(item.getValue('fileID'))><enclosure url="#XMLFormat('http://#application.settingsManager.getSite(item.getValue('siteID')).getDomain()##application.configBean.getServerPort()##application.configBean.getContext()#/tasks/render/file/index.cfm?fileID=#item.getValue('fileID')#&fileEXT=.#item.getValue('fileExt')#')#" length="#fileMeta.filesize#" type="#fileMeta.ContentType#/#fileMeta.ContentSubType#" /></cfif>
		</item></cfloop>
	</channel>
</rss></cfoutput>
