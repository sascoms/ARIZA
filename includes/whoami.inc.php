<?php
	$user_projects = get_user_projects($staff_id, 1, 0); //print_r($user_projects);


	$userEnvironment = getEnvironment();

	$smarty->assign('user_projects', 		$user_projects);
	$smarty->assign('selectedProjectID', 	$selected_project_id);
	$smarty->assign('userEnvironment', 		$userEnvironment);
	$smarty->assign('userData', 			$userdata);

	$smarty->assign('LNG_select', 		translateStr('select'));
	$smarty->assign('LNG_department', 	translateStr('department'));
	$smarty->assign('LNG_staffIdTitle', translateStr('staffIdTitle'));
	$smarty->assign('LNG_envOS', 		translateStr('envOS'));
	$smarty->assign('LNG_nameSurname', 	translateStr('name_surname'));
	$smarty->assign('LNG_select_project_title', 	translateStr('select_project_title'));
	$smarty->assign('LNG_submit', 		translateStr('submit'));

	$WhoAmIContent = $smarty->fetch('whoami.tpl');
?>