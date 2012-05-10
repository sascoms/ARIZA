
		<fieldset id="id_operationUsersRes" style="background-color: lightyellow; display:none;margin:10px;padding:10px; color: brown; font-weight:bold;">
			{$operationUsersResMsg}
		</fieldset>

		 <fieldset id="idUsersList" style="background-color: #efefef">
			 <legend>{#users_list#}:</legend>


			 <div style="margin:10px;">

			 	<div align="" style="float:right;">
			 		<strong><a href="javascript:void(0);" onclick="$('userEditForm').hide(); $('userAddForm').show();">{#add_new_user#}</a></strong>
			 	</div>


			 	{if $operatorsArr != ''}
					<form name="getUser" id="getUserForm" method="post" action="" onsubmit="getOperatorData('userListSelect', 'userEditForm', 'userAddForm');return false;">
			 	     	<select name="userListSelect" id="userListSelect" size="1">
				 	     {foreach key=key item=value from=$operatorsArr}
			 	     		<option value="{$key}">{$value}</option>
					     {/foreach}
			 	     	</select>
						<input type="submit" name="getUserDataSubmit" id="getUserDataSubmit" value="{#update#}" class="noborder">
						<input type="submit" name="deleteUserSubmit" id="deleteUserSubmit" value="{#delete_user#}" class="noborder" onclick="deleteUser('userListSelect', 'id_operationUsersRes', '{#users_delete_confirm#}'); return false;">
					</form>
				{else}
					<div id="idusersListErrMsg" class="small">
					 	&nbsp;&nbsp;&nbsp;{#users_list_error#}
				 	</div>

				{/if}


					<div id="userEditForm" style="display:none;padding:5px;">
					<br />
					<br />
					<h3 style="border-bottom:1px solid #ccc;">{#update_user_header#}</h3>

						<table border="0" cellpadding="2" cellspacing="2">
						<form name="updateUser" id="updateUserForm" method="post" action="" onsubmit="updateOperatorData('userListSelect', 'id_operationUsersRes', 'userEditForm');return false;">
							<tr>
								<th align="right">{#user_id#}</th>
								<td>
									<span id="userDetails_id_span"></span>
									<input type="hidden" id="userDetails_id" name="" value="" />

								</td>
							</tr>
							<tr>
								<th align="right">{#user_name#}<span style="color:red;"><strong>*</strong></span></th>
								<td id=""><input type="text" id="userDetails_user" name="" value="" /></td>
							</tr>
							<tr>
								<th align="right">{#password#}</span></th>
								<td id=""><input type="text" id="userDetails_pass" name="" value="" /></td>
							</tr>
							<tr>
								<th align="right">{#user_firstname#}</th>
								<td id=""><input type="text" id="userDetails_firstname" name="" value="" /></td>
							</tr>
							<tr>
								<th align="right">{#user_lastname#}</th>
								<td id=""><input type="text" id="userDetails_lastname" name="" value="" /></td>
							</tr>
							<tr>
								<th align="right">{#user_email#}<span style="color:red;"><strong>*</strong></span></th>
								<td id=""><input type="text" id="userDetails_email" name="" value="" /></td>
							</tr>
							<tr>
								<th align="right">{#user_type#}</th>
								<td id=""><input type="text" id="userDetails_type" name="" value="" /></td>
							</tr>
							<tr>
								<th align="right">{#user_status#}<span style="color:red;"><strong>*</strong></span></th>
								<td id=""><input type="checkbox" id="userDetails_status" name="userDetails_status" value="" /></td>
							</tr>
							<tr>
								<th align="right">{#user_admin#}</th>
								<td id=""><input type="checkbox" id="userDetails_admin" name="userDetails_admin" value="" /></td>
							</tr>
							<tr>
								<th align="right">{#user_project_default#}</th>
								<td id="">

									<select name="userDetails_project_default" id="userDetails_project_default" size="1">
									<option value="">-- --</option>
			 	     				{foreach key=projectsKeyD item=projectsValuesD from=$projectsArr}
						 	     		<option value="{$projectsKeyD}">{$projectsValuesD.name}</option>
								     {/foreach}

									</select>
								</td>
							</tr>
							<tr>
								<td align="right" colspan="2"><input type="submit" name="updateUserDataSubmit" id="updateUserDataSubmit" value="{#submit#}" class="noborder" />
							</tr>
						</form>

						<form name="updateUserProjects" id="updateUserProjects" method="post" action="" onsubmit="updateOperatorProjects('userListSelect', 'id_operationUsersRes', 'updateUserProjects');return false;">

							<tr>
								<th align="right">{#user_projects#}<span style="color:red;"><strong>*</strong></span></th>
								<td id="">

			 	     				{foreach key=projectsKey item=projectsValues from=$projectsArr}
     									<label><input type="checkbox" id="userDetails_projects_{$projectsKey}" name="userDetails_projects[]" value="{$projectsKey}" />{$projectsValues.name}</label>
								     {/foreach}

								</td>

							</tr>
							<tr>
								<td align="right" colspan="2"><input type="submit" name="updateUserProjectsSubmit" id="updateUserProjectsSubmit" value="{#submit#}" class="noborder" />
							</tr>
						</form>

						</table>
					</div>








					<div id="userAddForm" style="display:none;padding:5px;">
					<br />
					<br />
					<h3 style="border-bottom:1px solid #ccc;">{#add_new_user#}</h3>
						<table border="0" cellpadding="2" cellspacing="2">
						<form name="addUser" id="addUserForm" method="post" action="" onsubmit="addOperatorData('id_operationUsersRes', 'addUserForm', 'userListSelect');return false;">
							<tr>
								<th align="right">{#user_name#}<span style="color:red;"><strong>*</strong></span></th>
								<td id=""><input type="text" id="userNew_user" name="" value="" /></td>
							</tr>
							<tr>
								<th align="right">{#user_email#}<span style="color:red;"><strong>*</strong></span></th>
								<td id=""><input type="text" id="userNew_email" name="" value="" /></td>
							</tr>
							<tr>
								<th align="right">{#password#}<span style="color:red;"><strong>*</strong></span></th>
								<td id=""><input type="text" id="userNew_pass" name="" value="" /></td>
							</tr>
							<tr>
								<th align="right">{#user_firstname#}</th>
								<td id=""><input type="text" id="userNew_firstname" name="" value="" /></td>
							</tr>
							<tr>
								<th align="right">{#user_lastname#}</th>
								<td id=""><input type="text" id="userNew_lastname" name="" value="" /></td>
							</tr>
							<tr>
								<th align="right">{#user_type#}</th>
								<td id=""><input type="text" id="userNew_type" name="" value="" /></td>
							</tr>
							<tr>
								<th align="right">{#user_status#}<span style="color:red;"><strong>*</strong></span></th>
								<td id=""><input type="checkbox" id="userNew_status" name="userNew_status" value="" /></td>
							</tr>
							<tr>
								<th align="right">{#user_admin#}</th>
								<td id=""><input type="checkbox" id="userNew_admin" name="userNew_admin" value="" /></td>
							</tr>
							<tr>
								<th align="right">{#user_project_default#}</th>
								<td id="">

									<select name="userNew_project_default" id="userNew_project_default" size="1">
									<option value="">-- --</option>
			 	     				{foreach key=projectsKeyD item=projectsValuesD from=$projectsArr}
						 	     		<option value="{$projectsKeyD}">{$projectsValuesD.name}</option>
								     {/foreach}

									</select>
								</td>
							</tr>
							<tr>
								<th align="right">{#user_projects#}<span style="color:red;"><strong>*</strong></span></th>
								<td id="">

			 	     				{foreach key=projectsKey item=projectsValues from=$projectsArr}
						 	     		<label><input type="checkbox" id="userNew_projects_{$projectsKey}" name="userNew_projects[]" value="{$projectsKey}" />{$projectsValues.name}</label>
								     {/foreach}

								</td>

							</tr>

							<tr>
								<td align="right" colspan="2"><input type="submit" name="addUserDataSubmit" id="addUserDataSubmit" value="{#submit#}" class="noborder" />
							</tr>
						</form>


						</table>
					</div>



			 </div>


		</fieldset>
