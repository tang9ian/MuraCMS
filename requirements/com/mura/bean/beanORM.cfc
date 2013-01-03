component output="false" persistent="false" extends="com.mura.bean.bean" {

	property name="instance" type="struct" persistent="false" required="true" setter="false" getter="false";
	property name="fromMuraCache" type="boolean" default="false" persistent="false" required="true" setter="false" getter="false";
	property name="siteID" type="String" default="" required="true";

	function init(){
		variables.errors={};
		variables.instance={};
	}

	function validate(){
		return variables.errors;
	}

	function setSiteID(siteID){
		if(len(arguments.siteID)){
			variables.siteID=arguments.siteID;
		}
	}

	function getErrors(){
		return variables.errors;
	}

	function setErrors(errors){
		variables.errors=arguments.errors;
		return this;
	}

	function setAllValues(struct data){
		init();
		local.processed={};

		for (local.md = getMetaData(this); 
		    structKeyExists(local.md, "extends"); 
		    local.md = local.md.extends) 
		  { 
		    if (structKeyExists(local.md, "properties")) 
		    { 
		      for (local.i = 1; 
		           i <= arrayLen(local.md.properties); 
		           i++) { 
		        local.pName = md.properties[i].name; 

		        if(!structkeyExists(local.processed,local.pName) && structKeyExists(this,"set#local.pName#")){
		        	if(structKeyExists(arguments.data,local.pName)){
		        		evaluate("set#local.pName#(arguments.data[local.pName])"); 
		        	} else if (structKeyExists(md.properties[i],'default')){
		       	 		evaluate("set#local.pName#(md.properties[i].default)"); 
		       	 	}
		       	 	local.processed[local.pName]=true;
		       	 }
		      } 
		     }
		   } 

		 for(local.pName in arguments.data){
		 	 if(not structKeyExists(this,"set#local.pName#")){
		 	 	variables.instance[local.pName]=arguments.data[local.pName]
		 	 }

		 }

		return this;
	}

	struct function getAllValues(){ 
		var properties = {}; 	
		local.processed={};

		for (local.md = getMetaData(this); 
		    structKeyExists(local.md, "extends"); 
		    local.md = md.extends) 
		  { 
		    if (structKeyExists(local.md, "properties")) 
		    { 
		      for (local.i = 1; 
		           i <= arrayLen(local.md.properties); 
		           i++) 
		      { 
		        local.pName = local.md.properties[i].name; 
		      
		        if(!structkeyExists(local.processed,local.pName) && structKeyExists(this,"get#local.pName#") && (!structKeyExists(local.md.properties[i],'persistent') OR local.md.properties[i].persistent)){
		       	 	//writeDump(var=local.md.properties[i]);
		       	 	local.properties[local.pName]=evaluate("get#local.pName#()"); 
		       	 	local.processed[local.pName]=true;
		      	} 
		      }
		    } 
		  } 

		//abort;
		structAppend(properties,variables.instance,false);
		return properties; 
	}

	function setlastUpdateBy(lastUpdateBy){
		variables.lastUpdateBy = left(trim(arguments.lastUpdateBy),50);
		return this;
	}

	function save(){
		if (ArrayLen(EntityLoadByExample(this))){ 
		   local.obj=ORMGetSession().merge(this); 
			
		} else {
    		local.obj=this;
    	}
    	entitySave(local.obj);
    	ormFlush()
    	return local.obj;
    }

    function delete(){
		if (ArrayLen(EntityLoadByExample(this))){ 
		   local.obj=ORMGetSession().merge(this); 
			
		} else {
    		local.obj=this;
    	}
    	entityDelete(local.obj);
    	ormFlush()
    	return local.obj;
    }

    function loadBy(){
    	init();
    	set(arguments);

    	try{
    		entityReload(this);
    	} catch(any e){}

    	return this;
    } 

}