component persistent="true" extends="mura.bean.beanORM" table="tapprovalassignments" {

	property name="assignmentID" ormtype="string" length="35" fieldtype="id" generator="assigned";
	property name="chainID" ormtype="string" length="35";
    property name="groupID" ormtype="string" length="35";
    property name="siteID" ormtype="string" length="25" default="" required=true;
    property name="orderno" ormtype="int";
    property name="created" ormtype="timestamp";

    function init() {
    	super.init();
    	variables.assignmentID=createUUID();
    }


}