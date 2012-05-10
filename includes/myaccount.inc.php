<?php

	if (isset($_POST['updateUserDetails'])) {
		$newData['staff_name'] 	= clean_string($_POST['name']);
		$newData['staff_surname'] 	= clean_string($_POST['lastname']);
		$newData['default_project_id'] = clean_string($_POST['default_project_id']);

		$res = updateUser($_SESSION['userdata']['staff_id'], $newData);
		$smarty->assign('showUpdateResult', true ) ;
		$smarty->assign('updateResult', (($res === true) ? true : false) ) ;

	}

	if (isset($_POST['updateUserPass'])) {
		$pCurrentPass 		= clean_string($_POST['current_pass']);
		$pPassA 		= clean_string($_POST['passA']);
		$pPassB 		= clean_string($_POST['passB']);

		if ( empty($pCurrentPass) || empty($pPassA) || empty($pPassB) ) {//empty fields
			$smarty->assign('emptyPasswordsError', true) ;
		} else if ( (md5($pCurrentPass) != $_SESSION['userdata']['staff_pass']) || ($pPassA != $pPassB) ) {
			//error current pass does not match with the one coming from the form
			$smarty->assign('passwordsMatchError', true) ;

		} else {
			$newData['staff_pass'] = md5($pPassA);

			$res = updateUser($_SESSION['userdata']['staff_id'], $newData);
			$smarty->assign('showPasswordsResult',  true ) ;
			$smarty->assign('updatePasswordsResult', (($res === true) ? true : false) ) ;
		}


	}

	$myUserData = get_user_data($_SESSION['userdata']['staff_id']); //print_r($myUserData);
	$tmpProjects = get_user_projects($_SESSION['userdata']['staff_id']);

	$smarty->assign('myUserData', 		$myUserData);
	$smarty->assign('projectsArr', 		$tmpProjects);

	$MainContent = '';
	$MainContent .= $smarty->fetch('myaccount.tpl');
?>