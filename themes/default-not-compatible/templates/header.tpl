<html>
<head>
<title>{$siteTitle}</title>
<meta http-equiv="Content-Type" CONTENT="text/html; charset=utf-8">
<style type="text/css" media="screen">@import url({$themePath}/styles/main.css);</style>
<style type="text/css">
<!--
	
-->
</style>
</head>
<body>
<div id="navcontainer">
<ul id="navlist">
		
	{foreach key=key item=value from=$MenuLinks}		
		<li><a href="index.php?job={$key}"{if $key==$jobAction} id="current" {else}{/if}>{$value}</a></li>
	{/foreach}

</ul>
</div>