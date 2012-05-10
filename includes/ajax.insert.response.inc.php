<?php

		$sql = "SELECT B.* from bugs B WHERE B.project_id = '".$selected_project_id."' AND B.bug_id='".$_POST['bug_id']."'";
		$res = $db->query($sql); //print_r($res);
		$num = $res->numrows();
		if (PEAR::isError($res)) {
			$data['errorCode'] 	= 'C31420';
			$data['errorMSG'] 	= translateStr('C31420');
			echo output_ajax_xml_error($data);
			exit;
		}
		if ($num < 1) {
			$data['errorCode'] 	= '-1000';
			$data['errorMSG'] 	= translateStr('bug_not_found');
			echo output_ajax_xml_error($data);
			exit;
		}
		$bugInfo = $res->fetchrow(); //print_r($row);



		//dublicate row check
		$sql = "SELECT response_id FROM responses WHERE bug_id ='".$_POST['bug_id']."' AND response_status ='".$_POST['statusId']."' AND response_text = '".trim($_POST['response_text'])."'";
		$res = $db->query($sql); //print_r($res);
		if (PEAR::isError($res)) {
//			echo 'C31410';
//			exit;
				$data['errorCode'] 	= 'C31410';
				$data['errorMSG'] 	= translateStr('C31410');
				echo output_ajax_xml_error($data);
				exit;
		}
		$num = $res->numrows();
		if ($num>0) {
//			echo 'C31430';
//			exit;
				$data['errorCode'] 	= 'C31430';
				$data['errorMSG'] 	= translateStr('C31430');
				echo output_ajax_xml_error($data);
				exit;
		}


		$new_response_id = $db->nextID("response_id");
		if (PEAR::isError($new_response_id)) {
			//echo translateStr('C31410');
//			echo 'C31410';
//			exit;
				$data['errorCode'] 	= 'C31410';
				$data['errorMSG'] 	= translateStr('C31410');
				echo output_ajax_xml_error($data);
				exit;
		}


		$uploaded_file = ''; //print_r($_POST);
		$responseDateTime = date("Y-m-d H:i:s");
		$_POST['response_text'] = str_replace("\n", '<br />', $_POST['response_text']);
			$sql = "
				INSERT INTO responses
					(response_id, bug_id , response_text, replying_staff_id , response_datetime, response_status)
				VALUES
					('".$new_response_id."', '".$_POST['bug_id']."', '".$_POST['response_text']."', '".$_POST['staffId']."', '".$responseDateTime."', '".$_POST['statusId']."')
			";

		$res = $db->query($sql); //print_r($res);
		if (PEAR::isError($res)) {
			//echo translateStr('C31420');
			//echo 'C31420';
				$data['errorCode'] 	= 'C31420';
				$data['errorMSG'] 	= translateStr('C31420');
				echo output_ajax_xml_error($data);
				exit;
		} else {
			$addSql = '';
			if ($_POST['statusId'] == '4') {
				$addSql = " , is_solved=1, solved_datetime = '".$_POST['solvedDatetime']."'"; // , solve_duration = '".$_POST['solve_duration']."'";
			}
			$sql = "UPDATE bugs SET progress_percent='".$_POST['progressPercent']."', status='".$_POST['statusId']."' ".$addSql." WHERE bug_id='".$_POST['bug_id']."'";
			$res = $db->query($sql); //print_r($res);
				if (PEAR::isError($res)) {
					//echo translateStr('C31430');
					$data['errorCode'] 	= 'C31430';
					$data['errorMSG'] 	= translateStr('C31430');
					echo output_ajax_xml_error($data);
					exit;
				}
//			echo 'C31200';
			$statuses = get_statuses();

			$data['errorCode'] 			= '0';
			$data['errorMSG'] 			= '';
			$data['responseID'] 	= $new_response_id;
			$data['bugStatus'] 		= $statuses[$_POST['statusId']];
			$data['staffFullname'] 	= $_POST['staffFullname'];
			$data['responseText'] 	= $_POST['response_text'];
			$data['responseDateTime'] = $responseDateTime;

			//$tmpContent = createResponseDiv($data);

			echo $tmpContent = output_ajax_xml_response_content($data);

			//*****************************
			//MAIL SECTION
				$sql = "
					SELECT CONCAT(P.staff_name, ' ', P.staff_surname) as user_fullname, staff_email
					FROM staff P WHERE P.staff_id = '".$bugInfo['reporting_staff_id']."'";
				$res = $db->query($sql); //print_r($res);
				$row = $res->fetchrow();
				$userFullName = $row['user_fullname'];
				$userEmail = $row['staff_email'];

				$smarty->assign("userFullName", $userFullName);

					$bugTypes = get_bugTypes();
					$project_versions = get_versions($selected_project_id);
					$projects = get_projects();

					$smarty->assign("bugType", $bugTypes[$bugInfo['bug_type_id']]);
					$smarty->assign("projectVersionName", $project_versions[$bugInfo['project_version_id']]);
					$smarty->assign("projectName", $projects[$bugInfo['project_id']]['name']);
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
					$smarty->assign('LNG_bug_status', 		translateStr('bug_status'));
					$smarty->assign('LNG_response_datetime', 		translateStr('response_datetime'));
					$smarty->assign('LNG_response_text', 		translateStr('response_text'));



				$smarty->assign('bugDetails', $bugInfo);
				$smarty->assign('progressPercent', $_POST['progressPercent']);
				$smarty->assign('new_respond_message', translateStr('new_respond_message'));

				$smarty->assign('responseText', $data['responseText']);
				$smarty->assign('responseDateTime', $responseDateTime);
				$smarty->assign('bugStatus', $data['bugStatus']);


				$mailBody = $smarty->fetch('mails/new.respond.tpl');
				$mailData = composeMailDataArray('html', SITE_EMAIL, $userEmail, translateStr('new_respond_made'), $mailBody, 'ARIZA', '', '', '');
				$mailRes  = sendMail($mailData);

			//MAIL SECTION
			//*****************************



			exit;
		}
?>