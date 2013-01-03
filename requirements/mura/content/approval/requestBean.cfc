component persistent="true" extends="mura.bean.beanORM" table="tapprovalrequests" {

	property name="requestID" ormtype="string" length="35" fieldtype="id";
	property name="chainID" ormtype="string" length="35";
    property name="contentHistID" ormtype="string" length="35";
    property name="siteID" ormtype="string" length="25" default="" required=true;

    property name="actions" fieldtype="one-to-many" cfc="actionBean"
		fkcolumn="requestID" type="array" singularname="action" orderby="created asc"
		inverse="true" cascade="delete";

    function init() {
    	super.init();
    	variables.requestID=createUUID();
    }

}