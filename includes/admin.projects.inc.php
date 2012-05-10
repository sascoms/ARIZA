<?php
	if (isset($_POST['deleteProjectSubmit'])) {
			$projectID 			= clean_string($_POST['projectListSelect']);

			if (empty($projectID)) {
				$smarty->assign('operationResMsg', $smarty->get_config_vars('required_fields_msg'));
			} else {
				$updateData['is_deleted'] = '1';
				$updateData['is_active'] = '0';
				$res = updateProject($projectID, $updateData);
				$updateResMsg = (($res == true) ? $smarty->get_config_vars('project_delete_success') : $smarty->get_config_vars('project_delete_failure'));
				$smarty->assign('operationResMsg', $updateResMsg);
			}
	}

	if (isset($_POST['updateProjectDataSubmit'])) {
			$projectID 			= clean_string($_POST['project_id']);
			$updateData['name'] = clean_string($_POST['project_name']);
			$updateData['description'] = clean_string($_POST['project_description']);
			$updateData['is_active'] = clean_string($_POST['project_active']);

			if (empty($projectID) || empty($updateData['name'])) {
				$smarty->assign('operationResMsg', $smarty->get_config_vars('required_fields_msg'));
			} else {
				$res = updateProject($projectID, $updateData);
				$updateResMsg = (($res == true) ? $smarty->get_config_vars('project_update_success') : $smarty->get_config_vars('project_update_failure'));
				$smarty->assign('operationResMsg', $updateResMsg);
			}
	}

	if (isset($_POST['addProjectDataSubmit'])) {
			$newData['project_id']	= $db->nextID('project_id');;
			$newData['name'] = clean_string($_POST['new_project_name']);
			$newData['description'] = clean_string($_POST['new_project_description']);
			$newData['is_active'] = clean_string($_POST['new_project_active']);
			$newData['is_deleted'] 	= '0';

			if (empty($newData['project_id'])) {
				$smarty->assign('operationResMsg', $smarty->get_config_vars('C31420'));

			} else if (empty($newData['name'])) {
				$smarty->assign('operationResMsg', $smarty->get_config_vars('required_fields_msg'));

			} else {
				$res = addProject($newData);
				$addResMsg = (($res == true) ? $smarty->get_config_vars('project_add_success') : $smarty->get_config_vars('project_add_failure'));
				$smarty->assign('operationResMsg', $addResMsg);
			}

	}


	$tmpOperators = get_operators();
	$tmpProjects = get_projects('', 'all');

	$smarty->assign('projectsArr', $tmpProjects);
	$smarty->assign('operatorsArr', $tmpOperators);



	$MainContent = '';
	include_once('admin.header.inc.php');
	$MainContent .= $adminHeaderContent;
	$MainContent .= $smarty->fetch('admin.projects.tpl');
?>