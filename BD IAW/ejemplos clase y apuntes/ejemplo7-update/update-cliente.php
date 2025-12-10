<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modificar Cliente</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin-left: 80px;
            margin-right: 80px;
        }

        label {
            font-weight: bold;
        }

        form {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h1>Formulario para modificar un cliente</h1>
<?php

    // Si se ha enviado petición de borrado
    if ($_SERVER["REQUEST_METHOD"] === "POST"
        && isset($_POST["id"])
        && isset($_POST["nombre"])
        && isset($_POST["correo"])
        && isset($_POST["fechaRegistro"]))
    {
        $idCliente = $_POST["id"];
        $nombreCliente = $_POST["nombre"];
        $correoCliente = $_POST["correo"];
        $fechaRegistroCliente = $_POST["fechaRegistro"];
?>

    <p>El cliente a modificar es el siguiente:</p>
    <ul>
        <li>ID: <?= $idCliente ?></li>
        <li>Nombre: <?= $nombreCliente ?></li>
        <li>Correo: <?= $correoCliente ?></li>
        <li>Fecha de registro: <?= $fechaRegistroCliente ?></li>
    </ul>

    <hr/>

    <form method="post" action="action-update-cliente.php">
        <input type="hidden" name="id" value="<?= $idCliente ?>">

        <label for="nombre">Nombre:</label><br>
        <input type="text" name="nombre" value="<?= $nombreCliente ?>" required><br><br>

        <label for="correo">Correo:</label><br>
        <input type="email" name="correo" value="<?= $correoCliente ?>" required><br><br>

        <label for="fechaRegistro">Fecha de registro:</label><br>
        <input type="text" name="fechaRegistro" value="<?= $fechaRegistroCliente ?>" required><br><br>

        <input type="submit" value="Modificar el cliente">
    </form>
<?php
    } else {
        // Si no se ha recibido la petición correcta, mostramos un mensaje de error.
        echo "<p style='color:red;'>No se han recibido los datos del cliente a modificar.</p>";
    }
?>
    <hr/>
    <p><button onclick="history.back()" type="button">Volver atrás</button></p>
</body>
</html>