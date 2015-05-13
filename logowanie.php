<?php

include('include/include.database.php');
require_once('include/include.header.php');

db_connect();

session_start();

if(isset($_SESSION['zalogowany']))
	header('Location: index.php');
else if(!empty($_POST))
{
	if(isset($_POST['name']) and isset($_POST['password']))
	{
		$sql = 'SELECT id FROM uzytkownicy WHERE pesel = "'.$_POST['name'].'" and haslo = "'.$_POST['password'].'";';
		$query = mysql_query($sql);

		if(mysql_num_rows($query)>0)
		{
			$row = mysql_fetch_assoc($query);
			$_SESSION['zalogowany'] = 'y';
			$_SESSION['user_id'] = $row['id'];

			header('Location: index.php');
		}
	}
}

else
{

?>
		<div class="login">
			<div style="margin:0 110px 0;">
				<h1>Logowanie</h1>
				<form action="logowanie.php" method="POST">
					<table>
						<tbody>
							<tr>
								<td>PESEL:</td>
								<td><input type="text" name="name" /></td>
							</tr>
							<tr>
								<td>Hasło:</td>
								<td><input type="text" name="password" /></td>
							</tr>
							<tr>
								<td colspan="2"><center><input type="submit" value="Zaloguj" /></center></td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
		</div>
<?php

}

require_once('include/include.footer.php');

db_disconnect();

?>