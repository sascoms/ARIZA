<?php
		//dublicate row check
		$sql = "SELECT bug_id FROM bugs WHERE bug_title = '".trim($_POST['bugTitle'])."'";
		$res = $db->query($sql); //print_r($res);
		if (PEAR::isError($res)) {
//			echo 'C31410';
			$data['errorCode'] 	= 'C31410';
			$data['errorMSG'] 	= translateStr('C31410');
			echo output_ajax_xml_error($data);
			exit;
		}
		$num = $res->numrows();
		if ($num > 0) {
			$data['errorCode'] 	= 'C31430';
			$data['errorMSG'] 	= translateStr('C31430');
			echo output_ajax_xml_error($data);
			exit;
		}

		$new_bug_id = $db->nextID('bug_id');
		if (PEAR::isError($new_bug_id)) {
			$data['errorCode'] 	= 'C31410';
			$data['errorMSG'] 	= translateStr('C31410');
			echo output_ajax_xml_error($data);
			exit;
//			echo translateStr('C31410');
//			exit;
		}

		$randomString = date("Ym") . $new_bug_id . microtime() . mt_rand(1000, 9999);
		$randomString = md5($randomString);
		$randomString = strtoupper($randomString);
		$randomString = str_replace(array('0','O','I','1'), array('','','',''), $randomString);
		$randomString = substr($randomString, 6, 6); //start from 6th char and get me 6 chars

		$uploaded_file = ''; //print_r($_POST);
		$sql = "
			INSERT INTO bugs
				(bug_id,bug_code, reporting_staff_id, replying_staff_id, bug_title, bug_description,
				bug_steps, possible_solution, uploaded_file, status, is_solved,
				progress_percent, reported_datetime, solved_datetime, bug_type_id, project_id, project_version_id, bug_priority)
			VALUES
				('".$new_bug_id."','".$randomString."','".$_POST['staffId']."','' , '".$_POST['bugTitle']."',
				'".$_POST['bugDesc']."' , '".$_POST['bugSteps']."' ,
				'".$_POST['bugSolution']."','".$uploaded_file."', '1' , '0' ,
				'".$_POST['progressPercent']."', now(), '', '".$_POST['bugType']."', '".$_POST['selectedProjectId']."', '".$_POST['projectVersionId']."',
				'".$_POST['priorityId']."'
				)
			";

		$res = $db->query($sql); //print_r($res);
		if (PEAR::isError($res)) {
			//echo translateStr('C31420');
			$data['errorCode'] 	= 'C31420';
			$data['errorMSG'] 	= translateStr('C31420');
			echo output_ajax_xml_error($data);
			$res = false;
			exit;
//			echo 'C31420';
//			$res = false;
		} else {
			//*****************************
			//MAIL SECTION
			$sql = "
				SELECT CONCAT(P.staff_name, ' ', P.staff_surname) as user_fullname, staff_email
				FROM staff P WHERE P.staff_id = '".$_POST['staffId']."'";
			$res = $db->query($sql); //print_r($res);
			$row = $res->fetchrow();
			$userFullName = $row['user_fullname'];
			$userEmail = $row['staff_email'];

			$bugTypes = get_bugTypes();
			$project_versions = get_versions($selected_project_id);
			$projects = get_projects();

			$smarty->assign("bugType", $bugTypes[$_POST['bugType']]);
			$smarty->assign("projectVersionName", $project_versions[$_POST['projectVersionId']]);
			$smarty->assign("projectName", $projects[$_POST['selectedProjectId']]['name']);
			$smarty->assign("userFullName", $userFullName);


			$smarty->assign("LNG_request_form_title", translateStr('request_form_title'));
			$smarty->assign("LNG_request_type", translateStr('request_type'));
			$smarty->assign("LNG_added_by", translateStr('added_by'));
			$smarty->assign("LNG_project_label", translateStr('project_label'));
			$smarty->assign("LNG_version", translateStr('version'));
			$smarty->assign("LNG_request_title", translateStr('request_title'));
			$smarty->assign("LNG_request_explanation", translateStr('request_explanation'));
			$smarty->assign("LNG_steps_caused_bug", translateStr('steps_caused_bug'));
			$smarty->assign("LNG_suggested_solutions", translateStr('suggested_solutions'));
			$smarty->assign("LNG_request_attachment", translateStr('request_attachment'));
			$smarty->assign("LNG_completed_percentage", translateStr('completed_percentage'));

			$smarty->assign('bugDetails', $_POST);
			$mailBody = $smarty->fetch('mails/new.bug.tpl');
			$mailData = composeMailDataArray('html', SITE_EMAIL, ADMIN_EMAIL, translateStr('new_request_made'), $mailBody, '', '', '', '');
			$mailRes  = sendMail($mailData);

			//send to record owner
			$we_received_your_request = translateStr('we_received_your_request');
			$smarty->assign('we_received_your_request', $we_received_your_request);
			$mailBody = $smarty->fetch('mails/new.bug.tpl');
			$mailData = composeMailDataArray('html', SITE_EMAIL, $userEmail, translateStr('new_request_made'), $mailBody, '', '', '', '');
			$mailRes  = sendMail($mailData);

			//MAIL SECTION
			//*****************************

			//echo 'C31200'; //return true -> operation success
			$data['errorCode'] 	= '0';
			$data['errorMSG'] 	= '';
			echo output_ajax_xml_error($data);
			exit;
		}


?>