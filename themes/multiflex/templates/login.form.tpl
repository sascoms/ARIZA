{literal}
<script type="text/javascript">
	addLoadEvent(function() {
		focusOnField('user');
	});
</script>
{/literal}

<form id="loginform" name="loginform" method="post" action="">
<table width="60%" class="classic" cellspacing="1" cellpadding="1">
	<tr>
		<th colspan="2" class="rowTitle align-left">
			Please login first
		</th>
	</tr>


	{if $login_err_msg != ''}
	<tr>
		<td colspan="2" class="errorBox align-center">
				{$login_err_msg}
		</td>
	</tr>
	{/if}


	<tr class="row1">
		<td class="align-right" width="30%"><label for="user">{$LNG_username}</label></td>
		<td>
			<input class="inputs" type="text" name="user" id="user" value="" /><br />
		</td>
	</tr>
	<tr class="row1">
		<td class="align-right"><label for="user">{$LNG_password}</label></td>
		<td>
			<input class="inputs" type="password" name="pass" id="pass" value="" /><br />
		</td>
	</tr>
	<tr class="row3">
		<td>&nbsp;</td>
		<td>
			<input class="buttons" type="submit" name="login_submit" id="login_submit" value="{$LNG_submit}" />
		</td>
	</tr>
</table>



</form>