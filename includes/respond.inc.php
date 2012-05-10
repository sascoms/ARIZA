<?php
	//post bugId kontrolu yapilacak

	$responseList = '';
	$statuses = '';
	$filter	 = '';

/* ** ** OPERATORS ** */
$statuses 	= get_statuses();
$staffList 	= get_operators(); //print_r($staffList);
$priorities = get_priorities();
$bug_types 	= get_bugTypes();
/* ** ** OPERATORS ** */
		$sql = "SELECT B.* from bugs B WHERE B.project_id = '".$selected_project_id."' AND B.bug_id='".$_GET['id']."'";
		$res = $db->query($sql); //print_r($res);
		$num = $res->numrows();
		$bugInfo = $res->fetchrow(); //print_r($row);

			$bugInfo['bug_description'] 		= nl2br($bugInfo['bug_description']);

			$bugInfo['priority_text'] 		= $priorities[$bugInfo['bug_priority']];
			$bugInfo['sender_fullname'] 	= $staffList[$bugInfo['reporting_staff_id']];
			$bugInfo['status_id'] 			= $bugInfo['status'];
			$bugInfo['status'] 				= $statuses[$bugInfo['status']];

			if ($bugInfo['replying_staff_id'] > 0) {
				$bugInfo['replier_fullname'] 	= $staffList[$bugInfo['replying_staff_id']];
			} else {
				$bugInfo['replier_fullname'] 	= '';
			}
/*

 	$sql = "
		SELECT EB.*, V.version_title, PR.name as priority_text,
			P.staff_id, CONCAT(P.staff_name, ' ', P.staff_surname) as sender_fullname,
			P2.staff_id as replier_id, CONCAT(P2.staff_name, ' ', P2.staff_surname) as replier_fullname
		FROM bugs EB, staff P
		LEFT JOIN staff P2 ON EB.replying_staff_id = P2.staff_id
		LEFT JOIN priorities PR ON PR.id = EB.bug_priority
		LEFT JOIN versions V ON V.version_id = EB.project_version_id

		WHERE
			EB.project_id = '".$selected_project_id."'
			AND EB.reporting_staff_id = P.staff_id
			AND bug_id='".$_GET['id']."'
	";

		$res = $db->query($sql); //print_r($res);
		$num = $res->numrows();
		$bugInfo = $res->fetchrow(); //print_r($bugInfo);
		$bugInfo['status_id'] = $bugInfo['status'];
		$bugInfo['status'] = $statuses[$bugInfo['status']];
*/
		$sql = "
			SELECT R.*,  CONCAT(P.staff_name, ' ', P.staff_surname) as replier_fullname
			FROM responses R
			LEFT JOIN staff P ON P.staff_id = R.replying_staff_id
			WHERE R.bug_id = '".$bugInfo['bug_id']."'
			ORDER BY response_datetime ASC
			";
		$res = $db->query($sql); //print_r($res);
		$num = $res->numrows();
		$i = 1;
		while ($row = $res->fetchrow()) {
					$data['index'] 				= $i;
					$data['id'] 				= $row['response_id'];
					$data['status'] 			= $statuses[$row['response_status']];
					$data['staffFullname'] 		= $row['replier_fullname'];
					$data['response_text'] 		= $row['response_text'];
					$data['response_datetime'] 	= $row["response_datetime"];

				$responseList[$row['response_id']] = createResponseDiv($data);

//			$responseList[$row['response_id']] = $row;
//			$responseList[$row['response_id']]['i'] = $i;
			$i++;
		}



	$smarty->assign("statuses", $statuses);
	$smarty->assign("bugInfo", $bugInfo);
	$smarty->assign("responseList", $responseList);
	$smarty->assign("responseTotal", $num);

	$smarty->assign("siteLanguage", $_SESSION['siteOptions']['site_language']);

		$smarty->assign('LNG_submit', 	translateStr('submit'));
		$smarty->assign('LNG_respond', 	translateStr('respond'));
		$smarty->assign('LNG_hide', 	translateStr('hide'));
		$smarty->assign('LNG_show', 	translateStr('show'));

		$smarty->assign('LNG_bug_status', 		translateStr('bug_status'));
		$smarty->assign('LNG_solved_datetime', 	translateStr('solved_datetime'));
		$smarty->assign('LNG_close', 			translateStr('close'));
		$smarty->assign('LNG_clear', 			translateStr('clear'));
		$smarty->assign('LNG_response_text',	translateStr('response_text'));
		$smarty->assign('LNG_details', 		translateStr('details'));
		$smarty->assign('LNG_replies', 		translateStr('replies'));
		$smarty->assign('LNG_sender', 		translateStr('sender'));
		$smarty->assign('LNG_envOS', 		translateStr('envOS'));
		$smarty->assign('LNG_date', 		translateStr('date'));
		$smarty->assign('LNG_nameSurname', 	translateStr('name_surname'));
		$smarty->assign('LNG_enter_solved_datetime', 	translateStr('enter_solved_datetime'));
		$smarty->assign('LNG_request_report_datetime', 	translateStr('request_report_datetime'));

		$smarty->assign('LNG_there_is_no_response', 	translateStr('there_is_no_response'));


		$smarty->assign('LNG_version', 				translateStr('version'));
		$smarty->assign('LNG_request_explanation', 	translateStr('request_explanation'));
		$smarty->assign('LNG_steps_caused_bug', 	translateStr('steps_caused_bug'));
		$smarty->assign('LNG_suggested_solutions', 	translateStr('suggested_solutions'));
		$smarty->assign('LNG_request_attachment', 	translateStr('request_attachment'));
		$smarty->assign('LNG_completed_percentage', translateStr('completed_percentage'));
		$smarty->assign('LNG_request_owner', 		translateStr('request_owner'));

	//javascript errors
	$smarty->assign("LNG_js_check_the_errors_below", translateStr('js_check_the_errors_below'));
	$smarty->assign("LNG_js_required_field_value", translateStr('js_required_field_value'));
	$smarty->assign("LNG_js_no_option_selected", translateStr('js_no_option_selected'));

	$smarty->assign("LNG_response_insert_success", translateStr('response_insert_success'));
	$smarty->assign("LNG_response_insert_failure", translateStr('response_insert_failure'));

	$smarty->assign("LNG_ajax_processing_operation", translateStr('ajax_processing_operation'));


	$MainContent = $smarty->fetch('respond.tpl');





?>