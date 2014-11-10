CKFinder.addPlugin( 'csrf', function( api ) {
    var baseURL='plugins/csrf/remote.cfc?method=getCSRFTokens';
    
    if(typeof context == 'string'){
      baseURL= context + '/tasks/widgets/ckfinder/' + baseURL;
    } else if(typeof mura == 'object' && typeof mura.context == 'string'){
        baseURL= mura.context + '/tasks/widgets/ckfinder/' + baseURL;
    } 
  
    var getTokens = function(){
      var request=new XMLHttpRequest();
      request.open('GET', baseURL + "&cacheid" + Math.random(), false);  // `false` makes the request synchronous
      request.send(null);
    
      var response=JSON.parse(request.responseText);

      if(response.token){
         return {
          mura_token:response.token,
          mura_token_expires: response.expires
        };
      } else {
         return {
          mura_token: response.TOKEN,
          mura_token_expires: response.EXPIRES
        };
      }

    }

    var extendObj = function(obj1,obj2){
        for (var attrname in obj2) { obj1[attrname] = obj2[attrname]; }
        return obj2;
    };

    var orginalComposeUrlParams = api.connector.composeUrlParams;
    api.connector.composeUrlParams = function() {
     var params={};
   
      if(typeof arguments[0] == 'object'){
        extendObj(params,arguments[0]);
      } 

      if(!params.mura_token){
        extendObj(params,getTokens());
      }
    
      // call the original function
      var result = orginalComposeUrlParams.apply(this,[params]);

      return result;
    }
  
    var orginalsendCommandPost = api.connector.sendCommandPost;
    api.connector.sendCommandPost = function() {

      var params={};

      if(typeof arguments[2] == 'object'){
        extendObj(params,arguments[2]);
      } 

      if(!params.mura_token){
        extendObj(params,getTokens());
      }
         
      // call the original function
      var result = orginalsendCommandPost.apply(this,[arguments[0],arguments[1],params,arguments[3],arguments[4],arguments[5]]);

      return result;

    }
   
    
    var orginalsendCommand = api.connector.sendCommand;
    api.connector.sendCommand = function() {
     
     var params={};


      if(!params.mura_token){
        extendObj(params,getTokens());
      }

      //alert(JSON.stringify(params));
    
      // call the original function
      var result = orginalsendCommandPost.apply(this,[arguments[0],arguments[1],params,arguments[2],arguments[3],arguments[4]]);

      return result;
    }
   

} );