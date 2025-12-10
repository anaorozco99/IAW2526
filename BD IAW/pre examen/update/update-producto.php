<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modificar Producto</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h1 {
            color: #333;
        }
        .datos-actuales {
            background-color: #e7f3ff;
            padding: 15px;
            margin: 20px 0;
            border-left: 4px solid #0078D7;
        }
        form {
            background-color: #f9f9f9;
            padding: 20px;
            margin: 20px 0;
            border-radius: 5px;
        }
        label {
            display: block;
            font-weight: bold;
            margin-top: 10px;
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="number"],
        input[type="email"],
        input[type="date"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #0078D7;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 15px;
        }
        input[type="submit"]:hover {
            background-color: #005fa3;
        }
        .error {
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
    EJERCICIO UPDATE - PASO 2: FORMULARIO
    ========================================
    
    📋 QUÉ HACE ESTE ARCHIVO:
    1. Recibe los datos actuales del producto por POST (desde index.php)
    2. Muestra los datos actuales
    3. Muestra un formulario PRE-RELLENADO con esos datos
    4. El usuario puede modificar los campos
    5. Al enviar, manda los datos a action-update-producto.php
    
    ⚠️ QUÉ CAMBIAR SI TE PIDEN OTRA TABLA:
    - Los campos que verificas en el if
    - Las variables que lees del POST
    - Los campos del formulario
    -->
    
    <h1>✏️ Formulario para modificar un producto</h1>

<?php

// ========================================
// PASO 1: VERIFICAR QUE LLEGAN LOS DATOS
// ========================================

// ⚠️ CAMBIO 1: Verificar que llegan TODOS los campos
// Debe coincidir con los hidden inputs de index.php
// Para productos: id, nombre, precio, stock
// Para clientes: id, nombre, correo, fechaRegistro

if ($_SERVER["REQUEST_METHOD"] === "POST"
    && isset($_POST["id"])
    && isset($_POST["nombre"])
    && isset($_POST["precio"])
    && isset($_POST["stock"])
) {
    
    // ========================================
    // PASO 2: LEER LOS DATOS DEL POST
    // ========================================
    
    // ⚠️ CAMBIO 2: Leer cada campo
    $id = $_POST["id"];
    $nombre = $_POST["nombre"];
    $precio = $_POST["precio"];
    $stock = $_POST["stock"];
    
?>

    <!-- ========================================
         MOSTRAR DATOS ACTUALES
         ======================================== -->
    
    <div class="datos-actuales">
        <p><strong>El producto a modificar es el siguiente:</strong></p>
        <ul>
            <!-- ⚠️ CAMBIO 3: Mostrar los datos actuales -->
            <li><strong>ID:</strong> <?= $id ?></li>
            <li><strong>Nombre:</strong> <?= $nombre ?></li>
            <li><strong>Precio:</strong> <?= number_format($precio, 2) ?> €</li>
            <li><strong>Stock:</strong> <?= $stock ?></li>
        </ul>
    </div>

    <hr/>

    <!-- ========================================
         FORMULARIO PARA MODIFICAR
         ======================================== -->
    
    <p><strong>Modifica los campos que desees y pulsa "Modificar":</strong></p>
    
    <!-- ⚠️ CAMBIO 4: Action del formulario -->
    <!-- Para clientes: action="action-update-cliente.php" -->
    <!-- Para pedidos: action="action-update-pedido.php" -->
    <form method="post" action="action-update-producto.php">
        
        <!-- Campo oculto con el ID (NO se modifica) -->
        <!-- ⚠️ IMPORTANTE: El ID siempre va como hidden -->
        <input type="hidden" name="id" value="<?= $id ?>">
        
        <!-- ⚠️ CAMBIO 5: Campos del formulario según tu tabla -->
        <!-- Cada campo tiene value="<?= $variable ?>" para pre-rellenarlo -->
        
        <!-- Para PRODUCTOS: nombre, precio, stock -->
        
        <label for="nombre">Nombre:</label>
        <input type="text" name="nombre" id="nombre" value="<?= $nombre ?>" required>
        
        <label for="precio">Precio (€):</label>
        <input type="number" step="0.01" name="precio" id="precio" value="<?= $precio ?>" required>
        
        <label for="stock">Stock:</label>
        <input type="number" name="stock" id="stock" value="<?= $stock ?>" required>
        
        <!-- Para CLIENTES sería:
        <label for="nombre">Nombre:</label>
        <input type="text" name="nombre" id="nombre" value="<?= $nombre ?>" required>
        
        <label for="correo">Correo:</label>
        <input type="email" name="correo" id="correo" value="<?= $correo ?>" required>
        
        <label for="fechaRegistro">Fecha de Registro:</label>
        <input type="date" name="fechaRegistro" id="fechaRegistro" value="<?= $fechaRegistro ?>" required>
        -->
        
        <input type="submit" value="Modificar el producto">
    </form>

<?php
} else {
    // Si no se han recibido los datos correctamente
    echo "<div class='error'>";
    echo "<p><strong>❌ Error:</strong> No se han recibido los datos del producto a modificar.</p>";
    echo "<p>Vuelve a la lista de productos y selecciona el producto que deseas modificar.</p>";
    echo "</div>";
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

CAMBIO 3 - Mostrar datos actuales:
<ul>
    <li><strong>ID:</strong> <?= $id ?></li>
    <li><strong>Nombre:</strong> <?= $nombre ?></li>
    <li><strong>Correo:</strong> <?= $correo ?></li>
    <li><strong>Fecha Registro:</strong> <?= $fechaRegistro ?></li>
</ul>

CAMBIO 4 - Action:
<form method="post" action="action-update-cliente.php">

CAMBIO 5 - Campos del formulario:
<input type="hidden" name="id" value="<?= $id ?>">

<label for="nombre">Nombre:</label>
<input type="text" name="nombre" id="nombre" value="<?= $nombre ?>" required>

<label for="correo">Correo:</label>
<input type="email" name="correo" id="correo" value="<?= $correo ?>" required>

<label for="fechaRegistro">Fecha de Registro:</label>
<input type="date" name="fechaRegistro" id="fechaRegistro" value="<?= $fechaRegistro ?>" required>

========================================
⚠️ MUY IMPORTANTE: value="<?= ... ?>"
========================================

Para que el formulario esté PRE-RELLENADO necesitas:

value="<?= $variable ?>"

Esto hace que cuando se cargue el formulario, los campos
YA tengan los valores actuales del producto.

Ejemplo:
Si el producto actual tiene nombre="Teclado" y precio=45.99

<input type="text" name="nombre" value="<?= $nombre ?>">
↓ Se convierte en:
<input type="text" name="nombre" value="Teclado">

El usuario verá "Teclado" en el campo y podrá cambiarlo.

========================================
🎯 FLUJO COMPLETO DEL UPDATE
========================================

1. Usuario en index.php ve lista de productos
2. Pulsa "Modificar" en un producto
3. Se envían TODOS los datos por POST a update-producto.php
4. update-producto.php recibe los datos
5. Muestra un formulario con los campos pre-rellenados
6. Usuario cambia los valores que quiera
7. Pulsa "Modificar"
8. Los datos van a action-update-producto.php
9. action-update-producto.php ejecuta el UPDATE
10. Muestra mensaje de éxito

========================================
📋 CHECKLIST PARA EL EXAMEN:
========================================

☐ 1. En el if, verifico que llegan TODOS los campos
☐ 2. Leo cada campo con $_POST["campo"]
☐ 3. Muestro los datos actuales en un div
☐ 4. Cambio el action a action-update-[tabla].php
☐ 5. Pongo el ID como hidden (NO se debe modificar)
☐ 6. Por cada campo que se puede modificar, creo un input con:
     - type correcto
     - name igual al nombre del campo
     - value="<?= $variable ?>" para pre-rellenarlo
☐ 7. Guardo como update-[tabla].php

⚠️ COMÚN: Olvidar el value="<?= ... ?>"
→ Sin esto, el formulario aparecerá vacío

⚠️ COMÚN: Permitir modificar el ID
→ El ID SIEMPRE va como hidden, nunca como input editable

¡LISTO! ✅
-->
