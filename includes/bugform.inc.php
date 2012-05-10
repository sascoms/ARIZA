<?php
	$bugTypes = get_bugTypes();
	$prioritiesArr = get_priorities();
	if (is_array($prioritiesArr)) {
		foreach ($prioritiesArr as $key=>$prData) {
			$priorities[$prData['id']] = $prData['name'];
		}
	}

	$project_versions = get_versions($selected_project_id);
	if (!is_array($project_versions) || empty($project_versions)) {
		$smarty->assign("LNG_no_version_found", translateStr('no_version_found'));
	}

	$smarty->assign("priorities", $priorities);
	$smarty->assign("BugTypes", $bugTypes);
	$smarty->assign("projectVersions", $project_versions);

	$smarty->assign("LNG_request_form_title", translateStr('request_form_title'));
	$smarty->assign("LNG_request_type", translateStr('request_type'));
	$smarty->assign("LNG_version", translateStr('version'));
	$smarty->assign("LNG_request_title", translateStr('request_title'));
	$smarty->assign("LNG_request_explanation", translateStr('request_explanation'));
	$smarty->assign("LNG_steps_caused_bug", translateStr('steps_caused_bug'));
	$smarty->assign("LNG_suggested_solutions", translateStr('suggested_solutions'));
	$smarty->assign("LNG_request_attachment", translateStr('request_attachment'));
	$smarty->assign("LNG_completed_percentage", translateStr('completed_percentage'));
	$smarty->assign("LNG_priority", translateStr('priority'));
	$smarty->assign("LNG_select_option_value", translateStr('select_option_value'));

	$smarty->assign("LNG_submit", translateStr('submit'));


	//javascript errors
	$smarty->assign("LNG_js_check_the_errors_below", translateStr('js_check_the_errors_below'));
	$smarty->assign("LNG_js_required_field_value", translateStr('js_required_field_value'));
	$smarty->assign("LNG_js_no_option_selected", translateStr('js_no_option_selected'));

	//form results
	$smarty->assign("LNG_bug_record_insert_success", translateStr('bug_record_insert_success'));
	$smarty->assign("LNG_bug_record_insert_failure", translateStr('bug_record_insert_failure'));
	$smarty->assign("LNG_bug_record_insert_new", translateStr('bug_record_insert_new'));

	$smarty->assign("LNG_ajax_processing_operation", translateStr('ajax_processing_operation'));



	$MainContent = $smarty->fetch('bugform.tpl');


?>