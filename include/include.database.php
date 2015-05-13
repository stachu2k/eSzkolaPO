<?php

function db_connect()
{
	$server_addr = "localhost:3306";
	$username = "root";
	$password = "";
	$database_name = "eszkola";

	mysql_connect($server_addr, $username, $password);
	mysql_select_db($database_name);
	mysql_query("set names utf8");
}

function db_disconnect()
{
	mysql_close();
}

?>