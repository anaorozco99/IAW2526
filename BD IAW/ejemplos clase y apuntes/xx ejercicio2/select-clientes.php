<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consultar clientes</title>
</head>
<body>

<?php

// Incluimos el servicio de base de datos, que nos permite conectarnos.
include_once 'DatabaseService.php';

// Creamos una instancia del servicio de base de datos.
$databaseService = new DatabaseService();

// Nos conectamos a la base de datos.
$connection = $databaseService->getConnection();

// Creamos la consulta que nos da todos los clientes.
$query = "select * from clientes";

// Ejecutamos la consulta.
$stmt = $connection->query($query);

// Obtenemos todos las filas resultado de la consulta. En este caso son nuestros clientes
$clientes = $stmt->fetchAll();

// Mostrar resultados
echo "<h2>Lista de clientes</h2><ul>";

echo "<table border='1'>";
echo "<tr><th>ID</th><th>Nombre</th><th>Correo</th></tr>";


foreach ($clientes as $cliente) {
    echo "<tr>";
    echo "<td>{$cliente['id']}</td><td>{$cliente['nombre']}</td><td>{$cliente['correo']}</td>";
    echo "</tr>";
}

echo "</table>";

echo "<button type='button' onclick='history.back()'>Volver</button>";

?>

</body>
</html>