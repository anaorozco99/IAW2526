# 📝 CHULETA PARA EXAMEN - HTML, CSS, PHP, MariaDB

## 🌐 HTML BÁSICO

### Estructura HTML básica
```html
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mi Página</title>
    <link rel="stylesheet" href="estilos.css">
</head>
<body>
    <h1>Título Principal</h1>
    <p>Párrafo de texto</p>
</body>
</html>
```

### Formulario completo
```html
<form method="POST" action="procesar.php">
    <!-- Input de texto -->
    <label for="nombre">Nombre:</label>
    <input type="text" id="nombre" name="nombre" required>
    
    <!-- Email -->
    <input type="email" name="email" required>
    
    <!-- Password -->
    <input type="password" name="password" required>
    
    <!-- Select (desplegable) -->
    <select name="pais">
        <option value="">Selecciona</option>
        <option value="España">España</option>
        <option value="México">México</option>
    </select>
    
    <!-- Textarea -->
    <textarea name="mensaje" rows="4"></textarea>
    
    <!-- Radio buttons -->
    <input type="radio" name="genero" value="M"> Masculino
    <input type="radio" name="genero" value="F"> Femenino
    
    <!-- Checkbox -->
    <input type="checkbox" name="acepto" value="1"> Acepto términos
    
    <!-- Botones -->
    <button type="submit">Enviar</button>
    <button type="reset">Limpiar</button>
</form>
```

### Tabla
```html
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Email</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1</td>
            <td>Juan</td>
            <td>juan@email.com</td>
        </tr>
    </tbody>
</table>
```

### Enlaces e imágenes
```html
<!-- Enlace -->
<a href="pagina.php">Ir a página</a>

<!-- Imagen -->
<img src="imagen.jpg" alt="Descripción">

<!-- Listas -->
<ul>
    <li>Elemento 1</li>
    <li>Elemento 2</li>
</ul>

<ol>
    <li>Primero</li>
    <li>Segundo</li>
</ol>
```

---

## 🎨 CSS BÁSICO

### Selectores
```css
/* Por etiqueta */
p { color: blue; }

/* Por clase */
.mi-clase { font-size: 16px; }

/* Por ID */
#mi-id { background: red; }

/* Descendiente */
div p { color: green; }

/* Hover */
a:hover { color: red; }
```

### Propiedades más usadas
```css
/* Textos */
color: #333;
font-size: 16px;
font-weight: bold;
text-align: center;
text-decoration: none;

/* Espaciado */
margin: 10px;           /* Exterior */
padding: 10px;          /* Interior */
margin-top: 20px;
padding-left: 15px;

/* Bordes */
border: 1px solid #ddd;
border-radius: 4px;

/* Dimensiones */
width: 100%;
height: 200px;
max-width: 1200px;

/* Display */
display: block;
display: inline;
display: inline-block;
display: flex;
display: none;         /* Ocultar */

/* Flexbox básico */
display: flex;
justify-content: center;    /* Horizontal */
align-items: center;        /* Vertical */
gap: 10px;                  /* Espacio entre elementos */

/* Posicionamiento */
position: relative;
position: absolute;
position: fixed;

/* Colores */
background: #f4f4f4;
background-color: white;
opacity: 0.5;          /* Transparencia */

/* Sombras */
box-shadow: 0 2px 5px rgba(0,0,0,0.1);
```

### Media Queries (Responsive)
```css
@media (max-width: 768px) {
    .columna {
        width: 100%;
    }
}
```

---

## 🐘 PHP BÁSICO

### Conectar a Base de Datos
```php
<?php
// Datos de conexión
$host = 'localhost';
$dbname = 'mi_base_datos';
$username = 'root';
$password = '';

// Crear conexión
$conn = new mysqli($host, $username, $password, $dbname);

// Verificar conexión
if ($conn->connect_error) {
    die("Error: " . $conn->connect_error);
}

// UTF-8
$conn->set_charset("utf8mb4");
?>
```

### Recibir datos del formulario
```php
<?php
// Método POST
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nombre = $_POST['nombre'];
    $email = $_POST['email'];
    
    // Limpiar datos
    $nombre = trim($nombre);
    $email = filter_var($email, FILTER_SANITIZE_EMAIL);
    
    // Validar
    if (empty($nombre)) {
        echo "El nombre es obligatorio";
    }
    
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        echo "Email no válido";
    }
}

// Método GET
$id = $_GET['id'];
?>
```

### INSERT (Insertar)
```php
<?php
// Escapar datos (prevenir SQL Injection)
$nombre = $conn->real_escape_string($nombre);
$email = $conn->real_escape_string($email);

// Con Prepared Statements (MÁS SEGURO)
$sql = "INSERT INTO usuarios (nombre, email) VALUES (?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ss", $nombre, $email); // s=string, i=integer

if ($stmt->execute()) {
    echo "Registro insertado";
} else {
    echo "Error: " . $stmt->error;
}
$stmt->close();
?>
```

### SELECT (Consultar)
```php
<?php
// Consulta simple
$sql = "SELECT * FROM usuarios";
$resultado = $conn->query($sql);

// Mostrar resultados
if ($resultado->num_rows > 0) {
    while($fila = $resultado->fetch_assoc()) {
        echo $fila['nombre'] . " - " . $fila['email'];
    }
} else {
    echo "No hay resultados";
}

// Consulta con WHERE
$sql = "SELECT * FROM usuarios WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $id);
$stmt->execute();
$resultado = $stmt->get_result();
?>
```

### UPDATE (Actualizar)
```php
<?php
$sql = "UPDATE usuarios SET nombre = ?, email = ? WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ssi", $nombre, $email, $id);

if ($stmt->execute()) {
    echo "Actualizado correctamente";
}
?>
```

### DELETE (Eliminar)
```php
<?php
$sql = "DELETE FROM usuarios WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $id);

if ($stmt->execute()) {
    echo "Eliminado correctamente";
}
?>
```

### Mostrar resultados en HTML
```php
<?php
$sql = "SELECT * FROM usuarios";
$resultado = $conn->query($sql);
?>

<table>
    <tr>
        <th>ID</th>
        <th>Nombre</th>
        <th>Email</th>
    </tr>
    <?php while($fila = $resultado->fetch_assoc()): ?>
        <tr>
            <td><?php echo htmlspecialchars($fila['id']); ?></td>
            <td><?php echo htmlspecialchars($fila['nombre']); ?></td>
            <td><?php echo htmlspecialchars($fila['email']); ?></td>
        </tr>
    <?php endwhile; ?>
</table>
```

### Hashear contraseñas
```php
<?php
// Crear hash
$password_hash = password_hash($password, PASSWORD_DEFAULT);

// Verificar hash
if (password_verify($password_ingresada, $password_hash)) {
    echo "Contraseña correcta";
}
?>
```

### Sesiones
```php
<?php
// Iniciar sesión (al principio del archivo)
session_start();

// Guardar datos en sesión
$_SESSION['usuario'] = $nombre;
$_SESSION['id'] = $id;

// Leer datos de sesión
echo $_SESSION['usuario'];

// Verificar si existe
if (isset($_SESSION['usuario'])) {
    echo "Usuario logueado";
}

// Destruir sesión (logout)
session_destroy();
?>
```

### Redireccionar
```php
<?php
header("Location: index.php");
exit();
?>
```

---

## 🗄️ SQL/MariaDB BÁSICO

### Crear base de datos
```sql
CREATE DATABASE mi_base_datos;
USE mi_base_datos;
```

### Crear tabla
```sql
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

### INSERT (Insertar)
```sql
-- Un registro
INSERT INTO usuarios (nombre, email, password) 
VALUES ('Juan', 'juan@email.com', 'hash123');

-- Múltiples registros
INSERT INTO usuarios (nombre, email, password) VALUES
('Juan', 'juan@email.com', 'hash1'),
('María', 'maria@email.com', 'hash2'),
('Carlos', 'carlos@email.com', 'hash3');
```

### SELECT (Consultar)
```sql
-- Todo
SELECT * FROM usuarios;

-- Campos específicos
SELECT nombre, email FROM usuarios;

-- Con condición WHERE
SELECT * FROM usuarios WHERE id = 1;
SELECT * FROM usuarios WHERE nombre = 'Juan';

-- Múltiples condiciones
SELECT * FROM usuarios WHERE nombre = 'Juan' AND email = 'juan@email.com';
SELECT * FROM usuarios WHERE id = 1 OR id = 2;

-- LIKE (búsqueda)
SELECT * FROM usuarios WHERE nombre LIKE '%Juan%';

-- ORDER BY (ordenar)
SELECT * FROM usuarios ORDER BY nombre ASC;
SELECT * FROM usuarios ORDER BY fecha_registro DESC;

-- LIMIT (limitar resultados)
SELECT * FROM usuarios LIMIT 10;
SELECT * FROM usuarios LIMIT 5, 10;  -- Desde el 5, 10 registros

-- COUNT (contar)
SELECT COUNT(*) FROM usuarios;
SELECT COUNT(*) as total FROM usuarios WHERE nombre = 'Juan';
```

### UPDATE (Actualizar)
```sql
-- Actualizar un campo
UPDATE usuarios SET nombre = 'Juan Pérez' WHERE id = 1;

-- Actualizar múltiples campos
UPDATE usuarios SET nombre = 'Juan', email = 'nuevo@email.com' WHERE id = 1;

-- Actualizar todos (¡CUIDADO!)
UPDATE usuarios SET activo = 1;
```

### DELETE (Eliminar)
```sql
-- Eliminar un registro
DELETE FROM usuarios WHERE id = 1;

-- Eliminar varios
DELETE FROM usuarios WHERE nombre = 'Juan';

-- Eliminar todos (¡CUIDADO!)
DELETE FROM usuarios;
```

### Otras consultas útiles
```sql
-- Ver estructura de tabla
DESCRIBE usuarios;

-- Añadir columna
ALTER TABLE usuarios ADD telefono VARCHAR(20);

-- Eliminar columna
ALTER TABLE usuarios DROP COLUMN telefono;

-- Vaciar tabla (borra todo)
TRUNCATE TABLE usuarios;

-- Eliminar tabla
DROP TABLE usuarios;

-- Eliminar base de datos
DROP DATABASE mi_base_datos;
```

### JOINs (Unir tablas)
```sql
-- INNER JOIN (coincidencias en ambas tablas)
SELECT usuarios.nombre, pedidos.total 
FROM usuarios 
INNER JOIN pedidos ON usuarios.id = pedidos.usuario_id;

-- LEFT JOIN (todos de la izquierda)
SELECT usuarios.nombre, pedidos.total 
FROM usuarios 
LEFT JOIN pedidos ON usuarios.id = pedidos.usuario_id;
```

---

## ⚡ TIPS RÁPIDOS

### Seguridad
- ✅ Siempre usa `prepared statements`
- ✅ Hashea contraseñas con `password_hash()`
- ✅ Usa `htmlspecialchars()` al mostrar datos
- ✅ Valida datos del formulario
- ❌ NUNCA uses `$_POST` directo en SQL

### Depuración
```php
// Ver errores
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Ver contenido de variable
print_r($variable);
var_dump($variable);

// Mostrar error SQL
echo $conn->error;
```

### Cerrar conexiones
```php
// Al final del script
$stmt->close();
$conn->close();
```

---

## 📌 ESTRUCTURA TÍPICA DE EXAMEN

```
mi_proyecto/
├── index.php          (Formulario + Lista)
├── procesar.php       (Procesa datos)
├── editar.php         (Editar registro)
├── eliminar.php       (Eliminar registro)
├── estilos.css        (Estilos)
└── config.php         (Conexión DB)
```