        <link href="{$libraryPath}mochikit/style/sortable_tables.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="{$libraryPath}mochikit/lib/MochiKit.js"></script>
        <script type="text/javascript" src="{$libraryPath}mochikit/lib/sortable_tables.js"></script>
        
  		<script src="{$libraryPath}scriptaculous/lib/prototype.js" type="text/javascript"></script>
  		<script src="{$libraryPath}scriptaculous/src/scriptaculous.js" type="text/javascript"></script>        
  
        <script type="text/javascript" src="{$libraryPath}generalFuncs.js"></script>
        <script type="text/javascript" src="{$libraryPath}bugListFuncs.js"></script>
        
 <br />
        
<div id="id_operationRes" align="center">&nbsp;</div>

<div id="operationsBar"> 
	<fieldset>
	<legend>{$LNG_operations}:</legend>		 
		<fieldset class="sub">
			<legend>{$LNG_association}:</legend>		 
				<select name="operatorId" id="operatorId" size="1" class="noborder">
			     {foreach key=key item=value from=$staffList}
			     	<option value="{$key}">{$value}</option>
			     {/foreach}
				</select>
					<input name="button" type="button" class="noborder" id="submit" value="{$LNG_submit}" onclick="javascript:ajaxPerformer('associate', 'operatorId', 'id_replier_');">
		</fieldset>
		
		<fieldset class="sub">
			<legend>{$LNG_filter}:</legend>		 
				<select name="filterBugTypeId" id="filterBugTypeId" size="1" class="noborder">
			     {foreach key=key item=value from=$BugTypes}
			     	<option value="{$key}">{$value}</option>
			     {/foreach}
				</select>
				<select name="filterPriorityId" id="filterPriorityId" size="1" class="noborder">
			     {foreach key=key item=value from=$priorities}
			     	<option value="{$key}">{$value}</option>
			     {/foreach}
				</select>
					<input name="button" type="button" class="noborder" id="submit" value="{$LNG_submit}" onclick="javascript:filterBugs();">
		</fieldset>
		
		<fieldset class="sub">
			<legend>{$LNG_prioritize}:</legend>		 
				<select name="priorityId" id="priorityId" size="1" class="noborder">
			     {foreach key=key item=value from=$priorities}
			     	<option value="{$key}">{$value}</option>
			     {/foreach}
				</select>
					<input name="button" type="button" class="noborder" id="submit" value="{$LNG_submit}" onclick="javascript:ajaxPerformer('prioritize', 'priorityId', 'id_priority_');">
		</fieldset>
		
		<fieldset class="sub">
			<legend>{$LNG_change_bug_type}:</legend>		 
				<select name="bugTypeId" id="bugTypeId" size="1" class="noborder">
			     {foreach key=key item=value from=$BugTypes}
			     	<option value="{$key}">{$value}</option>
			     {/foreach}
				</select>
					<input name="button" type="button" class="noborder" id="submit" value="{$LNG_submit}" onclick="javascript:ajaxPerformer('changeBugType', 'bugTypeId', 'id_bugType_');">
		</fieldset>
	</fieldset>
	
</div>
<form name="bugListForm" enctype="multipart/form-data" method="post" action="" id="id_bugListForm">
        
<table id="sortable_table" class="datagrid" width="100%"> 
	<thead>
	    <tr>
	        <th mochi:format="str">#</th>
	        <th mochi:format="istr">{$LNG_request_title}</th>
	        <th mochi:format="istr">{$LNG_request_type}</th>
	        <th mochi:format="istr">{$LNG_sender}</th>
	        <th mochi:format="istr">{$LNG_date}</th>
	        <th mochi:format="istr">{$LNG_priority}</th>
	        <th mochi:format="istr">{$LNG_forwarded_to}</th>
	        <th>{$LNG_replies}</th>
	        <th>-</th>
	    </tr>
	</thead>
	<tbody>
{if $bugList != ''}
     {foreach key=key item=value from=$bugList}		
	    <tr id="id_row_{$value.bug_id}">
			<td><a href="index.php?job=respond&amp;id={$value.bug_id}">{$value.bug_id}</a></td>
			<td><a href="index.php?job=respond&amp;id={$value.bug_id}">{$value.bug_title|truncate:30:"...":false}</a></td>
			<td id="id_bugType_{$value.bug_id}">{$BugTypes[$value.bug_type_id]}</td>    
			<td>{$value.sender_fullname}</td>
			<td>{$value.reported_datetime}</td>
			<td id="id_priority_{$value.bug_id}">{$value.priority_text}</td>
			<td id="id_replier_{$value.bug_id}">{$value.replier_fullname}</td>
			
			<td>
			{if $value.totalentries > 0}
			<img src="images/icons/entries.gif" alt="toplam yanit" />
				{$value.totalentries}
			{/if}
			</td>
			<td>
			{if $value.replier_id == NULL}			{/if}
				<input type="checkbox" name="bugs[]" id="id_bugs_{$value.bug_id}" value="{$value.bug_id}" onclick="hilite('id_row_{$value.bug_id}','hiliteRow');" />
			</td>
	    </tr>
	{/foreach}
{/if}	
</tbody>     
</table>
</form>


