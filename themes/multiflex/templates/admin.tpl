

		<fieldset id="id_operationRes" style="background-color: lightyellow; display:{if $admOperationResDivVis != ''}{$admOperationResDivVis}{else}none{/if};margin:10px;padding:10px; color: brown; font-weight:bold;">
			{$operationResMsg}
		</fieldset>




		<form name="ChangeLangForm" id="idChangeLangForm" method="post" action="">
		 <fieldset id="idChangeLang" style="background-color: #efefef">
			 <legend>{$LNG_changeLang}:</legend>
			 <div style="margin:10px;">
				<span class=""><strong>{$LNG_currentLangFile}</strong>:</span>
				<span id="idCurrentLang" class=""><em><strong>{$currentLangFile}</strong></em></span>
			 {if is_array($langFilesArr)}
			 <br />
			<br />

			 	{$LNG_availableLangFiles}:
		 	     	<select name="langFileName" id="idlangFileName" size="1">
			 	     {foreach key=key item=value from=$langFilesArr}
		 	     		<option value="{$key}">{$key}</option>
				     {/foreach}
		 	     	</select>
		 	     	<!--
						<input type="submit" name="ChangeLangSubmit" name="idChangeLangSubmit" value="{$LNG_submit}" class="noborder" onclick="javascript:ajaxPerformer('changeSiteLang', 'idChangeLangForm', 'idlangFileName', 'idCurrentLang');return false;">
					-->
					<input type="submit" name="ChangeLangSubmit" name="idChangeLangSubmit" value="{$LNG_submit}" class="noborder"">
					<br />
					<strong style="color: brown;"><em>{$LNG_site_options_activation_msg}</em></strong>

			 {else}
				<div id="idLangFileErrMsg" class="small">
				 	&nbsp;&nbsp;&nbsp;{$LNG_langFilesError}
			 	</div>
			 {/if}
			 </div>


		</fieldset>
		</form>

		<form name="changeSiteOptionsForm" id="idChangeSiteOptionsForm" method="post" action="">
		 <fieldset id="idChangeSiteTitle" style="background-color: #efefef">
			 <legend>{$LNG_change_site_settings}:</legend>

				<fieldset id="id_optionsOperationRes" style="background-color: lightyellow; display:none;margin:10px;padding:10px; color: brown; font-weight:bold;">
					{$operationResMsg}
				</fieldset>


			 <div style="margin:10px;">
			 	<div style="float:left;width:150px;"><strong>{$LNG_change_site_title}:</strong></div>
					<input type="type" name="site_title" id="site_title" value="{$siteOptions.site_title}" class="" size="50">
					<input type="submit" name="ChangeSiteTitleSubmit" id="idChangeSiteTitleSubmit" value="{$LNG_submit}" class="noborder"
							onclick="javascript:ajaxPerformerInput('changeSiteOptions', 'idChangeSiteOptionsForm', 'site_title', 'idNewSiteTitle', 'id_optionsOperationRes');return false;">
			 </div>

			 <div style="margin:10px;">
			 	<div style="float:left;width:150px;"><strong>{$LNG_change_site_header}:</strong></div>
					<input type="type" name="site_header" id="site_header" value="{$siteOptions.site_header}" class="" size="50">
					<input type="submit" name="ChangeSiteHeaderSubmit" name="idChangeSiteHeaderSubmit" value="{$LNG_submit}" class="noborder"
							onclick="javascript:ajaxPerformerInput('changeSiteOptions', 'idChangeSiteOptionsForm', 'site_header', 'idNewSiteHeader', 'id_optionsOperationRes');return false;">
			 </div>

			 <div style="margin:10px;">
			 	<div style="float:left;width:150px;"><strong>{$LNG_change_site_slogan}:</strong></div>
					<input type="type" name="site_slogan"id="site_slogan" value="{$siteOptions.site_slogan}" class="" size="50">
					<input type="submit" name="ChangeSiteSloganSubmit" id="idChangeSiteSloganSubmit" value="{$LNG_submit}" class="noborder"
							onclick="javascript:ajaxPerformerInput('changeSiteOptions', 'idChangeSiteOptionsForm', 'site_slogan', 'idNewSiteSlogan', 'id_optionsOperationRes');return false;">
			 </div>




			</fieldset>
		</form>
