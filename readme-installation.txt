FOR SUBVERSION USERS:
-YOU MAY FIND SOME BUGS (forward them to me please: sascoms at gmail dot com)

---------------------------------------------------------------------------------------------------------------
REQUIREMENTS

1. ARIZA requires pear mdb2 and smarty packages. By default, these packages are included in /library/pear folder.
You can have more information about these pear packages used in ARIZA:
	-PEAR: pear.php.net
	-MDB2: http://pear.php.net/package/MDB2
	-Smarty: http://smarty.php.net/

NOTICE:
-Tested only with mysql.
-themes/theme_name/templates_c must have write permissions. Since smarty use these folder for template cache.

INSTALLATION:

1. create a database called ariza_db. you are free to create the db with any name you like,
but don't forget to change the database name as explained in step 3 below.

2. open config.php

3. edit the lines below for db connection
	$dsn = array(
	    'phptype'  => 'mysql', //--> if you will use a dbms other than mysql, then change phptype variable accordingly.
	    'username' => 'root',  //--> change your database user name
   	    'password' => '',	//--> change your database user password
  	    'database' => 'ariza_db', //--> if you created the database with a name other then ariza_db, then change this setting, too.


4. import sql dump file (sql files are in /sql folder).
you can check other available sql dump files (located under /sql). More sql files other than mysql will be added in the future releases.
Note that: Only mysql sql dump file is tested. Please use the other ones on your own risk.

5. browse to your new "ariza" url

6. your default user with admin rights is
	username: admin
	password: admin

	dummy user I:
		username: demet
		password: demet
	dummy user II:
		username: berrak
		password: berrak

7. you can send any suggesstions, bugs, requests to sascoms [at] gmail.com

http://demos.satt.web.tr/ariza | http://ariza.sourceforge.net