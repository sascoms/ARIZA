<form name="loginform" method="post" action="">

	{if $login_err_msg != ''}
		<div style="font-weight:bold;color:red;">{$login_err_msg}</div>
	{/if}
 
	<div style="float:left;width:100px;background-color:#efefef;height:21px;"> {$LNG_username}: </div>
		<div style="float:left;width:120px;background-color:lightyellow;height:21px;"> <input type="text" name="user" value="" size="10" class="noborder"> </div>
	<div style="float:left;width:100px;background-color:#efefef;height:21px;">{$LNG_password}: </div>
		<div style="float:left;width:120px;background-color:lightyellow;height:21px;"> <input type="password" name="pass" value="" size="10" class="noborder"> </div>
	<div style="float:left;"><input type="submit" name="login_submit" value="{$LNG_submit}" class="noborder"></div>

</form>

