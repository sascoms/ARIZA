
  <link rel="stylesheet" type="text/css" media="all" href="{$libraryPath}calendar/calendar-win2k-cold-1.css" title="win2k-cold-1" />
  <script type="text/javascript" src="{$libraryPath}calendar/calendar.js"></script>
  <script type="text/javascript" src="{$libraryPath}calendar/calendar-{$siteLanguage}.js"></script>
  <script type="text/javascript" src="{$libraryPath}calendar/calendar-setup.js"></script>
	
  
  		<script src="{$libraryPath}scriptaculous/lib/prototype.js" type="text/javascript"></script>
  		<script src="{$libraryPath}scriptaculous/src/scriptaculous.js" type="text/javascript"></script>          
	
        <script type="text/javascript" src="{$libraryPath}generalFuncs.js"></script>
  
  
  		<script type="text/javascript">
  {literal}
  function insert_response() {
  			var doc = document;
  			var i = 1;
		  	var response_text = doc.getElementById('response_text').value;
		  	var statusId = doc.getElementById('statusId').value;
		  	var solvedDatetime = doc.getElementById('idSolvedDatetime').value;
		  	var staffId = doc.getElementById('staffId').value;
		  	var staffFullname = doc.getElementById('staffFullname').value;
		  	var bug_id = doc.getElementById('bug_id').value;
	//var postString = Form.serialize('idAddResponse');
	var postString = 'staffId='+staffId+'&bug_id='+bug_id+'&response_text='+response_text+'&staffFullname='+staffFullname+'&statusId='+statusId+'&solvedDatetime='+solvedDatetime;
	//alert(postString);
	  	var options = {
	   	    method: 'post', // Use POST
	    	postBody: postString,  
	    	onSuccess: function(t) { alert(t.responseText);
	        	if ((t.responseText !='C31410') || (t.responseText !='C31420')) { //successful
	        		Element.hide('idAddResponseFormRow','idFinishedDatetime','idHideAllLink');
	        		var msg = 'Kaydiniz girildi. Tesekkur ederiz...<br />'
	        		Element.update('idOperationRes',msg);
       			 	Element.update('idNoResponse','');
	        		new Insertion.Top('idResponseList', t.responseText);

	        	} else {
	        		Element.update('idOperationRes','Kaydýnýz girilemedi!'); 
	        		alert('Kaydýnýz girilemedi!');	 
	        		alert(t.responseText);      	
	        	}
	    	},	    
	    	on404: function(t) { // Handle 404
	        	alert('Error 404: location "' + t.statusText + '" was not found.');
	    	},	    
	    	onFailure: function(t) {// Handle other errors
	        	alert('Error ' + t.status + ' -- ' + t.statusText);
	    	}
		}	
	new Ajax.Request('index.php?job=ajjb&do=respond', options);
  }
  
  
  {/literal}
  </script>  		
<table width="100%" border="1" cellpadding="1" cellspacing="3">
    <tr bgcolor="#E1E1F0">
      <td colspan="4" align="center"><font size="+1"><b>{$LNG_details}</b></font></td>
    </tr>
    <tr bgcolor="#F8F1F1">
      <td id="idOperationRes" colspan="4" align="center"></td>
    </tr>
    <tr>
      <td colspan="4" style="background-color: lightblue;font-size: %110; font-family: georgia; font-weight: bold;">[{$bugInfo.bug_id}] {$bugInfo.bug_title}</td>
    </tr>
    <tr>
      <td align="right" valign="top" bgcolor="#F7F9F9" width="15%"><b>{$LNG_request_owner} </b></td>
      <td valign="top" bgcolor="#F7F9F9" width="40%">{$bugInfo.sender_fullname}      </td>
      <td align="right" valign="top" bgcolor="#F7F9F9" width="15%"><b>{$LNG_version}</b></td>
      <td valign="top" bgcolor="#F7F9F9" width="20%">{$bugInfo.version}    &nbsp;  </td>
    </tr>
    <tr>
      <td align="right" valign="top" bgcolor="#F7F9F9"><b>{$LNG_request_report_datetime}</b></td>
      <td valign="top" bgcolor="#F7F9F9">{$bugInfo.reported_datetime}      </td>
      <td align="right" valign="top" bgcolor="#F7F9F9"><b>{$LNG_request_attachment}</b></td>
      <td valign="top" bgcolor="#F7F9F9">{$bugInfo.uploaded_file}&nbsp;</td>
    </tr>
    <tr>
      <td align="right"><b>{$LNG_bug_status} </b></td>
      <td>{$bugInfo.status}</td>
      <td align="right">{$LNG_completed_percentage}</td>
      <td>{$bugInfo.progress_percent}</td>
    </tr>
    <tr>
      <td valign="top" bgcolor="#F7F9F9" align="right"><b>{$LNG_request_explanation}</b></td> 
      <td valign="top" bgcolor="#F7F9F9" colspan="3">&nbsp;</td>
    </tr>
    <tr>
      <td colspan="4" bgcolor="#F7F9F9">{$bugInfo.bug_description}</td>
    </tr>
    <tr>
      <td align="right" valign="top" bgcolor="#F7F9F9"><b>{$LNG_steps_caused_bug}</b></td>
      <td bgcolor="#F7F9F9">{$bugInfo.bug_steps}</td>
      <td align="right" bgcolor="#F7F9F9"><b>{$LNG_suggested_solutions}</b></td>
      <td bgcolor="#F7F9F9">{$bugInfo.possible_solution}</td>
    </tr>
    <tr>
      <td colspan="4" align="right" bgcolor="#F2F2F2">
      	
      		<a id="idShowAllLink" href="javascript:void(0);" onclick="Element.show('idAddResponseFormRow'); Element.show('idHideAllLink'); ">{$LNG_respond}</a> 
      			&nbsp;<a class="small" id="idHideAllLink" href="javascript:void(0);" style="display:none;" onclick="Element.hide('idAddResponseFormRow','idFinishedDatetime','idHideAllLink');  ">[{$LNG_hide}]</a> 
      	
      	</td>
    </tr>
    
    <tr id="idAddResponseFormRow" style="display:none;">
      <td bgcolor="#F0FAFF" colspan="4">
      
      
      
		<form name="idAddResponseForm" method="post" action="" id="idAddResponseForm">
		
		
		<input type="hidden" name="bug_id" id="bug_id" value="{$bugInfo.bug_id}">
		<input name="staffId" id="staffId" type="hidden" value="{$userData.staff_id}">
		<input name="staffFullname" id="staffFullname" type="hidden" value="{$userData.staff_name} {$userData.staff_surname}">
		
		
			<div class="leftColDiv">{$LNG_bug_status}: </div> 
	      	<div class="rightColDiv">
				<select name="statusId" id="statusId" size="1" class="noborder">
			     {foreach key=key item=value from=$statuses}
			     	<option value="{$key}">{$value}</option>
			     {/foreach}
				</select>
				<a href="javascript:void(0);" onclick="Element.show('idFinishedDatetime');">{$LNG_enter_solved_datetime}</a>
	      	</div> 
    	<div style="clear:both; height:3px; border-top:1px dotted #ccc;">&nbsp;</div>
    	
      	<div id="idFinishedDatetime" style="display:none;">
	      	<div class="leftColDiv">{$LNG_solved_datetime}: </div> 
	      	<div class="rightColDiv">
				<input type="text" name="solvedDatetime" id="idSolvedDatetime" maxlength="16" readonly="readonly" value="" />
				<button type="reset" id="f_trigger_date">...</button>
				{literal}
				<script type="text/javascript">
				    Calendar.setup({
				    	showsTime      :    true,
				    	timeFormat     :    '24',			    	
				        inputField     :    "idSolvedDatetime",     // id of the input field
				        ifFormat       :    "%Y-%m-%d %H:%M",     // format of the input field (even if hidden, this format will be honored)
				        displayArea    :    "show_e",       // ID of the span where the date is to be shown
				        daFormat       :    "%d %B %Y %A ",// format of the displayed date
				        button         :    "f_trigger_date",  // trigger button (well, IMG in our case)
				        align          :    "Tl",           // alignment (defaults to "Bl")
				        singleClick    :    true
				    });
				</script>      
				{/literal}
	      		<a href="javascript:void(0);" onclick="Element.hide('idFinishedDatetime');">{$LNG_close}</a> | 
	      		<a href="javascript:void(0);" onclick="updateElement('idSolvedDatetime','');">{$LNG_clear}</a>
	      	</div> 
		</div>
		
	
		
    	<div style="clear:both; height:3px; border-top:1px dotted #ccc;">&nbsp;</div>      
	      	<div class="leftColDiv">{$LNG_response_text} </div> 
	      	<div class="rightColDiv">
	      		<textarea name="response_text" cols="65" rows="6" class="noborder" id="response_text"></textarea>
	      	</div> 
	      	
    	<div style="clear:both; height:3px; border-top:1px dotted #ccc;">&nbsp;</div>	      	
	      	<div align="center"> 
	      		<input name="button" type="button" class="noborder" id="submit" value="{$LNG_submit}" onclick="javascript:insert_response();">      
    		</div>
    	
      
  	</form>
      
   </td>
   </tr>
 </table>

 
 
 
 
 
 
 
 <fieldset id="idResponseList">
	 <legend>{$LNG_replies}:</legend>
	 <div style="margin:10px;"> 

	 {if $responseTotal > 0}
	 	     {foreach key=key item=value from=$responseList}	 	     
			 		{$value}
		     {/foreach}
	
	 {/if}
		<div id="idNoResponse" class="small">
			 {if $responseTotal < 1}
			 	&nbsp;&nbsp;&nbsp;{$LNG_there_is_no_response}
			 {/if}
	 	</div>
	 
	 </div>
 
</fieldset>
