  		<script src="{$libraryPath}scriptaculous/lib/prototype.js" type="text/javascript"></script>
  		<script src="{$libraryPath}scriptaculous/src/scriptaculous.js" type="text/javascript"></script>        
  
        <script type="text/javascript" src="{$libraryPath}/generalFunc.js"></script>
        <script type="text/javascript" src="{$libraryPath}/adminFuncs.js"></script>

<div id="id_operationRes">{$operationResMsg}</div>



<form name="ChangeLangForm" id="idChangeLangForm" method="post" action="">
 <fieldset id="idChangeLang">
	 <legend>{$LNG_changeLang}:</legend>
	 <div style="margin:10px;">
		<span class="currentOptionName">{$LNG_currentLangFile}:</span></strong> <span id="idCurrentLang" class="currentOptionValue">{$currentLangFile}</span>
	 {if is_array($langFilesArr)}
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
	 {else}
		<div id="idLangFileErrMsg" class="small">
		 	&nbsp;&nbsp;&nbsp;{$LNG_langFilesError}
	 	</div>
	 {/if}
	 </div>
	 
 
</fieldset>
</form>

<form name="ChangeLangForm" id="idChangeSiteTitleForm" method="post" action="">
 <fieldset id="idChangeSiteTitle">
	 <legend>{$LNG_changeLang}:</legend>
	 <div style="margin:10px;">
		<span class="currentOptionName">{$LNG_currentSiteTitle}:</span></strong> <span id="idCurrentSiteTitle" class="currentOptionValue">{$currentSiteTitle}</span>
			<input type="type" name="newSiteTitle" name="idNewSiteTitle" value="{$currentSiteTitle}" class="" size="50">		
			<input type="submit" name="ChangeSiteTitleSubmit" name="idChangeSiteTitleSubmit" value="{$LNG_submit}" class="noborder" onclick="javascript:ajaxPerformerInput('changeSiteTitle', 'idChangeSiteTitleForm', 'idNewSiteTitle', 'idCurrentSiteTitle');return false;">
	 </div>
	 
 
	</fieldset>
</form>
