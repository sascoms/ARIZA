	<script src="{$libraryPath}scriptaculous/lib/prototype.js" type="text/javascript"></script>
	<script src="{$libraryPath}scriptaculous/src/scriptaculous.js" type="text/javascript"></script>

	<script type="text/javascript">
		var ajax_processing_operation = '{$LNG_ajax_processing_operation}';

	    var error_alert_title = '{$LNG_js_check_the_errors_below}';
	    var empty_unchecked_boxes_error = '{$LNG_js_unchecked_box}';

		var operation_successful_msg = '{$LNG_operation_successful_msg}';
		var operation_failure_msg = '{$LNG_operation_failure_msg}';


	{literal}
	//	addLoadEvent(function() {
	//		changeRowClassOnMouseOver('bugListRows', 'row4', 'hilitedRow2');
	//	});

		/*
			Ajax.Responders.register({
				onCreate: function(){
					alert('a request has been initialized!');
				},
				onComplete: function(){
					alert('a request completed');
				}
			});
		*/
		Ajax.Responders.register( {
			onCreate: function(e) {
				showNotify(ajax_processing_operation);
			},
			onComplete: function() {
				hideNotify();
			}
		} );

		function ajaxPerformer(jobName, getId, updateId) {
			//check if there are any checked box
			var checkedTotal = 0;
			var chb = document.getElementsByName('bugs[]');
			for ( i=0; i < chb.length; i++ ) {
				var ch = chb[i];
					if (ch.checked==true) {
						++checkedTotal;
					}
				}
		    if (checkedTotal == 0) {
		    	alert(error_alert_title + "\n" + empty_unchecked_boxes_error);
		    	return false;
		    }


			var doc = document;
			var obj = doc.getElementById(getId);
			var sText = obj.options[obj.selectedIndex].text; //alert(sText);
			var postString = Form.serialize('id_bugListForm');  	//alert(postString);
				postString += '&'+getId+'='+obj.value;  	//alert(postString);

		  	var options = {
		   	    method: 'post', // Use POST
		    	postBody: postString,
		    	onSuccess: function(t) { //alert(t.responseText);
		        	if (t.responseText=='C31200') { //successful

		        		//check all checkbox indaki check isaretini kaldiralim.
		        		var cbAllObj = document.getElementById('checkAll');
		        		cbAllObj.checked = false;

		        		var chb = document.getElementsByName('bugs[]');
		        		 for ( i=0; i < chb.length; i++ ) {
		        		 	var ch = chb[i];
		    		 		var x = ch.value;
		        		 	if (ch.checked==true) {
		        		 		ch.checked=false;
					        	//hilite('id_row_'+x,'');
					        	Element.update(updateId + x, sText);
					        	//new Effect.Highlight('id_row_'+x);
					        	switchClass('id_row_'+x, 'row4');
		        		 	}
					      }
		        		var msg = operation_successful_msg + '<br />'
		        		Element.update('id_operationRes', msg);
		        		Element.show('id_operationRes');
		        		//hilite('id_operationRes', 'hilitedRow1');
		        	} else {
		        		alert(operation_failure_msg +"\n"+t.responseText);
		        	}
		    	},
		    	on404: function(t) { // Handle 404
		        	alert('Error 404: location "' + t.statusText + '" was not found.');
		    	},
		    	onFailure: function(t) {// Handle other errors
		        	alert('Error ' + t.status + ' -- ' + t.statusText);
		    	}
			}
			new Ajax.Request('index.php?job=ajjb&do='+jobName, options);

		}



	{/literal}
	</script>





<br />

<div id="operationsBar">
	<fieldset>
	<legend>{$LNG_operations}:</legend>
		<fieldset class="sub">
			<legend>{$LNG_assign_to}:</legend>
				<select name="operatorId" id="operatorId" size="1" class="noborder">
			     {foreach key=key item=value from=$staffList}
			     	<option value="{$key}">{$value}</option>
			     {/foreach}
				</select>
					<input name="button" type="button" id="submit" value="{$LNG_submit}" onclick="javascript:ajaxPerformer('associate', 'operatorId', 'id_replier_');">
		</fieldset>

		<fieldset class="sub">
			<legend>{$LNG_prioritize}:</legend>
				<select name="priorityId" id="priorityId" size="1">
			     {foreach key=key item=value from=$priorities}
			     	<option value="{$key}">{$value}</option>
			     {/foreach}
				</select>
					<input name="button" type="button" id="submit" value="{$LNG_submit}" onclick="javascript:ajaxPerformer('prioritize', 'priorityId', 'id_priority_');">
		</fieldset>

		<fieldset class="sub">
			<legend>{$LNG_change_bug_type}:</legend>
				<select name="bugTypeId" id="bugTypeId" size="1">
			     {foreach key=key item=value from=$BugTypes}
			     	<option value="{$key}">{$value}</option>
			     {/foreach}
				</select>
					<input name="button" type="button" id="submit" value="{$LNG_submit}" onclick="javascript:ajaxPerformer('changeBugType', 'bugTypeId', 'id_bugType_');">
		</fieldset>

	</fieldset>

</div>

<form action="" method="post" id="filterForm">
<div id="filtersBar">
	<fieldset>
	<legend>{$LNG_filter}:</legend>
		<fieldset class="sub">
			<legend>{$LNG_sender}:</legend>
				<select name="filterSenderId" id="filterSenderId" size="1" class="noborder">
					<option value="">{$LNG_select_option_value}</option>
			     {foreach key=key item=value from=$staffList}
			     	<option value="{$key}"{if $smarty.post.filterSenderId==$key} selected{/if}>{$value}</option>
			     {/foreach}
				</select>
		</fieldset>

		<fieldset class="sub">
			<legend>{$LNG_forwarded_to}:</legend>
				<select name="filterForwardedToId" id="filterForwardedTo" size="1" class="noborder">
					<option value="">{$LNG_select_option_value}</option>
			     {foreach key=key item=value from=$staffList}
			     	<option value="{$key}"{if $smarty.post.filterForwardedToId==$key} selected{/if}>{$value}</option>
			     {/foreach}
				</select>
		</fieldset>

		<fieldset class="sub">
			<legend>{$LNG_priority}:</legend>
				<select name="filterPriorityId" id="filterPriorityId" size="1">
					<option value="">{$LNG_select_option_value}</option>
			     {foreach key=key item=value from=$priorities}
			     	<option value="{$key}"{if $smarty.post.filterPriorityId==$key} selected{/if}>{$value}</option>
			     {/foreach}
				</select>
		</fieldset>

		<fieldset class="sub">
			<legend>{$LNG_request_type}:</legend>
				<select name="filterBugTypeId" id="filterBugTypeId" size="1">
					<option value="">{$LNG_select_option_value}</option>
			     {foreach key=key item=value from=$BugTypes}
			     	<option value="{$key}"{if $smarty.post.filterBugTypeId==$key} selected{/if}>{$value}</option>
			     {/foreach}
				</select>
		</fieldset>

		<fieldset class="sub">
			<legend>{$LNG_bug_status}:</legend>
				<select name="filterBugStatusId" id="filterBugStatusId" size="1">
					<option value="">{$LNG_select_option_value}</option>
			     {foreach key=key item=value from=$bug_statuses}
			     	<option value="{$key}"{if $smarty.post.filterBugStatusId==$key} selected{/if}>{$value}</option>
			     {/foreach}
				</select>
		</fieldset>

		<fieldset class="sub">
			<legend>&nbsp;</legend>
			<input name="filterSubmit" type="submit" id="filterSubmit" value="{$LNG_filter}" />
		</fieldset>

	</fieldset>

</div>
</form>





<div id="id_operationRes" class="operationResultMsg" style="display:none;" align="center"></div>
<br />

<form name="bugListForm" enctype="multipart/form-data" method="post" action="" id="id_bugListForm">
<table id="bugListRows" width="100%" class="classic" cellspacing="1" cellpadding="1">
	<thead>
		<tr>
			<th class="cellTitle align-right">#</th>
			<th class="cellTitle"><input class="checkbox" type="checkbox" name="checkAll" id="checkAll" onclick="toggleCheckBoxes('bugs[]', this, 'row4', 'hilitedRow1');" /></th>
			<th class="cellTitle">{#request_code#}</th>
			<th class="cellTitle">{$LNG_request_title}</th>
			<th class="cellTitle">{$LNG_request_type}</th>
			<th class="cellTitle">{$LNG_sender}</th>
			<th class="cellTitle" width="40">{$LNG_date}</th>
			<th class="cellTitle">{$LNG_bug_status}</th>
			<th class="cellTitle">{$LNG_completed_percentage}</th>
			<th class="cellTitle">{$LNG_priority}</th>
			<th class="cellTitle">{$LNG_forwarded_to}</th>
			<th class="cellTitle">{$LNG_replies}</th>
		</tr>
	</thead>


	<tbody>

{if $bugList != ''}
     {foreach key=key item=value from=$bugList}
	    <tr id="id_row_{$value.bug_id}" class="{if $value.is_solved == 0}row4{else}row6{/if}"{if $value.is_solved == 0} onmouseover="changeRowClass('id_row_{$value.bug_id}', 'id_bugs_{$value.bug_id}', 'hilitedRow2', '');" onmouseout="changeRowClass('id_row_{$value.bug_id}', 'id_bugs_{$value.bug_id}', 'row4', 'hilitedRow1');"{/if}>
			<td class="align-right"><a href="index.php?job=respond&amp;id={$value.bug_id}">{$key}</a></td>

			<td align="center">
				{if $value.replier_id == NULL}			{/if}
				{if $value.is_solved == 0}
					<input class="checkbox" type="checkbox" name="bugs[]" id="id_bugs_{$value.bug_id}" value="{$value.bug_id}" onclick="hiliteNew('id_row_{$value.bug_id}', 'row4', 'hilitedRow1');" />
				{else}
					<img src="images/icons/check.gif" alt="{$LNG_closed}" title="{$LNG_closed}" />
				{/if}
			</td>

			<td>{$value.bug_code}</td>
			<td><a href="index.php?job=respond&amp;id={$value.bug_id}">{$value.bug_title|truncate:30:"...":false}</a></td>
			<td id="id_bugType_{$value.bug_id}">{$BugTypes[$value.bug_type_id]}</td>
			<td>{$value.sender_fullname}</td>
			<td align="center">{$value.reported_datetime}</td>
			<td>{$value.status_label}</td>
			<td>{$value.progress_percent}%</td>
			<td id="id_priority_{$value.bug_id}">{$value.priority_text}</td>
			<td id="id_replier_{$value.bug_id}">{$value.replier_fullname}</td>

			<td align="left">
				{if $value.totalentries > 0}
						<img src="images/icons/comment{if $value.totalentries > 1}s{/if}.png" alt="{$value.totalentries} {if $value.totalentries > 1}{$LNG_replies}{else}{$LNG_reply}{/if}" title="{$value.totalentries} {if $value.totalentries > 1}{$LNG_replies}{else}{$LNG_reply}{/if}" />
						{$value.totalentries}
				{/if}
			</td>
	    </tr>
	{/foreach}
{/if}
</tbody>
</table>
</form>