<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Productos</title>

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
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            background: #fff;
        }
        th, td {
            padding: 12px 15px;
            text-align: center;
        }
        th {
            background: #0078D7;
            color: #fff;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        tr:nth-child(even) {
            background: #f9f9f9;
        }
        tr:hover {
            background: #eaf3ff;
        }
        .precio {
            color: #0078D7;
            font-weight: bold;
        }
        .stock {
            font-weight: bold;
        }
        .stock-bajo {
            color: #d9534f;
        }
        .stock-alto {
            color: #28a745;
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
        if ($resultadoDeLaInsercionDelProducto == false) {
            echo "<p>Error al insertar el producto.</p>";
            echo "<hr/>";
        }
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

    <h1>📦 Catálogo de Productos</h1>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Precio (€)</th>
                <th>Stock</th>
            </tr>
        </thead>
        <tbody>
            <?php
            // Incluimos el servicio de base de datos, que nos permite conectarnos.
            include_once 'DatabaseService.php';

            // Creamos una instancia del servicio de base de datos.
            $databaseService = new DatabaseService();

            // Nos conectamos a la base de datos.
            $connection = $databaseService->getConnection();

            // Creamos la consulta que nos da todos los productos.
            $query = "select * from productos";

            // Ejecutamos la consulta.
            $stmt = $connection->query($query);

            // Obtenemos todos las filas resultado de la consulta. En este caso son nuestros productos
            $productos = $stmt->fetchAll();

            // Recorremos los productos y los mostramos en la tabla
            foreach ($productos as $producto): ?>
                <tr>
                    <td><?= htmlspecialchars($producto["id"]) ?></td>
                    <td><?= htmlspecialchars($producto["nombre"]) ?></td>
                    <td class="precio"><?= number_format($producto["precio"], 2, ',', '.') ?></td>
                    <td class="stock
                        <?= $producto["stock"] < 10 ? 'stock-bajo' : 'stock-alto' ?>">
                        <?= htmlspecialchars($producto["stock"]) ?>
                    </td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</body>
</html>