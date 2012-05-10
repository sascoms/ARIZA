<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<!--  Version: Multiflex-1.1 Update-1                          -->
<!--  Date:    December 4, 2006                                -->
<!--  Author:  G. Wolfgang                                     -->
<!--  License: Fully open source without restrictions.         -->
<!--           Please keep footer credits with a link to       -->
<!--           Wolfgang (www.1234.info). Thank you!         -->
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="description" content="ARIZA is a bug/request/feature/issue tracking system" />
  <meta name="keywords" content="ariza, bug tracker, bugtracker, track, trak, issue, bug" />
  <meta name="author" content="Design: Wolfgang (www.1234.info) / Modified: ariza / Programming: eser sahillioglu" />
  <link rel="stylesheet" type="text/css" media="screen" href="{$themePath}/css/main.css" />
  <title>{$siteOptions.site_title}</title>
        <script type="text/javascript" src="{$libraryPath}generalFuncs.js"></script>
</head>
<body>
	<!-- LOADING MSGS BOX STARTS -->
		<span><div id="rc_notify"></div></span>
	<!-- LOADING MSGS BOX ENDS -->


  <div class="page-container">
  	<!-- HEADER -->
    <!-- Global Navigation -->
    <div class="top-left-menu-container">
      <div class="top-left-menu">
			  <ul>
    		    <li><a href="#">home</a></li>
    		    <li><a href="#">contact</a></li>
         		<li><a href="#">about us</a></li>
	          <li><a href="#"><img class="img-flag" src="{$themePath}/img/flag_uk.gif" title="Website in English" alt="" /></a></li>
	          <li><a href="#"><img class="img-flag" src="{$themePath}/img/flag_spain.gif" title="Website en Espanol" alt="" /></a></li>
	          <li><a href="#"><img class="img-flag" src="{$themePath}/img/flag_france.gif" title ="Website en Francais" alt="" /></a></li>
	          <li><a href="#"><img class="img-flag" src="{$themePath}/img/flag_germany.gif" title ="Website auf Deutsch" alt="" /></a></li>
        </ul>
	  </div>
    </div>


    <!-- Sitename and Banner -->
		<div class="site-name">
		  {$siteOptions.site_header}
		  <div class="site-slogan">
				{$siteOptions.site_slogan}
			</div>
		</div>
		<div><img class="img-header" src="{$themePath}/img/header.gif" alt=""/></div>

<!-- Main Navigation -->
    <div class="nav-main">
    	<!--<span style="float:right">{$smarty.now|date_format}</span>-->
		<ul>
			{foreach key=key item=values from=$menuLinks}
				{if $values.display==1}
					<li><a href="index.php?job={$key}"{if $key==$jobAction} class="selected" {else}{/if}>{$values.name}</a></li>
				{/if}
			{/foreach}

				{if $isAdmin==1}
					<li><a href="index.php?job=admin"{if $jobAction=='admin'} class="selected" {else}{/if}>{$menuLinks.admin.name}</a></li>
				{/if}

				{if $isAuthenticated==1}
					<li><a href="index.php?job=out"{if $jobAction=='out'} class="selected" {else}{/if}>{$menuLinks.out.name}</a></li>
				{/if}
		  </ul>
		</div>
		<div class="buffer"></div>

  	<!-- FRONT PAGE SIDEBANNER -->

  	<!-- WRAP CONTENT AND SIDEBAR -->
<div class="container-content-sidebar-front">



