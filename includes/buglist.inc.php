<?php
	$bugList = '';
	$filter = '';
	$totalEntries = '';
/*//not removed for further reference...
 	$sql = "
	SELECT EB.*, COUNT(R.response_id) as totalentries, PR.name as priority_text,
		P.staff_id, CONCAT(P.staff_name, ' ', P.staff_surname) as sender_fullname,
		P2.staff_id as replier_id, CONCAT(P2.staff_name, ' ', P2.staff_surname) as replier_fullname
	FROM bugs EB, staff P
	LEFT JOIN staff P2 ON EB.replying_staff_id = P2.staff_id
	LEFT JOIN responses R ON EB.bug_id = R.bug_id
	LEFT JOIN priorities PR ON PR.id = EB.bug_priority

	WHERE
		EB.reporting_staff_id = P.staff_id
		AND EB.project_id = '".$selected_project_id."'

		$filter
 	GROUP BY EB.bug_id
	ORDER BY EB.bug_id DESC,EB.status ASC, EB.is_solved ASC
		";*/

/* ** ** OPERATORS ** */
$staffList 	= get_operators(); //print_r($staffList);
$prioritiesArr = get_priorities();
if (is_array($prioritiesArr)) {
	foreach ($prioritiesArr as $key=>$prData) {
		$priorities[$prData['id']] = $prData['name'];
	}
}

$bug_types 	= get_bugTypes();
$bug_statuses 	= get_statuses();
/* ** ** OPERATORS ** */

/* ** ** FILTERS STARTS** */
	$addWhereArr = array();
	if (isset($_POST['filterSenderId']) && !empty($_POST['filterSenderId'])) {
		$filterSender = clean_string($_POST['filterSenderId']);
		$addWhereArr[] = "reporting_staff_id = '".$filterSender."'";
	}
	if (isset($_POST['filterForwardedTo']) && !empty($_POST['filterForwardedTo'])) {
		$filterForwarded = clean_string($_POST['filterForwardedTo']);
		$addWhereArr[] = "replying_staff_id  = '".$filterForwarded."'";
	}
	if (isset($_POST['filterPriorityId']) && !empty($_POST['filterPriorityId'])) {
		$filterPriority = clean_string($_POST['filterPriorityId']);
		$addWhereArr[] = "reporting_staff_id = '".$filterPriority."'";
	}
	if (isset($_POST['filterBugTypeId']) && !empty($_POST['filterBugTypeId'])) {
		$filterBugType = clean_string($_POST['filterBugTypeId']);
		$addWhereArr[] = "bug_type_id = '".$filterBugType."'";
	}
	if (isset($_POST['filterBugStatusId']) && !empty($_POST['filterBugStatusId'])) {
		$filterBugStatus = clean_string($_POST['filterBugStatusId']);
		$addWhereArr[] = "status= '".$filterBugStatus."'";
	} //print_r($addWhereArr);

	if (count($addWhereArr) > 0) {
		$addWhere = ' AND '. implode(' AND ', $addWhereArr);
	}
/* ** ** FILTERS ENDS** */





		$sql = "SELECT B.* from bugs B WHERE B.project_id = '".$selected_project_id."' " . $addWhere . " ORDER BY B.is_solved ASC, B.bug_id DESC";
		$res = $db->query($sql); //print_r($res);
		$num = $res->numrows();
		$i = 1;
		while ($row = $res->fetchrow()) {//print_r($row);
			$sqlResponseCount = "SELECT COUNT(R.response_id) as totalentries from responses R WHERE R.bug_id='".$row['bug_id']."'";
			$resResponseCount = $db->query($sqlResponseCount); //print_r($res);
			$rowResponseCount = $resResponseCount->fetchrow(); //print_r($rowResponseCount);

			$row['totalentries'] 	= $rowResponseCount['totalentries'];
			$row['priority_text'] = $priorities[$row['bug_priority']];
			$row['sender_fullname'] = $staffList[$row['reporting_staff_id']];
			$row['status_label'] = $bug_statuses[$row['status']];
			if ($row['replying_staff_id'] > 0) {
				$row['replier_fullname'] 	= $staffList[$row['replying_staff_id']];
			} else {
				$row['replier_fullname'] 	= '';
			}

			$bugList[$i] = $row;
			$i++;
		}


	$smarty->assign("LNG_submit", translateStr('submit'));
	$smarty->assign("LNG_select_option_value", translateStr('select_option_value'));
	$smarty->assign("LNG_bug_status", translateStr('bug_status'));
	$smarty->assign("LNG_completed_percentage", translateStr('completed_percentage'));

	$smarty->assign("LNG_operations", translateStr('operations'));
	$smarty->assign("LNG_assign_to", translateStr('assign_to'));
	$smarty->assign("LNG_filter", translateStr('filter'));
	$smarty->assign("LNG_change_bug_type", translateStr('change_bug_type'));
	$smarty->assign("LNG_prioritize", translateStr('prioritize'));

	$smarty->assign("LNG_request_type", translateStr('request_type'));
	$smarty->assign("LNG_request_title", translateStr('request_title'));
	$smarty->assign("LNG_date", translateStr('date'));

	$smarty->assign("LNG_sender", translateStr('sender'));
	$smarty->assign("LNG_priority", translateStr('priority'));
	$smarty->assign("LNG_forwarded_to", translateStr('forwarded_to'));
	$smarty->assign("LNG_replies", translateStr('replies'));
	$smarty->assign("LNG_closed", translateStr('closed'));
	$smarty->assign("LNG_replies", translateStr('replies'));
	$smarty->assign("LNG_reply", translateStr('reply'));


	$smarty->assign("LNG_ajax_processing_operation", translateStr('ajax_processing_operation'));
	$smarty->assign("LNG_operation_successful_msg", translateStr('operation_successful_msg'));
	$smarty->assign("LNG_operation_failure_msg", translateStr('operation_failure_msg'));
	$smarty->assign("LNG_js_unchecked_box", translateStr('js_unchecked_box'));
	$smarty->assign("LNG_js_check_the_errors_below", translateStr('js_check_the_errors_below'));





	$smarty->assign("bug_statuses", $bug_statuses);
	$smarty->assign("priorities", $priorities);
	$smarty->assign("staffList", $staffList);
	$smarty->assign("BugTypes", $bug_types);
	$smarty->assign('bugList', $bugList);
	$MainContent = $smarty->fetch('buglist.tpl');





?>