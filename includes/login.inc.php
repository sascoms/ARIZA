<?php
	$login_err_msg 	= false;
	/////////////
	if (isset($_GET['job']) && ($_GET['job'] == 'out')) {
		session_destroy();

		$_SESSION 		= array();
		$_GET['job']	= 'login';
		$job			= 'login';

		header('Location:'.MAIN_URL);
	}


	if (isset($_SESSION['userdata']['staff_user']) && isset($_SESSION['userdata']['staff_pass'] )) {		//echo 'session';
		$old_user	= $_SESSION['userdata']['staff_user'];
		$old_pass	= $_SESSION['userdata']['staff_pass'];

	} else if (isset($_POST['user']) && isset($_POST['pass'] )) {		//echo 'post';
		$old_user	= $_POST['user'];
		$old_pass	= md5($_POST['pass']);
		$login_err_msg 	= true;

	} else {
		$old_user	= '';
		$old_pass	= '';
	}

	if ( isset($old_user) && !empty($old_user)  && isset($old_pass)  && !empty($old_pass) )   {
		$row = authenticate_user($old_user, $old_pass);

		if (is_array($row) && !empty($row)) {
			$_GET['job'] = ( isset($_GET['job']) && ($_GET['job'] != 'out') ? $_GET['job'] : 'main' );
			$job		 = ( isset($_GET['job']) && ($_GET['job'] != 'out') ? $_GET['job'] : 'main');
			//$_GET['job'] = $job = 'main';

				$_SESSION['userdata']		= $row;
				$_SESSION['userdata']['is_authenticated']	= true;

				//$staff_id = $row['staff_id'];
				$login_err_msg 	= false;

		} else {
			$login_err_msg 	= true;
			$_GET['job']	= 'login';
			$job			= 'login';
		}
	} else {
		$_GET['job']	= 'login';
		$job			= 'login';
	}

//echo $job;
?>