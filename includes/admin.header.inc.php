<?php

	$smarty->assign("LNG_ajax_processing_operation", translateStr('ajax_processing_operation'));
	$smarty->assign("LNG_operation_successful_msg", translateStr('operation_successful_msg'));
	$smarty->assign("LNG_operation_failure_msg", translateStr('operation_failure_msg'));




	$smarty->assign('LNG_administrate_header', 		translateStr('administrate_header'));
	$smarty->assign('LNG_administrate_users', 		translateStr('administrate_users'));
	$smarty->assign('LNG_administrate_projects', 	translateStr('administrate_projects'));
	$smarty->assign('LNG_administrate_versions', 	translateStr('administrate_versions'));


	$adminHeaderContent = $smarty->fetch('admin.header.tpl');
?>