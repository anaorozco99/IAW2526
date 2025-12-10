<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado de Productos</title>

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

    <button type="button" class="btn btn-secondary" onclick="window.location.href='index.html'">Volver al listado</button>
</body>
</html>