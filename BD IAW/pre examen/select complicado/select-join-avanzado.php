<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SELECT con JOIN - Consultas avanzadas</title>
    <style>
        table { border-collapse: collapse; margin: 20px 0; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #0078D7; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        h2 { color: #333; margin-top: 30px; }
        .info { background-color: #e7f3ff; padding: 10px; margin: 10px 0; border-left: 4px solid #0078D7; }
    </style>
</head>
<body>

<?php
/*
========================================
SELECT CON JOIN - UNIR TABLAS
========================================

📋 QUÉ ES UN JOIN:
Un JOIN sirve para combinar datos de varias tablas relacionadas.

📊 ESTRUCTURA DE LAS TABLAS (del SQL que te dieron):

clientes (id, nombre, correo, fecha_registro)
pedidos (id, cliente_id, fecha_pedido, estado)
productos (id, nombre, precio, stock)
pedido_producto (pedido_id, producto_id, cantidad)

🔗 RELACIONES:
- 1 cliente puede tener muchos pedidos (cliente.id → pedido.cliente_id)
- 1 pedido puede tener muchos productos (tabla intermedia pedido_producto)
- 1 producto puede estar en muchos pedidos
*/

// Conectar a la base de datos
include_once 'DatabaseService.php';
$databaseService = new DatabaseService();
$connection = $databaseService->getConnection();

?>

<!-- ========================================
     EJEMPLO 1: JOIN DE 2 TABLAS
     ======================================== -->

<div class="info">
<strong>EJEMPLO 1: PEDIDOS CON NOMBRE DEL CLIENTE</strong><br>
Unimos la tabla <strong>pedidos</strong> con la tabla <strong>clientes</strong><br>
Para mostrar: ID pedido, Nombre del cliente, Fecha pedido, Estado
</div>

<?php

// ⚠️ QUERY CON INNER JOIN
// INNER JOIN = solo muestra los pedidos que tienen un cliente asociado
$query = "
    SELECT 
        pedidos.id AS pedido_id,
        clientes.nombre AS cliente_nombre,
        pedidos.fecha_pedido,
        pedidos.estado
    FROM pedidos
    INNER JOIN clientes ON pedidos.cliente_id = clientes.id
    ORDER BY pedidos.id
";

/*
EXPLICACIÓN DE LA QUERY:

SELECT 
    pedidos.id AS pedido_id         ← Columna de la tabla pedidos, le ponemos alias "pedido_id"
    clientes.nombre AS cliente_nombre   ← Columna de la tabla clientes
    pedidos.fecha_pedido            ← Columna de pedidos
    pedidos.estado                  ← Columna de pedidos

FROM pedidos                        ← Tabla principal
INNER JOIN clientes                 ← Tabla que unimos
ON pedidos.cliente_id = clientes.id ← Condición: cómo se relacionan
                                      (el cliente_id del pedido = id del cliente)

⚠️ IMPORTANTE:
- Usamos "tabla.columna" cuando las dos tablas tienen columnas con el mismo nombre
- Usamos "AS alias" para renombrar columnas y que sea más claro
- ON indica la relación entre las tablas (la FOREIGN KEY)
*/

$stmt = $connection->query($query);
$resultados = $stmt->fetchAll();

echo "<h2>EJEMPLO 1: Pedidos con nombre del cliente</h2>";
echo "<table>";
echo "<tr>
        <th>ID Pedido</th>
        <th>Cliente</th>
        <th>Fecha Pedido</th>
        <th>Estado</th>
      </tr>";

foreach ($resultados as $fila) {
    echo "<tr>";
    echo "<td>{$fila['pedido_id']}</td>";
    echo "<td>{$fila['cliente_nombre']}</td>";
    echo "<td>{$fila['fecha_pedido']}</td>";
    echo "<td>{$fila['estado']}</td>";
    echo "</tr>";
}

echo "</table>";

?>


<!-- ========================================
     EJEMPLO 2: JOIN DE 3 TABLAS
     ======================================== -->

<div class="info">
<strong>EJEMPLO 2: PEDIDOS CON CLIENTE Y PRODUCTOS</strong><br>
Unimos 3 tablas: <strong>pedidos + clientes + productos</strong> (a través de pedido_producto)<br>
Para mostrar: Nombre cliente, Fecha pedido, Producto, Cantidad, Precio
</div>

<?php

// ⚠️ QUERY CON MÚLTIPLES JOINS
$query = "
    SELECT 
        clientes.nombre AS cliente_nombre,
        pedidos.fecha_pedido,
        pedidos.estado,
        productos.nombre AS producto_nombre,
        productos.precio,
        pedido_producto.cantidad,
        (productos.precio * pedido_producto.cantidad) AS total
    FROM pedidos
    INNER JOIN clientes ON pedidos.cliente_id = clientes.id
    INNER JOIN pedido_producto ON pedidos.id = pedido_producto.pedido_id
    INNER JOIN productos ON pedido_producto.producto_id = productos.id
    ORDER BY pedidos.id, productos.nombre
";

/*
EXPLICACIÓN DE LA QUERY CON 3 JOINS:

FROM pedidos                                        ← Tabla principal
INNER JOIN clientes ON pedidos.cliente_id = clientes.id     ← 1er JOIN: pedidos → clientes
INNER JOIN pedido_producto ON pedidos.id = pedido_producto.pedido_id   ← 2do JOIN: pedidos → pedido_producto
INNER JOIN productos ON pedido_producto.producto_id = productos.id     ← 3er JOIN: pedido_producto → productos

Cada INNER JOIN añade una tabla más a la consulta.

⚠️ CÁLCULO EN SELECT:
(productos.precio * pedido_producto.cantidad) AS total
↑ Podemos hacer cálculos directamente en el SELECT
*/

$stmt = $connection->query($query);
$resultados = $stmt->fetchAll();

echo "<h2>EJEMPLO 2: Pedidos completos (cliente + productos)</h2>";
echo "<table>";
echo "<tr>
        <th>Cliente</th>
        <th>Fecha</th>
        <th>Estado</th>
        <th>Producto</th>
        <th>Precio Unit.</th>
        <th>Cantidad</th>
        <th>Total</th>
      </tr>";

foreach ($resultados as $fila) {
    echo "<tr>";
    echo "<td>{$fila['cliente_nombre']}</td>";
    echo "<td>{$fila['fecha_pedido']}</td>";
    echo "<td>{$fila['estado']}</td>";
    echo "<td>{$fila['producto_nombre']}</td>";
    echo "<td>" . number_format($fila['precio'], 2) . " €</td>";
    echo "<td>{$fila['cantidad']}</td>";
    echo "<td>" . number_format($fila['total'], 2) . " €</td>";
    echo "</tr>";
}

echo "</table>";

?>


<!-- ========================================
     EJEMPLO 3: LEFT JOIN
     ======================================== -->

<div class="info">
<strong>EJEMPLO 3: TODOS LOS CLIENTES (tengan pedidos o no)</strong><br>
Usamos <strong>LEFT JOIN</strong> para mostrar TODOS los clientes<br>
Si un cliente no tiene pedidos, aparecerá con campos NULL
</div>

<?php

// ⚠️ LEFT JOIN vs INNER JOIN
// LEFT JOIN = muestra TODOS los registros de la tabla izquierda (clientes)
//             aunque no tengan coincidencia en la tabla derecha (pedidos)
$query = "
    SELECT 
        clientes.id,
        clientes.nombre,
        clientes.correo,
        COUNT(pedidos.id) AS total_pedidos
    FROM clientes
    LEFT JOIN pedidos ON clientes.id = pedidos.cliente_id
    GROUP BY clientes.id, clientes.nombre, clientes.correo
    ORDER BY total_pedidos DESC
";

/*
EXPLICACIÓN LEFT JOIN:

LEFT JOIN = muestra todos los clientes, incluso si no tienen pedidos

COUNT(pedidos.id) = cuenta cuántos pedidos tiene cada cliente
GROUP BY = agrupa por cliente para poder contar sus pedidos

⚠️ DIFERENCIA:
- INNER JOIN: solo muestra clientes que tengan al menos 1 pedido
- LEFT JOIN: muestra TODOS los clientes (tengan pedidos o no)
*/

$stmt = $connection->query($query);
$resultados = $stmt->fetchAll();

echo "<h2>EJEMPLO 3: Todos los clientes con su número de pedidos</h2>";
echo "<table>";
echo "<tr>
        <th>ID</th>
        <th>Nombre</th>
        <th>Correo</th>
        <th>Total Pedidos</th>
      </tr>";

foreach ($resultados as $fila) {
    echo "<tr>";
    echo "<td>{$fila['id']}</td>";
    echo "<td>{$fila['nombre']}</td>";
    echo "<td>{$fila['correo']}</td>";
    echo "<td>{$fila['total_pedidos']}</td>";
    echo "</tr>";
}

echo "</table>";

?>


<!-- ========================================
     EJEMPLO 4: JOIN CON WHERE
     ======================================== -->

<div class="info">
<strong>EJEMPLO 4: PEDIDOS DE UN CLIENTE ESPECÍFICO</strong><br>
JOIN + WHERE para filtrar resultados
</div>

<?php

// ⚠️ JOIN CON FILTRO WHERE
// Podemos combinar JOIN con WHERE para filtrar
$query = "
    SELECT 
        pedidos.id AS pedido_id,
        clientes.nombre AS cliente_nombre,
        pedidos.fecha_pedido,
        pedidos.estado
    FROM pedidos
    INNER JOIN clientes ON pedidos.cliente_id = clientes.id
    WHERE clientes.nombre LIKE '%Ana%'
    ORDER BY pedidos.fecha_pedido DESC
";

/*
EXPLICACIÓN:

WHERE clientes.nombre LIKE '%Ana%'
↑ Filtramos después del JOIN
↑ LIKE '%Ana%' busca cualquier nombre que contenga "Ana"

Podemos combinar:
- JOIN (para unir tablas)
- WHERE (para filtrar)
- ORDER BY (para ordenar)
*/

$stmt = $connection->query($query);
$resultados = $stmt->fetchAll();

echo "<h2>EJEMPLO 4: Pedidos de clientes que se llaman 'Ana'</h2>";

if (count($resultados) > 0) {
    echo "<table>";
    echo "<tr>
            <th>ID Pedido</th>
            <th>Cliente</th>
            <th>Fecha</th>
            <th>Estado</th>
          </tr>";

    foreach ($resultados as $fila) {
        echo "<tr>";
        echo "<td>{$fila['pedido_id']}</td>";
        echo "<td>{$fila['cliente_nombre']}</td>";
        echo "<td>{$fila['fecha_pedido']}</td>";
        echo "<td>{$fila['estado']}</td>";
        echo "</tr>";
    }
    echo "</table>";
} else {
    echo "<p>No se encontraron pedidos.</p>";
}

?>

</body>
</html>

<!--
========================================
📚 RESUMEN DE TIPOS DE JOIN
========================================

1. INNER JOIN
   - Muestra solo las filas que tienen coincidencia en AMBAS tablas
   - Es el más común
   Ejemplo: pedidos INNER JOIN clientes
   → Solo muestra pedidos que tengan un cliente válido

2. LEFT JOIN (o LEFT OUTER JOIN)
   - Muestra TODAS las filas de la tabla izquierda
   - Y las coincidencias de la tabla derecha (NULL si no hay)
   Ejemplo: clientes LEFT JOIN pedidos
   → Muestra todos los clientes (tengan pedidos o no)

3. RIGHT JOIN (menos usado)
   - Muestra TODAS las filas de la tabla derecha
   - Y las coincidencias de la tabla izquierda

========================================
🎯 ESTRUCTURA BÁSICA DE UN JOIN
========================================

SELECT 
    tabla1.columna1,
    tabla2.columna2
FROM tabla1
INNER JOIN tabla2 ON tabla1.id_foranea = tabla2.id
WHERE condicion
ORDER BY columna;

Partes importantes:
1. SELECT: qué columnas quiero (tabla.columna)
2. FROM: tabla principal
3. INNER JOIN: tabla que uno
4. ON: cómo se relacionan (la FOREIGN KEY)
5. WHERE: filtros adicionales (opcional)
6. ORDER BY: ordenar resultados (opcional)

========================================
📋 CHECKLIST PARA HACER UN JOIN EN EL EXAMEN
========================================

☐ 1. Identifico qué tablas necesito unir
☐ 2. Identifico cómo se relacionan (la FOREIGN KEY)
      Ejemplo: pedidos.cliente_id → clientes.id
☐ 3. Escribo el SELECT con las columnas que quiero
☐ 4. Uso FROM con la tabla principal
☐ 5. Añado INNER JOIN con la otra tabla
☐ 6. Escribo el ON con la relación (FK = PK)
☐ 7. Si necesito filtrar, añado WHERE
☐ 8. Si necesito ordenar, añado ORDER BY

========================================
⚠️ ERRORES COMUNES
========================================

❌ Error: Columna ambigua
SELECT id FROM pedidos JOIN clientes...
         ↑ ¿id de qué tabla?

✅ Correcto:
SELECT pedidos.id FROM pedidos JOIN clientes...

---

❌ Error: Olvidar el ON
FROM pedidos INNER JOIN clientes

✅ Correcto:
FROM pedidos INNER JOIN clientes ON pedidos.cliente_id = clientes.id

---

❌ Error: Relación incorrecta en ON
ON pedidos.id = clientes.id  ← NO tiene sentido

✅ Correcto:
ON pedidos.cliente_id = clientes.id  ← La FOREIGN KEY

========================================
💡 EJEMPLO RÁPIDO PARA EL EXAMEN
========================================

Si te piden: "Muestra los pedidos con el nombre del cliente"

1. Identifico tablas: pedidos + clientes
2. Relación: pedidos.cliente_id → clientes.id
3. Escribo:

SELECT 
    pedidos.id,
    clientes.nombre,
    pedidos.fecha_pedido
FROM pedidos
INNER JOIN clientes ON pedidos.cliente_id = clientes.id;

¡LISTO! ✅
-->
