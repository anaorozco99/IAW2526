<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado de Clientes</title>
</head>
<body>
    <h1>👥 Listado de Clientes</h1>
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

        echo "<ul>";

        foreach ($clientes as $cliente) {

            $idCliente = $cliente["id"];
            $nombreCliente = $cliente["nombre"];
            $correoCliente = $cliente["correo"];
            $fechaRegistroCliente = $cliente["fecha_registro"];

            echo "<li>";
    ?>
            <form method="post" action="action-delete-cliente.php" style="display:inline;" onsubmit="return confirm('¿Estás seguro de que deseas borrar este cliente?');">
                <input type="hidden" name="id" value="<?= $cliente["id"] ?>">
                <button type="submit">Borrar</button>
            </form>
    <?php
            echo "ID: $idCliente - Nombre: $nombreCliente - Correo: $correoCliente - Fecha de Registro: $fechaRegistroCliente";

            echo "</li>";
        }

        echo "</ul>";
    ?>
</body>
</html>