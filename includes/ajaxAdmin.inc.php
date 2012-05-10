<?php


// post checkbox dolu mu bos mu kontrol.
// operator id bos mu degil mi
	//print_r($_POST);
	$ajaxOperation = clean_string($_GET['op']);

	switch ($ajaxOperation) {
//		case 'changeSiteLang':
//			$tmpLng = clean_string($_POST['langFileName']);
//			changeLang($tmpLng);
//		break;
		case 'changeSiteOptions':

			$tmpOptionName = clean_string($_POST['optionname']);
			$tmpOptionValue = clean_string($_POST['optionval']);

			if (empty($tmpOptionName) || empty($tmpOptionValue)) {
				echo $smarty->get_config_vars('required_fields_msg');
				exit;
			} else {
				echo changeSiteOption($tmpOptionName, $tmpOptionValue);
			}

		break;



		case 'getUserData':

			$tmpUserID = clean_string($_POST['userID']);
			$tmpUserData = get_user_data($tmpUserID);

				$user_projects_data = get_user_projects($tmpUserID); //print_r($user_projects);
				$userProjectsArr = array();
				if (is_array($user_projects_data) && !empty($user_projects_data)) {
						foreach ($user_projects_data as $key=>$values) {
							$userProjectsArr[] = $key;
						}
				}

			if (!is_array($tmpUserData) || empty($tmpUserData)) {
					$ajaxResponse = '
						{"results":
							{
							"res":	"0",
							"msg":"' . $smarty->get_config_vars('users_not_found')	.'"
							}
						}
					';
			} else {
					$ajaxResponse = '
						{"results":
							{
							"res":			"1",
							"id":"'			.$tmpUserData['staff_id']	.'",
							"user":"'		.$tmpUserData['staff_user']	.'",
							"firstname":"'		.$tmpUserData['staff_name']	.'",
							"lastname":"'	.$tmpUserData['staff_surname']	.'",
							"email":"'		.$tmpUserData['staff_email']	.'",
							"type":"'		.$tmpUserData['staff_type']	.'",
							"admin":"'		.$tmpUserData['is_admin']	.'",
							"projects":['		.implode(',', $userProjectsArr)	.'],
							"project_default":"'	.$tmpUserData['default_project_id']	.'",
							"status":"'		.$tmpUserData['status']	.'"
							}
						}
					';

			}
			echo $ajaxResponse;
			exit;


		break;

		case 'updateUserData':

			$tmp_staff_id 				= clean_string($_POST['userID']);
			$userNewData['staff_user'] 	= clean_string($_POST['username']);
			$userNewData['staff_name'] 		= clean_string($_POST['firstname']);
			$userNewData['staff_surname'] 	= clean_string($_POST['lastname']);
			$userNewData['staff_email'] 	= clean_string($_POST['email']);
			$userNewData['staff_type'] 		= clean_string($_POST['type']);
			$userNewData['is_admin'] 		= clean_string($_POST['admin']);
			$userNewData['status'] 			= clean_string($_POST['status']);
			$userNewData['default_project_id'] = clean_string($_POST['project_default']);

			if (!empty($_POST['password'])) {
				$userNewData['staff_pass'] 	= md5(clean_string($_POST['password']));
			}

			$tmp_staff_projects 	= explode(',', clean_string($_POST['projects']));

			if (empty($tmp_staff_id) || empty($userNewData['staff_user']) ||  empty($userNewData['staff_email']) ||  empty($userNewData['status'])) {
					$ajaxResponse = '
						{"results": {
							"res":	"0",
							"msg":"' . $smarty->get_config_vars('required_fields_msg')	.'"
							}
						}
					';
			} else {

				$res = updateUser($tmp_staff_id, $userNewData);
				$userDataUpdateRes = (($res == true) ? "1" : "0");
						$ajaxResponse = '
							{"results": {
								"res":		"'.$userDataUpdateRes.'",
								"msg":	"",
								}
							}
						';
			}
			echo $ajaxResponse;
			exit;


		break;

		case 'updateUserProjects':

			$tmp_staff_id 			= clean_string($_POST['userID']);
			$tmp_staff_projects 	= explode(',', clean_string($_POST['projects']));
			foreach ($tmp_staff_projects as $key=>$value) {
				if (!empty($value)) {
					$tmp_staff_projects_arr[] = $value;
				}
			}

			if (empty($tmp_staff_id) || empty($tmp_staff_projects_arr) ||  !is_array($tmp_staff_projects_arr)) {
					$ajaxResponse = '
						{"results": {
							"res":	"0",
							"msg":"' . $smarty->get_config_vars('required_fields_msg')	.'"
							}
						}
					';
			} else {

					$resUP = associateUserProjects($tmp_staff_id, $tmp_staff_projects_arr);

					if ($resUP != false) {
						$userProjectsTotal 		= $smarty->get_config_vars('user_projects_total')   . $resUP['total'];
						$userProjectsFailed 	= $smarty->get_config_vars('user_projects_failed')  . $resUP['failed'];
						$userProjectsSuccess 	= $smarty->get_config_vars('user_projects_success') . $resUP['success'];

						$ajaxResponse = '
							{"results": {
								"res":	"1",
								"msg":"'.$userProjectsTotal.'<br />'.$userProjectsFailed.'<br />'.$userProjectsSuccess.'<br />"
								}
							}
						';
					} else {
						$ajaxResponse = '
							{"results": {
								"res":	"000",
								"msg":""
								}
							}
						';
					}
			}
			echo $ajaxResponse;
			exit;
		break;


		case 'addUserData':
			//check duplicate

			$userNewData['staff_id']		= $db->nextID('user_id');;
			$userNewData['staff_user'] 		= clean_string($_POST['username']);
			$userNewData['staff_name'] 		= clean_string($_POST['firstname']);
			$userNewData['staff_surname'] 	= clean_string($_POST['lastname']);
			$userNewData['staff_email'] 	= clean_string($_POST['email']);
			$userNewData['staff_pass'] 		= md5(clean_string($_POST['pass']));
			$userNewData['staff_type'] 		= clean_string($_POST['type']);
			$userNewData['is_admin'] 		= clean_string($_POST['admin']);
			$userNewData['status'] 			= clean_string($_POST['status']);
			$userNewData['default_project_id'] = clean_string($_POST['project_default']);

			$tmp_staff_projects 	= explode(',', clean_string($_POST['projects']));

			if (empty($userNewData['staff_id'])) {
					$ajaxResponse = '
						{"results": {
							"res":	"0",
							"msg":"' . $smarty->get_config_vars('C31420')	.'"
							}
						}
					';
			} else if (empty($userNewData['staff_user']) || empty($userNewData['staff_pass']) ||  empty($userNewData['staff_email']) ||  empty($userNewData['status'])) {
					$ajaxResponse = '
						{"results": {
							"res":	"0",
							"msg":"' . $smarty->get_config_vars('required_fields_msg')	.'"
							}
						}
					';
			} else {

				$res = addUser($userNewData);
				if ($res == true) {
					$resAssocProjects = associateUserProjects($userNewData['staff_id'], $tmp_staff_projects);
				}
				$userDataAddRes = (($res == true) ? "1" : "0");
						$ajaxResponse = '
							{"results": {
								"res":		"'.$userDataAddRes.'",
								"newID":		"'.$userNewData['staff_id'].'",
								"msg":	"",
								}
							}
						';
			}
			echo $ajaxResponse;
			exit;


		break;

/*
		case 'getProjects':

			$tmpData = get_projects();

			if (!is_array($tmpData) || empty($tmpData)) {
					$ajaxResponse = '
						{"results":
							{
							"res":	"0",
							"msg":"' . $smarty->get_config_vars('project_not_found')	.'"
							}
						}
					';
			} else {
					$projectsJsonArr = array();
					foreach ($tmpData as $key=>$values) {
						$projectsJsonArr[] = '{
							"id":"'			.$values['project_id']	.'",
							"name":"'		.$values['name']	.'",
							"description":"'.$values['description']	.'"
							}
						';
					}

					$ajaxResponse = '
						{"results":
							{
							"res":			"1",
							"numrows":		"'. count($tmpData) .'",
							"projects": {
								'. implode(',', $projectsJsonArr) .'
								}
							}
						}
					';

			}
			echo $ajaxResponse;
			exit;


		break;


		case 'updateProjectData':

			$projectID = clean_string($_POST['project_id']);
			$updateData['name'] 	= clean_string($_POST['project_name']);
			$updateData['description'] 		= clean_string($_POST['project_description']);

			if (empty($projectID) || empty($updateData['name'])) {
					$ajaxResponse = '
						{"results": {
							"res":	"0",
							"msg":"' . $smarty->get_config_vars('required_fields_msg')	.'"
							}
						}
					';
			} else {

				$res = updateProject($projectID, $updateData);
				$updateRes = (($res == true) ? "1" : "0");
						$ajaxResponse = '
							{"results": {
								"res":		"'.$updateRes.'",
								"msg":	"",
								}
							}
						';
			}
			echo $ajaxResponse;
			exit;


		break;
*/
		case 'getProjectData':

			$tmpID = clean_string($_POST['projectID']);
			$tmpData = get_projects($tmpID, 'all', 'all');

			if (!is_array($tmpData) || empty($tmpData)) {
					$ajaxResponse = '
						{"results":
							{
							"res":	"0",
							"msg":"' . $smarty->get_config_vars('project_not_found')	.'"
							}
						}
					';
			} else {
					$ajaxResponse = '
						{"results":
							{
							"res":			"1",
							"id":"'			.$tmpData['project_id']	.'",
							"name":"'		.$tmpData['name']	.'",
							"description":"'.$tmpData['description']	.'",
							"is_active":"'.$tmpData['is_active']	.'"
							}
						}
					';

			}
			echo $ajaxResponse;
			exit;


		break;


		case 'getProjectUsers':

			$tmpID = clean_string($_POST['projectID']);
			$tmpData = get_project_operators($tmpID);

			if (!is_array($tmpData) || empty($tmpData)) {
					$ajaxResponse = '
						{"results":
							{
							"res":	"0",
							"msg":"' . $smarty->get_config_vars('projects_users_error')	.'"
							}
						}
					';
			} else {
				$tmpUsers = array_keys($tmpData);
					$ajaxResponse = '
						{"results":
							{
							"res":			"1",
							"userIDs": ['	.implode(',', $tmpUsers)	.']
							}
						}
					';

			}
			echo $ajaxResponse;
			exit;


		break;

		case 'updateProjectUsers':

			$tmpID = clean_string($_POST['projectID']);
			$tmpProjectNewUsers = explode(',', clean_string($_POST['projectUsers']));
			$tmpProjectNewUsers = array_filter($tmpProjectNewUsers);

			if (empty($tmpID) || !is_array($tmpProjectNewUsers)) {
					$ajaxResponse = '
						{"results": {
							"res":	"0",
							"msg":"' . $smarty->get_config_vars('required_fields_msg')	.'"
							}
						}
					';
			} else {
					//$tmpData = get_project_operators($tmpID);
					//$currentUsers = array_keys($tmpData);


					$sqlDel = "DELETE FROM projects_users WHERE project_id ='".$tmpID."'";
					$resDel = $db->query($sqlDel); //print_r($res);
						if (PEAR::isError($resDel)) {
							$ajaxResponse = '
								{"results": {
									"res":	"0",
									"msg":"' . $smarty->get_config_vars('C31420')	.'"
									}
								}
							';
						} else {
							$z=1;
							$insertResArr = array();
							foreach ($tmpProjectNewUsers as $key=>$userID) {
								$newSeq = $db->nextID('pr_us_id');
								if (empty($newSeq)) {
									$insertResArr[$userID] = "0";
								} else {
									$sqlAdd = "INSERT INTO projects_users (id, project_id, user_id) VALUES ('".$newSeq."', '".$tmpID."', '".$userID."')";
									$resUpdate = $db->query($sqlAdd); //print_r($res);
									if (PEAR::isError($resUpdate)) {
										$insertResArr[$z] = array(
											'id'=>$userID,
											'res'=> '<span class="successText">' . $smarty->get_config_vars('project_user_add_failure') .'</span>',
										);
									} else {
										$insertResArr[$z] = array(
											'id'=>$userID,
											'res'=> '<span class="successText">' . $smarty->get_config_vars('project_user_add_success') .'</span>',
										);
									}
								}
							$z++;
							}

							foreach ($insertResArr as $key=>$values) {
								$tmpMsg[] = "{id:'".$values['id']."', res:'". $values['res']."'}";
							}
							$tmpMsg = "[". implode(', ', $tmpMsg) . ']';
						}

						$ajaxResponse = '
							{"results": {
								"res": "1",
								"msg": "",
								"info": '.$tmpMsg.'
								}
							}
						';
			}
			echo $ajaxResponse;
			exit;

		break;


		case 'deleteUser':


			$tmpUserID = clean_string($_POST['userID']);
			$tmpUserData = get_user_data($tmpUserID);

			if (!is_array($tmpUserData) || empty($tmpUserData)) {
					$ajaxResponse = '
						{"results":
							{
							"res":	"0",
							"msg":"' . $smarty->get_config_vars('users_not_found')	.'"
							}
						}
					';
				echo $ajaxResponse;
				exit;
			}

			//$sqlDel = "DELETE FROM staff WHERE staff_id ='".$tmpUserID."' LIMIT 1";
			//$sqlDel = "UPDATE staff SET status = '0' AND is_deleted=1 WHERE staff_id ='".$tmpUserID."' LIMIT 1";
			//$resDel = $db->query($sqlDel); //print_r($res);

			$resDel = updateUser($tmpUserID, array('is_deleted'=>'1', 'status'=>'0'));//mark as deleted
				if ($resDel == false) {
					$ajaxResponse = '
						{"results": {
							"res":	"0",
							"msg":"' . $smarty->get_config_vars('C31420')	.'"
							}
						}
					';
				} else {
					$ajaxResponse = '
						{"results":
							{
							"res":	"1",
							"msg":""
							}
						}
					';
			}
			echo $ajaxResponse;
			exit;

		break;


		case 'deletePriority':


			$tmpID = clean_string($_POST['priorityID']);

			if (empty($tmpID)) {
					$ajaxResponse = '
						{"results": {
							"res":	"0",
							"msg":"' . $smarty->get_config_vars('priority_delete_failure')	.'"
							}
						}
					';
				echo $ajaxResponse;
				exit;
			}

			$sqlDel = "DELETE FROM priorities WHERE id ='".$tmpID."' LIMIT 1";
			$resDel = $db->query($sqlDel); //print_r($res);

				if (PEAR::isError($resDel)) {
					$ajaxResponse = '
						{"results": {
							"res":	"0",
							"msg":"' . $smarty->get_config_vars('priority_delete_failure') . ' ('. $smarty->get_config_vars('C31420').')"
							}
						}
					';
				} else {
					$ajaxResponse = '
						{"results":
							{
							"res":	"1",
							"msg":"'.$smarty->get_config_vars('priority_delete_success').'"
							}
						}
					';
			}
			echo $ajaxResponse;
			exit;

		break;


	}

?>