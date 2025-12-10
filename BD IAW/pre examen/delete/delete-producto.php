<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado de Productos - Borrar</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #0078D7;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .btn-borrar {
            background-color: #d9534f;
            color: white;
            border: none;
            padding: 8px 15px;
            cursor: pointer;
            border-radius: 4px;
        }
        .btn-borrar:hover {
            background-color: #c9302c;
        }
        .mensaje-exito {
            background-color: #d4edda;
            color: #155724;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #c3e6cb;
            border-radius: 4px;
        }
        .mensaje-error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #f5c6cb;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <!--
    ========================================
    EJERCICIO DELETE - VERSIÓN TODO EN UNO
    ========================================
    
    📋 QUÉ HACE ESTE ARCHIVO:
    1. Si recibe POST con ID → Borra el producto
    2. Muestra la lista de productos con botones borrar
    
    💡 VENTAJA: Un solo archivo (más simple)
    
    ⚠️ QUÉ CAMBIAR SI TE PIDEN OTRA TABLA:
    - Nombre de la tabla en DELETE
    - Nombre de la tabla en SELECT
    - Nombres de variables
    - Columnas que muestras
    -->
    
    <h1>🗑️ Listado de Productos - Borrar</h1>

<?php
// ========================================
// PARTE 1: PROCESAR BORRADO (SI VIENE POST)
// ========================================

// ⚠️ IMPORTANTE: Esta parte va ANTES de mostrar la lista
// Primero procesamos el borrado, luego mostramos la lista actualizada

if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST["id"])) {
    
    $idABorrar = $_POST["id"];
    
    // Conectar a la base de datos
    include_once "DatabaseService.php";
    $databaseService = new DatabaseService();
    $connection = $databaseService->getConnection();
    
    // ⚠️ CAMBIO 1: Nombre de la tabla en DELETE
    // Para clientes: delete from clientes where id = :id
    // Para pedidos: delete from pedidos where id = :id
    $query = "delete from productos where id = :id";  // ← CAMBIAR tabla
    
    $stmt = $connection->prepare($query);
    $stmt->bindParam(':id', $idABorrar);
    $resultado = $stmt->execute();
    
    // Mostrar mensaje de resultado
    if ($resultado) {
        echo "<div class='mensaje-exito'>";
        echo "✅ Producto con ID $idABorrar borrado correctamente.";
        echo "</div>";
    } else {
        echo "<div class='mensaje-error'>";
        echo "❌ Error al borrar el producto con ID $idABorrar.";
        echo "</div>";
    }
    
    echo "<hr/>";
}

// ========================================
// PARTE 2: MOSTRAR LA LISTA DE PRODUCTOS
// ========================================

// Conectar a la base de datos (puede que ya esté conectado de la parte 1)
include_once "DatabaseService.php";
$databaseService = new DatabaseService();
$connection = $databaseService->getConnection();

// ⚠️ CAMBIO 2: Nombre de la tabla en SELECT
$query = "select * from productos";  // ← CAMBIAR tabla

$stmt = $connection->query($query);

// ⚠️ CAMBIO 3: Nombre de la variable
$productos = $stmt->fetchAll();  // ← CAMBIAR variable

// Mostrar tabla
echo "<table>";

// ⚠️ CAMBIO 4: Encabezados
echo "<tr>
        <th>ID</th>
        <th>Nombre</th>
        <th>Precio</th>
        <th>Stock</th>
        <th>Acciones</th>
      </tr>";

// ⚠️ CAMBIO 5: Recorrer productos
foreach ($productos as $producto) {  // ← CAMBIAR variables
    
    $id = $producto["id"];
    $nombre = $producto["nombre"];
    $precio = $producto["precio"];
    $stock = $producto["stock"];
    
    echo "<tr>";
    
    // ⚠️ CAMBIO 6: Mostrar columnas
    echo "<td>$id</td>";
    echo "<td>$nombre</td>";
    echo "<td>" . number_format($precio, 2) . " €</td>";
    echo "<td>$stock</td>";
    
    echo "<td>";
    ?>
    
    <!-- ⚠️ IMPORTANTE: action="" vacío = se envía a sí mismo -->
    <form method="post" 
          action="" 
          style="display:inline;" 
          onsubmit="return confirm('¿Estás seguro de que deseas borrar este producto?');">
        
        <input type="hidden" name="id" value="<?= $id ?>">
        <button type="submit" class="btn-borrar">Borrar</button>
    </form>
    
    <?php
    echo "</td>";
    echo "</tr>";
}

echo "</table>";
?>

<p>
    <button type="button" onclick="history.back()">Volver</button>
</p>

</body>
</html>

<!--
========================================
📝 EJEMPLO DE CAMBIOS PARA TABLA CLIENTES
========================================

Si te piden hacer DELETE de la tabla CLIENTES:

CAMBIO 1 - Query DELETE:
$query = "delete from clientes where id = :id";

CAMBIO 2 - Query SELECT:
$query = "select * from clientes";

CAMBIO 3 - Variable:
$clientes = $stmt->fetchAll();

CAMBIO 4 - Encabezados:
echo "<tr>
        <th>ID</th>
        <th>Nombre</th>
        <th>Correo</th>
        <th>Fecha Registro</th>
        <th>Acciones</th>
      </tr>";

CAMBIO 5 - Foreach:
foreach ($clientes as $cliente) {

CAMBIO 6 - Mostrar columnas:
$id = $cliente["id"];
$nombre = $cliente["nombre"];
$correo = $cliente["correo"];
$fecha = $cliente["fecha_registro"];

echo "<td>$id</td>";
echo "<td>$nombre</td>";
echo "<td>$correo</td>";
echo "<td>$fecha</td>";

========================================
💡 VENTAJAS DE ESTA VERSIÓN (TODO EN UNO)
========================================

1. Un solo archivo
   → Más fácil de mantener
   → Menos archivos en el examen

2. La lista se actualiza automáticamente
   → Después de borrar, se muestra la lista actualizada
   → No necesitas volver atrás

3. El formulario se envía a sí mismo
   → action="" significa "envía a la misma página"
   → Más simple que tener otro archivo

========================================
⚠️ DIFERENCIAS CON LA VERSIÓN SEPARADA
========================================

VERSIÓN SEPARADA (2 archivos):
- delete-producto.php → Solo muestra la lista
- action-delete-producto.php → Solo borra

VERSIÓN TODO EN UNO (1 archivo):
- delete-producto.php → Borra Y muestra la lista

En el examen, puedes usar cualquiera de las dos.
La versión TODO EN UNO es más moderna y compacta.

========================================
🎯 ORDEN DE EJECUCIÓN
========================================

1. Usuario entra a la página
   → No hay POST → Salta la parte 1 → Muestra la lista (parte 2)

2. Usuario pulsa "Borrar" en un producto
   → Se envía POST con ID → Ejecuta DELETE (parte 1)
   → Muestra mensaje de éxito
   → Continúa y muestra la lista actualizada (parte 2)

========================================
📋 CHECKLIST PARA EL EXAMEN:
========================================

☐ 1. Cambio el nombre de la tabla en DELETE
☐ 2. Cambio el nombre de la tabla en SELECT
☐ 3. Cambio el nombre de la variable después de fetchAll()
☐ 4. Cambio los encabezados <th>
☐ 5. Cambio las variables en el foreach
☐ 6. Cambio las columnas que muestro
☐ 7. Verifico que action="" está vacío (se envía a sí mismo)
☐ 8. Guardo como delete-[nombre-tabla].php

========================================
💡 ESTRUCTURA BÁSICA PARA EL EXAMEN
========================================

<?php
// PARTE 1: Procesar borrado si viene POST
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST["id"])) {
    // Conectar
    // DELETE
    // Mostrar mensaje
}

// PARTE 2: Mostrar lista
// Conectar
// SELECT
// Mostrar tabla con botones borrar
?>

¡LISTO! ✅
-->
