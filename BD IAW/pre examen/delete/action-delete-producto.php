<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Borrar Producto</title>
</head>
<body>

<?php
/*
========================================
EJERCICIO DELETE - EJECUTAR EL BORRADO
========================================

📋 QUÉ HACE ESTE ARCHIVO:
1. Recibe el ID por POST desde delete-producto.php
2. Se conecta a la base de datos
3. Ejecuta el DELETE
4. Muestra un mensaje de éxito o error

⚠️ QUÉ CAMBIAR SI TE PIDEN OTRA TABLA:
- Nombre de la tabla en el DELETE
- Mensaje de éxito/error
*/

// ========================================
// PASO 1: VERIFICAR QUE LLEGA EL ID
// ========================================

// ⚠️ Verificamos que:
// 1. Se ha enviado por POST
// 2. Existe el campo "id"

if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST["id"])) {
    
    // Leemos el ID que queremos borrar
    $idABorrar = $_POST["id"];
    
    // ========================================
    // PASO 2: CONECTAR A LA BASE DE DATOS
    // ========================================
    
    include_once "DatabaseService.php";
    $databaseService = new DatabaseService();
    $connection = $databaseService->getConnection();
    
    // ========================================
    // PASO 3: CREAR LA CONSULTA DELETE
    // ========================================
    
    // ⚠️ CAMBIO 1: Nombre de la tabla
    // Formato: delete from TABLA where id = :id
    // Para clientes: delete from clientes where id = :id
    // Para pedidos: delete from pedidos where id = :id
    
    $query = "delete from productos where id = :id";  // ← CAMBIAR tabla
    
    /*
    EXPLICACIÓN DE LA QUERY:
    
    delete from productos  ← Tabla de la que borramos
    where id = :id         ← Condición: solo borramos el registro con este ID
                             :id es un placeholder (para evitar SQL injection)
    
    ⚠️ IMPORTANTE:
    - SIEMPRE usar WHERE con DELETE
    - Sin WHERE, borrarías TODOS los registros de la tabla
    - Usamos :id como placeholder por seguridad
    */
    
    // ========================================
    // PASO 4: PREPARAR Y EJECUTAR
    // ========================================
    
    // Preparar la consulta
    $stmt = $connection->prepare($query);
    
    // Vincular el placeholder :id con la variable $idABorrar
    $stmt->bindParam(':id', $idABorrar);
    
    // Ejecutar el DELETE
    $resultado = $stmt->execute();
    
    // ========================================
    // PASO 5: MOSTRAR RESULTADO
    // ========================================
    
    // ⚠️ CAMBIO 2: Mensajes (opcional, puedes personalizarlos)
    if ($resultado) {
        echo "<p>✅ Producto con ID $idABorrar borrado correctamente.</p>";
    } else {
        echo "<p>❌ Error al borrar el producto con ID $idABorrar.</p>";
    }
    
} else {
    // Si no se ha recibido el ID correctamente
    echo "<p>❌ Error: No se ha proporcionado un ID de producto para borrar.</p>";
}

?>

<hr/>
<p>
    <button type="button" onclick="history.back()">Volver atrás</button>
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

CAMBIO 2 - Mensajes (opcional):
if ($resultado) {
    echo "<p>✅ Cliente con ID $idABorrar borrado correctamente.</p>";
} else {
    echo "<p>❌ Error al borrar el cliente con ID $idABorrar.</p>";
}

========================================
⚠️ IMPORTANTE SOBRE DELETE
========================================

1. SIEMPRE usar WHERE
   ❌ delete from productos
      → Borra TODOS los productos
   
   ✅ delete from productos where id = :id
      → Borra SOLO el producto con ese ID

2. Usar prepare() y bindParam()
   → Evita SQL injection
   → Más seguro que concatenar

3. Verificar que llega el ID
   → Con isset($_POST["id"])
   → Antes de intentar borrar

4. Comprobar el resultado
   → $resultado será true si se borró
   → false si hubo un error

========================================
🔗 RELACIÓN CON OTROS ARCHIVOS
========================================

Este archivo se llama desde delete-producto.php

Flujo completo:
1. Usuario ve delete-producto.php (lista de productos)
2. Usuario pulsa botón "Borrar" de un producto
3. Se envía el ID por POST a action-delete-producto.php
4. Este archivo ejecuta el DELETE
5. Muestra mensaje de éxito/error

========================================
📋 CHECKLIST PARA EL EXAMEN:
========================================

☐ 1. Verifico que llega el ID por POST
☐ 2. Conecto a la base de datos
☐ 3. Escribo el DELETE con WHERE id = :id
☐ 4. Cambio el nombre de la tabla
☐ 5. Uso prepare() y bindParam()
☐ 6. Ejecuto con execute()
☐ 7. Compruebo el resultado y muestro mensaje
☐ 8. Guardo como action-delete-[nombre-tabla].php

========================================
💡 CÓDIGO MÍNIMO PARA EL EXAMEN
========================================

Si te piden borrar de tabla CLIENTES, este es el código mínimo:

<?php
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST["id"])) {
    $idABorrar = $_POST["id"];
    
    include_once "DatabaseService.php";
    $databaseService = new DatabaseService();
    $connection = $databaseService->getConnection();
    
    $query = "delete from clientes where id = :id";
    $stmt = $connection->prepare($query);
    $stmt->bindParam(':id', $idABorrar);
    $resultado = $stmt->execute();
    
    if ($resultado) {
        echo "Cliente borrado correctamente.";
    } else {
        echo "Error al borrar el cliente.";
    }
} else {
    echo "No se ha proporcionado un ID.";
}
?>

¡LISTO! ✅
-->
