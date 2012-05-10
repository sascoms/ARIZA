<?php

	$tmpOperators = get_operators();
	$tmpProjects = get_projects();

	$smarty->assign('projectsArr', $tmpProjects);
	$smarty->assign('operatorsArr', $tmpOperators);
	$smarty->assign('LNG_users_list', 		translateStr('users_list'));
	$smarty->assign('LNG_users_list_error', 		translateStr('users_list_error'));

	$smarty->assign('LNG_user_id', 		translateStr('user_id'));
	$smarty->assign('LNG_user_name', 		translateStr('user_name'));
	$smarty->assign('LNG_user_firstname', 		translateStr('user_firstname'));
	$smarty->assign('LNG_user_lastname', 		translateStr('user_lastname'));
	$smarty->assign('LNG_user_email', 		translateStr('user_email'));
	$smarty->assign('LNG_user_type', 		translateStr('user_type'));
	$smarty->assign('LNG_user_admin', 		translateStr('user_admin'));
	$smarty->assign('LNG_user_project_default', 		translateStr('user_project_default'));
	$smarty->assign('LNG_user_projects', 		translateStr('user_projects'));
	$smarty->assign('LNG_user_status', 		translateStr('user_status'));

//	$smarty->assign('LNG_user_data_updated', 		translateStr('user_data_updated'));
//	$smarty->assign('LNG_user_data_update_failed', 		translateStr('user_data_update_failed'));
//
//	$smarty->assign('LNG_user_projects_updated', 		translateStr('user_projects_updated'));
//	$smarty->assign('LNG_user_projects_total', 		translateStr('user_projects_total'));
//	$smarty->assign('LNG_user_projects_failed', 		translateStr('user_projects_failed'));
//	$smarty->assign('LNG_user_projects_success', 		translateStr('user_projects_success'));



	$MainContent = '';
	include_once('admin.header.inc.php');
	$MainContent .= $adminHeaderContent;
	$MainContent .= $smarty->fetch('admin.users.tpl');
?>