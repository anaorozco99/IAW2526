<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consultar Productos</title>
</head>
<body>

<?php
/*
========================================
EJERCICIO SELECT - CONSULTAR Y MOSTRAR DATOS
========================================

📋 QUÉ HACE ESTE ARCHIVO:
1. Se conecta a la base de datos
2. Hace un SELECT de todos los productos
3. Muestra los resultados en una tabla HTML

⚠️ QUÉ CAMBIAR SI TE PIDEN OTRA TABLA:
- Cambiar "productos" por el nombre de la tabla que te pidan
- Cambiar las columnas según la estructura de la tabla
- Cambiar los nombres de las variables
*/

// ========================================
// PASO 1: CONECTAR A LA BASE DE DATOS
// ========================================
// Esta parte es SIEMPRE IGUAL, no la toques

// Incluimos el servicio de base de datos
include_once 'DatabaseService.php';

// Creamos una instancia del servicio
$databaseService = new DatabaseService();

// Nos conectamos a la base de datos
$connection = $databaseService->getConnection();

// ========================================
// PASO 2: HACER LA CONSULTA SELECT
// ========================================

// ⚠️ CAMBIO 1: Nombre de la tabla
// Si te piden "clientes", cambia productos por clientes
// Si te piden "pedidos", cambia productos por pedidos
$query = "select * from productos";  // ← CAMBIAR "productos" por tu tabla

// Ejecutamos la consulta
$stmt = $connection->query($query);

// ⚠️ CAMBIO 2: Nombre de la variable (debe coincidir con la tabla)
// productos → $productos
// clientes → $clientes
// pedidos → $pedidos
$productos = $stmt->fetchAll();  // ← CAMBIAR "$productos" según tu tabla

// ========================================
// PASO 3: MOSTRAR LOS RESULTADOS
// ========================================

// Título
echo "<h2>Lista de productos</h2>";  // ← CAMBIAR "productos" por tu tabla

// Inicio de la tabla HTML
echo "<table border='1'>";

// ⚠️ CAMBIO 3: Encabezados de la tabla (columnas que vas a mostrar)
// Según la estructura de tu tabla, pon los nombres de las columnas
// Ejemplo para productos: ID, Nombre, Precio, Stock
// Ejemplo para clientes: ID, Nombre, Correo, Fecha Registro
// Ejemplo para pedidos: ID, Cliente ID, Fecha Pedido, Estado
echo "<tr><th>ID</th><th>Nombre</th><th>Precio</th><th>Stock</th></tr>";  // ← CAMBIAR columnas

// ⚠️ CAMBIO 4: Recorrer los resultados
// Cambia "$productos" y "$producto" según tu tabla:
// Para productos: foreach ($productos as $producto)
// Para clientes: foreach ($clientes as $cliente)
// Para pedidos: foreach ($pedidos as $pedido)
foreach ($productos as $producto) {  // ← CAMBIAR nombres de variables
    
    echo "<tr>";
    
    // ⚠️ CAMBIO 5: Mostrar las columnas de cada fila
    // Cambia según las columnas de tu tabla
    // IMPORTANTE: Usa el nombre de la variable del foreach ($producto, $cliente, $pedido)
    echo "<td>{$producto['id']}</td>";          // ← CAMBIAR $producto por tu variable
    echo "<td>{$producto['nombre']}</td>";      // ← CAMBIAR columnas
    echo "<td>{$producto['precio']}</td>";      // ← según tu tabla
    echo "<td>{$producto['stock']}</td>";       // ←
    
    echo "</tr>";
}

// Cerrar la tabla
echo "</table>";

// Botón para volver
echo "<button type='button' onclick='history.back()'>Volver</button>";

?>

</body>
</html>

<!--
========================================
📝 EJEMPLO DE CAMBIOS PARA OTRA TABLA
========================================

Si te piden hacer SELECT de la tabla CLIENTES:

1. Línea con $query:
   $query = "select * from clientes";

2. Línea con fetchAll():
   $clientes = $stmt->fetchAll();

3. Título:
   echo "<h2>Lista de clientes</h2>";

4. Encabezados tabla:
   echo "<tr><th>ID</th><th>Nombre</th><th>Correo</th><th>Fecha Registro</th></tr>";

5. Foreach:
   foreach ($clientes as $cliente) {

6. Mostrar columnas:
   echo "<td>{$cliente['id']}</td>";
   echo "<td>{$cliente['nombre']}</td>";
   echo "<td>{$cliente['correo']}</td>";
   echo "<td>{$cliente['fecha_registro']}</td>";

========================================
📋 CHECKLIST RÁPIDO PARA EL EXAMEN:
========================================

☐ 1. Miro la estructura de la tabla (qué columnas tiene)
☐ 2. Cambio el nombre de la tabla en SELECT
☐ 3. Cambio el nombre de la variable después de fetchAll()
☐ 4. Cambio el nombre en el foreach (la variable plural y singular)
☐ 5. Cambio los encabezados <th> de la tabla HTML
☐ 6. Cambio las columnas que muestro en el foreach

¡LISTO! ✅

-->
