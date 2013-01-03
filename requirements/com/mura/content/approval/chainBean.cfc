component persistent="true" extends="com.mura.bean.beanORM" table="tapprovalchains" {

	property name="chainID" ormtype="varchar" length="35" fieldtype="id" generator="assigned";
    property name="name" ormtype="varchar" length="100" required=true;
    property name="siteID" type="String" default="" required="true";

    function init() {
    	super.init();
    	variables.chainID=createUUID();
    }

}