<?php
		
		
// post checkbox dolu mu bos mu kontrol.
// operator id bos mu degil mi
	//print_r($_POST);
	$bugIds = implode($_POST['bugs'],',');
	
	$sql = "
		UPDATE bugs 
			set bug_type_id = '".$_POST['bugTypeId']."'		
		WHERE bug_id IN (".$bugIds.")";

	
		$res = $db->query($sql); //print_r($res);
		//$res = true;
		if (PEAR::isError($res)) {
			echo 'C31420'; print_r($res);
			$res = false;
		} else {
			echo 'C31200';
		}
		
		
?>