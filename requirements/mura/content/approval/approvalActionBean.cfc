component persistent="true" extends="mura.bean.beanORM" table="tapprovalactions" {

	property name="actiontID" ormtype="string" length="35" fieldtype="id" generator="assigned";
    property name="parentID" ormtype="string" length="35";
    property name="requestID" ormtype="string" length="35";
    property name="chainID" ormtype="string" length="35";
    property name="groupID" ormtype="string" length="35";
    property name="userID" ormtype="string" length="35" default="" required=true;
    property name="siteID" ormtype="string" length="25" default="" required=true;
    property name="actionType" ormtype="string" length="50" default="" required=true;
    property name="created" ormtype="timestamp";
    property name="comments" ormtype="text";

    property name="actions" fieldtype="one-to-many" cfc="approvalActionBean"
		fkcolumn="parentID" type="array" singularname="action" orderby="created asc"
		inverse="true" cascade="delete";

    function init() {
    	super.init();
    	variables.actiontID=createUUID();

    	if(not isDate(variables.created)){
    		variables.created=now();
    	}
  
    }

}