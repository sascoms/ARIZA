<?php
	if (isset($_POST['deletePrioritySubmit'])) {
			$priorityID 			= clean_string($_POST['priorityListSelect']);

			if (empty($priorityID)) {
				$smarty->assign('operationResMsg', $smarty->get_config_vars('required_fields_msg'));
			} else {
				$updateData['is_deleted'] = '1';
				$updateData['is_active'] = '0';
				$res = updatePriority($priorityID, $updateData);
				$updateResMsg = (($res == true) ? $smarty->get_config_vars('priority_delete_success') : $smarty->get_config_vars('priority_delete_failure'));
				$smarty->assign('operationResMsg', $updateResMsg);
			}
	}

	if (isset($_POST['updatePrioritiesSubmit'])) {


			$pPriorityData 		= $_POST['priorities'];

			$i = 0;
			foreach ($pPriorityData as $key=>$values) {
				$priorityID = clean_string($values['id']);
				$updateData['name'] = clean_string($values['name']);
				$updateData['color'] = clean_string($values['color']);

				if (!empty($priorityID) && !empty($updateData['name'])) {
					$res = updatePriority($priorityID, $updateData);
					if ($res == true) {
						$i++;
					}

				}

			}

			$updateResMsg = (($i > 0) ? $smarty->get_config_vars('priority_update_success') : $smarty->get_config_vars('priority_update_failure'));
			$smarty->assign('operationResMsg', $updateResMsg);


	}

	if (isset($_POST['addPrioritySubmit'])) {

			$newData['id']	= $db->nextID('priority_id');;
			$newData['name'] = clean_string($_POST['new_priority_name']);
			$newData['color'] = clean_string($_POST['new_priority_color']);

			if (empty($newData['id'])) {
				$smarty->assign('operationResMsg', $smarty->get_config_vars('C31420'));

			} else if (empty($newData['name'])) {
				$smarty->assign('operationResMsg', $smarty->get_config_vars('required_fields_msg'));

			} else {
				$res = addPriority($newData);
				$addResMsg = (($res == true) ? $smarty->get_config_vars('priority_add_success') : $smarty->get_config_vars('priority_add_failure'));
				$smarty->assign('operationResMsg', $addResMsg);
			}

	}

	$tmpPriorities = get_priorities(); //print_r($tmpPriorities);
	$smarty->assign('prioritiesArr', $tmpPriorities);



	$MainContent = '';
	include_once('admin.header.inc.php');
	$MainContent .= $adminHeaderContent;
	$MainContent .= $smarty->fetch('admin.priorities.tpl');
?>