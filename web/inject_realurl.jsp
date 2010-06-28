<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="mockey" uri="/WEB-INF/mockey.tld" %>
<%--@elvariable id="proxyInfo" type="com.mockey.ProxyServer"--%>
<c:set var="actionKey" value="conf_service" scope="request" />
<c:set var="pageTitle" value="Real URL Injection" scope="request" />
<c:set var="currentTab" value="inject" scope="request" />
<%@include file="/WEB-INF/common/header.jsp" %>
<script type="text/javascript">
	$(function() {
		$("#inject-button").button().click(function() {
			var replacementValues = new Array();
			$.each($('input:text[name=replacement]'), function() {
				replacementValues.push($(this).val());
			       
			    });	
		    var match = $('#match');
		    $.post('<c:url value="/inject"/>', { match: match.val(), 'replacement[]':  replacementValues} ,function(data){
					if (data.result.success){
						
						 $.prompt(
								 '<div style=\"color:blue;\">Updated:</div> ' + data.result.success,
					                {
					                    callback: function (proceed) {
					                        if(proceed) document.location="<c:url value="/home" />";
					                    },
					                    buttons: {
					                        'OK': true
					                    }
					                });
					}else {
						$.prompt('<div style=\"color:red;\">Not updated:</div> ' + data.result.fail);
					}
				}, 'json' );
		});
	});
</script>
<div id="main">     
    <p><h1>Real URL Injection</h1></p> 
    <div>
       			<p>If Mockey connects to many <i>similar</i> testing and development environments (i.e. DEV, STAGE, UAT1 and UAT2), you could 
       			be spending a lot of time copying and duplicating real URL(s) defined in your service definitions. In general, many sibling environments 
       			have the same file paths but different domains and this is when <strong>injecting</strong> real URLs can come in handy. 
       		    When you inject a pattern, you don't replace the original real URL. Instead a new real URL is added to your service(s). 
       		    </p>
        <div class="centerform" >       
          <label for="match">Match real URL pattern</label> 
          <input type="text" class="text ui-corner-all ui-widget-content" id="match" name="match" size="80"  value="">
          <div class="tinyfieldset">For example: qa1.domain.com</div>
          <label for="replacement">Replace real URL pattern</label> 
          <input type="text" class="text ui-corner-all ui-widget-content" id="replacement" name="replacement" size="80"  value="">
          <div class="tinyfieldset">For example: qa2.another-domain.com</div>
          <p align="right"><button id="inject-button">Inject real URLs</button></p>
	    </div> 
       </div>  
        <h3>Example</h3>
       <div class="info_message">
       Before injection:
       <p><strong>Service XYZ</strong> has the following real URLs:
      
                <ul>
                  <li>http://qa1.domain.com/authentication</li>
                  <li>http://qa2.domain.com/authentication</li>
                </ul>
                </p>
                After injecting with match pattern <i>qa1.domain.com</i> and 
                replace pattern <i>qa8.domain.com</i>, we get:
                <p>
                <strong>Service XYZ</strong> has the following real URLs:
      
                <ul>
                  <li>http://qa1.domain.com/authentication</li>
                  <li>http://qa2.domain.com/authentication</li>
                  <li>http://qa8.domain.com/authentication</li>
                </ul>
                </p>
        </div>
      
       			
       		    
</div>
<jsp:include page="/WEB-INF/common/footer.jsp" />