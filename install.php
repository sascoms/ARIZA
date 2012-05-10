<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>ARIZA Installation</title>

	<style>
		body {
			font-family: verdana,arial, helvetica;
			font-size: 9pt;
		}
		table th {
			background-color: lightblue;
			text-align:left;
			font-size: 140%;
			color: #666;
		}
		table td.label {
			background-color: #eee;
			text-align:right;
		}
		table td.content {
			background-color: lightyellow;
		}
		table td.buttons {
			background-color: #ccc;
		}
	</style>
</head>

<body>


	<table cellpadding="2" cellspacing="2" border="0" width="70%" align="center">
	<tr>
		<th colspan="2">Permissions</th>
	</tr>
	<tr>
		<td width="30%" class="label">Directory is writable?</td>
		<td class="content">
			<?php echo ((is_writable('definitions.php') === true) ? 'yes': 'no');?>
		</td>
	</tr>

	<tr>
		<th colspan="2">DB Parameters</th>
	</tr>
	<tr>
		<td class="label">DB Host</td>
		<td class="content">
			<input type="text" name="dbhost" id="dbhost" value="<?php echo $form['dbhost'];?>" />
		</td>
	</tr>
	<tr>
		<td class="label">DB Name</td>
		<td class="content">
			<input type="text" name="dbname" id="dbname" value="<?php echo $form['dbname'];?>" />
		</td>
	</tr>
	<tr>
		<td class="label">DB Username</td>
		<td class="content">
			<input type="text" name="dbuser" id="dbuser" value="<?php echo $form['dbuser'];?>" />
		</td>
	</tr>
	<tr>
		<td class="label">DB Password</td>
		<td class="content">
			<input type="text" name="dbpass" id="dbpass" value="<?php echo $form['dbpass'];?>" />
		</td>
	</tr>



	<tr>
		<th colspan="2">E-mail</th>
	</tr>
	<tr>
		<td class="label">Site e-mail address</td>
		<td class="content">
			<input type="text" name="site_email" id="site_email" value="<?php echo $form['site_email'];?>" />
		</td>
	</tr>
	<tr>
		<td class="label">Admin e-mail address</td>
		<td class="content">
			<input type="text" name="admin_email" id="admin_email" value="<?php echo $form['admin_email'];?>" />
		</td>
	</tr>

	<tr>
		<td class="buttons">&nbsp;</td>
		<td class="buttons">
			<input type="submit" name="submit" id="submit" value="Install" />
		</td>
	</tr>

	</table>


</body>
</html>