<table width="100%" class="classic" cellspacing="1" cellpadding="1">
  <tr>
    <th>{$LNG_department}</th>
    <th>{$LNG_staffIdTitle} - {$LNG_nameSurname}</th>
    <th>{$LNG_envOS}</th>
    <th>{$LNG_select_project_title}</th>
  </tr>
  <form name="" method="post" action="" class="formarea">
  <tr class="row1 align-center">
    <td>{$userData.staff_type}</td>
    <td>{$userData.staff_name} {$userData.staff_surname}</td>
    <td>{$userEnvironment.platform}</td>
    <td>
		<select name="change_project_id" id="change_project_id" onchange="return changeProject('change_project_id', 'index.php?project=');">
			<option value="">--- {$LNG_select} ---</option>
			{foreach key=key item=values from=$user_projects}
				<option value="{$key}"{if $key==$selectedProjectID} selected {else}{/if}>{$values.name}</option>
			{/foreach}
		  </select>
		  <input class="buttons" type="submit" name="change_project_submit" id="change_project_submit" value="{$LNG_submit}" />
    </td>
  </tr>
  </form>

</table>