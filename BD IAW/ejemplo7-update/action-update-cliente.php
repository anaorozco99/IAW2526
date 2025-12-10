<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
</head>
<body>

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

    include_once "DatabaseService.php";
    $databaseService = new DatabaseService();
    $connection = $databaseService->getConnection();
    $query = "update clientes set nombre = :nombre, correo = :correo, fecha_registro = :fechaRegistro where id = :id";
    $stmt = $connection->prepare($query);
    $stmt->bindParam(':id', $idCliente);
    $stmt->bindParam(':nombre', $nombreCliente);
    $stmt->bindParam(':correo', $correoCliente);
    $stmt->bindParam(':fechaRegistro', $fechaRegistroCliente);
    $resultadoUpdate = $stmt->execute();

    if ($resultadoUpdate) {
        echo "<p>Cliente con ID $idCliente actualizado correctamente con los valores ($nombreCliente, $correoCliente, $fechaRegistroCliente).</p>";
    } else {
        echo "<p>Error al modificar el cliente con ID: $idCliente ($nombreCliente, $correoCliente, $fechaRegistroCliente).</p>";
    }
}
else {
    // Si no se ha recibido la petición correcta, mostramos un mensaje de error.
    echo "<p style='color:red;'>No se han recibido los datos del cliente a modificar.</p>";
}
?>

<hr/>
<p><button onclick="history.back()" type="button">Volver atrás</button></p>

</body>
</html>
