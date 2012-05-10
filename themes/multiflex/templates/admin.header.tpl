<script type="text/javascript">
	var ajax_processing_operation = '{$LNG_ajax_processing_operation}';

	var operation_successful_msg = '{$LNG_operation_successful_msg}';
	var operation_failure_msg = '{$LNG_operation_failure_msg}';
</script>

		<script src="{$libraryPath}scriptaculous/lib/prototype.js" type="text/javascript"></script>
  		<script src="{$libraryPath}scriptaculous/src/scriptaculous.js" type="text/javascript"></script>

        <script type="text/javascript" src="{$libraryPath}adminFuncs.js"></script>

<fieldset id="idChangeLang" style="background-color: #E9F3EA; margin:10px 3px;; padding: 10px;" class="align-right">
	<strong>
		{$LNG_administrate_header}
		<br />
    	<a href="./index.php?job=admin&amp;do=users">{#administrate_users#}</a>
    	| <a href="./index.php?job=admin&amp;do=projects">{#administrate_projects#}</a>
    	| <a href="./index.php?job=admin&amp;do=versions" onclick="return false;">{#administrate_versions#}</a>
    	| <a href="./index.php?job=admin&amp;do=priorities">{#administrate_priorities#}</a>
	</strong>
</fieldset>
