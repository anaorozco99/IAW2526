<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado de Clientes</title>
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
        .btn-borrar {
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            background: #d9534f;
            color: #fff;
            cursor: pointer;
            transition: background 0.3s;
        }
        .btn-borrar:hover {
            background: #c9302c;
        }
    </style>
</head>
<body>
<?php

// Si se ha enviado petición de borrado
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST["id"])) {
    $idABorrar = $_POST["id"];

    include_once "DatabaseService.php";
    $databaseService = new DatabaseService();

    $resultadoBorrado = $databaseService->deleteClienteById($idABorrar);


    if ($resultadoBorrado) {
        echo "<p>Cliente con ID $idABorrar borrado correctamente.</p>";
    } else {
        echo "<p>Error al borrar el cliente con ID $idABorrar.</p>";
    }

    echo "<hr/>";
}
?>


    <h1>👥 Listado de Clientes</h1>
    <table>
        <thead>
            <tr>
                <th>Nombre</th>
                <th>Correo</th>
                <th>Fecha de registro</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <?php
            include_once "DatabaseService.php";
            $databaseService = new DatabaseService();
            $clientes = $databaseService->selectClientes();

            foreach ($clientes as $cliente): ?>
                <tr>
                    <td><?= htmlspecialchars($cliente["nombre"]) ?></td>
                    <td><?= htmlspecialchars($cliente["correo"]) ?></td>
                    <td><?= htmlspecialchars($cliente["fecha_registro"]) ?></td>
                    <td>
                        <form method="post" action="" style="display:inline;">
                            <input type="hidden" name="id" value="<?= htmlspecialchars($cliente["id"]) ?>">
                            <button type="submit" class="btn-borrar">Borrar</button>
                        </form>
                    </td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</body>
</html>