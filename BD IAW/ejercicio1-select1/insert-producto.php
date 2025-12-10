<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Añadir Producto</title>

    <style>
        body {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        form {
            width: 60%;
            margin: 20px auto;
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }
        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 18px;
            border: 1px solid #ccc;
            border-radius: 4px;
            transition: border-color 0.3s;
        }
        input[type="text"]:focus,
        input[type="number"]:focus {
            border-color: #0078D7;
            outline: none;
        }
        .btn {
            display: inline-block;
            padding: 12px 20px;
            margin-right: 10px;
            border: none;
            border-radius: 4px;
            background: #0078D7;
            color: #fff;
            font-size: 15px;
            cursor: pointer;
            transition: background 0.3s;
        }
        .btn:hover {
            background: #005fa3;
        }
        .btn-secondary {
            background: #6c757d;
        }
        .btn-secondary:hover {
            background: #565e64;
        }
    </style>
</head>
<body>
<?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $nombre = htmlspecialchars($_POST["nombre"]);
        $precio = htmlspecialchars($_POST["precio"]);
        $stock  = htmlspecialchars($_POST["stock"]);

        // Incluimos el servicio de base de datos, que nos permite conectarnos.
        include_once 'DatabaseService.php';

        // Creamos una instancia del servicio de base de datos.
        $databaseService = new DatabaseService();

        // Nos conectamos a la base de datos.
        $connection = $databaseService->getConnection();

        // Creamos la consulta que nos da todos los clientes.
        $query = "insert into productos (nombre, precio, stock) values (:nombre, :precio, :stock)";

        $stmt = $connection->prepare($query);
        $stmt->bindParam(":nombre", $nombre);
        $stmt->bindParam(":precio", $precio);
        $stmt->bindParam(":stock", $precio);

        $resultadoDeLaInsercionDelProducto = $stmt->execute();

        // Dependiendo del resultado mostramos un mensaje u otro
        if ($resultadoDeLaInsercionDelProducto) {

            // Obtener el ID del último cliente insertado
            $query = "SELECT LAST_INSERT_ID();";
            $stmt = $connection->prepare($query);
            $stmt->execute();
            $lastInsertedId = $stmt->fetch();

            echo "<p>Producto insertado correctamente: ($lastInsertedId[0], $nombre, $precio, $stock).</p>";
        }
        else {
            echo "<p>Error al insertar el producto.</p>";
        }

        echo "<hr/>";
    }
    ?>

    <h1>📝 Añadir Nuevo Producto</h1>
    <form method="post" action="">
        <label for="nombre">Nombre</label>
        <input type="text" name="nombre" id="nombre" required>

        <label for="precio">Precio (€)</label>
        <input type="number" step="0.01" name="precio" id="precio" required>

        <label for="stock">Stock</label>
        <input type="number" name="stock" id="stock" required>

        <button type="submit" class="btn">Añadir</button>
        <button type="button" class="btn btn-secondary" onclick="window.location.href='index.html'">Volver al listado</button>
    </form>
</body>
</html>

