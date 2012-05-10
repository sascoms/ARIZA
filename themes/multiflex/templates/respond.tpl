
<link rel="stylesheet" type="text/css" media="all" href="{$libraryPath}calendar/calendar-win2k-cold-1.css" title="win2k-cold-1" />
<script type="text/javascript" src="{$libraryPath}calendar/calendar.js"></script>
<script type="text/javascript" src="{$libraryPath}calendar/calendar-{$siteLanguage}.js"></script>
<script type="text/javascript" src="{$libraryPath}calendar/calendar-setup.js"></script>


<script src="{$libraryPath}scriptaculous/lib/prototype.js" type="text/javascript"></script>
<script src="{$libraryPath}scriptaculous/src/scriptaculous.js" type="text/javascript"></script>

<script type="text/javascript" src="{$libraryPath}generalFuncs.js"></script>
<script src="{$libraryPath}validation/apple_formvalidation.js" type="text/javascript"></script>


<script type="text/javascript">
		    var error_alert_title = '{$LNG_js_check_the_errors_below}';
		    var empty_field_error = '{$LNG_js_required_field_value}';
		    var no_option_selected_error = '{$LNG_js_no_option_selected}';

			var response_insert_success = '{$LNG_response_insert_success}';
			var response_insert_failure = '{$LNG_response_insert_failure}';

			var ajax_processing_operation = '{$LNG_ajax_processing_operation}';

		    var bug_status = '{$LNG_bug_status}';
		    var response_text 		= '{$LNG_response_text}';
		    var solved_datetime 	= '{$LNG_solved_datetime}';


  {literal}
		function process_form() {
			 var res = validateForm();
			 if (res == true) {
			 	insert_response();
			 }
		}

		function validateForm() {
		    var errors = "";

		    errors += checkDropdown('statusId', bug_status, no_option_selected_error);

		    errors += isEmpty('response_text', response_text, empty_field_error);
		    //errors += isEmpty('idSolvedDatetime', solved_datetime, empty_field_error);

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

/*	function createHTMLNode(obj, htmlCode) {
	    obj.innerHTML = htmlCode;
	    return;
	}
*/
	function insertResponseFieldset(data) {
		//alert(data);

		var xObj;
		xObj = document.createElement('fieldset');
		xObj.className = 'replies';
		xObj.id = 'responseId_' + data.result.responseID;
		//alert(1)

		var xLegend = document.createElement('legend');
		xLegend.appendChild(document.createTextNode(data.result.staffFullName));
		xObj.appendChild(xLegend);
		//alert(2)

		var xResponseText = document.createElement('div');
		xResponseText.className = 'response_text';
		xResponseText.innerHTML = data.result.responseText;
		//xResponseText.appendChild(document.createTextNode(data.result.responseText));
		xObj.appendChild(xResponseText);
		//alert(3)

		var xDateTime = document.createElement('div');
		xDateTime.className = 'small align-right';
		xDateTime.appendChild(document.createTextNode(data.result.bugStatus + ' | ' + data.result.responseDateTime));
		xObj.appendChild(xDateTime);
		//alert(4)

		document.getElementById('idResponseList').appendChild(xObj);
		//alert(5)
	}

  function insert_response() {
		  	var bug_id =  $('bug_id').value;
		  	var statusObj = document.getElementById('statusId');
		  		var statusId = statusObj.value;
		  		var statusText = statusObj[statusObj.selectedIndex].text;

		  	var progressPercentCurrentValue = $('progressPercent').value;
			  	if (isNaN(progressPercentCurrentValue)) {
			  		progressPercentCurrentValue = 0;
			  	} else {
			  		progressPercentCurrentValue = ( (progressPercentCurrentValue * 1) / (100/20) );
			  	}	//alert(progressPercentCurrentValue)

		var postString = Form.serialize('idAddResponseForm'); //alert(postString);  	//return;
	  	var options = {
	   	    method: 'post', // Use POST
	    	postBody: postString,
	    	onSuccess: function(t) { //alert(t.responseText);
	    		var x = t.responseText;
    			var resultData = eval('(' + t.responseText + ')'); //alert(resultData.result.errorCode);

	        	if (resultData.result.errorCode == '0') { //successful
	        		Element.hide('idAddResponseFormRow');
	        		Element.hide('idFinishedDatetime');
	        		Element.hide('hideFormLink');
	        		Element.show('showFormLink');

	        		Element.update('id_status_'+bug_id, statusText);

					slider1.setValue(progressPercentCurrentValue);
//					alert($('progressPercentShow1').value)
					$('progressPercentShow1').innerHTML = $('progressPercentShow2').innerHTML;

					Element.update('idNoResponse', '');
	    			insertResponseFieldset(resultData);

	        		var msg = response_insert_success + '<br />'
	    			Element.update('id_operationRes', msg);
	        		Element.show('id_operationRes');
	        		//new Insertion.Bottom('idResponseList', eval('(' + newResponseFieldset + ')'));

	        	} else { //has error
	        		Element.update('id_operationRes', response_insert_failure);
	        		Element.show('id_operationRes');
	        		alert(response_insert_failure + "\n" + resultData.result.errorMSG);
	        	}
	    	},
	    	on404: function(t) { // Handle 404
	        	alert('Error 404: location "' + t.statusText + '" was not found.');
	    	},
	    	onFailure: function(t) {// Handle other errors
	        	alert('Error ' + t.status + ' -- ' + t.statusText);
	    	}
		}
	new Ajax.Request('index.php?job=ajjb&do=respond', options);
  }


  {/literal}
</script>
  <br />

<div id="id_operationRes" class="operationResultMsg" style="display:none;" align="center"></div>
<br />

<table id="bugDetails" width="100%" class="classic" cellspacing="1" cellpadding="1">
    <tr>
      <th class="cellTitle align-left" colspan="4">{$LNG_details}: {$bugInfo.bug_title} [{$bugInfo.bug_id}] </th>
    </tr>
    <tr>
      <td class="row1 align-right bold" width="25%">{$LNG_request_owner} </td>
      <td class="row3">{$bugInfo.sender_fullname}      </td>
      <td class="row1 align-right bold" width="20%">{$LNG_version}</td>
      <td class="row3" width="25%">{$bugInfo.version_title}    &nbsp;  </td>
    </tr>
    <tr>
      <td class="row1 align-right bold">{$LNG_request_report_datetime}</td>
      <td class="row3">{$bugInfo.reported_datetime}      </td>
      <td class="row1 align-right bold">
      		{$LNG_completed_percentage}
      </td>
      <td class="row3">
					<!-- need this wrap so that 'span' can exist and the track is still easily clickable by the mouse -->
					<div id="wrap1" style="float:left; left:20px;width: 100px; background-color: #ccc; height: 20px; border: 0px solid black;">
						<div id="span1" style="float: left; background-color: lightgreen; height: 20px; border: 0px solid blue;">
							<div id="track1" style="width: 100px; height: 20px; position: absolute; border: 0px solid white;">
								<div id="handle1" style="position: absolute; width: 10px; height: 25px; background-color: #f00; cursor: col-resize;"></div>
							</div>
						</div>
					</div>
					&nbsp;
					<span id="progressPercentShow1">{$bugInfo.progress_percent}%</span>

					<script type="text/javascript" language="javascript">
						var current_percentage = {$bugInfo.progress_percent};
						var current_slider_value = ( (current_percentage * 1) / (100/20) );

						{literal}
						// <![CDATA[
						  		//alert(current_slider_value);

						  	if (isNaN(current_slider_value)) {
						  		current_slider_value = 0;
						  	}
							// horizontal slider control
								var slider1 = new Control.Slider('handle1', 'track1', {
									range: $R(0,20),
									values: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20],
									sliderValue: current_slider_value ,//eger default bir degere getirmek istiyorsak o zaman yukaridaki degerlerden birini secerek buraya yazacagiz.
									disabled: true,
									startSpan: 'span1'
								});


						// ]]>
						{/literal}
					</script>


      	</td>
    </tr>
    <tr>
      <td class="row1 align-right bold">{$LNG_bug_status} </td>
      <td class="row3" id="id_status_{$bugInfo.bug_id}">{$bugInfo.status}</td>
      <td class="row1 align-right bold">{$LNG_request_attachment}</td>
      <td class="row3">{$bugInfo.uploaded_file}&nbsp;</td>
    </tr>
    <tr>
      <td class="row1 align-right bold" valign="top">{$LNG_request_explanation}</td>
      <td class="row3" colspan="3">
      	{$bugInfo.bug_description}
      </td>
    </tr>
    <tr>
      <td class="row1 align-right bold" valign="top">{$LNG_steps_caused_bug}</td>
      <td class="row3" colspan="3">
      	{$bugInfo.bug_steps}
      </td>
    </tr>
    <tr>
      <td class="row1 align-right bold" valign="top">{$LNG_suggested_solutions}</td>
      <td class="row3" colspan="3">
      	{$bugInfo.possible_solution}
      </td>
    </tr>
    {if $bugInfo.is_solved == 0}
	    <tr id="idHideShowFormLinks">
	      <th colspan="3" class="row4 align-left">
	      	{$LNG_respond}
	      </th>
	      <th class="row4 align-right">
	      	<div id="hideShowRespondForm">

	      		<a id="showFormLink" href="javascript:void(0);" 					  onclick="Element.show('idAddResponseFormRow', 'hideFormLink'); Element.show('hideFormLink'); Element.hide('showFormLink'); ">{$LNG_show}</a>
	      		<a id="hideFormLink" href="javascript:void(0);" style="display:none;" onclick="Element.hide('idAddResponseFormRow','idFinishedDatetime'); Element.hide('hideFormLink'); Element.show('showFormLink');  ">{$LNG_hide}</a>
			</div>

	      </th>
	    </tr>

	    <tr id="idAddResponseFormRow" style="display:;">
	      <td colspan="4" class="row2">



			<form name="idAddResponseForm" method="post" action="" id="idAddResponseForm">

				<input type="hidden" name="bug_id" id="bug_id" value="{$bugInfo.bug_id}">
				<input name="staffId" id="staffId" type="hidden" value="{$userData.staff_id}">
				<input name="staffFullname" id="staffFullname" type="hidden" value="{$userData.staff_name} {$userData.staff_surname}">

				<table width="100%" border="0" cellspacing="1" cellpadding="1" class="classic">
					<tr>
						<td class="row1" width="30%">
							&nbsp;{$LNG_bug_status}
						</td>
						<td class="">
							<select name="statusId" id="statusId" size="1" class="selectbox">
								{foreach key=key item=value from=$statuses}
									<option value="{$key}"{if $key==$bugInfo.status_id} selected {else}{/if}>{$value}</option>
								{/foreach}
							</select>
							<a href="javascript:void(0);" onclick="$('idFinishedDatetime').toggle();">{$LNG_enter_solved_datetime}</a>
						</td>
					</tr>

					<tr id="idFinishedDatetime" style="display:none;">
						<td class="row1">
							&nbsp;{$LNG_solved_datetime}
						</td>
						<td class="">
							<input type="text" name="solvedDatetime" id="idSolvedDatetime" maxlength="16" readonly="readonly" value="" />
							<button type="reset" id="f_trigger_date">...</button>
							{literal}
							<script type="text/javascript">
							    Calendar.setup({
							    	showsTime      :    true,
							    	timeFormat     :    '24',
							        inputField     :    "idSolvedDatetime",     // id of the input field
							        ifFormat       :    "%Y-%m-%d %H:%M",     // format of the input field (even if hidden, this format will be honored)
							        displayArea    :    "show_e",       // ID of the span where the date is to be shown
							        daFormat       :    "%d %B %Y %A ",// format of the displayed date
							        button         :    "f_trigger_date",  // trigger button (well, IMG in our case)
							        align          :    "Tl",           // alignment (defaults to "Bl")
							        singleClick    :    true
							    });
							</script>
							{/literal}
				      		<a href="javascript:void(0);" onclick="$('idFinishedDatetime').toggle();updateElement('idSolvedDatetime', '');">{$LNG_close}</a> |
				      		<a href="javascript:void(0);" onclick="updateElement('idSolvedDatetime', '');">{$LNG_clear}</a>
						</td>
					</tr>

					<tr>
						<td class="row1" valign="top">
							&nbsp;{$LNG_response_text}
						</td>
						<td class="">
							<textarea name="response_text" rows="6" id="response_text"></textarea>
						</td>
					</tr>

					<tr>
						<td class="row1" valign="top">
							&nbsp;{$LNG_response_text}
						</td>
						<td class="">
							<input name="progressPercent" type="hidden" id="progressPercent" value="{$bugInfo.progress_percent}">

							<!-- need this wrap so that 'span' can exist and the track is still easily clickable by the mouse -->
							<div id="wrap2" style="float:left; left:20px;width: 240px; background-color: #ccc; height: 20px; border: 0px solid black;">
								<div id="span2" style="float: left; background-color: lightgreen; height: 20px; border: 0px solid blue;">
									<div id="track2" style="width: 240px; height: 20px; position: absolute; border: 0px solid white;">
										<div id="handle2" style="position: absolute; width: 10px; height: 25px; background-color: #f00; cursor: col-resize;"></div>
									</div>
								</div>
							</div>
							&nbsp;
							<span id="progressPercentShow2">{$bugInfo.progress_percent}%</span>

							<script type="text/javascript" language="javascript">
							{literal}
							// <![CDATA[
								// horizontal slider control
									var slider2 = new Control.Slider('handle2', 'track2', {
										range: $R(0,20),
										values: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20],
										sliderValue: current_slider_value ,//eger default bir degere getirmek istiyorsak o zaman yukaridaki degerlerden birini secerek buraya yazacagiz.
		//								alignY: 0,
										startSpan: 'span2',
										onSlide: function(v) { updateSlider2(v); },
										onChange: function(v) { updateSlider2(v); }
									});

									function updateSlider2(value) {
										$('progressPercentShow2').innerHTML = Math.round(value/slider2.maximum*100) + '%';
										$('progressPercent').value = Math.round(value/slider2.maximum*100) + '';

									}

							// ]]>
							{/literal}
							</script>


						</td>
					</tr>

					<tr>
						<td class="row4 align-center" colspan="2">
							<input name="button" type="button" id="submit" value="{$LNG_submit}" onclick="process_form(); return false;">
						</td>
					</tr>
				</table>

	  	</form>

	   </td>
	   </tr>
   {/if}
 </table>







 <fieldset id="idResponseList">
	 <legend>{$LNG_replies}:</legend>

	 {if $responseTotal > 0}
	 	     {foreach key=key item=value from=$responseList}
			 		{$value}
		     {/foreach}
	 {/if}
		<div id="idNoResponse" class="small">
			 {if $responseTotal < 1}
			 	&nbsp;&nbsp;&nbsp;{$LNG_there_is_no_response}
			 {/if}
	 	</div>

</fieldset>
