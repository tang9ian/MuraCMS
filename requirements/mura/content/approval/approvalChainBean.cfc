component persistent="true" extends="mura.bean.beanORM" table="tapprovalchains" {

	property name="chainID" ormtype="string" length="35" fieldtype="id" generator="assigned";
    property name="siteID" ormtype="string" length="25" default="" required="true";
    property name="name" ormtype="string" length="100" required=true;
    property name="description" ormtype="text";
    property name="created" ormtype="timestamp";
    property name="lastupdate" ormtype="timestamp";
    property name="lastupdateby" ormtype="string" length="50";
    property name="lastupdatebyid" ormtype="string" length="35";

    property name="assignments" fieldtype="one-to-many" cfc="approvalChainAssignmentBean"
		fkcolumn="chainID" type="array" singularname="assignment" orderby="orderno asc"
		inverse="true" cascade="delete";

	property name="requests" fieldtype="one-to-many" cfc="approvalRequestBean"
		fkcolumn="chainID" type="array" singularname="request" orderby="created asc"
		inverse="true" cascade="delete";

    function init() {
    	super.init();
    	variables.chainID=createUUID();

    	if(isDefined("session.mura") and session.mura.isLoggedIn){
			variables.lastupdateby = left(session.mura.fname & " " & session.mura.lname,50);
			variables.lastupdatebyid = session.mura.userID;
		}
    }

}