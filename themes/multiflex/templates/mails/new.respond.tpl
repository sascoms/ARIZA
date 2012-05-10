




{$new_respond_message}

<br />
<br />

	{$LNG_bug_status}: {$bugStatus}<br />
	{$LNG_response_datetime}: {$responseDateTime}<br />
	{$LNG_response_text}:<br />

		{$responseText}
		<br />
		<br />




<br />

	<table id="bugFormTable" width="100%" class="classic" cellspacing="1" cellpadding="1">
		<tr>
			<th colspan="2" class="cellTitle align-left">&nbsp;{$LNG_request_form_title}</th>
		</tr>
		<tr class="row2">
			<td align="right" valign="top" width="30%"><b>{$LNG_request_type}: </b></td>
			<td>{$bugType}</td>
		<tr class="row2">
			<td align="right"><b>{$LNG_added_by}: </b></td>
			<td>{$userFullName}</td>
		</tr>
		<tr class="row2">
			<td align="right"><b>{$LNG_project_label}: </b></td>
			<td>{$projectName}</td>
		</tr>
		<tr class="row2">
			<td align="right"><b>{$LNG_version}: </b></td>
			<td>{$projectVersionName}</td>
		</tr>
		<tr class="row2">
			<td align="right" valign="top"> <b>{$LNG_request_title}: </b></td>
			<td>{$bugDetails.bug_title}</td>
		</tr>
		<tr class="row2">
			<td align="right" valign="top"> <b>{$LNG_request_explanation}: </b></td>
			<td>{$bugDetails.bug_description}</textarea></td>
		</tr>
		<tr class="row2">
			<td align="right" valign="top"> <b>{$LNG_steps_caused_bug}:</b></td>
			<td colspan="3">{$bugDetails.bug_steps}</td>
		</tr>
		<tr class="row2">
			<td align="right" valign="top"> <b>{$LNG_suggested_solutions}:</b></td>
			<td colspan="3">{$bugDetails.possible_solution}</td>
		</tr>
		<tr class="row2">
			<td align="right" valign="top"> <b>{$LNG_completed_percentage}:</b></td>
			<td>
				&nbsp;<span>{$progressPercent}%</span>
			</td>
		</tr>
	</table>