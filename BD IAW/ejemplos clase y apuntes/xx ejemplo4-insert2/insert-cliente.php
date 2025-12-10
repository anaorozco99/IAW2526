<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insertar Cliente</title>
</head>
<body>
    <h2>Formulario para insertar cliente</h2>
    <form method="post" action="action-insert-cliente.php">
        <label for="nombre">Nombre:</label><br>
        <input type="text" name="nombre" required><br><br>

        <label for="correo">Correo:</label><br>
        <input type="email" name="correo" required><br><br>

        <input type="submit" value="Insertar">
    </form>

<?php

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    echo "<hr/>";
    $nombre = $_POST["nombre"];
    $correo = $_POST["correo"];

    // Incluimos el servicio de base de datos, que nos permite conectarnos.
    include_once 'DatabaseService.php';

    // Creamos una instancia del servicio de base de datos.
    $databaseService = new DatabaseService();

    // Nos conectamos a la base de datos.
    $connection = $databaseService->getConnection();

    // Creamos la consulta que nos da todos los clientes.
    $query = "insert into clientes (nombre, correo) values (:nombre, :correo)";

    $stmt = $connection->prepare($query);
    $stmt->bindParam(":nombre", $nombre);
    $stmt->bindParam(":correo", $correo);

    $resultadoDeLaInsercionDelCliente = $stmt->execute();

    /**
     * // Esta orden es equivalente a las tres anteriores:
     * resultadoDeLaInsercionDelCliente = $stmt->execute(['nombre' => $nombre, 'correo' => $correo]);
     */

    // Dependiendo del resultado mostramos un mensaje u otro
    if ($resultadoDeLaInsercionDelCliente) {
        echo "<p>Cliente insertado correctamente: $nombre y $correo.</p>";
    }
    else {
        echo "<p>Error al insertar el cliente.</p>";
    }

    // Obtener el ID del último cliente insertado
    $query = "SELECT LAST_INSERT_ID();";
    $stmt = $connection->prepare($query);
    $stmt->execute();
    $lastInsertedId = $stmt->fetch();

    echo "<p>El ID del último cliente insertado es: " . $lastInsertedId[0] . "</p>";
}
?>

</body>
</html>