<!DOCTYPE html> <!-- DOCTYPE en mayúsculas y formato moderno -->
<html lang="es"> <!-- Añadir idioma -->
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- Para responsive -->
<title>Documento sin título</title>
<style>
	h1{
		text-align:center;
	}

	table{
		background-color:#FFC;
		padding:5px;
		border:#666 5px solid;
		width: 15%; /* Movido de atributo HTML a CSS */
		margin: 0 auto; /* Reemplaza align="center" */
	}
	
	/* Centrar tabla */
	form {
		display: flex;
		justify-content: center;
	}
	
	/* Centrar celdas */
	.centrado {
		text-align: center;
	}
	
	.no_validado{
		font-size:18px;
		color:#F00;
		font-weight:bold;
	}
	
	.validado{
		font-size:18px;
		color:#0C3;
		font-weight:bold;
	}

</style>
</head>

<body>
<h1>USANDO OPERADORES COMPARACIÓN</h1>

<form action="" method="post" name="datos_usuario" id="datos_usuario">
  <table>
    <tr>
      <td>Nombre:</td>
      <td>
        <label for="nombre_usuario"></label> <!-- Label vacío puede quitarse o añadir texto -->
        <input type="text" name="nombre_usuario" id="nombre_usuario">
      </td>
    </tr>
    <tr>
      <td>Edad:</td>
      <td>
        <label for="edad_usuario"></label>
        <input type="text" name="edad_usuario" id="edad_usuario">
      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td colspan="2" class="centrado"> <!-- Reemplaza align="center" con clase CSS -->
        <input type="submit" name="enviando" id="enviando" value="Enviar">
      </td>
    </tr>
  </table>
</form>

<?php

if(isset($_POST["enviando"])){

    $usuario=$_POST["nombre_usuario"];
    $edad_usuario=$_POST["edad_usuario"];

    if($usuario=="Ana" && $edad>=18){
      echo "<p class=\"validado\">Puedes entrar</p>";
    }else{
      echo "<p class=\"no_validado\">No puedes entrar</p>";

    }

}



?>






</body>
</html>