<?php

include('include/include.database.php');
require_once('include/include.header.php');

session_start();

if(!isset($_SESSION['zalogowany']))
	header('Location: logowanie.php');
else {
?>
sukces
<?php
}

require_once('include/include.footer.php');

?>