<?php

	$login_err_msg = ( ($login_err_msg == true) ? $langArr['login_error'] : '' );	
	$smarty->assign("login_err_msg", $login_err_msg);
	
	$smarty->assign("LNG_username", translateStr('username'));
	$smarty->assign("LNG_password", translateStr('password'));
	
	$smarty->assign("LNG_submit", translateStr('submit'));
		
	$MainContent = $smarty->fetch('login.form.tpl');

	
	
	

?>
