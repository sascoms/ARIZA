	<script src="{$libraryPath}scriptaculous/lib/prototype.js" type="text/javascript"></script>
	<script src="{$libraryPath}scriptaculous/src/scriptaculous.js" type="text/javascript"></script>
	<script src="{$libraryPath}validation/apple_formvalidation.js" type="text/javascript"></script>

	<script type="text/javascript">
		    var error_alert_title = '{$LNG_js_check_the_errors_below}';
		    var empty_field_error = '{$LNG_js_required_field_value}';
		    var no_option_selected_error = '{$LNG_js_no_option_selected}';

		    var bugtypes_field_title = '{$LNG_request_type}';
		    var versions_field_title = '{$LNG_version}';
		    var bugTitle_field_title 		= '{$LNG_request_title}';
		    var bugExplanation_field_title 	= '{$LNG_request_explanation}';

			var bug_record_insert_success = '{$LNG_bug_record_insert_success}';
			var bug_record_insert_failure = '{$LNG_bug_record_insert_failure}';
			var bug_record_insert_new = '{$LNG_bug_record_insert_new}';

			var ajax_processing_operation = '{$LNG_ajax_processing_operation}';
	</script>

{literal}
	<script type="text/javascript">
		function process_form() {
			 var res = validateForm();
			 if (res == true) {
			 	insert_new_bug();
			 }
		}

		function validateForm() {
		    var errors = "";

		    errors += checkDropdown('bugType', bugtypes_field_title, no_option_selected_error);
		    errors += checkDropdown('projectVersionId', versions_field_title, no_option_selected_error);

		    errors += isEmpty('bugTitle', bugTitle_field_title, empty_field_error);
		    errors += isEmpty('bugDesc', bugExplanation_field_title, empty_field_error);

		    if (errors != "") {
		    	errors = error_alert_title + "\n" + errors;
		       alert(errors);
		       return false;
		    }
			return true;
		}



		Ajax.Responders.register( {
			onCreate: function(e) {
				showNotify(ajax_processing_operation);
			},
			onComplete: function() {
				hideNotify();
			}
		} );




	  	function insert_new_bug() {
		/*	  	doc = document;
			  	var staffId = doc.getElementById('staffId').value;
			  	var bugType = doc.getElementById('bugType').value;
			  	var bugVersion = doc.getElementById('bugVersion').value;
			  	var bugTitle = doc.getElementById('bugTitle').value;
			  	var bugDesc = doc.getElementById('bugDesc').value;
			  	var bugSteps = doc.getElementById('bugSteps').value;
			  	var bugSolution = doc.getElementById('bugSolution').value;
			  	var bugFile = '';//doc.getElementById('bugFile').value;
			  	var bugPlatform = doc.getElementById('bugPlatform').value;
		*/
		  	var projectIdValue = document.getElementById('change_project_id').value;

			var postString = Form.serialize('id_bugInsertion');
	  		//alert(postString);
		  	var options = {
			   	    method: 'post', // Use POST
			    	postBody: postString, //'staffId='+staffId+'&bugType='+bugType+'&bugVersion='+bugVersion+'&bugTitle='+bugTitle+'&bugDesc='+bugDesc+'&bugSteps='+bugSteps+'&bugSolution='+bugSolution+'&bugFile='+bugFile+'&bugPlatform='+bugPlatform+'',// Send this lovely data
			    	onSuccess: function(t) {// Handle successful response
			    		var x = t.responseText;
		    			var resultData = eval('(' + t.responseText + ')'); //alert(resultData.result.errorCode);
			        	if (resultData.result.errorCode == '0') { //successful
			        		//alert(t.responseText);
			        		//if (t.responseText=='C31200') { //successful
			        		Element.hide('id_bugInsertion');
			        		var msg = bug_record_insert_success + ' <br />'
			        		msg += '<a href="javascript:void(0);" onclick="Effect.SlideDown(\'id_bugInsertion\'); return false;">'+bug_record_insert_new+'</a>';
			        		Element.update('id_bugInsertionRes',msg);
			        		Element.show('id_bugInsertionRes');
			        	} else {
			        		alert(bug_record_insert_failure + "\n" + resultData.result.errorMSG);
			        		//alert(t.responseText);
			        	}
			    	},
			    	on404: function(t) { // Handle 404
			        	alert('Error 404: location "' + t.statusText + '" was not found.');
			    	},
			    	onFailure: function(t) {// Handle other errors
			        	alert('Error ' + t.status + ' -- ' + t.statusText);
			    	}
				}
			new Ajax.Request('index.php?job=ajjb&do=addbug', options);
  		}
	</script>
{/literal}

<div id="id_bugInsertionRes" class="operationResultMsg" style="display:none;" align="center"></div>
<br />

<form name="bugInsertion" enctype="multipart/form-data" method="post" action="" id="id_bugInsertion">

	<input name="selectedProjectId" id="selectedProjectId" type="hidden" value="{$selectedProjectID}">
	<input name="staffId" id="staffId" type="hidden" value="{$userData.staff_id}">
	<input type="hidden" name="bugPlatform" id="bugPlatform" value="{$userEnvironment.platform}" />

	<table id="bugFormTable" width="100%" class="classic" cellspacing="1" cellpadding="1">
		<tr>
			<th colspan="2" class="cellTitle align-left">&nbsp;{$LNG_request_form_title}</th>
		</tr>
		<tr class="row2">
			<td align="right" valign="top" width="30%"><b>{$LNG_request_type}: </b><span class="redstar">*</span></td>
			<td>
				<select name="bugType" size="1" id="bugType">
					{foreach key=key item=value from=$BugTypes}
						<option value="{$key}">{$value}</option>
					{/foreach}
				</select>
			</td>
		<tr class="row2">
			<td align="right"><b>{$LNG_version}: </b><span class="redstar">*</span></td>
			<td>
				<select name="projectVersionId" size="1" id="projectVersionId" class="{if $projectVersions == ''} hiliteRow2{/if}">
					{if $projectVersions != ''}
						{foreach key=key item=value from=$projectVersions}
							<option value="{$key}">{$value}</option>
						{/foreach}
					{else}
						<option value="">{$LNG_no_version_found}</option>
					{/if}
				</select>
			</td>
		</tr>
		<tr class="row2">
			<td align="right" valign="top"> <b>{$LNG_request_title}: </b><span class="redstar">*</span></td>
			<td><input name="bugTitle" type="text" id="bugTitle" size="90"></td>
		</tr>
		<tr class="row2">
			<td align="right" valign="top"> <b>{$LNG_request_explanation}: <span class="redstar">*</span></b></td>
			<td><textarea name="bugDesc" rows="5" id="bugDesc"></textarea></td>
		</tr>
		<tr class="row2">
			<td align="right" valign="top"> <b>{$LNG_steps_caused_bug}:</b></td>
			<td colspan="3"><textarea name="bugSteps" rows="5" id="bugSteps"></textarea></td>
		</tr>
		<tr class="row2">
			<td align="right" valign="top"> <b>{$LNG_suggested_solutions}:</b></td>
			<td colspan="3"><textarea name="bugSolution" rows="5" id="bugSolution"></textarea></td>
		</tr>

		<tr class="row2">
			<td align="right" valign="top"> <b>{$LNG_priority}: </b></td>
			<td>
				<select name="priorityId" id="priorityId" size="1">
					<option value="">{$LNG_select_option_value}</option>
			     {foreach key=key item=value from=$priorities}
			     	<option value="{$key}">{$value}</option>
			     {/foreach}
				</select>

			</td>
		</tr>

		<tr class="row2">
			<td align="right" valign="top"> <b>{$LNG_completed_percentage}:</b></td>
			<td>
				<input name="progressPercent" type="hidden" id="progressPercent" value="0">
					<!-- need this wrap so that 'span' can exist and the track is still easily clickable by the mouse -->

					<div id="wrap1" style="float:left; left:20px;width: 240px; background-color: #ccc; height: 20px; border: 0px solid black;">
						<div id="span1" style="float: left; background-color: lightgreen; height: 20px; border: 0px solid blue;">
							<div id="track1" style="width: 240px; height: 20px; position: absolute; border: 0px solid white;">
								<div id="handle1" style="position: absolute; width: 10px; height: 25px; background-color: #f00; cursor: col-resize;"></div>
							</div>
						</div>
					</div>
					&nbsp;<span id="progressPercentShow">0%</span>

					<script type="text/javascript" language="javascript">
					{literal}
					// <![CDATA[

						// horizontal slider control
						// horizontal slider control
							var slider1 = new Control.Slider('handle1', 'track1', {
								range: $R(0,20),
								values: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20],
								sliderValue: 0,//eger default bir degere getirmek istiyorsak o zaman yukaridaki degerlerden birini secerek buraya yazacagiz.
//								alignY: 0,
								startSpan: 'span1',
								onSlide: function(v) { updateSlider1(v); },
								onChange: function(v) { updateSlider1(v); }
							});



							function updateSlider1(value) {
								$('progressPercent').value = Math.round(value/slider1.maximum*100) + '';
								$('progressPercentShow').innerHTML = Math.round(value/slider1.maximum*100) + '%';

							}



					// ]]>
					{/literal}
					</script>







			</td>
		</tr>
<!--
		<tr class="row2">
			<td align="right" valign="top"><b>{$LNG_request_attachment}: </b></td>
			<td colspan="3"><input type="file" name="userfile" s�ze="30" >&nbsp; </td>
		</tr>
-->
		<tr class="row2">
			<td height="40" colspan="4" align="center">
				<input name="submitForm" type="button" id="submit" value="{$LNG_submit}" onclick="process_form(); return false;">
			</td>
		</tr>
	</table>
</form>
