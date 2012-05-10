		Ajax.Responders.register( {
			onCreate: function(e) {
				showNotify(ajax_processing_operation);
			},
			onComplete: function() {
				hideNotify();
			}
		} );

function ajaxPerformer(jobName,formName, getId, updateId) {
	var doc = document;
	var obj = doc.getElementById(getId);
	var sText = obj.options[obj.selectedIndex].text; //alert(sText);
	var postString = Form.serialize(formName);  	//alert(postString);
		//postString += '&'+getId+'='+obj.value;  	alert(postString);

  	var options = {
   	    method: 'post', // Use POST
    	postBody: postString,
    	onSuccess: function(t) { alert(t.responseText);
        	if (t.responseText=='C31200') { //successful
        		Element.update('id_operationRes', msg);
        		Element.show('id_operationRes');

        		Element.update(updateId, sText);

        	} else {
        		alert(operation_failure_msg); //alert(t.responseText);
        	}
    	},
    	on404: function(t) { // Handle 404
        	alert('Error 404: location "' + t.statusText + '" was not found.');
    	},
    	onFailure: function(t) {// Handle other errors
        	alert('Error ' + t.status + ' -- ' + t.statusText);
    	}
	}
	new Ajax.Request('index.php?ajax=ajjb&do='+jobName, options);
}

function ajaxPerformerInput(jobName,formName, getId, updateId, resMsgId) {
	var doc = document;
	var obj = doc.getElementById(getId);
	//var postString = Form.serialize(formName);  	//alert(postString);
	var	postString = '&optionname='+getId+'&optionval='+obj.value;  	//alert(postString);

		Element.hide(resMsgId);
		Element.update(resMsgId, '');

  	var options = {
   	    method: 'post', // Use POST
    	postBody: postString,
    	onSuccess: function(t) { //alert(t.responseText);
        	if (t.responseText=='C31200') { //successful
        		var msg = operation_successful_msg + '<br />'
        		Element.update(resMsgId, msg);
        		Element.show(resMsgId);

        		Element.update(updateId, obj.value);
        		//hilite('id_operationRes','hiliteRow');
        	} else {
        		alert(operation_failure_msg+"\n"+t.responseText); //alert(t.responseText);
        	}
    	},
    	on404: function(t) { // Handle 404
        	alert('Error 404: location "' + t.statusText + '" was not found.');
    	},
    	onFailure: function(t) {// Handle other errors
        	alert('Error ' + t.status + ' -- ' + t.statusText);
    	}
	}
	new Ajax.Request('index.php?job=ajjb&do=ajaxOps&op='+jobName, options);
}


function getOperatorData(getId, formName, hideFormName) {
	//reset form
	  var projectsGroupName = document.getElementsByName('userDetails_projects[]');
	  var projectsGroupNameLen = projectsGroupName.length;

		  for (i = 0; i < projectsGroupNameLen; i++) {
		  	projectsGroupName[i].checked = false;
		  }

		$('userDetails_project_default').value = '';

	var obj = document.getElementById(getId);
	//var postString = Form.serialize(formName);  	//alert(postString);
	var	postString = 'userID='+obj.value;  	//alert(postString);

  	var options = {
   	    method: 'post', // Use POST
    	postBody: postString,
    	onSuccess: function(t) { //alert(t.responseText);
    		var tData = eval('(' + t.responseText + ')');
    		var resultData = tData.results;
        	if (resultData.res == '1') { //successful
        		//var msg = operation_successful_msg + '<br />'

        		$('userDetails_id').value = resultData.id;
        		Element.update('userDetails_id_span', resultData.id);

        		$('userDetails_user').value = resultData.user;
        		$('userDetails_pass').value = '';
        		$('userDetails_firstname').value = resultData.firstname;
        		$('userDetails_lastname').value = resultData.lastname;
        		$('userDetails_email').value = resultData.email;
        		$('userDetails_type').value = resultData.type;
        		$('userDetails_admin').checked = ((resultData.admin == '1') ? true:false);
        		$('userDetails_status').checked = ((resultData.status == '1') ? true:false);
        		$('userDetails_project_default').value = resultData.project_default;



        		var projectsList = resultData.projects;
        		var projectsListLen = projectsList.length;


        		for (z = 0; z < projectsListLen; z++) {
        			$('userDetails_projects_'+projectsList[z]).checked = true;
        		}

	       		Element.show(formName);
	       		Element.hide(hideFormName);

        		//hilite('id_operationRes','hiliteRow');
        	} else {
        		alert(operation_failure_msg+"\n"+resultData.msg); //alert(t.responseText);
        	}
    	},
    	on404: function(t) { // Handle 404
        	alert('Error 404: location "' + t.statusText + '" was not found.');
    	},
    	onFailure: function(t) {// Handle other errors
        	alert('Error ' + t.status + ' -- ' + t.statusText);
    	}
	}
	new Ajax.Request('index.php?job=ajjb&do=ajaxOps&op=getUserData', options);

}

function updateOperatorData(getId, updateId, formName) {
	var obj = document.getElementById(getId);
	var	postString = 'userID='+obj.value;  	//alert(postString);

//
//	  var projectsGroupName = document.getElementsByName('userDetails_projects[]');
//	  var projectsGroupNameLen = projectsGroupName.length;
//	  var userProjects =  '';
//		  for (i = 0; i < projectsGroupNameLen; i++) {
//		  	if (projectsGroupName[i].checked == true) {
//		  		userProjects += projectsGroupName[i].value + ',';
//		  	}
//		  }
//
	//postString += '&projects='+userProjects;  	//alert(postString);
	postString += '&username='+$('userDetails_user').value;  	//alert(postString);
	postString += '&password='+$('userDetails_pass').value;  	//alert(postString);
	postString += '&firstname='+$('userDetails_firstname').value;  	//alert(postString);
	postString += '&lastname='+$('userDetails_lastname').value;  	//alert(postString);
	postString += '&email='+$('userDetails_email').value;  	//alert(postString);
	postString += '&type='+$('userDetails_type').value;  	//alert(postString);
	postString += '&admin='+ ( ($('userDetails_admin').checked == true) ? '1' : '0');
	postString += '&status='+ ( ($('userDetails_status').checked == true) ? '1' : '0');
	postString += '&project_default='+ $('userDetails_project_default').value;




  	var options = {
   	    method: 'post', // Use POST
    	postBody: postString,
    	onSuccess: function(t) { //alert(t.responseText);
    		var tData = eval('(' + t.responseText + ')');
    		var resultData = tData.results;

        	if (resultData.res == '1') { //successful

        		var msg = operation_successful_msg + '<br />'

        		Element.update(updateId, msg);
	       		Element.show(updateId);
        	} else {
        		alert(operation_failure_msg+"\n"+resultData.msg); //alert(t.responseText);
        	}
    	},
    	on404: function(t) { // Handle 404
        	alert('Error 404: location "' + t.statusText + '" was not found.');
    	},
    	onFailure: function(t) {// Handle other errors
        	alert('Error ' + t.status + ' -- ' + t.statusText);
    	}
	}
	new Ajax.Request('index.php?job=ajjb&do=ajaxOps&op=updateUserData', options);

}

function updateOperatorProjects(getId, updateId, formName) {
	var obj = document.getElementById(getId);
	var	postString = 'userID='+obj.value;  	//alert(postString);


	  var projectsGroupName = document.getElementsByName('userDetails_projects[]');
	  var projectsGroupNameLen = projectsGroupName.length;
	  var userProjects =  '';
		  for (i = 0; i < projectsGroupNameLen; i++) {
		  	if (projectsGroupName[i].checked == true) {
		  		userProjects += projectsGroupName[i].value + ',';
		  	}
		  }

	postString += '&projects='+userProjects;  	//alert(postString);


  	var options = {
   	    method: 'post', // Use POST
    	postBody: postString,
    	onSuccess: function(t) { //alert(t.responseText);
    		var tData = eval('(' + t.responseText + ')');
    		var resultData = tData.results;

        	if (resultData.res == '1') { //successful

        		var msg = operation_successful_msg + '<br />'

        		Element.update(updateId, msg);
	       		Element.show(updateId);
        	} else {
        		alert(operation_failure_msg+"\n"+resultData.msg); //alert(t.responseText);
        	}
    	},
    	on404: function(t) { // Handle 404
        	alert('Error 404: location "' + t.statusText + '" was not found.');
    	},
    	onFailure: function(t) {// Handle other errors
        	alert('Error ' + t.status + ' -- ' + t.statusText);
    	}
	}
	new Ajax.Request('index.php?job=ajjb&do=ajaxOps&op=updateUserProjects', options);

}



function addOperatorData(updateId, formName, userListBox) {
	var	postString = '';  	//alert(postString);


	  var projectsGroupName = document.getElementsByName('userNew_projects[]');
	  var projectsGroupNameLen = projectsGroupName.length;
	  var userProjects =  '';
		  for (i = 0; i < projectsGroupNameLen; i++) {
		  	if (projectsGroupName[i].checked == true) {
		  		userProjects += projectsGroupName[i].value + ',';
		  	}
		  }

	postString += '&projects='+userProjects;  	//alert(postString);
	postString += '&username='+$('userNew_user').value;  	//alert(postString);
	postString += '&firstname='+$('userNew_firstname').value;  	//alert(postString);
	postString += '&lastname='+$('userNew_lastname').value;  	//alert(postString);
	postString += '&email='+$('userNew_email').value;  	//alert(postString);
	postString += '&pass='+$('userNew_pass').value;  	//alert(postString);
	postString += '&type='+$('userNew_type').value;  	//alert(postString);
	postString += '&admin='+ ( ($('userNew_admin').checked == true) ? '1' : '0');
	postString += '&status='+ ( ($('userNew_status').checked == true) ? '1' : '0');
	postString += '&project_default='+ $('userNew_project_default').value;



  	var options = {
   	    method: 'post', // Use POST
    	postBody: postString,
    	onSuccess: function(t) { //alert(t.responseText);
    		var tData = eval('(' + t.responseText + ')');
    		var resultData = tData.results;

        	if (resultData.res == '1') { //successful

        		var msg = operation_successful_msg + '<br />'

        		Element.update(updateId, msg);
	       		Element.show(updateId);

	       		var theSelectList = $(userListBox);
	       		var newStaffFullname = $('userNew_firstname').value +' '+ $('userNew_lastname').value
	       		var newStaffID = resultData.newID;
				addSelectOption(theSelectList, newStaffFullname, newStaffID, true);



				//empty form fields
				$('userNew_user').value = '';
				$('userNew_firstname').value = '';
				$('userNew_lastname').value = '';
				$('userNew_email').value = '';
				$('userNew_pass').value = '';
				$('userNew_type').value = '';
				$('userNew_admin').checked = false;
				$('userNew_status').checked = false;
				$('userNew_project_default').value='';
				for (i = 0; i < projectsGroupNameLen; i++) {
					projectsGroupName[i].checked = false;
				}



        	} else {
        		alert(operation_failure_msg+"\n"+resultData.msg); //alert(t.responseText);
        	}
    	},
    	on404: function(t) { // Handle 404
        	alert('Error 404: location "' + t.statusText + '" was not found.');
    	},
    	onFailure: function(t) {// Handle other errors
        	alert('Error ' + t.status + ' -- ' + t.statusText);
    	}
	}
	new Ajax.Request('index.php?job=ajjb&do=ajaxOps&op=addUserData', options);

}


function addSelectOption(selectObj, text, value, isSelected) {
    if (selectObj != null && selectObj.options != null) {
        selectObj.options[selectObj.options.length] = new Option(text, value, false, isSelected);
    }
}



function getProjectData(getId, formName, hideFormName) {
	//reset form
	var obj = document.getElementById(getId);
	var	postString = 'projectID='+obj.value;  	//alert(postString);

  	var options = {
   	    method: 'post', // Use POST
    	postBody: postString,
    	onSuccess: function(t) { //alert(t.responseText);
    		var tData = eval('(' + t.responseText + ')');
    		var resultData = tData.results;
        	if (resultData.res == '1') { //successful

        		$('project_id').value = '';
        		$('project_id').value = resultData.id;

        		Element.update('project_id_span', '');
        		Element.update('project_id_span', resultData.id);

        		$('project_name').value = '';
        		$('project_name').value = resultData.name;

        		$('project_description').value = '';
        		$('project_description').value = resultData.description;

        		$('project_active').checked = false;
        		$('project_active').checked = ((resultData.is_active == '1') ? true:false);

	       		Element.show(formName);
	       		Element.hide(hideFormName);

        		//hilite('id_operationRes','hiliteRow');
        	} else {
        		alert(operation_failure_msg+"\n"+resultData.msg); //alert(t.responseText);
        	}
    	},
    	on404: function(t) { // Handle 404
        	alert('Error 404: location "' + t.statusText + '" was not found.');
    	},
    	onFailure: function(t) {// Handle other errors
        	alert('Error ' + t.status + ' -- ' + t.statusText);
    	}
	}
	new Ajax.Request('index.php?job=ajjb&do=ajaxOps&op=getProjectData', options);

}



function showProjectUsers(getId, formName, hideFormName) {
	  var usersCB = document.getElementsByName('project_users[]');
	  var usersCBLen = usersCB.length;

		  for (i = 0; i < usersCBLen; i++) {
		  	usersCB[i].checked = false;
		  }


	var obj = document.getElementById(getId); //alert(obj.value)

	$('users_project_id').value = obj.value;
	Element.update('users_project_id_span', obj.value); //alert(obj[obj.selectedIndex].innerHTML)
	Element.update('users_project_name_span', obj[obj.selectedIndex].innerHTML);


	var	postString = 'projectID='+obj.value;  	//alert(postString);

  	var options = {
   	    method: 'post', // Use POST
    	postBody: postString,
    	onSuccess: function(t) { //alert(t.responseText);
    		var tData = eval('(' + t.responseText + ')');
    		var resultData = tData.results;
        	if (resultData.res == '1') { //successful



        		var userIDs = resultData.userIDs;
        		var userIDsLen = userIDs.length;


        		for (z = 0; z < userIDsLen; z++) {
        			$('project_users_'+userIDs[z]).checked = true;
        		}


        		Element.show(formName);

	       		//Element.hide(hideFormName);

        		//hilite('id_operationRes','hiliteRow');
        	} else {

        		Element.show(formName);
        		alert(operation_failure_msg+"\n"+resultData.msg); //alert(t.responseText);
        	}


    	},
    	on404: function(t) { // Handle 404
        	alert('Error 404: location "' + t.statusText + '" was not found.');
    	},
    	onFailure: function(t) {// Handle other errors
        	alert('Error ' + t.status + ' -- ' + t.statusText);
    	}
	}
	new Ajax.Request('index.php?job=ajjb&do=ajaxOps&op=getProjectUsers', options);

}


function updateProjectUsers(updateId, formName) {
		Element.hide(updateId);
		Element.update(updateId, '');

	var	postString = 'projectID='+$('users_project_id').value;  	//alert(postString);

	  var usersCB = document.getElementsByName('project_users[]');
	  var usersCBLen = usersCB.length;

	  var projectUsers =  '';
		  for (i = 0; i < usersCBLen; i++) {
		  	if (usersCB[i].checked == true) {
		  		projectUsers += usersCB[i].value + ',';
		  	}
		  }

	postString += '&projectUsers='+projectUsers;


  	var options = {
   	    method: 'post', // Use POST
    	postBody: postString,
    	onSuccess: function(t) { //alert(t.responseText);
    		var tData = eval('(' + t.responseText + ')');
    		var resultData = tData.results;

        	if (resultData.res == '1') { //successful

        		var msg = operation_successful_msg + '<br />'

        		Element.update(updateId, msg);
	       		Element.show(updateId);

	       		 var infoMsgLen = resultData.info.length;
				  for (i = 0; i < infoMsgLen; i++) {
				  		//Element.update('project_users_res_'+resultData.info[i].id, resultData.info[i].res);
				  }

        	} else {
        		alert(operation_failure_msg+"\n"+resultData.msg); //alert(t.responseText);
        	}
    	},
    	on404: function(t) { // Handle 404
        	alert('Error 404: location "' + t.statusText + '" was not found.');
    	},
    	onFailure: function(t) {// Handle other errors
        	alert('Error ' + t.status + ' -- ' + t.statusText);
    	}
	}
	new Ajax.Request('index.php?job=ajjb&do=ajaxOps&op=updateProjectUsers', options);

}


function deleteUser(getId, updateId, confirmMsg) {
	confirmRes = confirm(confirmMsg);
	//alert(confirmRes)
	if (confirmRes === false) {
		return false;
	}
	//reset form
	var obj = document.getElementById(getId);
	var	postString = 'userID='+obj.value;  	//alert(postString);

  	var options = {
   	    method: 'post', // Use POST
    	postBody: postString,
    	onSuccess: function(t) { //alert(t.responseText);
    		var tData = eval('(' + t.responseText + ')');
    		var resultData = tData.results;
        	if (resultData.res == '1') { //successful

				Element.update(updateId, operation_successful_msg + '<br />');
	       		Element.show(updateId);
	       		obj.remove(obj.selectedIndex);


        	} else {
        		alert(operation_failure_msg+"\n"+resultData.msg); //alert(t.responseText);
        	}
    	},
    	on404: function(t) { // Handle 404
        	alert('Error 404: location "' + t.statusText + '" was not found.');
    	},
    	onFailure: function(t) {// Handle other errors
        	alert('Error ' + t.status + ' -- ' + t.statusText);
    	}
	}
	new Ajax.Request('index.php?job=ajjb&do=ajaxOps&op=deleteUser', options);

}

function deletePriority(id, updateId, confirmMsg) {
	confirmRes = confirm(confirmMsg);
	if (confirmRes === false) {
		return false;
	}

	var	postString = 'priorityID='+id;  	//alert(postString);

  	var options = {
   	    method: 'post', // Use POST
    	postBody: postString,
    	onSuccess: function(t) { //alert(t.responseText);
    		var tData = eval('(' + t.responseText + ')');
    		var resultData = tData.results;
        	if (resultData.res == '1') { //successful

	       		$('priorityRow_'+id).remove();
				Element.update(updateId, operation_successful_msg + '<br />'+resultData.msg);
	       		Element.show(updateId);


        	} else {
        		alert(operation_failure_msg+"\n"+resultData.msg); //alert(t.responseText);
        	}
    	},
    	on404: function(t) { // Handle 404
        	alert('Error 404: location "' + t.statusText + '" was not found.');
    	},
    	onFailure: function(t) {// Handle other errors
        	alert('Error ' + t.status + ' -- ' + t.statusText);
    	}
	}
	new Ajax.Request('index.php?job=ajjb&do=ajaxOps&op=deletePriority', options);

}



