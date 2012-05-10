<?php



	$langFilesArr = getLangFiles();


	$smarty->assign('currentLangFile', $_SESSION['siteOptions']['site_language']);
	$smarty->assign('langFilesArr', $langFilesArr);



	$smarty->assign('LNG_availableLangFiles', translateStr('available_lang_files'));
	$smarty->assign('LNG_currentLangFile', translateStr('current_lang_file'));
	$smarty->assign('LNG_langFilesError', translateStr('lang_file_error'));
	$smarty->assign('LNG_submit', translateStr('submit'));
	$smarty->assign('LNG_changeLang', translateStr('change_lang'));
	$smarty->assign('LNG_change_site_settings', translateStr('change_site_settings'));
	$smarty->assign('LNG_noAuthorization', translateStr('no_authorization'));




	$smarty->assign('LNG_currentSiteTitle', translateStr('current_site_title'));
	$smarty->assign('LNG_change_site_title', translateStr('change_site_title'));
	$smarty->assign('LNG_change_site_header', translateStr('change_site_header'));
	$smarty->assign('LNG_change_site_slogan', translateStr('change_site_slogan'));
	$smarty->assign('LNG_site_options_activation_msg', translateStr('site_options_activation_msg'));




	$MainContent = '';
	include_once('admin.header.inc.php');
	$MainContent .= $adminHeaderContent;
	$MainContent .= $smarty->fetch('admin.tpl');
?>