<?php
/* ============================================
   CONFIGURACIÓN DE BASE DE DATOS
   ============================================ */

// Datos de conexión a la base de datos
$host = 'localhost'; // Servidor de base de datos (normalmente localhost)
$dbname = 'mi_base_datos'; // Nombre de tu base de datos
$username = 'root'; // Usuario de MySQL/MariaDB
$password = ''; // Contraseña del usuario (vacío por defecto en XAMPP/WAMP)

// Crear conexión usando mysqli
$conn = new mysqli($host, $username, $password, $dbname);

// Verificar la conexión
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error); // Detiene el script si falla la conexión
}

// Establecer el charset a UTF-8 para evitar problemas con caracteres especiales
$conn->set_charset("utf8mb4");


/* ============================================
   PROCESAR FORMULARIO (cuando se envía)
   ============================================ */

// Variable para mensajes
$mensaje = '';
$tipo_mensaje = '';

// Verificar si el formulario fue enviado con método POST
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    
    // Recibir datos del formulario y limpiarlos
    $nombre = $conn->real_escape_string(trim($_POST['nombre'])); // Escapa caracteres especiales para prevenir SQL Injection
    $email = $conn->real_escape_string(trim($_POST['email']));
    $password = $_POST['password']; // No hacemos trim en password para permitir espacios si el usuario quiere
    $pais = $conn->real_escape_string($_POST['pais']);
    $mensaje_form = $conn->real_escape_string(trim($_POST['mensaje']));
    
    // Validar que los campos no estén vacíos
    if (empty($nombre) || empty($email) || empty($password) || empty($pais)) {
        $mensaje = "Por favor completa todos los campos obligatorios.";
        $tipo_mensaje = "error";
    } 
    // Validar formato de email
    elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $mensaje = "Por favor introduce un email válido.";
        $tipo_mensaje = "error";
    }
    // Si todo está correcto, insertar en la base de datos
    else {
        // Hashear la contraseña por seguridad (NUNCA guardar contraseñas en texto plano)
        $password_hash = password_hash($password, PASSWORD_DEFAULT);
        
        // Preparar la consulta SQL para insertar datos
        // Usamos prepared statements para mayor seguridad
        $sql = "INSERT INTO usuarios (nombre, email, password, pais, mensaje, fecha_registro) 
                VALUES (?, ?, ?, ?, ?, NOW())";
        
        // Preparar la sentencia
        $stmt = $conn->prepare($sql);
        
        if ($stmt) {
            // Vincular parámetros (s = string, i = integer, d = double)
            // "sssss" significa que los 5 parámetros son strings
            $stmt->bind_param("sssss", $nombre, $email, $password_hash, $pais, $mensaje_form);
            
            // Ejecutar la consulta
            if ($stmt->execute()) {
                $mensaje = "¡Usuario registrado exitosamente!";
                $tipo_mensaje = "success";
                
                // Limpiar variables después de insertar
                $nombre = $email = $pais = $mensaje_form = '';
            } else {
                $mensaje = "Error al registrar: " . $stmt->error;
                $tipo_mensaje = "error";
            }
            
            // Cerrar statement
            $stmt->close();
        } else {
            $mensaje = "Error en la preparación: " . $conn->error;
            $tipo_mensaje = "error";
        }
    }
}


/* ============================================
   OBTENER TODOS LOS USUARIOS (para mostrar en tabla)
   ============================================ */

// Consulta SQL para obtener todos los usuarios ordenados por fecha de registro
$sql_select = "SELECT id, nombre, email, pais, fecha_registro FROM usuarios ORDER BY fecha_registro DESC";
$resultado = $conn->query($sql_select); // Ejecutar consulta


/* ============================================
   ELIMINAR USUARIO (si se envía ID por GET)
   ============================================ */

if (isset($_GET['eliminar'])) {
    $id_eliminar = (int)$_GET['eliminar']; // Convertir a entero para seguridad
    
    // Preparar consulta de eliminación
    $sql_delete = "DELETE FROM usuarios WHERE id = ?";
    $stmt_delete = $conn->prepare($sql_delete);
    
    if ($stmt_delete) {
        $stmt_delete->bind_param("i", $id_eliminar); // i = integer
        
        if ($stmt_delete->execute()) {
            $mensaje = "Usuario eliminado correctamente.";
            $tipo_mensaje = "success";
        } else {
            $mensaje = "Error al eliminar usuario.";
            $tipo_mensaje = "error";
        }
        
        $stmt_delete->close();
    }
    
    // Recargar la página sin el parámetro eliminar en la URL
    header("Location: " . $_SERVER['PHP_SELF']);
    exit();
}

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema PHP con MariaDB</title>
    <style>
        /* Reset básico */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Formularios */
        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        select,
        textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        input:focus,
        select:focus,
        textarea:focus {
            outline: none;
            border-color: #007bff;
        }

        /* Botones */
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-right: 10px;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary {
            background: #007bff;
            color: white;
        }

        .btn-primary:hover {
            background: #0056b3;
        }

        .btn-danger {
            background: #dc3545;
            color: white;
        }

        .btn-danger:hover {
            background: #c82333;
        }

        /* Tablas */
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            margin: 20px 0;
        }

        th,
        td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background: #007bff;
            color: white;
        }

        tr:hover {
            background: #f5f5f5;
        }

        /* Alertas */
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
        }

        /* Navegación */
        nav {
            background: #333;
            padding: 10px 0;
        }

        nav ul {
            list-style: none;
            display: flex;
            justify-content: center;
        }

        nav li {
            margin: 0 15px;
        }

        nav a {
            color: white;
            text-decoration: none;
        }

        nav a:hover {
            color: #007bff;
        }

        /* Utilidades */
        .text-center {
            text-align: center;
        }

        .mt-20 {
            margin-top: 20px;
        }

        .mb-20 {
            margin-bottom: 20px;
        }

        .seccion {
            background: white;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        h2 {
            color: #007bff;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #007bff;
        }

        /* Responsive */
        @media (max-width: 768px) {
            nav ul {
                flex-direction: column;
                align-items: center;
            }
            
            nav li {
                margin: 5px 0;
            }
        }
    </style>
</head>
<body>
    <!-- Navegación -->
    <nav>
        <ul>
            <li><a href="#inicio">Inicio</a></li>
            <li><a href="#formulario">Registro</a></li>
            <li><a href="#usuarios">Usuarios</a></li>
        </ul>
    </nav>

    <div class="container">
        <h1 class="text-center mt-20 mb-20">Sistema de Gestión con PHP y MariaDB</h1>

        <!-- Mostrar mensajes si existen -->
        <?php if (!empty($mensaje)): ?>
            <div class="alert alert-<?php echo $tipo_mensaje; ?>">
                <?php echo htmlspecialchars($mensaje); ?>
            </div>
        <?php endif; ?>

        <!-- Formulario de Registro -->
        <div class="seccion" id="formulario">
            <h2>Formulario de Registro</h2>
            <form method="POST" action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']); ?>">
                <div class="form-group">
                    <label for="nombre">Nombre: *</label>
                    <input type="text" id="nombre" name="nombre" placeholder="Introduce tu nombre" required>
                </div>

                <div class="form-group">
                    <label for="email">Email: *</label>
                    <input type="email" id="email" name="email" placeholder="tu@email.com" required>
                </div>

                <div class="form-group">
                    <label for="password">Contraseña: *</label>
                    <input type="password" id="password" name="password" placeholder="••••••••" required>
                </div>

                <div class="form-group">
                    <label for="pais">País: *</label>
                    <select id="pais" name="pais" required>
                        <option value="">Selecciona un país</option>
                        <option value="España">España</option>
                        <option value="México">México</option>
                        <option value="Argentina">Argentina</option>
                        <option value="Colombia">Colombia</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="mensaje">Mensaje:</label>
                    <textarea id="mensaje" name="mensaje" rows="4" placeholder="Escribe tu mensaje aquí..."></textarea>
                </div>

                <button type="submit" class="btn btn-primary">Registrar Usuario</button>
                <button type="reset" class="btn btn-danger">Limpiar Formulario</button>
            </form>
        </div>

        <!-- Tabla de Usuarios -->
        <div class="seccion" id="usuarios">
            <h2>Usuarios Registrados</h2>
            
            <?php if ($resultado && $resultado->num_rows > 0): ?>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Email</th>
                            <th>País</th>
                            <th>Fecha Registro</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php while($fila = $resultado->fetch_assoc()): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($fila['id']); ?></td>
                                <td><?php echo htmlspecialchars($fila['nombre']); ?></td>
                                <td><?php echo htmlspecialchars($fila['email']); ?></td>
                                <td><?php echo htmlspecialchars($fila['pais']); ?></td>
                                <td><?php echo date('d/m/Y H:i', strtotime($fila['fecha_registro'])); ?></td>
                                <td>
                                    <a href="?eliminar=<?php echo $fila['id']; ?>" 
                                       class="btn btn-danger" 
                                       onclick="return confirm('¿Estás seguro de eliminar este usuario?')">
                                        Eliminar
                                    </a>
                                </td>
                            </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
            <?php else: ?>
                <p class="text-center">No hay usuarios registrados todavía.</p>
            <?php endif; ?>
        </div>
    </div>

    <?php
    // Cerrar la conexión a la base de datos al final del script
    $conn->close();
    ?>
</body>
</html>