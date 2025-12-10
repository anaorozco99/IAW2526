<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado de Productos</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h1 {
            color: #333;
        }
        table {
            margin-top: 20px;
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #0078D7;
            color: white;
            text-align: left;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        button {
            margin-right: 5px;
            padding: 8px 12px;
            cursor: pointer;
            border: none;
            border-radius: 4px;
            color: white;
        }
        .btn-modificar {
            background-color: #5cb85c;
        }
        .btn-modificar:hover {
            background-color: #4cae4c;
        }
    </style>
</head>
<body>
    <!--
    ========================================
    EJERCICIO UPDATE - PASO 1: MOSTRAR LISTA
    ========================================
    
    📋 QUÉ HACE ESTE ARCHIVO:
    1. Muestra una lista de todos los productos
    2. Por cada producto, muestra un botón "Modificar"
    3. Al pulsar "Modificar", envía TODOS los datos a update-producto.php
    
    ⚠️ QUÉ CAMBIAR SI TE PIDEN OTRA TABLA:
    - Nombre de la tabla en el SELECT
    - Nombres de variables
    - Columnas que muestras en la tabla HTML
    - Campos que envías en el formulario (todos los campos de la fila)
    -->
    
    <h1>📦 Listado de Productos</h1>
    
    <table>
        <tr>
            <!-- ⚠️ CAMBIO 1: Encabezados según columnas de tu tabla -->
            <th>ID</th>
            <th>Nombre</th>
            <th>Precio</th>
            <th>Stock</th>
            <th>Acciones</th>
        </tr>

<?php
// ========================================
// CONECTAR Y HACER SELECT
// ========================================

include_once 'DatabaseService.php';
$databaseService = new DatabaseService();
$connection = $databaseService->getConnection();

// ⚠️ CAMBIO 2: Nombre de la tabla
// Para clientes: select * from clientes
// Para pedidos: select * from pedidos
$query = "select * from productos";  // ← CAMBIAR tabla

$stmt = $connection->query($query);

// ⚠️ CAMBIO 3: Nombre de la variable
$productos = $stmt->fetchAll();  // ← CAMBIAR variable

// ========================================
// RECORRER Y MOSTRAR CADA PRODUCTO
// ========================================

// ⚠️ CAMBIO 4: Variables en foreach
foreach ($productos as $producto) {  // ← CAMBIAR variables
    
    // Guardamos cada columna en una variable
    $id = $producto["id"];
    $nombre = $producto["nombre"];
    $precio = $producto["precio"];
    $stock = $producto["stock"];
    
    echo "<tr>";
    
    // ⚠️ CAMBIO 5: Mostrar las columnas
    echo "<td>$id</td>";
    echo "<td>$nombre</td>";
    echo "<td>" . number_format($precio, 2) . " €</td>";
    echo "<td>$stock</td>";
    
    echo "<td>";
?>
    
    <!-- ========================================
         FORMULARIO PARA MODIFICAR
         ======================================== -->
    
    <!-- ⚠️ CAMBIO 6: Nombre del archivo action -->
    <!-- Para clientes: action="update-cliente.php" -->
    <!-- Para pedidos: action="update-pedido.php" -->
    <form method="post" action="update-producto.php" style="display:inline;">
        
        <!-- ⚠️ CAMBIO 7: Enviar TODOS los campos de la fila como hidden -->
        <!-- IMPORTANTE: Necesitamos enviar TODOS los datos actuales -->
        <!-- Para que update-producto.php pueda mostrarlos en el formulario -->
        
        <!-- Para productos: id, nombre, precio, stock -->
        <input type="hidden" name="id" value="<?= $id ?>">
        <input type="hidden" name="nombre" value="<?= $nombre ?>">
        <input type="hidden" name="precio" value="<?= $precio ?>">
        <input type="hidden" name="stock" value="<?= $stock ?>">
        
        <!-- Para clientes sería: id, nombre, correo, fecha_registro -->
        <!-- <input type="hidden" name="id" value="<?= $id ?>"> -->
        <!-- <input type="hidden" name="nombre" value="<?= $nombre ?>"> -->
        <!-- <input type="hidden" name="correo" value="<?= $correo ?>"> -->
        <!-- <input type="hidden" name="fechaRegistro" value="<?= $fechaRegistro ?>"> -->
        
        <button type="submit" class="btn-modificar">Modificar</button>
    </form>

<?php
    echo "</td>";
    echo "</tr>";
}

echo "</table>";
?>

</body>
</html>

<!--
========================================
📝 EJEMPLO DE CAMBIOS PARA TABLA CLIENTES
========================================

Si te piden hacer UPDATE de la tabla CLIENTES:

CAMBIO 1 - Encabezados:
<tr>
    <th>ID</th>
    <th>Nombre</th>
    <th>Correo</th>
    <th>Fecha Registro</th>
    <th>Acciones</th>
</tr>

CAMBIO 2 - Query:
$query = "select * from clientes";

CAMBIO 3 - Variable:
$clientes = $stmt->fetchAll();

CAMBIO 4 - Foreach:
foreach ($clientes as $cliente) {

CAMBIO 5 - Guardar columnas y mostrar:
$id = $cliente["id"];
$nombre = $cliente["nombre"];
$correo = $cliente["correo"];
$fechaRegistro = $cliente["fecha_registro"];

echo "<td>$id</td>";
echo "<td>$nombre</td>";
echo "<td>$correo</td>";
echo "<td>$fechaRegistro</td>";

CAMBIO 6 - Action:
<form method="post" action="update-cliente.php" style="display:inline;">

CAMBIO 7 - Hidden inputs (TODOS los campos):
<input type="hidden" name="id" value="<?= $id ?>">
<input type="hidden" name="nombre" value="<?= $nombre ?>">
<input type="hidden" name="correo" value="<?= $correo ?>">
<input type="hidden" name="fechaRegistro" value="<?= $fechaRegistro ?>">

========================================
⚠️ MUY IMPORTANTE SOBRE LOS HIDDEN INPUTS
========================================

Para el UPDATE necesitamos enviar TODOS los campos porque:

1. El siguiente archivo (update-producto.php) necesita mostrar
   los valores actuales en el formulario

2. Necesitamos saber QUÉ producto estamos modificando (el ID)

3. El usuario verá los valores actuales y podrá cambiarlos

Ejemplo de flujo:
- Usuario ve: Producto "Teclado", precio 45.99
- Pulsa "Modificar"
- Va a update-producto.php con estos datos
- update-producto.php muestra un formulario pre-rellenado
- Usuario cambia el precio a 49.99
- Pulsa "Guardar"
- action-update-producto.php ejecuta el UPDATE

========================================
🎯 DIFERENCIA CON DELETE
========================================

DELETE: Solo necesitamos el ID
<input type="hidden" name="id" value="...">

UPDATE: Necesitamos TODOS los campos
<input type="hidden" name="id" value="...">
<input type="hidden" name="nombre" value="...">
<input type="hidden" name="precio" value="...">
<input type="hidden" name="stock" value="...">

========================================
📋 CHECKLIST PARA EL EXAMEN:
========================================

☐ 1. Cambio el nombre de la tabla en SELECT
☐ 2. Cambio el nombre de la variable después de fetchAll()
☐ 3. Cambio los encabezados <th>
☐ 4. Cambio las variables en foreach
☐ 5. Cambio las columnas que muestro
☐ 6. Cambio el action a update-[tabla].php
☐ 7. Creo input hidden para CADA campo de la tabla
☐ 8. Verifico que los name de los hidden coinciden con los nombres de columna
☐ 9. Guardo como index.php (o lista-[tabla].php)

⚠️ COMÚN: Olvidar enviar algún campo como hidden
→ Asegúrate de enviar TODOS los campos que tiene la fila

¡LISTO! ✅
-->
