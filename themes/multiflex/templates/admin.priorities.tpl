<script src="{$libraryPath}colorPicker/301a.js" type="text/javascript"></script>
<div id="colorpicker301" class="colorpicker301"></div>


<fieldset id="id_operationRes" style="background-color: lightyellow; display:{if $operationResMsg != ''}block{else}none{/if};margin:10px;padding:10px; color: brown; font-weight:bold;">
	{$operationResMsg}
</fieldset>








		 <fieldset id="idPriorityList" style="background-color: #efefef">
			 <legend>{#priorities_list_header#}:</legend>


			 <div style="margin:10px;">

			 	<div align="" style="float:right;">
			 		<strong><a href="#add-priority">{#priorities_add_new#}</a></strong>
			 	</div>


			 	{if $prioritiesArr == ''}
					<div id="idPriorityListErrMsg" class="small">
					 	&nbsp;&nbsp;&nbsp;<span class="failureText">{#priorities_list_error#}</span>
				 	</div>

				{else}


					<div id="editForm" style="display:;padding:5px;" align="left">
					<h3 style="border-bottom:1px solid #ccc;">{#priorities_update_header#}</h3>

						<table border="0" cellpadding="2" cellspacing="2" width="75%" class="classic" style="margin:0;">
						<form name="updatePriorities" id="updatePrioritiesForm" method="post" action="" onsubmit="return validateUpdateForm();">
							<tr>
								<th align="left" width="20">#</th>
								<th align="left" width="20">{#priority_id_label#}</th>
								<th align="left" width="120">{#priority_name_label#}</th>
								<th align="left">{#priority_color_label#}</th>
								<th align="left">{#delete#}</th>
							</tr>

							{counter start=0 print=0}
					 	    {foreach key=key item=values from=$prioritiesArr}
							<tr class="row4" id="priorityRow_{$values.id}">
				 	     		<td id="">{counter}</td>
				 	     		<td id="">
				 	     			{$values.id}
				 	     			<input type="hidden" id="userDetails_id" name="priorities[{$values.id}][id]" value="{$values.id}" />
				 	     		</td>
				 	     		<td id=""><input type="text" id="priorities_name_{$values.id}" name="priorities[{$values.id}][name]" value="{$values.name}" /></td>
				 	     		<td id="">
				 	     			<input type="text" id="priorities_color_{$values.id}" name="priorities[{$values.id}][color]" value="{$values.color}" maxlength="7" />

				 	     			<span id="priorities_color_sample_{$values.id}" style="border:1px solid #000;background-color:{$values.color};">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
				 	     			<img src="{$libraryPath}colorPicker/sel.gif" onclick="showColorGrid3('priorities_color_{$values.id}','priorities_color_sample_{$values.id}');" border="0" style="cursor:pointer" alt="{#select_color#}" title="{#select_color#}">






				 	     		</td>
				 	     		<td id="">
	     								<a href="javascript:void(0);" onclick="deletePriority('{$values.id}', 'id_operationRes', '{#priority_delete_confirm#}'); return false;">{#delete#}</a>
				 	     		</td>
							</tr>
						    {/foreach}
							<tr class="row4">
								<td align="center" colspan="5"><input type="submit" name="updatePrioritiesSubmit" id="updatePrioritiesSubmit" value="{#submit#}" class="noborder" />
							</tr>
						</form>

						</table>
					</div>
				{/if}







					<a name="add-priority"></a>
					<div id="priorityAddForm" style="display:block;padding:5px;">
					<br />
					<br />
					<h3 style="border-bottom:1px solid #ccc;">{#priorities_add_new#}</h3>

						<table border="0" cellpadding="2" cellspacing="2" class="classic" style="margin:0px;" width="40%">
						<form name="addPriorityForm" id="addPriorityForm" method="post" action="" onsubmit="validateAddForm();">
							<tr class="row4">
								<th align="right">{#label#}<span style="color:red;"><strong>*</strong></span></th>
								<td id=""><input type="text" id="new_priority_name" name="new_priority_name" value="" /></td>
							</tr>
							<tr class="row4">
								<th align="right">{#priority_color_label#}</th>
								<td id=""><input type="text" id="new_priority_color" name="new_priority_color" value="" maxlength="7" /></td>
							</tr>
							<tr class="row4">
								<td align="right" colspan="2"><input type="submit" name="addPrioritySubmit" id="addPrioritySubmit" value="{#submit#}" class="noborder" />
							</tr>
						</form>

						</table>
					</div>



			 </div>


		</fieldset>

