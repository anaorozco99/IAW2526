<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Actualizar Producto</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .mensaje-exito {
            background-color: #d4edda;
            color: #155724;
            padding: 15px;
            margin: 20px 0;
            border: 1px solid #c3e6cb;
            border-radius: 4px;
        }
        .mensaje-error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 15px;
            margin: 20px 0;
            border: 1px solid #f5c6cb;
            border-radius: 4px;
        }
    </style>
</head>
<body>

<?php
/*
========================================
EJERCICIO UPDATE - PASO 3: EJECUTAR UPDATE
========================================

📋 QUÉ HACE ESTE ARCHIVO:
1. Recibe los datos modificados del formulario (desde update-producto.php)
2. Se conecta a la base de datos
3. Ejecuta el UPDATE con los nuevos valores
4. Muestra un mensaje de éxito o error

⚠️ QUÉ CAMBIAR SI TE PIDEN OTRA TABLA:
- Los campos que verificas en el if
- Las variables que lees del POST
- El nombre de la tabla en el UPDATE
- Las columnas que actualizas
- Los bindParam
*/

// ========================================
// PASO 1: VERIFICAR QUE LLEGAN LOS DATOS
// ========================================

// ⚠️ CAMBIO 1: Verificar que llegan TODOS los campos
// Debe coincidir con los campos del formulario de update-producto.php
// Para productos: id, nombre, precio, stock
// Para clientes: id, nombre, correo, fechaRegistro

if ($_SERVER["REQUEST_METHOD"] === "POST"
    && isset($_POST["id"])
    && isset($_POST["nombre"])
    && isset($_POST["precio"])
    && isset($_POST["stock"])
) {
    
    // ========================================
    // PASO 2: LEER LOS DATOS DEL FORMULARIO
    // ========================================
    
    // ⚠️ CAMBIO 2: Leer cada campo
    $id = $_POST["id"];
    $nombre = $_POST["nombre"];
    $precio = $_POST["precio"];
    $stock = $_POST["stock"];
    
    // ========================================
    // PASO 3: CONECTAR A LA BASE DE DATOS
    // ========================================
    
    include_once "DatabaseService.php";
    $databaseService = new DatabaseService();
    $connection = $databaseService->getConnection();
    
    // ========================================
    // PASO 4: CREAR LA CONSULTA UPDATE
    // ========================================
    
    // ⚠️ CAMBIO 3: La consulta UPDATE
    // Formato: update TABLA set col1 = :col1, col2 = :col2 where id = :id
    // - Cambiar TABLA por tu tabla
    // - Cambiar las columnas (NO incluir el ID en el SET)
    // - Usar placeholders :nombreColumna
    
    $query = "update productos 
              set nombre = :nombre, 
                  precio = :precio, 
                  stock = :stock 
              where id = :id";
    
    /*
    EXPLICACIÓN DE LA QUERY:
    
    update productos              ← Tabla que actualizamos
    set nombre = :nombre,         ← Columna 1 = nuevo valor
        precio = :precio,         ← Columna 2 = nuevo valor
        stock = :stock            ← Columna 3 = nuevo valor
    where id = :id                ← Condición: solo actualizar este registro
    
    ⚠️ IMPORTANTE:
    - NO ponemos el ID en el SET (el ID NO se modifica)
    - El ID solo va en el WHERE
    - Usamos placeholders (:nombre, :precio, etc.) por seguridad
    - SIEMPRE usar WHERE, si no actualizarías TODOS los registros
    */
    
    // ========================================
    // PASO 5: PREPARAR Y EJECUTAR
    // ========================================
    
    // Preparar la consulta
    $stmt = $connection->prepare($query);
    
    // ⚠️ CAMBIO 4: bindParam para cada columna
    // Por cada placeholder en el SET y en el WHERE
    // Formato: $stmt->bindParam(":placeholder", $variable);
    
    $stmt->bindParam(':id', $id);           // Para el WHERE
    $stmt->bindParam(':nombre', $nombre);   // Para el SET
    $stmt->bindParam(':precio', $precio);   // Para el SET
    $stmt->bindParam(':stock', $stock);     // Para el SET
    
    // Ejecutar el UPDATE
    $resultado = $stmt->execute();
    
    // ========================================
    // PASO 6: MOSTRAR RESULTADO
    // ========================================
    
    if ($resultado) {
        echo "<div class='mensaje-exito'>";
        echo "<h2>✅ Producto actualizado correctamente</h2>";
        echo "<p><strong>ID:</strong> $id</p>";
        echo "<p><strong>Nuevos valores:</strong></p>";
        echo "<ul>";
        echo "<li><strong>Nombre:</strong> $nombre</li>";
        echo "<li><strong>Precio:</strong> " . number_format($precio, 2) . " €</li>";
        echo "<li><strong>Stock:</strong> $stock</li>";
        echo "</ul>";
        echo "</div>";
    } else {
        echo "<div class='mensaje-error'>";
        echo "<h2>❌ Error al actualizar el producto</h2>";
        echo "<p>No se pudo modificar el producto con ID $id.</p>";
        echo "</div>";
    }
    
} else {
    // Si no se han recibido los datos correctamente
    echo "<div class='mensaje-error'>";
    echo "<h2>❌ Error</h2>";
    echo "<p>No se han recibido todos los datos necesarios para actualizar el producto.</p>";
    echo "</div>";
}

?>

<hr/>
<p>
    <button type="button" onclick="window.location.href='index.php'">Volver a la lista</button>
</p>

</body>
</html>

<!--
========================================
📝 EJEMPLO DE CAMBIOS PARA TABLA CLIENTES
========================================

Si te piden hacer UPDATE de la tabla CLIENTES:

CAMBIO 1 - Verificar campos:
if ($_SERVER["REQUEST_METHOD"] === "POST"
    && isset($_POST["id"])
    && isset($_POST["nombre"])
    && isset($_POST["correo"])
    && isset($_POST["fechaRegistro"])
) {

CAMBIO 2 - Leer campos:
$id = $_POST["id"];
$nombre = $_POST["nombre"];
$correo = $_POST["correo"];
$fechaRegistro = $_POST["fechaRegistro"];

CAMBIO 3 - Query UPDATE:
$query = "update clientes 
          set nombre = :nombre, 
              correo = :correo, 
              fecha_registro = :fechaRegistro 
          where id = :id";

CAMBIO 4 - bindParam:
$stmt->bindParam(':id', $id);
$stmt->bindParam(':nombre', $nombre);
$stmt->bindParam(':correo', $correo);
$stmt->bindParam(':fechaRegistro', $fechaRegistro);

========================================
⚠️ ESTRUCTURA DEL UPDATE
========================================

UPDATE TABLA
SET 
    columna1 = :valor1,
    columna2 = :valor2,
    columna3 = :valor3
WHERE id = :id

Partes importantes:
1. UPDATE TABLA → nombre de la tabla
2. SET → columnas que vas a modificar
3. columna = :placeholder → cada columna con su placeholder
4. WHERE id = :id → CRÍTICO: solo actualizar este registro

⚠️ ERRORES COMUNES:

❌ Incluir el ID en el SET:
update productos set id = :id, nombre = :nombre...
                     ↑ NO, el ID no se modifica

✅ Correcto:
update productos set nombre = :nombre, precio = :precio where id = :id
                                                          ↑ ID solo en WHERE

---

❌ Olvidar el WHERE:
update productos set nombre = :nombre

✅ Correcto:
update productos set nombre = :nombre where id = :id

---

❌ Número incorrecto de bindParam:
Query tiene 3 placeholders pero solo 2 bindParam

✅ Correcto:
Por cada placeholder (:nombre, :precio, :stock, :id) → un bindParam

========================================
🎯 FLUJO COMPLETO
========================================

Archivo 1: index.php
- Muestra lista
- Botón "Modificar" envía todos los datos a update-producto.php

Archivo 2: update-producto.php
- Recibe los datos actuales
- Muestra formulario pre-rellenado
- Usuario modifica lo que quiera
- Envía los nuevos datos a action-update-producto.php

Archivo 3: action-update-producto.php (ESTE ARCHIVO)
- Recibe los nuevos datos
- Ejecuta UPDATE en la base de datos
- Muestra mensaje de éxito

========================================
📋 CHECKLIST PARA EL EXAMEN:
========================================

☐ 1. En el if, verifico que llegan TODOS los campos
☐ 2. Leo cada campo con $_POST["campo"]
☐ 3. Conecto a la base de datos
☐ 4. Escribo el UPDATE con:
     - Nombre de la tabla correcto
     - SET con las columnas a modificar (sin el ID)
     - WHERE id = :id
☐ 5. Hago prepare()
☐ 6. Hago bindParam para CADA placeholder (incluyendo :id del WHERE)
☐ 7. Verifico que número de placeholders = número de bindParam
☐ 8. Ejecuto con execute()
☐ 9. Compruebo resultado y muestro mensaje
☐ 10. Guardo como action-update-[tabla].php

========================================
💡 CÓDIGO MÍNIMO PARA EL EXAMEN
========================================

Si te piden UPDATE de tabla CLIENTES:

<?php
if ($_SERVER["REQUEST_METHOD"] === "POST" 
    && isset($_POST["id"]) 
    && isset($_POST["nombre"]) 
    && isset($_POST["correo"])
) {
    $id = $_POST["id"];
    $nombre = $_POST["nombre"];
    $correo = $_POST["correo"];
    
    include_once "DatabaseService.php";
    $databaseService = new DatabaseService();
    $connection = $databaseService->getConnection();
    
    $query = "update clientes 
              set nombre = :nombre, correo = :correo 
              where id = :id";
    
    $stmt = $connection->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->bindParam(':nombre', $nombre);
    $stmt->bindParam(':correo', $correo);
    $resultado = $stmt->execute();
    
    if ($resultado) {
        echo "Cliente actualizado correctamente.";
    } else {
        echo "Error al actualizar.";
    }
}
?>

¡LISTO! ✅
-->
