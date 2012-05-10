<?php
	$staff_id 		= '';
	$MainContent 	= '';
	$FooterContent 	= '';


//	include_once('./config.devel.php');
//	include_once('./config.demos.php');
	include_once('./config.php');

	include_once(INCLDS_DIR.'login.inc.php');

	$userdata = $_SESSION['userdata']; //print_r($userdata); //exit;
	//$userdata = get_user_data($staff_id); //print_r($userdata); //exit;
	//$_SESSION['userdata'] = $userdata; //print_r($_SESSION);

		//set project id
		if ( !isset($_SESSION['selected_project_id']) || empty($_SESSION['selected_project_id']) ) {
			$_SESSION['selected_project_id'] = $userdata['default_project_id'];
		}

		if ( isset($_POST['change_project_submit']) && !empty($_POST['change_project_id']) ) {
			$_SESSION['selected_project_id'] = trim($_POST['change_project_id']);
		}
		if ( isset($_GET['project']) && !empty($_GET['project']) ) {
			$_SESSION['selected_project_id'] = trim($_GET['project']);
		}



		if ($_SESSION['userdata']['is_admin'] == '1') {
			if (isset($_POST['ChangeLangSubmit']) && !empty($_POST['langFileName'])) {
				$tmpLng = clean_string($_POST['langFileName']);
					$tmpLng = clean_string($_POST['langFileName']);
					$res = changeLang($tmpLng);
					$operationResMsg = ($res) ? $langArr['lang_file_changed_msg'] : $langArr['lang_file_change_failed_msg'];
					if ($res === true) {
						$_SESSION['siteOptions']['site_language'] 	= $tmpLng;
						$siteMainOptions['site_language'] 			= $tmpLng;
						$smarty->assign('operationResMsg', $operationResMsg);


						$admOperationResDivVis = 'block';
						$smarty->assign('admOperationResDivVis', $admOperationResDivVis);

					}

			}
		}

	$staff_id 				= $_SESSION['userdata']['staff_id'];
	$reporting_staff_id 	= $_SESSION['userdata']['staff_id'];
	$replying_staff_id 		= '';
	$selected_project_id 	= $_SESSION['selected_project_id'];
	$is_admin 				= $_SESSION['userdata']['is_admin'];

	$HeaderContent = '';
	$WhoAmIContent = '';


	$job = (!isset($_GET['job']) ? 'main' : clean_string($_GET['job']));
	$do = (!isset($_GET['do']) ? '' : clean_string($_GET['do']));


	switch ($job) {
		default:
		case '':
		case 'list':
			$include_file = 'buglist.inc.php';
		break;

		case 'add':
			$include_file = 'bugform.inc.php';
		break;

		case 'account':
			$include_file = 'myaccount.inc.php';
		break;

		case 'ajjb':
			switch ($do) {
				default:
				case '':
				break;

				case 'addbug':
					$include_file = 'ajax.insert.bug.inc.php';
				break;

				case 'respond':
					$include_file = 'ajax.insert.response.inc.php';
				break;

				case 'prioritize':
					$include_file = 'ajax.prioritize.bug.inc.php';
				break;

				case 'changeBugType':
					$include_file = 'ajax.changeBugType.bug.inc.php';
				break;

				case 'associate':
					$include_file = 'ajax.associate.bug.inc.php';
				break;


				case 'ajaxOps':
					$include_file = 'ajaxAdmin.inc.php';
				break;


			}

		break;

		case 'respond':
			$include_file = 'respond.inc.php';
		break;
		case 'admin':
			if ($_SESSION['userdata']['is_admin'] == '1') {
				switch ($do) {
					default:
					case '':
						$include_file = 'admin.inc.php';
					break;

					case 'users':
						$include_file = 'admin.users.inc.php';
					break;
					case 'projects':
						$include_file = 'admin.projects.inc.php';
					break;
					case 'versions':
						$include_file = 'admin.versions.inc.php';
					break;
					case 'priorities':
						$include_file = 'admin.priorities.inc.php';
					break;
				}
			} else {
					$include_file = 'admin.noAuth.inc.php';
			}

		break;

		case 'login':
			$include_file = 'loginform.inc.php';
		break;

	}

	$smarty->assign('themePath', 	MAIN_URL . THEMES_DIR . $_SESSION['siteOptions']['site_template'].''.'');
	$smarty->assign('libraryPath', 	MAIN_URL . LBRARY_DIR);
	$smarty->assign('jobAction', 	$job);
	$smarty->assign('isAdmin', 			$_SESSION['userdata']['is_admin']);
	$smarty->assign('isAuthenticated', 	$_SESSION['userdata']['is_authenticated']);
	$smarty->assign("siteOptions", 		$_SESSION['siteOptions']);


	if (($job != 'login') && ($job != 'ajjb')) {
		include_once(INCLDS_DIR.'whoami.inc.php');
	}

	include_once(INCLDS_DIR.$include_file);

	if ($job != 'ajjb') {
		include_once(INCLDS_DIR.'header.inc.php');
		include_once(INCLDS_DIR.'footer.inc.php');
		$smarty->append("HeaderContent", 	$HeaderContent);
		$smarty->append("HeaderContent", 	$WhoAmIContent);
		$smarty->assign("MainContent", 		$MainContent);
		$smarty->assign("FooterContent", 	$FooterContent);
		$smarty->display('index.tpl');
	}


?>