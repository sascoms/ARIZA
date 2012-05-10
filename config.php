<?php

	define("MAIN_URL", 		"http://".$_SERVER["SERVER_NAME"]. substr($_SERVER["PHP_SELF"], 0, strrpos($_SERVER["PHP_SELF"],"/")) . "/");
	define("ROOT_PATH", 	dirname(__FILE__).'/'); //echo ROOT_PATH;
	define("INCLDS_DIR", 	ROOT_PATH."includes/");
	define("THEMES_DIR", 	"themes/");
	define("LBRARY_DIR", 	"library/");
	define("LANGUAGE_DIR", 	"language/");
	define("LANG_FILE_EXTENSION", 	".lang");//

	define("DEVELOPMENT_MODE", 	false);//IS DEVELOPMENT MODE of ARIZA


	require_once('params.php');

		$smtpParams['host'] = '';
		$smtpParams['port'] = '25';
		$smtpParams['helo'] = 'HELO';
		$smtpParams['auth'] = true;
		$smtpParams['user'] = '';
		$smtpParams['pass'] = '';


	ini_set("include_path", "".ROOT_PATH."library/pear"); // add custom pear directory to the include path
	//echo get_include_path();

	require_once 'MDB2.php';
	require_once ROOT_PATH.LBRARY_DIR.'/pear/smarty/libs/Smarty.class.php';

	$dsn = array(
	    'phptype'  => 'mysql',
	    'hostspec' => DBHOST,
  	    'database' => DBNAME,
	    'username' => DBUSER,
   	    'password' => DBPASS,
	    'dbsyntax' => false,
	    'protocol' => false,
	    'port'     => false,
	    'socket'   => false,

	);
	$options = array(
		'debug'       => 2,
	    'portability' => MDB2_PORTABILITY_ALL,
	);

	$db =& MDB2::connect($dsn, $options);
	if (PEAR::isError($db)) {
		//echo 'Standard Code:		' .	$db->getCode() 		. "\n";
		//echo 'DBMS/User Message:	' . $db->getUserInfo() 	. "\n";
		//echo 'DBMS/Debug Message:	' . $db->getDebugInfo() . "\n";
	    die($db->getMessage());

	}

	$db->setOption('seqname_format', '_seq_%s');
	$db->setFetchMode(MDB2_FETCHMODE_ASSOC);

	session_start(); //print_r($_SESSION);

	if ( (!isset($_SESSION['siteOptions'])) || (!is_array($_SESSION['siteOptions'])) || (empty($_SESSION['siteOptions'])) ) {
		$siteMainOptions = get_site_options(); //print_r($siteMainOptions);

		if (is_array($siteMainOptions)) {
			$_SESSION['siteOptions'] 	= $siteMainOptions;
		} else {
			die('Unable to get site options...');
		}

	} //print_r($_SESSION['siteOptions']);



	/* SMARTY CONF */
		$smarty = new Smarty;
		$smarty->compile_check 	= true;
		$smarty->debugging 		= false;

		$smarty->template_dir 	= ROOT_PATH . THEMES_DIR . $_SESSION['siteOptions']['site_template'].'/templates';
		$smarty->compile_dir 	= ROOT_PATH . THEMES_DIR . $_SESSION['siteOptions']['site_template'].'/templates_c/';
		$smarty->config_dir 	= ROOT_PATH.LANGUAGE_DIR;
		$smarty->cache_dir 		= ROOT_PATH . THEMES_DIR . $_SESSION['siteOptions']['site_template'].'/cache/';


	//smarty config/language file inclusion
	$smartyLanguageFile = ROOT_PATH.LANGUAGE_DIR.$_SESSION['siteOptions']['site_language'].'.lang';
	$smarty->config_load($smartyLanguageFile, 'SITE_GLOBAL');
	//print_r($smarty->get_config_vars());


	$defaultLanguageFile = ROOT_PATH.LANGUAGE_DIR . 'en_US.php';
	$languageFile = ROOT_PATH.LANGUAGE_DIR . $_SESSION['siteOptions']['site_language'].'.php';
	$languageFile = ( file_exists($languageFile) ? $languageFile : $defaultLanguageFile );
		require_once($languageFile);

	/* MESSAGE CODES --ERROR+SUCCESS */
		define("C31200", translateStr('C31200'));
		define("C31400", translateStr('C31400'));
		define("C31410", translateStr('C31410'));
		define("C31420", translateStr('C31420'));
		define("C31430", translateStr('C31430'));

	$menuLinks = array(
		'main'	=> array('name'=>translateStr('home'), 			'display'=>'1'),
		'add'	=> array('name'=>translateStr('new_request'), 	'display'=>'1'),
		'list'	=> array('name'=>translateStr('request_list'), 	'display'=>'1'),
		'report'=> array('name'=>translateStr('usage_report'), 	'display'=>'1'),
		'account'=> array('name'=>translateStr('my_account'), 	'display'=>'1'),
		'admin'	=> array('name'=>translateStr('admin_area'), 	'display'=>'0'),
		'out'	=> array('name'=>translateStr('secure_logout'), 'display'=>'0'),
	);


/* ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** */
/* ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** */

	function get_user_data($id) {
		global $db;
		$sql = "SELECT * FROM staff WHERE staff_id='".(int)$id."'";
		$res =& $db->query($sql);
		$row = $res->fetchRow(); 	//print_r($row);
		return $row;
	}

	function get_projects($project_id='', $is_active='1', $is_deleted='0') {
		global $db;

		$sqlWhere = array();

		if (!empty($project_id)) {
			$sqlWhere[] = "project_id='".$project_id."'";
		}

		switch ($is_active) {
			case 'all':
			break;

			case '0':
				$sqlWhere[] = "is_active = '0'";
			break;

			default:
			case '1':
				$sqlWhere[] = "is_active = '1'";
			break;
		}

		switch ($is_deleted) {
			case 'all':
			break;

			case '0':
				$sqlWhere[] = "is_deleted = '0'";
			break;

			default:
			case '1':
				$sqlWhere[] = "is_deleted = '1'";
			break;
		}


		$sqlWhereString = '';
		if (count($sqlWhere) > 0) {
			$sqlWhereString = ' WHERE '. implode(' AND ', $sqlWhere);
		}

		$sql = "SELECT * FROM projects ".$sqlWhereString."";

		$res =& $db->query($sql); //print_r($res);
		$num = $res->numRows();
		if (!empty($project_id)) {
			$row = $res->fetchRow();
			return $row;
		}

		while ($row = $res->fetchRow()) {
			$projects[$row['project_id']] = $row;
		}
		return $projects; //print_r($userProjects);
	}


	function get_priorities($priority_id='') {
		global $db;

		$sql = "SELECT * FROM priorities";
		if (!empty($project_id)) {
			$sql .= " WHERE id='".$priority_id."'";
		}
		$res =& $db->query($sql); //print_r($res);
		$num = $res->numRows();
		if (!empty($priority_id)) {
			$row = $res->fetchRow();
			return $row;
		}

		while ($row = $res->fetchRow()) {
			$data[$row['id']] = $row;
		}
		return $data; //print_r($data);
	}

	function get_user_projects($id) {
		global $db;
		$sql = "
			SELECT * FROM projects_users PU
			INNER JOIN projects P ON P.project_id=PU.project_id AND P.is_active=1 AND P.is_deleted=0
			WHERE PU.user_id='".(int)$id."'";
		$res =& $db->query($sql); //print_r($res);
		$num = $res->numRows();
			while ($row = $res->fetchRow()) {
				$userProjects[$row['project_id']] = $row;
			}
		return $userProjects; //print_r($userProjects);
	}

	function get_project_operators($id) {// get operators associated with a project
		global $db;
		$sql = "
			SELECT PU.user_id FROM projects_users PU, staff U, projects P
				WHERE
					PU.project_id='".(int)$id."'
					AND PU.project_id=P.project_id AND P.is_active=1 AND P.is_deleted=0
					AND PU.user_id=U.staff_id AND U.is_deleted=0 and U.status=1
			";
		$res =& $db->query($sql); //print_r($res);
		$num = $res->numRows();
			while ($row = $res->fetchRow()) {
				$data[$row['user_id']] = $row;
			}
		return $data; //print_r($userProjects);
	}

	function authenticate_user($user, $pass) {
		global $db;
		$sql = "SELECT * FROM staff U WHERE staff_user='".$user."' AND staff_pass='".$pass."' AND U.is_deleted=0 and U.status=1";
		$res =& $db->query($sql);
		$num = $res->numRows();
		$row = $res->fetchRow(); 	//print_r($row);
		return $row;
	}

	function get_site_options($project_id='') {
		global $db;
		$siteMainOptions = '';
		//projectid gelince eklenecek.. sessiondan... veya kisinin default projesi..
		$sql = "SELECT * FROM options";
		$res =& $db->query($sql);
		while ($row = $res->fetchRow()) {
			$siteMainOptions[$row['optionname']] = $row['optionvalue'];
		}
		return $siteMainOptions;
	}

	function get_operators($project_id='') {
		global $db;
		$staffList = '';
		//projectid gelince eklenecek.. sessiondan... veya kisinin default projesi..
		$sql = "SELECT staff_id as id, CONCAT(staff_name, ' ', staff_surname) AS fullname FROM staff U WHERE U.is_deleted=0 and U.status=1";
		$res =& $db->query($sql);
		while ($row = $res->fetchRow()) {
			$staffList[$row['id']] = $row['fullname'];
		}
		return $staffList;
	}

	function get_bugTypes($project_id='') {
		global $db;
		$bugTypes = '';
		//projectid gelince eklenecek.. sessiondan... veya kisinin default projesi..
		$sql = "SELECT id, name FROM bug_types";
		$res =& $db->query($sql);
		while ($row = $res->fetchRow()) {
			$bugTypes[$row['id']] = $row['name'];
		}
		return $bugTypes;
	}

	function get_versions($project_id) {
		global $db;
		$versions = '';
		//projectid gelince eklenecek.. sessiondan... veya kisinin default projesi..
		$sql = "SELECT version_id, version_title FROM versions WHERE project_id='".$project_id."'";
		$res =& $db->query($sql);
		while ($row = $res->fetchRow()) {
			$versions[$row['version_id']] = $row['version_title'];
		}
		return $versions;
	}

	function get_statuses($project_id='') {
		global $db;
		$statuses = '';
		//projectid gelince eklenecek.. sessiondan... veya kisinin default projesi..
		$sql = "SELECT id, name FROM statuses";
		$res =& $db->query($sql);
		while ($row = $res->fetchRow()) {
			$statuses[$row['id']] = $row['name'];
		}
		return $statuses;
	}

	function getEnvironment() {
	    $Browser_Platform = "unknown";
	    if(ereg("Windows", $_SERVER['HTTP_USER_AGENT']) ||
	        ereg("WinNT",  $_SERVER['HTTP_USER_AGENT']) ||
	        ereg("Win95",  $_SERVER['HTTP_USER_AGENT'])) {
	        $Browser_Platform = "Windows";
	    }

	    if(ereg("Mac", $_SERVER['HTTP_USER_AGENT'])) {
	        $Browser_Platform = "Macintosh";
	    }

	    if(ereg("Linux", $_SERVER['HTTP_USER_AGENT'])) {
	        $Browser_Platform = "Linux";
	    }
		$userEnvironment['platform'] = $Browser_Platform;
		return $userEnvironment;
	}

	function translateStr($string) {
		global $langArr;
		if ( isset($langArr[$string]) && !empty($langArr[$string]) ) {
			return $langArr[$string];
		}
		return '###Undefined###';
	}

	function getLangFiles() {
		$langFilesArr = '';
		$tmplangDir = ROOT_PATH . '' . LANGUAGE_DIR;

		$dirObj = new DirectoryIterator( $tmplangDir );
		foreach($dirObj as $file ) {
			//if(!$file->isDot() && !$file->isDir() && (preg_match("/.lang$/", $file->getFilename())) ) {
			if(!$file->isDot() && !$file->isDir() && (stristr($file->getFilename(), LANG_FILE_EXTENSION)) ) {
    	   		$tmpLangName = str_ireplace(LANG_FILE_EXTENSION, '', $file->getFilename());
           		$langFilesArr[$tmpLangName] = $tmpLangName;
			}
		}//print_r($langFilesArr);
		return $langFilesArr;
	}

	function clean_string($string) {
		$p_string = trim($string);
		$p_string = strip_tags($p_string);
		$p_string = addslashes($p_string);
		return $p_string;
	}

	function get_ip_address() {
	   if (isset($_SERVER["HTTP_X_FORWARDED_FOR"]) && ($_SERVER["HTTP_X_FORWARDED_FOR"] != "")) {
	       return $_SERVER["HTTP_X_FORWARDED_FOR"];
	   } else {
	       return $_SERVER["REMOTE_ADDR"];
	   }
	}


	function changeLang($lng, $projectId='') {
		global $db;
		if (empty($lng)) {
			return false;
		}

		$sql = "
			UPDATE options
				set optionvalue = '".$lng."'
				WHERE optionname = 'site_language' ";
					//project_id = '".$projectId."'";


			$res = $db->query($sql); //print_r($res);
			if (PEAR::isError($res)) {
				return false;
			} else {
				$_SESSION['siteOptions']['site_language'] = $lng;
				return true;
			}

	}

	function changeSiteOption($optionName, $optionValue, $projectId='') {
		global $db;
		$sql = "
			UPDATE options
				set optionvalue = '".$optionValue."'
				WHERE optionname = '".$optionName."'";
					//project_id = '".$projectId."'";

			$res = $db->query($sql); //print_r($res);
			if (PEAR::isError($res)) {
				return false;
			} else {
				$_SESSION['siteOptions'][$optionName] = $optionValue;
				return 'C31200';
			}
	}

	function updateUser($userID, $newData) {
		global $db;

		$updateSQL = array();
		foreach ($newData as $key=>$value) {
			$updateSQL[] = "".$key."='".$value."'";
		}
		$updateSQLString = implode(', ', $updateSQL);

		$sql = "
			UPDATE staff
				SET ".$updateSQLString."
				WHERE staff_id = '".$userID."'";
					//project_id = '".$projectId."'";

			$res = $db->query($sql); //print_r($res);
			if (PEAR::isError($res)) {
				return false;
			} else {
				return true;
			}
	}

	function addUser($newData) {
		global $db;

		$sql = "INSERT INTO staff
			(staff_id, staff_user, staff_pass, staff_name, staff_surname, staff_email, staff_type, is_admin, status, default_project_id)
			VALUES (
				".$newData['staff_id'].", '".$newData['staff_user']."',  '".$newData['staff_pass']."', '".$newData['staff_name']."', '".$newData['staff_surname']."', '".$newData['staff_email']."', '".$newData['staff_type']."', '".$newData['is_admin']."', '".$newData['status']."', '".$newData['default_project_id']."'
			)";

			$res = $db->query($sql); //print_r($res);
			if (PEAR::isError($res)) {
				return false;
			} else {
				return true;
			}
	}

	function addProject($newData) {
		global $db;

		$sql = "INSERT INTO projects (project_id, name, description, is_active, is_deleted)
			VALUES (".$newData['project_id'].", '".$newData['name']."',  '".$newData['description']."',  '".$newData['is_active']."',  '0'
			)";

			$res = $db->query($sql); //print_r($res);
			if (PEAR::isError($res)) {
				return false;
			} else {
				return true;
			}
	}

	function addPriority($newData) {
		global $db;

		$sql = "INSERT INTO priorities (id, name, color)
			VALUES (".$newData['id'].", '".$newData['name']."',  '".$newData['color']."'
			)";

			$res = $db->query($sql); //print_r($res);
			if (PEAR::isError($res)) {
				return false;
			} else {
				return true;
			}
	}


	function updateProject($id, $data) {
		global $db;

		$updateSQL = array();
		foreach ($data as $key=>$value) {
			$updateSQL[] = "".$key."='".$value."'";
		}
		$updateSQLString = implode(', ', $updateSQL);

		$sql = "
			UPDATE projects
				SET ".$updateSQLString."
				WHERE project_id = '".$id."' LIMIT 1";
			$res = $db->query($sql); //print_r($res);
			if (PEAR::isError($res)) {
				return false;
			} else {
				return true;
			}
	}

	function updatePriority($id, $data) {
		global $db;

		$updateSQL = array();
		foreach ($data as $key=>$value) {
			$updateSQL[] = "".$key."='".$value."'";
		}
		$updateSQLString = implode(', ', $updateSQL);

		$sql = "
			UPDATE priorities
				SET ".$updateSQLString."
				WHERE id = '".$id."' LIMIT 1";
			$res = $db->query($sql); //print_r($res);
			if (PEAR::isError($res)) {
				return false;
			} else {
				return true;
			}
	}

	function associateUserProjects($userID, $projectsArr) {
		global $db;

		$sqlDel = "DELETE FROM projects_users WHERE user_id='".$userID."'";
		$resDel = $db->query($sqlDel); //print_r($res);
		if ($resDel === false) {
			return false;
		}

		$failed 	= 0;
		$success 	= 0;
		$total 		= count($projectsArr);

		foreach ($projectsArr as $key=>$project_id) {
			$new_user_project_id = $db->nextID('pr_us_id');
			if (PEAR::isError($new_user_project_id)) {
				$failed++;
			} else {
				if (!empty($project_id)) {
					$sql = "INSERT INTO projects_users (id, project_id, user_id) VALUES ('".$new_user_project_id."', '".$project_id."', '".$userID."')";
					$res = $db->query($sql); //print_r($res);
					if ($res == true) {
						$success++;
					} else {
						$failed++;
					}
				}
			}
		}
		if ($total == $success) {
			return true;
		} else {
			$resData['total'] 	= $total;
			$resData['success'] = $success;
			$resData['failed'] 	= $failed;
			return $resData;
		}
	}


	function createResponseDiv($data) {

		$tmpContent = '
			<fieldset id="responseId_'.$data['id'].'" class="replies">
				<legend>'.$data['staffFullname'].'</legend>
				'. ' '
				//<!--<span class="response_counter">'.$data['index'].'</span>-->
				.'
	    	 	<div class="response_text">'.$data['response_text'].'</div>
	    	 	<div class="small align-right">'.$data["status"].' | '.$data["response_datetime"].' </div>
		 	</fieldset>
		';

		return $tmpContent;
	}

	function output_ajax_xml_error($data) {
		/*
		$content = '
			header("Content-Type: text/xml");
			<?xml version="1.0" encoding="utf-8"?>
			<error>
				<code>'.	$data['errorCode']		.'</code>
				<message>'.	$data['errorMSG'] 	.'</message>
			</error>

		';
		*/
		$content = '
			{"result":
				{
				"errorCode":"'	.$data['errorCode']	.'",
				"errorMSG":"'	.$data['errorMSG']	.'"
				}
			}

		';
		return $content;
	}

	function output_ajax_xml_response_content($data) {
		/*
		$content = '
			header("Content-Type: text/xml");
			<?xml version="1.0" encoding="utf-8"?>
			<response>
				<error>'			.$data['error'].			'</responseID>
				<responseID>'		.$data['responseID'].		'</responseID>
				<bugStatus>'		.$data['bugStatus'] .		'</bugStatus>
				<staffFullName>'	.$data['staffFullname'].	'</staffFullName>
				<responseDateTime>'	.$data['responseDateTime'].	'</responseDateTime>
				<responseText>'		.$data['responseText'].		'</responseText>
			</response>
		';
		*/

		$content = '
			{"result":
				{
				"errorCode":"'		.$data['errorCode']	.'",
				"errorMSG":"'		.$data['errorMSG']	.'",
				"responseID":"'		.$data['responseID'].'",
				"bugStatus":"'		.$data['bugStatus']	.'",
				"staffFullName":"'	.$data['staffFullname']		.'",
				"responseDateTime":"'.$data['responseDateTime']	.'",
				"responseText":"'	.$data['responseText']		.'"
				}
			}
		';



		return $content;
	}


    function composeMailDataArray($mailFormat='html', $from, $to, $subject, $body, $fromPageJobName='MAILER', $fromTitle='', $toTitle='', $charset='utf-8') {
    	$to 		= clean_string($to);
    	$from 		= clean_string($from);
    	$subject 	= clean_string($subject);
    	$toTitle 	= clean_string($toTitle);

        if ($to == '') {
            //commonObjects::fileLogger(__FILE__, __LINE__, '', '', 'TO email is empty ($maildata)!');
            return false;
        }
        if ($from == '') {
            //commonObjects::fileLogger(__FILE__, __LINE__, '', '', 'FROM email is empty ($maildata)!');
            return false;
        }

        if ($toTitle != '') {
	        $maildata['to']			= '"'.$toTitle.'" <'.$to.'>';
        } else {
        	$maildata['to']			= $to;
        }
        //$maildata['to']			= $toTitle . $to;
        $maildata['from']		= '"'.$fromTitle .'"'. ' <'.$from.'>';
        $maildata['subject']	= '['.$fromPageJobName.'] '.$subject;
        $maildata['body']		= $body;
        $maildata['format']		= $mailFormat;
        $maildata['charset']	= $charset;

        if (!is_array($maildata) || empty($maildata)) {
            //commonObjects::fileLogger(__FILE__, __LINE__, '', '', 'maildata is not set or is not array  or empty ($maildata)!');
            return false;
        }


        return $maildata;
    }

    function sendMail($maildata) {

	        require_once(ROOT_PATH . LBRARY_DIR . 'htmlMimeMail5/htmlMimeMail5.php');

            $mailer = new htmlMimeMail5();


	        $mailer->setBcc(ADMIN_EMAIL);//let's send a copy to admin and archive accounts
	        $mailer->setFrom($maildata['from']);
            $mailer->setReturnPath(SITE_EMAIL);
            $mailer->setHeader('Reply-to', ''.$maildata['from'].'');

	        $mailer->setPriority('high');

	        //$mailer->setHeader('X-Mailer', 'PHP');//$mailer->setHeader('X-Mailer', 'PHP v'.phpversion().'');


	        $mailer->setSubject($maildata['subject']);


	        $mailer->setHeadCharset($maildata['charset']);
	        $mailer->setTextCharset($maildata['charset']);
	        $mailer->setHTMLCharset($maildata['charset']);
	        //$mailer->setHTMLEncoding('quoted-printable');

	        if ($maildata['format'] == 'text') {
	            $mailer->setText($maildata['body']);
	        } else {
	            $mailer->setHTML($maildata['body']);
	        }


	        if (isset($maildata['attachment']) && ($maildata['attachment'] != '')) {
    	        $mailer->addAttachment(new fileAttachment($maildata['attachment']['tmp_name'], $maildata['attachment']['type'], new Base64Encoding()));
        	    //$mailer->addEmbeddedImage(new fileEmbeddedImage('background.gif', 'image/gif', new Base64Encoding()));
	        }


	        //SEND EMAILS TO ADMIN in DEVELOPMENT MODE
	        if (DEVELOPMENT_MODE == true) {
	            $maildata['to'] = ADMIN_EMAIL;
	            $mailer->setHeader('Reply-to', ''.ADMIN_EMAIL.'');
	            $mailer->setReturnPath(ADMIN_EMAIL);
	        }


	        $res = $mailer->send(array($maildata['to']));
            if ($res===false) {//print_r($mailer->errors);
                //commonObjects::fileLogger(__FILE__, __LINE__, '', '', 'Failed sending e-mail!'); //$res->getDebugInfo de eklenebilir veya kullanilabilir
                return false;
            }
	        return true;
	    }

?>