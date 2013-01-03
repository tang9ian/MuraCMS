component persistent="true" extends="com.mura.bean.beanORM" table="tapprovalchains" {

	property name="chainID" ormtype="string" length="35" fieldtype="id" generator="assigned";
    property name="name" ormtype="string" length="100" required=true;
    property name="siteID" ormtype="string" length="25" default="" required="true";

    function init() {
    	super.init();
    	variables.chainID=createUUID();
    }

}