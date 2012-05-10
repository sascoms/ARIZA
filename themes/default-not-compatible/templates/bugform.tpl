  <script src="{$libraryPath}scriptaculous/lib/prototype.js" type="text/javascript"></script>
  <script src="{$libraryPath}scriptaculous/src/scriptaculous.js" type="text/javascript"></script>
  <script type="text/javascript">
  {literal}
  function insert_new_bug() {
		/*	  	doc = document;
			  	var staffId = doc.getElementById('staffId').value;
			  	var bugType = doc.getElementById('bugType').value;
			  	var bugVersion = doc.getElementById('bugVersion').value;
			  	var bugTitle = doc.getElementById('bugTitle').value;
			  	var bugDesc = doc.getElementById('bugDesc').value;
			  	var bugSteps = doc.getElementById('bugSteps').value;
			  	var bugSolution = doc.getElementById('bugSolution').value;
			  	var bugFile = '';//doc.getElementById('bugFile').value;
			  	var bugPlatform = doc.getElementById('bugPlatform').value;
		*/  	
	var postString = Form.serialize('id_bugInsertion');
  	//alert(postString);
	  	var options = {
	   	    method: 'post', // Use POST
	    	postBody: postString, //'staffId='+staffId+'&bugType='+bugType+'&bugVersion='+bugVersion+'&bugTitle='+bugTitle+'&bugDesc='+bugDesc+'&bugSteps='+bugSteps+'&bugSolution='+bugSolution+'&bugFile='+bugFile+'&bugPlatform='+bugPlatform+'',// Send this lovely data	    
	    	onSuccess: function(t) {// Handle successful response
	        	//alert(t.responseText);
	        	if (t.responseText=='C31200') { //successful
	        		Element.hide('id_bugInsertion');
	        		var msg = 'Kaydiniz girildi. Tesekkur ederiz...<br />'
	        		msg += '<a href="javascript:void(0);" onclick="Effect.SlideDown(\'id_bugInsertion\'); return false;">yeni kayit gir</a>'
	        		Element.update('id_bugInsertionRes',msg);
	        	} else {
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
	new Ajax.Request('index.php?job=ajjb&do=addbug', options);
  }
  
  
  {/literal}
  </script>

<div id="id_bugInsertionRes" align="center"></div>
<form name="bugInsertion" enctype="multipart/form-data" method="post" action="" id="id_bugInsertion">
      <input name="staffId" id="staffId" type="hidden" value="{$userData.staff_id}">
      <input type="hidden" name="bugPlatform" id="bugPlatform" value="{$userEnvironment.platform}" />
  <table width="100%" border="0" cellspacing="3" cellpadding="1">
    <tr align="center" bgcolor="#E1E1F0">
      <td colspan="4"><font size="+1"><b> {$LNG_request_form_title}</b></font></td>
    </tr>
    <tr>
      <td colspan="4" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
    <tr>
      <td align="right" valign="top" bgcolor="#F0FAFF"> 
      <b>{$LNG_request_type}: </b>
      </td>
      <td colspan="3" bgcolor="#F0FAFF">
      	<select name="bugType" size="1" id="bugType">
	
	{foreach key=key item=value from=$BugTypes}
		<option value="{$key}">{$value}</option>
	{/foreach}

      	</select>

      </td>
    <tr>
      <td align="right" bgcolor="#F0FAFF"><b>{$LNG_version}: </b></td>
      <td bgcolor="#F0FAFF"><input name="bugVersion" type="text" class="noborder" id="bugVersion"></td>
    </tr>
    </tr>
    <tr>
      <td align="right" valign="top" bgcolor="#F0FAFF"> <b>{$LNG_request_title}: </b>
      </td>
      <td colspan="3" bgcolor="#F0FAFF"><input name="bugTitle" type="text" class="noborder" id="bugTitle"></td>
    </tr>
    <tr>
      <td align="right" valign="top" bgcolor="#F0FAFF"> <b>{$LNG_request_explanation}: </b>
      </td>
      <td colspan="3" bgcolor="#F0FAFF"><textarea name="bugDesc" cols="35" rows="5" class="noborder" id="bugDesc"></textarea></td>
    </tr>
    <tr>
      <td align="right" valign="top" bgcolor="#F0FAFF"> <b>{$LNG_steps_caused_bug}:</b></td>
      <td colspan="3" bgcolor="#F0FAFF"><textarea name="bugSteps" cols="35" rows="5" class="noborder" id="bugSteps"></textarea></td>
    </tr>
    <tr>
      <td align="right" valign="top" bgcolor="#F0FAFF"> <b>{$LNG_suggested_solutions}:</b></td>
      <td colspan="3" bgcolor="#F0FAFF"><textarea name="bugSolution" cols="35" rows="5" class="noborder" id="bugSolution"></textarea></td>
    </tr>

     <tr>
      <td align="right" valign="top" bgcolor="#F0FAFF"><b>{$LNG_request_attachment}: </b></td>
      <td colspan="3" bgcolor="#F0FAFF"><INPUT TYPE="file" NAME="userfile" SIZE="30" class="noborder" >
        &nbsp; </td>
    </tr>

    <tr bgcolor="#F2F2F2">
      <td height="40" colspan="4" align="center"> 
      	<input name="button" type="button" class="noborder" id="submit" value="{$LNG_submit}" onclick="javascript:insert_new_bug();">
      </td>
    </tr>
  </table>
  </form>
