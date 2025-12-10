<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

<?php

// Si se ha enviado petición de borrado
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST["id"])) {
    $idABorrar = $_POST["id"];

    include_once "DatabaseService.php";
    $databaseService = new DatabaseService();

    $connection = $databaseService->getConnection();
    $query = "delete from clientes where id = :id";
    $stmt = $connection->prepare($query);
    $stmt->bindParam(':id', $idABorrar);
    $resultadoBorrado = $stmt->execute();

    if ($resultadoBorrado) {
        echo "<p>Cliente con ID $idABorrar borrado correctamente.</p>";
    } else {
        echo "<p>Error al borrar el cliente con ID $idABorrar.</p>";
    }
}
else {
    echo "<p>No se ha proporcionado un ID de cliente para borrar.</p>";
}
?>

<hr/>
<p><button onclick="history.back()" type="button">Volver atrás</button></p>

</body>
</html>
