<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado de Clientes</title>
    <style>

        body {
            font-family: Arial, sans-serif;
            margin-left: 80px;
            margin-right: 80px;
        }

        table {
            margin-top: 20px;
            border-collapse: collapse;
            width: 100%;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }

        th {
            background-color: #f2f2f2;
            text-align: left;
        }

        td:hover {
            background-color: #e0e0e0;
        }

        button {
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <h1>
        👥 Listado de Clientes
    </h1>

    <button onclick="window.location.href='../ejemplo3-insert/insert-cliente.html'">
        ➕ Crear Nuevo Cliente
    </button>

    <button onclick="location.reload()">
        🔄 Recargar
    </button>

    <table border='1'>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Correo</th>
            <th>Fecha de registro</th>
            <th>Acciones</th>
        </tr>
<?php
        // Incluimos el servicio de base de datos, que nos permite conectarnos.
        include_once 'DatabaseService.php';

        // Creamos una instancia del servicio de base de datos.
        $databaseService = new DatabaseService();

        // Nos conectamos a la base de datos.
        $connection = $databaseService->getConnection();

        // Creamos la consulta que nos da todos los clientes.
        $query = "select * from clientes";

        // Ejecutamos la consulta.
        $stmt = $connection->query($query);

        // Obtenemos todos las filas resultado de la consulta. En este caso son nuestros clientes
        $clientes = $stmt->fetchAll();

        foreach ($clientes as $cliente) {

            $idCliente = $cliente["id"];
            $nombreCliente = $cliente["nombre"];
            $correoCliente = $cliente["correo"];
            $fechaRegistroCliente = $cliente["fecha_registro"];

            echo "\t\t<tr>\n";
            echo "\t\t\t<td>$idCliente</td>\n";
            echo "\t\t\t<td>$nombreCliente</td>\n";
            echo "\t\t\t<td>$correoCliente</td>\n";
            echo "\t\t\t<td>$fechaRegistroCliente</td>\n";
            echo "\t\t\t<td>\n";
    ?>
                <form method="post" action="update-cliente.php" style="display:inline;">
                    <input type="hidden" name="id" value="<?= $idCliente ?>">
                    <input type="hidden" name="nombre" value="<?= $nombreCliente ?>">
                    <input type="hidden" name="correo" value="<?= $correoCliente ?>">
                    <input type="hidden" name="fechaRegistro" value="<?= $fechaRegistroCliente ?>">
                    <button type="submit">Modificar</button>
                </form>

                <form method="post" action="../ejemplo5-delete1/action-delete-cliente.php" style="display:inline;" onsubmit="return confirm('¿Estás seguro de que deseas borrar este cliente?');">
                    <input type="hidden" name="id" value="<?= $cliente["id"] ?>">
                    <button type="submit">Borrar</button>
                </form>
    <?php
            echo "\t\t</td>\n";
            echo "\t\t</tr>\n";
        }

        echo "\t</table>\n";
    ?>
</body>
</html>
