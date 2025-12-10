<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inserción de un producto</title>
</head>
<body>

<?php
/*
========================================
EJERCICIO INSERT - PROCESAR FORMULARIO
========================================

📋 QUÉ HACE ESTE ARCHIVO:
1. Recibe los datos del formulario por POST
2. Se conecta a la base de datos
3. Hace un INSERT con los datos
4. Muestra un mensaje de éxito o error

⚠️ QUÉ CAMBIAR SI TE PIDEN OTRA TABLA:
- Cambiar los nombres de los campos que se reciben
- Cambiar el nombre de la tabla en el INSERT
- Cambiar las columnas en el INSERT
- Cambiar los bindParam según los campos
*/

// ========================================
// PASO 1: VERIFICAR QUE LLEGUEN LOS DATOS
// ========================================

// ⚠️ CAMBIO 1: Verificar que llegan TODOS los campos del formulario
// Añade un isset() por cada campo que tenga tu formulario
// Para productos: nombre, precio, stock
// Para clientes: nombre, correo
// Para pedidos: cliente_id, fecha_pedido, estado

if ($_SERVER["REQUEST_METHOD"] == "POST" 
    && isset($_POST["nombre"])      // ← CAMBIAR según tus campos
    && isset($_POST["precio"])      // ← 
    && isset($_POST["stock"])       // ←
) {
    
    // ========================================
    // PASO 2: LEER LOS DATOS DEL FORMULARIO
    // ========================================
    
    // ⚠️ CAMBIO 2: Leer cada campo del formulario
    // Por cada campo del formulario, lee su valor
    $nombre = $_POST["nombre"];     // ← CAMBIAR según tus campos
    $precio = $_POST["precio"];     // ←
    $stock = $_POST["stock"];       // ←
    
    // ========================================
    // PASO 3: CONECTAR A LA BASE DE DATOS
    // ========================================
    // Esta parte es SIEMPRE IGUAL
    
    include_once 'DatabaseService.php';
    $databaseService = new DatabaseService();
    $connection = $databaseService->getConnection();
    
    // ========================================
    // PASO 4: CREAR LA CONSULTA INSERT
    // ========================================
    
    // ⚠️ CAMBIO 3: La consulta INSERT
    // Formato: insert into TABLA (col1, col2, col3) values (:col1, :col2, :col3)
    // - Cambiar TABLA por tu tabla
    // - Cambiar las columnas (sin poner el ID)
    // - Poner :nombreColumna para cada columna (estos son placeholders)
    
    $query = "insert into productos (nombre, precio, stock) values (:nombre, :precio, :stock)";
    //                    ↑          ↑                                ↑
    //                    tabla      columnas                         placeholders
    
    // ========================================
    // PASO 5: PREPARAR Y EJECUTAR
    // ========================================
    
    // Preparar la consulta (para evitar SQL injection)
    $stmt = $connection->prepare($query);
    
    // ⚠️ CAMBIO 4: bindParam para cada columna
    // Por cada placeholder (:nombre, :precio, :stock) hacemos un bindParam
    // Formato: $stmt->bindParam(":nombrePlaceholder", $variableConElValor);
    
    $stmt->bindParam(":nombre", $nombre);   // ← Uno por cada columna
    $stmt->bindParam(":precio", $precio);   // ←
    $stmt->bindParam(":stock", $stock);     // ←
    
    // Ejecutar la consulta
    $resultado = $stmt->execute();
    
    // ========================================
    // PASO 6: MOSTRAR RESULTADO
    // ========================================
    
    if ($resultado) {
        echo "<p>✅ Producto insertado correctamente: $nombre, $precio, $stock.</p>";
        
        // BONUS: Obtener el ID del último registro insertado
        $query = "SELECT LAST_INSERT_ID();";
        $stmt = $connection->prepare($query);
        $stmt->execute();
        $lastInsertedId = $stmt->fetch();
        
        echo "<p>El ID del último producto insertado es: " . $lastInsertedId[0] . "</p>";
    }
    else {
        echo "<p>❌ Error al insertar el producto.</p>";
    }

} else {
    // Si no llegan los datos correctamente
    echo "<p>❌ Error: No se han recibido todos los datos del formulario.</p>";
}

?>

<button type='button' onclick="window.location.href='insert-producto.html'">Volver al formulario</button>
</body>
</html>

<!--
========================================
📝 EJEMPLO DE CAMBIOS PARA TABLA CLIENTES
========================================

Si te piden hacer INSERT en la tabla CLIENTES (id, nombre, correo, fecha_registro):

PASO 1 - Verificar campos:
if ($_SERVER["REQUEST_METHOD"] == "POST" 
    && isset($_POST["nombre"])
    && isset($_POST["correo"])
) {

PASO 2 - Leer campos:
$nombre = $_POST["nombre"];
$correo = $_POST["correo"];

PASO 3 - Query INSERT:
$query = "insert into clientes (nombre, correo) values (:nombre, :correo)";

PASO 4 - bindParam:
$stmt->bindParam(":nombre", $nombre);
$stmt->bindParam(":correo", $correo);

========================================
📝 EJEMPLO PARA TABLA PEDIDOS
========================================

Para tabla PEDIDOS (id, cliente_id, fecha_pedido, estado):

PASO 1:
if ($_SERVER["REQUEST_METHOD"] == "POST" 
    && isset($_POST["cliente_id"])
    && isset($_POST["fecha_pedido"])
    && isset($_POST["estado"])
) {

PASO 2:
$cliente_id = $_POST["cliente_id"];
$fecha_pedido = $_POST["fecha_pedido"];
$estado = $_POST["estado"];

PASO 3:
$query = "insert into pedidos (cliente_id, fecha_pedido, estado) values (:cliente_id, :fecha_pedido, :estado)";

PASO 4:
$stmt->bindParam(":cliente_id", $cliente_id);
$stmt->bindParam(":fecha_pedido", $fecha_pedido);
$stmt->bindParam(":estado", $estado);

========================================
📋 CHECKLIST PARA EL EXAMEN:
========================================

☐ 1. Miro qué campos tiene mi formulario HTML
☐ 2. En el if, pongo isset() para cada campo
☐ 3. Leo cada campo con $_POST["nombre_campo"]
☐ 4. Escribo el INSERT con el nombre de la tabla correcto
☐ 5. Pongo las columnas (sin ID) y sus placeholders :nombre
☐ 6. Hago bindParam para cada placeholder
☐ 7. Verifico que el número de columnas = número de values = número de bindParam

⚠️ COMÚN: El número de columnas, values y bindParam DEBE SER IGUAL

Ejemplo correcto:
insert into productos (nombre, precio, stock) values (:nombre, :precio, :stock)
                       ↑       ↑       ↑              ↑        ↑       ↑
                       3 columnas                     3 placeholders
$stmt->bindParam(":nombre", $nombre);
$stmt->bindParam(":precio", $precio);  
$stmt->bindParam(":stock", $stock);
↑
3 bindParam

¡LISTO! ✅
-->
