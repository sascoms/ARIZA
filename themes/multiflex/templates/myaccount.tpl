<script src="{$libraryPath}validation/apple_formvalidation.js" type="text/javascript"></script>
<script type="text/javascript">
	var passCurrent = '{#current_password#}'
	var passA = '{#new_password#}'
	var passB = '{#new_password#}'
	var error_text = '{#passwords_empty_msg#}'
    var error_alert_title = '{#js_check_the_errors_below#}';

{literal}
		function validatePasswordForm() {
		    var errors = "";

		    errors += isEmpty('current_pass', passCurrent, error_text);
		    errors += isEmpty('passA', passA, error_text);
		    errors += isEmpty('passB', passB, error_text);

		    if (errors != "") {
		    	errors = error_alert_title + "\n" + error_text;
		       alert(errors);
		       return false;
		    }
			return true;
		}
{/literal}
</script>
{if $showUpdateResult == true}
	<fieldset id="id_operationUsersRes" style="background-color: lightyellow; margin:10px;padding:10px; color: brown; font-weight:bold;">
		{if $updateResult == true}
			{#my_account_update_success#}
		{else}
			(#my_account_update_failure#)
		{/if}
	</fieldset>
{/if}
 <fieldset id="idUsersAccount" style="background-color: #efefef">
	 <legend>{#my_account_header#}</legend>


	 <div style="margin:10px;">


		<div id="userEditForm" style="">
			<table border="0" cellpadding="2" cellspacing="2" width="90%">
			<form name="updateUser" id="updateUserForm" method="post" action="" onsubmit="return true;">
				<tr>
					<th align="right" width="25%">{#user_id#}</th>
					<td>
						<span id="id_span">{$myUserData.staff_id}</span>

					</td>
				</tr>
				<tr>
					<th align="right">{#user_type#}</th>
					<td id=""><span>{$myUserData.staff_type}</span></td>
				</tr>
				<tr>
					<th align="right">{#user_name#}</th>
					<td id=""><span>{$myUserData.staff_user}</span></td>
				</tr>
				<tr>
					<th align="right">{#user_email#}</th>
					<td id=""><span>{$myUserData.staff_email}</span></td>
				</tr>
				<tr>
					<th align="right">{#user_firstname#}</th>
					<td id=""><input type="text" id="name" name="name" value="{$myUserData.staff_name}" /></td>
				</tr>
				<tr>
					<th align="right">{#user_lastname#}</th>
					<td id=""><input type="text" id="lastname" name="lastname" value="{$myUserData.staff_surname}" /></td>
				</tr>
				<tr>
					<th align="right">{#user_project_default#}</th>
					<td id="">

						<select name="default_project_id" id="default_project_id" size="1">
							<option value="">-- --</option>
 	     				{foreach key=projectsKeyD item=projectsValuesD from=$projectsArr}
			 	     		<option value="{$projectsKeyD}"{if $myUserData.default_project_id == $projectsKeyD} selected {/if}>{$projectsValuesD.name}</option>
					     {/foreach}
						</select>
					</td>
				</tr>

				<tr>
					<td align="">&nbsp;</td>
					<td align=""><input type="submit" name="updateUserDetails" id="updateUserDetails" value="{#submit#}" class="noborder" /></td>
				</tr>
			</form>
				<tr>
					<th align="right">&nbsp;</th>
					<td id=""><span>{#apply_to_admin_for_changes#}</span></td>
				</tr>
			</table>
		</div>


	 </div>


</fieldset>

<br />
<br />
<br />



 <fieldset id="idUsersPass" style="background-color: #efefef">
	 <legend>{#change_password_header#}</legend>


	 <div style="margin:10px;">


		<div id="userEditForm" style="">

			<table border="0" cellpadding="2" cellspacing="2" width="90%">
			<form name="updateUserPassword" id="updateUserPassword" method="post" action="" onsubmit="return validatePasswordForm();">

				{if $emptyPasswordsError == true}
					<tr>
						<td id="" colspan="2">
							<span class="failureText">{#passwords_empty_msg#}</span>
						</td>
					</tr>
				{/if}

				{if $passwordsMatchError == true}
					<tr>
						<td id="" colspan="2">
							<span class="failureText">{#passwords_match_error_msg#}</span>
						</td>
					</tr>
				{/if}

				{if $showPasswordsResult == true}
					<tr>
						<td id="" colspan="2">
							{if $updatePasswordsResult == true}
								<span class="successText">{#passwords_change_success#}</span>
							{else}
								<span class="failureText">{#passwords_change_failure#}</span>
							{/if}

						</td>
					</tr>
				{/if}

				<tr>
					<th align="right" valign="top" width="25%">{#current_password#}:</th>
					<td id="">
						<input type="text" id="current_pass" name="current_pass" value="" /><br />
					</td>
				</tr>
				<tr>
					<th align="right" valign="top" width="25%">{#new_password#}:</th>
					<td id="">
						<input type="text" id="passA" name="passA" value="" style="margin-bottom:1px" /><br />
					</td>
				</tr>

				<tr>
					<th align="right" valign="top">{#new_password#}:</th>
					<td id="">
						<input type="text" id="passB" name="passB" value="" /> ({#again#})
					</td>
				</tr>
				<tr>
					<td align="">&nbsp;</td>
					<td align=""><input type="submit" name="updateUserPass" id="updateUserPass" value="{#submit#}" class="noborder" /></td>
				</tr>

			</form>
			</table>
		</div>


	 </div>


</fieldset>
