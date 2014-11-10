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
<cfoutput>
<h1>#application.rbFactory.getKeyValue(session.rb,'user.adminusersearchresults')#</h1>

<form class="form-inline" novalidate="novalidate" action="index.cfm" method="get" name="form1" id="siteSearch">
  <div class="input-append">
      <input id="search" name="search" type="text" value="#esapiEncode('html_attr',rc.search)#" />
      <button type="button" class="btn" onclick="submitForm(document.forms.form1);" value="#application.rbFactory.getKeyValue(session.rb,'user.search')#" /><i class="icon-search"></i></button>
  </div>
<input type="hidden" name="muraAction" value="cPrivateUsers.Search" />
<input type="hidden" name="siteid" value="#esapiEncode('html_attr',rc.siteid)#">
</form>

        <table class="mura-table-grid">
          <tr> 
            <th class="var-width">Name</th>
            <th>#application.rbFactory.getKeyValue(session.rb,'user.email')#</th>
            <th>#application.rbFactory.getKeyValue(session.rb,'user.update')#</th>
            <th>Time</th>
            <th>#application.rbFactory.getKeyValue(session.rb,'user.authoreditor')#</th>
            <th>&nbsp;</th>
          </tr></cfoutput>
          <cfif rc.rsList.recordcount>
            <cfoutput query="rc.rsList" maxrows="#rc.nextN.recordsperPage#" startrow="#rc.startrow#"> 
              <tr> 
                <td class="var-width"><a  title="#application.rbFactory.getKeyValue(session.rb,'user.edit')#" href="./?muraAction=cPrivateUsers.edituser&userid=#rc.rsList.UserID#&type=2&siteid=#esapiEncode('url',rc.siteid)#&returnURL=#esapiEncode('url',rc.currentURL)#">#esapiEncode('html',rc.rslist.lname)#, #esapiEncode('html',rc.rslist.fname)# <cfif rc.rslist.company neq ''> (#esapiEncode('html',rc.rslist.company)#)</cfif></a></td>
                <td><cfif rc.rsList.email gt ""><a href="mailto:#esapiEncode('html',rc.rsList.email)#">#esapiEncode('html',rc.rsList.email)#</a><cfelse>&nbsp;</cfif></td>
                <td>#LSDateFormat(rc.rslist.lastupdate,session.dateKeyFormat)#</td>
              <td>#LSTimeFormat(rc.rslist.lastupdate,"short")#</td>
			  <td>#esapiEncode('html',rc.rsList.LastUpdateBy)#</td>
                <td class="actions"><ul><li class="edit"><a  title="#application.rbFactory.getKeyValue(session.rb,'user.edit')#" href="./?muraAction=cPrivateUsers.edituser&userid=#rc.rsList.UserID#&type=2&siteid=#esapiEncode('url',rc.siteid)#&returnURL=#esapiEncode('url',rc.currentURL)#"><i class="icon-pencil"></i></a></li></ul></td>
              </tr>
            </cfoutput>
		 <cfelse>
            <tr> 
              <td colspan="6" class="noResults"><cfoutput>#application.rbFactory.getKeyValue(session.rb,'user.nosearchresults')#</cfoutput></td>
            </tr>
          </cfif>   
        </table>
		
<cfif rc.nextN.numberofpages gt 1>
<cfoutput>
<div class="pagination">
<ul>
<cfif rc.nextN.currentpagenumber gt 1> 
  <li>
    <a href="./?muraAction=cPrivateUsers.search&startrow=#rc.nextN.previous#&lname=#esapiEncode('url',rc.lname)#&siteid=#esapiEncode('url',rc.siteid)#&search=#esapiEncode('url',rc.search)#">&laquo;&nbsp;#application.rbFactory.getKeyValue(session.rb,'user.prev')#</a>
  </li>
</cfif> 
 <cfloop from="#rc.nextN.firstPage#"  to="#rc.nextN.lastPage#" index="i">
  <cfif rc.nextN.currentpagenumber eq i>
    <li class="active"><a href="##">#i#</a></li>
  <cfelse> 
    <li><a href="./?muraAction=cPrivateUsers.search&startrow=#evaluate('(#i#*#rc.nextN.recordsperpage#)-#rc.nextN.recordsperpage#+1')#&lname=#esapiEncode('url',rc.lname)#&siteid=#esapiEncode('url',rc.siteid)#&search=#esapiEncode('url',rc.search)#">#i#</a></li>
  </cfif>
</cfloop>
<cfif rc.nextN.currentpagenumber lt rc.nextN.NumberOfPages>
  <li><a href="./?muraAction=cPrivateUsers.search&startrow=#rc.nextN.next#&lname=#esapiEncode('url',rc.lname)#&siteid=#esapiEncode('url',rc.siteid)#&search=#esapiEncode('url',rc.search)#">#application.rbFactory.getKeyValue(session.rb,'user.next')#&nbsp;&raquo;</a>
  </li>
</cfif> 
</ul>
</div>
</cfoutput>
</cfif>
