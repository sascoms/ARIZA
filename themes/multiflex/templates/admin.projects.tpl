
<fieldset id="id_operationRes" style="background-color: lightyellow; display:{if $operationResMsg != ''}block{else}none{/if};margin:10px;padding:10px; color: brown; font-weight:bold;">
	{$operationResMsg}
</fieldset>








		 <fieldset id="idProjectsList" style="background-color: #efefef">
			 <legend>{#projects_list_header#}:</legend>


			 <div style="margin:10px;">

			 	<div align="" style="float:right;">
			 		<strong><a href="javascript:void(0);" onclick="$('projectEditForm').hide(); $('projectAddForm').show();">{#projects_add_new#}</a></strong>
			 	</div>


			 	{if $projectsArr != ''}
					<form name="getProjectForm" id="getProjectForm" method="post" action="">
			 	     	<select name="projectListSelect" id="projectListSelect" size="1">
				 	     {foreach key=key item=values from=$projectsArr}
			 	     		<option value="{$values.project_id}">{$values.name}</option>
					     {/foreach}
			 	     	</select>
						<input type="submit" name="getProjectDataSubmit" id="getProjectDataSubmit" value="{#update#}" class="noborder" onclick="getProjectData('projectListSelect', 'projectEditForm', 'projectAddForm'); return false;">
						<input type="submit" name="deleteProjectSubmit" id="deleteProjectSubmit" value="{#projects_delete#}" class="noborder" onclick="return confirm('{#project_delete_confirm#}');" />
						<input type="submit" name="addUsersProjectSubmit" id="addUsersProjectSubmit" value="{#projects_add_users#}" class="noborder" onclick="showProjectUsers('projectListSelect', 'projectAddUsersForm');return false;" />
					</form>
				{else}
					<div id="idProjectsListErrMsg" class="small">
					 	&nbsp;&nbsp;&nbsp;{#projects_list_error#}
				 	</div>

				{/if}


					<div id="projectEditForm" style="display:none;padding:5px;">
					<br />
					<br />
					<h3 style="border-bottom:1px solid #ccc;">{#projects_update_header#}</h3>

						<table border="0" cellpadding="2" cellspacing="2">
						<form name="updateProject" id="updateProjectForm" method="post" action="" onsubmit="return validateUpdateForm();">
							<tr>
								<th align="right">{#project_id_label#}</th>
								<td>
									<span id="project_id_span"></span>
									<input type="hidden" id="project_id" name="project_id" value="" />

								</td>
							</tr>
							<tr>
								<th align="right">{#project_name_label#}<span style="color:red;"><strong>*</strong></span></th>
								<td id=""><input type="text" id="project_name" name="project_name" value="" /></td>
							</tr>
							<tr>
								<th align="right">{#project_description_label#}</th>
								<td id=""><input type="text" id="project_description" name="project_description" value="" size="75" maxlength="255" /></td>
							</tr>
							<tr>
								<th align="right"><label for="project_active">{#project_is_active_label#}</label></th>
								<td id="">
									<input type="checkbox" id="project_active" name="project_active" value="1" />
								</td>
							</tr>

							<tr>
								<td align="right" colspan="2"><input type="submit" name="updateProjectDataSubmit" id="updateProjectDataSubmit" value="{#submit#}" class="noborder" />
							</tr>
						</form>

						</table>
					</div>







					<div id="projectAddForm" style="display:none;padding:5px;">
					<br />
					<br />
					<h3 style="border-bottom:1px solid #ccc;">{#projects_add_new#}</h3>

						<table border="0" cellpadding="2" cellspacing="2">
						<form name="addProject" id="addProjectForm" method="post" action="" onsubmit="validateAddForm();">
							<tr>
								<th align="right">{#project_name_label#}<span style="color:red;"><strong>*</strong></span></th>
								<td id=""><input type="text" id="new_project_name" name="new_project_name" value="" /></td>
							</tr>
							<tr>
								<th align="right">{#project_description_label#}</th>
								<td id=""><input type="text" id="new_project_description" name="new_project_description" value="" size="75" maxlength="255" /></td>
							</tr>
							<tr>
								<th align="right"><label for="new_project_active">{#project_is_active_label#}</label></th>
								<td id="">
									<input type="checkbox" id="new_project_active" name="new_project_active" value="1" checked="true" />
								</td>
							</tr>
							<tr>
								<td align="right" colspan="2"><input type="submit" name="addProjectDataSubmit" id="addProjectDataSubmit" value="{#submit#}" class="noborder" />
							</tr>
						</form>

						</table>
					</div>



					<div id="projectAddUsersForm" style="display:none;padding:5px;">
					<br />
					<br />
					<h3 style="border-bottom:1px solid #ccc;">{#projects_add_users#}</h3>

						<table border="0" cellpadding="2" cellspacing="2">
						<form name="addUsersProject" id="addUsersProject" method="post" action="" onsubmit="updateProjectUsers('id_operationRes');return false;">
							<tr>
								<th align="right">{#project_id_label#}</th>
								<td>
									<span id="users_project_id_span"></span>
									<input type="hidden" id="users_project_id" name="users_project_id" value="" />

								</td>
							</tr>
							<tr>
								<th align="right">{#project_name_label#}</th>
								<td>
									<span id="users_project_name_span"></span>
								</td>
							</tr>

							<tr>
								<th align="right" valign="top">{#projects_add_users#}<span style="color:red;"><strong>*</strong></span></th>
								<td id="">
								{foreach key=key item=value from=$operatorsArr}
									<label><input type="checkbox" id="project_users_{$key}" name="project_users[]" value="{$key}" />{$value}</label> <span id="project_users_res_{$key}"></span> <br />
								{/foreach}
								</td>
							</tr>
							<tr>
								<td align="right" colspan="2"><input type="submit" name="projectUsersSubmit" id="projectUsersSubmit" value="{#submit#}" class="noborder" />
							</tr>
						</form>

						</table>
					</div>



			 </div>


		</fieldset>

