<?php

// Incluimos el servicio de base de datos, que nos permite conectarnos.
include_once 'DatabaseService2.php';

// Creamos una instancia del servicio de base de datos.
$databaseService = new DatabaseService();

// Creamos la consulta que nos da todos los clientes.
$query = "select * from clientes";

// Obtenemos todos las filas resultado de la consulta. En este caso son nuestros clientes
$clientes = $databaseService->fetchAll($query);

// Mostrar resultados
echo "<h2>Lista de clientes</h2><ul>";
foreach ($clientes as $cliente) {
    echo "<li>{$cliente['id']}: {$cliente['nombre']} ({$cliente['correo']})</li>";
}
echo "</ul>";

